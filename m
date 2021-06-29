Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570E3B72E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhF2NHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhF2NHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:07:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC63C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso2379229pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpqDaaIgEP6xSclV0UOsGcx+vGzvGM5obTodSSWKHwU=;
        b=IJsVkSvHqg1V7wL+3/QysqDJAu5CRUfRjRp+iNGXrBq6gfdYk0yrFG6d7H3PwEGNIg
         7ycVQcOfAKKc3YqajjqxRLXFqLRhD/q2SDm4d1fgkf09Kf5l5x6p0E4yDLXl0IPwrnSF
         z6YBi1eAwvvbl6ZmDINRAJ1QbJ9aBDkLdcE4uIjB74+BaW8Kf0ovWD7+EB6hEcfEUUHb
         uyzB6mWQJg56K7scMsd09IKIOO0vx7s9NUe7bh6/WustSvUJ3zkp8KHPuuBbptEMAWsv
         FoqsuWkzriBxDt4xKhTLHY+EGiBH4oZFbBhFOj1mcGjJJE5dq7YFixXDiE2OXhnn2e9X
         OoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpqDaaIgEP6xSclV0UOsGcx+vGzvGM5obTodSSWKHwU=;
        b=KXLO6spYPlBD80lGTE2sDIGKshcoHNYAC/VtbQcxs/vmXFjQ8QWOeNwk/ry9cIU6xS
         stS97Qna/EJJf0WcuJsgm5I/Sij0d33uJrOTYpoaGtaNfU7Hi6JTrJEJcgzoK2F9Do8Y
         mMkFhSEX85d+SG35R6JTqTQJTav8n3hBhRLoFv7ByRn+9efhyV4Xa8nVnnBSUyu/jvRa
         BgAVsY1/CEwyOr1XECwg0y28DXKCGhBCg9vQSuE7qBndDVnDruqgErDbVO7lGHNIGh0t
         jW5UMBU65xwtS7bU15PRSnEm/zL6yYQfH9R7TJA0iuUqazi8widx2f2Wx70sHqLW70Wf
         MDOQ==
X-Gm-Message-State: AOAM531FShR5diA2xMOUjVodEPL+TU3TtbjkqxRcTsS3ptkoK4cIuNvS
        aGc+e1g6t9RwUctCXLCOqAF7cA==
X-Google-Smtp-Source: ABdhPJw17Wqmqt6FMozwV3u8X6OY2sG+EViDqwvu2KxppyTNB2TJa7cGVx2zLny7D+W2ehZjKkJfGQ==
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr34006499pjb.156.1624971912980;
        Tue, 29 Jun 2021 06:05:12 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u13sm18766769pga.64.2021.06.29.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:05:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>, Wen Su <wen.su@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: mt6358: Remove shift fields from struct mt6358_regulator_info
Date:   Tue, 29 Jun 2021 21:05:01 +0800
Message-Id: <20210629130503.2183574-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shift setting can be calculated via the corresponding mask field,
so remove these shift fields.

The usage of da_vsel_mask is different from other mask defines because
current code does shift regval before mask with the da_vsel_mask.
Do proper shit to da_vsel_mask setting so we can calculate the shift.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6358-regulator.c | 87 +++++++++++++---------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 0d35be4e0e5a..eb8027813b99 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -28,18 +28,15 @@ struct mt6358_regulator_info {
 	u32 qi;
 	const u32 *index_table;
 	unsigned int n_table;
-	u32 vsel_shift;
 	u32 da_vsel_reg;
 	u32 da_vsel_mask;
-	u32 da_vsel_shift;
 	u32 modeset_reg;
 	u32 modeset_mask;
-	u32 modeset_shift;
 };
 
 #define MT6358_BUCK(match, vreg, min, max, step,		\
 	volt_ranges, vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
