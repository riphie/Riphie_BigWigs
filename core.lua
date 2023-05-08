local A, L = ...
local cfg = L.cfg

-- If BigWigsAPI isn't load, early return
if not BigWigsAPI then
	return
end

local floor = floor

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = false,
	tileSize = 0,
	edgeSize = 1,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local function ApplyStyle(bar)
	local cbb = bar.candyBarBar

	local height = bar:GetHeight()
	bar:Set("bigwigs:restoreheight", height)
	PixelUtil.SetHeight(bar, height / 2)

	local bd = bar.candyBarBackdrop
	PixelUtil.SetPoint(bd, "TOPLEFT", bar, "TOPLEFT", -1, 1)
	PixelUtil.SetPoint(bd, "BOTTOMRIGHT", bar, "BOTTOMRIGHT", 1, -1)
	bd:SetBackdrop(backdrop)
	bd:SetBackdropColor(0, 0, 0, 0.7)
	bd:SetBackdropBorderColor(0, 0, 0, 0.7)
	bd:Show()

	local tex = bar:GetIcon()
	if tex then
		local icon = bar.candyBarIconFrame

		bar:SetIcon(nil)

		icon:SetTexture(tex)
		icon:Show()

		if bar.iconPosition == "RIGHT" then
			PixelUtil.SetPoint(icon, "BOTTOMLEFT", bar, "BOTTOMRIGHT", 5, 0)
		else
			PixelUtil.SetPoint(icon, "BOTTOMRIGHT", bar, "BOTTOMLEFT", -5, 0)
		end

		PixelUtil.SetSize(icon, height + 2, height + 2)

		bar:Set("bigwigs:restoreicon", tex)

		local iconBd = bar.candyBarIconFrameBackdrop
		iconBd:SetBackdrop(backdrop)
		iconBd:SetBackdropColor(0.15, 0.15, 0.15, 0.4)
		iconBd:SetBackdropBorderColor(0, 0, 0, 1)
		iconBd:ClearAllPoints()
		PixelUtil.SetPoint(iconBd, "TOPLEFT", icon, "TOPLEFT", -1, 1)
		PixelUtil.SetPoint(iconBd, "BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
		iconBd:Show()
	end

	local label = bar.candyBarLabel
	label:SetShadowOffset(0, 0)
	label:ClearAllPoints()
	PixelUtil.SetPoint(label, "BOTTOMLEFT", cbb, "TOPLEFT", 2, -height / 4 + 2)

	local timer = bar.candyBarDuration
	timer:SetShadowOffset(0, 0)
	timer:ClearAllPoints()
	PixelUtil.SetPoint(timer, "BOTTOMRIGHT", cbb, "TOPRIGHT", -2, -height / 4 + 2)
end

local function BarStopped(bar)
	local cbb = bar.candyBarBar
	bar.candyBarBackdrop:Hide()

	local height = bar:Get("bigwigs:restoreheight")
	if height then
		bar:SetHeight(height)
	end

	local tex = bar:Get("bigwigs:restoreicon")
	if tex then
		bar:SetIcon(tex)
		bar:Set("bigwigs:restoreicon", nil)
		bar.candyBarIconFrameBackdrop:Hide()
	end

	local timer = bar.candyBarDuration
	timer:ClearAllPoints()
	timer:SetPoint("TOPLEFT", cbb, "TOPLEFT", 2, 0)
	timer:SetPoint("BOTTOMRIGHT", cbb, "BOTTOMRIGHT", -2, 0)

	local label = bar.candyBarLabel
	label:ClearAllPoints()
	label:SetPoint("TOPLEFT", cbb, "TOPLEFT", 2, 0)
	label:SetPoint("BOTTOMRIGHT", cbb, "BOTTOMRIGHT", -2, 0)
end

BigWigsAPI:RegisterBarStyle("Riphie", {
	apiVersion = 1,
	version = 1,
	barHeight = 10,
	fontSizeNormal = 12,
	fontSizeEmphasized = 12,
	fontOutline = "OUTLINE",
	GetSpacing = function(bar)
		return bar:GetHeight() + 10
	end,
	ApplyStyle = ApplyStyle,
	BarStopped = BarStopped,
	GetStyleName = function()
		return "Riphie"
	end,
})