-	_da_vsel_shift, _modeset_reg, _modeset_shift)		\
+	_modeset_reg, _modeset_shift)		\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
@@ -61,15 +58,13 @@ struct mt6358_regulator_info {
 	.qi = BIT(0),	\
 	.da_vsel_reg = _da_vsel_reg,	\
 	.da_vsel_mask = _da_vsel_mask,	\
-	.da_vsel_shift = _da_vsel_shift,	\
 	.modeset_reg = _modeset_reg,	\
 	.modeset_mask = BIT(_modeset_shift),	\
-	.modeset_shift = _modeset_shift	\
 }
 
 #define MT6358_LDO(match, vreg, ldo_volt_table,	\
 	ldo_index_table, enreg, enbit, vosel,	\
-	vosel_mask, vosel_shift)	\
+	vosel_mask)	\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
@@ -89,12 +84,11 @@ struct mt6358_regulator_info {
 	.qi = BIT(15),	\
 	.index_table = ldo_index_table,	\
 	.n_table = ARRAY_SIZE(ldo_index_table),	\
-	.vsel_shift = vosel_shift,	\
 }
 
 #define MT6358_LDO1(match, vreg, min, max, step,	\
 	volt_ranges, _da_vsel_reg, _da_vsel_mask,	\
-	_da_vsel_shift, vosel, vosel_mask)	\
+	vosel, vosel_mask)	\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
@@ -113,7 +107,6 @@ struct mt6358_regulator_info {
 	},	\
 	.da_vsel_reg = _da_vsel_reg,	\
 	.da_vsel_mask = _da_vsel_mask,	\
-	.da_vsel_shift = _da_vsel_shift,	\
 	.status_reg = MT6358_LDO_##vreg##_DBG1,	\
 	.qi = BIT(0),	\
 }
@@ -260,9 +253,9 @@ static int mt6358_set_voltage_sel(struct regulator_dev *rdev,
 	pvol = info->index_table;
 
 	idx = pvol[selector];
+	idx <<= ffs(info->desc.vsel_mask) - 1;
 	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
-				 info->desc.vsel_mask,
-				 idx << info->vsel_shift);
+				 info->desc.vsel_mask, idx);
 
 	return ret;
 }
@@ -282,7 +275,8 @@ static int mt6358_get_voltage_sel(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	selector = (selector & info->desc.vsel_mask) >> info->vsel_shift;
+	selector = (selector & info->desc.vsel_mask) >>
+			(ffs(info->desc.vsel_mask) - 1);
 	pvol = info->index_table;
 	for (idx = 0; idx < info->desc.n_voltages; idx++) {
 		if (pvol[idx] == selector)
@@ -305,7 +299,7 @@ static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	ret = (regval >> info->da_vsel_shift) & info->da_vsel_mask;
+	ret = (regval & info->da_vsel_mask) >> (ffs(info->da_vsel_mask) - 1);
 
 	return ret;
 }
@@ -342,11 +336,10 @@ static int mt6358_regulator_set_mode(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	dev_dbg(&rdev->dev, "mt6358 buck set_mode %#x, %#x, %#x, %#x\n",
-		info->modeset_reg, info->modeset_mask,
-		info->modeset_shift, val);
+	dev_dbg(&rdev->dev, "mt6358 buck set_mode %#x, %#x, %#x\n",
+		info->modeset_reg, info->modeset_mask, val);
 
-	val <<= info->modeset_shift;
+	val <<= ffs(info->modeset_mask) - 1;
 
 	return regmap_update_bits(rdev->regmap, info->modeset_reg,
 				  info->modeset_mask, val);
@@ -364,7 +357,7 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	switch ((regval & info->modeset_mask) >> info->modeset_shift) {
+	switch ((regval & info->modeset_mask) >> (ffs(info->modeset_mask) - 1)) {
 	case MT6358_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
 	case MT6358_BUCK_MODE_FORCE_PWM:
@@ -412,30 +405,30 @@ static const struct regulator_ops mt6358_volt_fixed_ops = {
 static struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
 		    buck_volt_range2, 0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f,
-		    0, MT6358_VDRAM1_ANA_CON0, 8),
+		    MT6358_VDRAM1_ANA_CON0, 8),
 	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
-		    0, MT6358_VCORE_VGPU_ANA_CON0, 1),
+		    MT6358_VCORE_VGPU_ANA_CON0, 1),
 	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
-		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, 0,
+		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
 		    MT6358_VPA_ANA_CON0, 3),
 	MT6358_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f,
-		    0, MT6358_VPROC_ANA_CON0, 1),
+		    MT6358_VPROC_ANA_CON0, 1),
 	MT6358_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f,
-		    0, MT6358_VPROC_ANA_CON0, 2),
+		    MT6358_VPROC_ANA_CON0, 2),
 	MT6358_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, 0,
+		    buck_volt_range1, 0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f,
 		    MT6358_VCORE_VGPU_ANA_CON0, 2),
 	MT6358_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
-		    buck_volt_range2, 0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, 0,
+		    buck_volt_range2, 0x7f, MT6358_BUCK_VS2_DBG0, 0x7f,
 		    MT6358_VS2_ANA_CON0, 8),
 	MT6358_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f,
-		    0, MT6358_VMODEM_ANA_CON0, 8),
+		    MT6358_VMODEM_ANA_CON0, 8),
 	MT6358_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
-		    buck_volt_range4, 0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, 0,
+		    buck_volt_range4, 0x7f, MT6358_BUCK_VS1_DBG0, 0x7f,
 		    MT6358_VS1_ANA_CON0, 8),
 	MT6358_REG_FIXED("ldo_vrf12", VRF12,
 			 MT6358_LDO_VRF12_CON0, 0, 1200000),
@@ -457,49 +450,49 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_REG_FIXED("ldo_vaud28", VAUD28,
 			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
 	MT6358_LDO("ldo_vdram2", VDRAM2, vdram2_voltages, vdram2_idx,
-		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0xf, 0),
+		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0xf),
 	MT6358_LDO("ldo_vsim1", VSIM1, vsim_voltages, vsim_idx,
-		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vibr", VIBR, vibr_voltages, vibr_idx,
-		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vusb", VUSB, vusb_voltages, vusb_idx,
-		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700, 8),
+		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
 	MT6358_LDO("ldo_vcamd", VCAMD, vcamd_voltages, vcamd_idx,
-		   MT6358_LDO_VCAMD_CON0, 0, MT6358_VCAMD_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VCAMD_CON0, 0, MT6358_VCAMD_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
-		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vmch", VMCH, vmch_vemc_voltages, vmch_vemc_idx,
-		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700, 8),
+		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
 	MT6358_LDO("ldo_vcama1", VCAMA1, vcama_voltages, vcama_idx,
-		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
-		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700, 8),
+		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
 	MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
 		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
-		   0, MT6358_VCN33_ANA_CON0, 0x300, 8),
+		   0, MT6358_VCN33_ANA_CON0, 0x300),
 	MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
 		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
-		   0, MT6358_VCN33_ANA_CON0, 0x300, 8),
+		   0, MT6358_VCN33_ANA_CON0, 0x300),
 	MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
-		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
-		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vldo28", VLDO28, vldo28_voltages, vldo28_idx,
 		   MT6358_LDO_VLDO28_CON0_0, 0,
-		   MT6358_VLDO28_ANA_CON0, 0x300, 8),
+		   MT6358_VLDO28_ANA_CON0, 0x300),
 	MT6358_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
-		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00, 8),
+		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f, 8,
+		    buck_volt_range1, MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON0, 0x7f),
 	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f, 8,
+		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON2, 0x7f),
 	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f, 8,
+		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON3, 0x7f),
 	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f, 8,
+		    buck_volt_range1, MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
-- 
2.25.1

