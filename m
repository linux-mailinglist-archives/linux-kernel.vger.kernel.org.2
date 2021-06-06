Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC939CDB5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFFGxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFFGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:53:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248AC061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 23:51:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso3406724pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 23:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HF2YVrJqSlTrER93FSJLhVBw4mRCymjLc/k55sto80U=;
        b=RL12Q/2DqNJ+P+D+bUKeCTmeBaj43WxzMZ8mnWztzJ60n4+Jvbi4ouSzMdyBt/RSdm
         M5Ej2gMty4qBRMoYseHy7maQ91MBB6UvBT1RUxZlMqp7zQZ9KuykXh8aILeZgqoHqMaX
         K92wOekMpHoTq/6OFgYi0VlrbClLITlJDnlzzyeTnYxeedtI41DCS85Z4EPXYguycxfl
         zmrN7vvPiJEGmnHbBT0YB7nV52+trmWwnKC4IZnyodACFdDM14m7SAn3ielv+4tymSG9
         Vehr3efv/KI8YiRz1ZW46LmbL0l4yKX4y1sH3iw6W0xzE4Cn4gJRUSk3+edpnLuzIArZ
         ndQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HF2YVrJqSlTrER93FSJLhVBw4mRCymjLc/k55sto80U=;
        b=H3VMrCdChKNUSwQLREtYeD93TG4/27VEmtCq8Jaohgog5xKYov0LQ9nuTlPtckcxfI
         2kkEH/qeenygjiJG6B++H4ygQAUn4UwoGJXclrVV0FOCiPaF6o5wz4QT6jbzPDtX689M
         wKn7RKv2CPsbt1Bt2FSsYVIz9doawab6MW+QZnedcPbJhT3OCsoisRGnXxuRC9EnqmYM
         eHN8w12CMUlh+8XAD3+PCYfciSogiq5yk0inZuDIBwY7JEYpMTFahM5zd3jYx+rcuJCc
         niW2enfJaxkGNkTUYhcGOze/17TpE3KROHEEOn8PHLrn/TIwuYUgqcvMS9w6sOVdZ6cO
         XU9A==
X-Gm-Message-State: AOAM530Zwc6vIs6lsDcYkPLy3AEz+FQNLbhHkoZK09ZMnog4ChKUTl5i
        CxyLo4rp4V3MqBj1Hooo8qkX9w==
X-Google-Smtp-Source: ABdhPJzf3t7/fG3JWIXdLX8hGECrAqSwAayeU3uSIWiXU8EG/VmdHyV3bpOrwleF3qcknCjXBnSWVQ==
X-Received: by 2002:a17:90a:117:: with SMTP id b23mr14015355pjb.183.1622962271487;
        Sat, 05 Jun 2021 23:51:11 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u21sm5324851pfh.163.2021.06.05.23.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 23:51:11 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wen Su <wen.su@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: mt6359: Get rid of linear_range tables
Date:   Sun,  6 Jun 2021 14:50:52 +0800
Message-Id: <20210606065052.1417111-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606065052.1417111-1-axel.lin@ingics.com>
References: <20210606065052.1417111-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6359_BUCK and MT6359_LDO_LINEAR macros setup both
linear settings (min_uV, uV_step, linear_min_sel) and linar_range
(linear_ranges, n_linear_ranges) settings.
All the linear range tables actually only has one entry.
Let's simplify it by using linear instead of linear range.

The linear_min_sel setting is 0 for all cases, remove it
from the macros.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6359-regulator.c | 157 ++++++++++-----------------
 1 file changed, 59 insertions(+), 98 deletions(-)

diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index 8003c363cdfd..7ce0bd377a08 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -41,8 +41,8 @@ struct mt6359_regulator_info {
 	u32 lp_mode_shift;
 };
 
-#define MT6359_BUCK(match, _name, min, max, step, min_sel,	\
-	volt_ranges, _enable_reg, _status_reg,			\
+#define MT6359_BUCK(match, _name, min, max, step,		\
+	_enable_reg, _status_reg,				\
 	_vsel_reg, _vsel_mask,					\
 	_lp_mode_reg, _lp_mode_shift,				\
 	_modeset_reg, _modeset_shift)				\
@@ -51,16 +51,13 @@ struct mt6359_regulator_info {
 		.name = #_name,					\
 		.of_match = of_match_ptr(match),		\
 		.regulators_node = of_match_ptr("regulators"),	\
-		.ops = &mt6359_volt_range_ops,			\
+		.ops = &mt6359_volt_linear_ops,			\
 		.type = REGULATOR_VOLTAGE,			\
 		.id = MT6359_ID_##_name,			\
 		.owner = THIS_MODULE,				\
 		.uV_step = (step),				\
-		.linear_min_sel = (min_sel),			\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
 		.min_uV = (min),				\
-		.linear_ranges = volt_ranges,			\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
 		.vsel_reg = _vsel_reg,				\
 		.vsel_mask = _vsel_mask,			\
 		.enable_reg = _enable_reg,			\
@@ -77,24 +74,20 @@ struct mt6359_regulator_info {
 	.modeset_shift = _modeset_shift				\
 }
 
-#define MT6359_LDO_LINEAR(match, _name, min, max, step, min_sel,\
-	volt_ranges, _enable_reg, _status_reg,			\
-	_vsel_reg, _vsel_mask)					\
+#define MT6359_LDO_LINEAR(match, _name, min, max, step,		\
+	_enable_reg, _status_reg, _vsel_reg, _vsel_mask)	\
 [MT6359_ID_##_name] = {						\
 	.desc = {						\
 		.name = #_name,					\
 		.of_match = of_match_ptr(match),		\
 		.regulators_node = of_match_ptr("regulators"),	\
-		.ops = &mt6359_volt_range_ops,			\
+		.ops = &mt6359_volt_linear_ops,			\
 		.type = REGULATOR_VOLTAGE,			\
 		.id = MT6359_ID_##_name,			\
 		.owner = THIS_MODULE,				\
 		.uV_step = (step),				\
-		.linear_min_sel = (min_sel),			\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
 		.min_uV = (min),				\
-		.linear_ranges = volt_ranges,			\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
 		.vsel_reg = _vsel_reg,				\
 		.vsel_mask = _vsel_mask,			\
 		.enable_reg = _enable_reg,			\
@@ -171,38 +164,6 @@ struct mt6359_regulator_info {
 	.qi = BIT(0),					\
 }
 
-static const struct linear_range mt_volt_range1[] = {
-	REGULATOR_LINEAR_RANGE(800000, 0, 0x70, 12500),
-};
-
-static const struct linear_range mt_volt_range2[] = {
-	REGULATOR_LINEAR_RANGE(400000, 0, 0x7f, 6250),
-};
-
-static const struct linear_range mt_volt_range3[] = {
-	REGULATOR_LINEAR_RANGE(400000, 0, 0x70, 6250),
-};
-
-static const struct linear_range mt_volt_range4[] = {
-	REGULATOR_LINEAR_RANGE(800000, 0, 0x40, 12500),
-};
-
-static const struct linear_range mt_volt_range5[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x3F, 50000),
-};
-
-static const struct linear_range mt_volt_range6[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
-};
-
-static const struct linear_range mt_volt_range7[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
-};
-
-static const struct linear_range mt_volt_range8[] = {
-	REGULATOR_LINEAR_RANGE(506250, 0, 0x7f, 6250),
-};
-
 static const unsigned int vsim1_voltages[] = {
 	0, 0, 0, 1700000, 1800000, 0, 0, 0, 2700000, 0, 0, 3000000, 3100000,
 };
@@ -465,9 +426,9 @@ static int mt6359p_vemc_get_voltage_sel(struct regulator_dev *rdev)
 	return val;
 }
 
-static const struct regulator_ops mt6359_volt_range_ops = {
-	.list_voltage = regulator_list_voltage_linear_range,
-	.map_voltage = regulator_map_voltage_linear_range,
+static const struct regulator_ops mt6359_volt_linear_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
@@ -512,75 +473,75 @@ static const struct regulator_ops mt6359p_vemc_ops = {
 
 /* The array is indexed by id(MT6359_ID_XXX) */
 static struct mt6359_regulator_info mt6359_regulators[] = {
-	MT6359_BUCK("buck_vs1", VS1, 800000, 2200000, 12500, 0,
-		    mt_volt_range1, MT6359_RG_BUCK_VS1_EN_ADDR,
+	MT6359_BUCK("buck_vs1", VS1, 800000, 2200000, 12500,
+		    MT6359_RG_BUCK_VS1_EN_ADDR,
 		    MT6359_DA_VS1_EN_ADDR, MT6359_RG_BUCK_VS1_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VS1_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VS1_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VS1_LP_ADDR, MT6359_RG_BUCK_VS1_LP_SHIFT,
 		    MT6359_RG_VS1_FPWM_ADDR, MT6359_RG_VS1_FPWM_SHIFT),
-	MT6359_BUCK("buck_vgpu11", VGPU11, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VGPU11_EN_ADDR,
+	MT6359_BUCK("buck_vgpu11", VGPU11, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VGPU11_EN_ADDR,
 		    MT6359_DA_VGPU11_EN_ADDR, MT6359_RG_BUCK_VGPU11_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VGPU11_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VGPU11_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VGPU11_LP_ADDR,
 		    MT6359_RG_BUCK_VGPU11_LP_SHIFT,
 		    MT6359_RG_VGPU11_FCCM_ADDR, MT6359_RG_VGPU11_FCCM_SHIFT),
-	MT6359_BUCK("buck_vmodem", VMODEM, 400000, 1100000, 6250, 0,
-		    mt_volt_range3, MT6359_RG_BUCK_VMODEM_EN_ADDR,
+	MT6359_BUCK("buck_vmodem", VMODEM, 400000, 1100000, 6250,
+		    MT6359_RG_BUCK_VMODEM_EN_ADDR,
 		    MT6359_DA_VMODEM_EN_ADDR, MT6359_RG_BUCK_VMODEM_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VMODEM_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VMODEM_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VMODEM_LP_ADDR,
 		    MT6359_RG_BUCK_VMODEM_LP_SHIFT,
 		    MT6359_RG_VMODEM_FCCM_ADDR, MT6359_RG_VMODEM_FCCM_SHIFT),
-	MT6359_BUCK("buck_vpu", VPU, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPU_EN_ADDR,
+	MT6359_BUCK("buck_vpu", VPU, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPU_EN_ADDR,
 		    MT6359_DA_VPU_EN_ADDR, MT6359_RG_BUCK_VPU_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPU_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPU_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPU_LP_ADDR, MT6359_RG_BUCK_VPU_LP_SHIFT,
 		    MT6359_RG_VPU_FCCM_ADDR, MT6359_RG_VPU_FCCM_SHIFT),
-	MT6359_BUCK("buck_vcore", VCORE, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VCORE_EN_ADDR,
+	MT6359_BUCK("buck_vcore", VCORE, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VCORE_EN_ADDR,
 		    MT6359_DA_VCORE_EN_ADDR, MT6359_RG_BUCK_VCORE_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VCORE_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VCORE_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VCORE_LP_ADDR, MT6359_RG_BUCK_VCORE_LP_SHIFT,
 		    MT6359_RG_VCORE_FCCM_ADDR, MT6359_RG_VCORE_FCCM_SHIFT),
-	MT6359_BUCK("buck_vs2", VS2, 800000, 1600000, 12500, 0,
-		    mt_volt_range4, MT6359_RG_BUCK_VS2_EN_ADDR,
+	MT6359_BUCK("buck_vs2", VS2, 800000, 1600000, 12500,
+		    MT6359_RG_BUCK_VS2_EN_ADDR,
 		    MT6359_DA_VS2_EN_ADDR, MT6359_RG_BUCK_VS2_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VS2_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VS2_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VS2_LP_ADDR, MT6359_RG_BUCK_VS2_LP_SHIFT,
 		    MT6359_RG_VS2_FPWM_ADDR, MT6359_RG_VS2_FPWM_SHIFT),
-	MT6359_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, 0,
-		    mt_volt_range5, MT6359_RG_BUCK_VPA_EN_ADDR,
+	MT6359_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
+		    MT6359_RG_BUCK_VPA_EN_ADDR,
 		    MT6359_DA_VPA_EN_ADDR, MT6359_RG_BUCK_VPA_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPA_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPA_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPA_LP_ADDR, MT6359_RG_BUCK_VPA_LP_SHIFT,
 		    MT6359_RG_VPA_MODESET_ADDR, MT6359_RG_VPA_MODESET_SHIFT),
-	MT6359_BUCK("buck_vproc2", VPROC2, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPROC2_EN_ADDR,
+	MT6359_BUCK("buck_vproc2", VPROC2, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC2_EN_ADDR,
 		    MT6359_DA_VPROC2_EN_ADDR, MT6359_RG_BUCK_VPROC2_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPROC2_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPROC2_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPROC2_LP_ADDR,
 		    MT6359_RG_BUCK_VPROC2_LP_SHIFT,
 		    MT6359_RG_VPROC2_FCCM_ADDR, MT6359_RG_VPROC2_FCCM_SHIFT),
-	MT6359_BUCK("buck_vproc1", VPROC1, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPROC1_EN_ADDR,
+	MT6359_BUCK("buck_vproc1", VPROC1, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC1_EN_ADDR,
 		    MT6359_DA_VPROC1_EN_ADDR, MT6359_RG_BUCK_VPROC1_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPROC1_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPROC1_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPROC1_LP_ADDR,
 		    MT6359_RG_BUCK_VPROC1_LP_SHIFT,
 		    MT6359_RG_VPROC1_FCCM_ADDR, MT6359_RG_VPROC1_FCCM_SHIFT),
-	MT6359_BUCK("buck_vcore_sshub", VCORE_SSHUB, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VCORE_SSHUB_EN_ADDR,
+	MT6359_BUCK("buck_vcore_sshub", VCORE_SSHUB, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VCORE_SSHUB_EN_ADDR,
 		    MT6359_DA_VCORE_EN_ADDR,
 		    MT6359_RG_BUCK_VCORE_SSHUB_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VCORE_SSHUB_VOSEL_MASK <<
@@ -607,7 +568,7 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 	MT6359_REG_FIXED("ldo_vusb", VUSB, MT6359_RG_LDO_VUSB_EN_0_ADDR,
 			 MT6359_DA_VUSB_B_EN_ADDR, 3000000),
 	MT6359_LDO_LINEAR("ldo_vsram_proc2", VSRAM_PROC2, 500000, 1293750, 6250,
-			  0, mt_volt_range6, MT6359_RG_LDO_VSRAM_PROC2_EN_ADDR,
+			  MT6359_RG_LDO_VSRAM_PROC2_EN_ADDR,
 			  MT6359_DA_VSRAM_PROC2_B_EN_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC2_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC2_VOSEL_MASK <<
@@ -646,7 +607,7 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 	MT6359_REG_FIXED("ldo_vaux18", VAUX18, MT6359_RG_LDO_VAUX18_EN_ADDR,
 			 MT6359_DA_VAUX18_B_EN_ADDR, 1800000),
 	MT6359_LDO_LINEAR("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750,
-			  6250, 0, mt_volt_range6,
+			  6250,
 			  MT6359_RG_LDO_VSRAM_OTHERS_EN_ADDR,
 			  MT6359_DA_VSRAM_OTHERS_B_EN_ADDR,
 			  MT6359_RG_LDO_VSRAM_OTHERS_VOSEL_ADDR,
@@ -707,7 +668,7 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 		   MT6359_RG_VRF18_VOSEL_MASK << MT6359_RG_VRF18_VOSEL_SHIFT,
 		   120),
 	MT6359_LDO_LINEAR("ldo_vsram_md", VSRAM_MD, 500000, 1100000, 6250,
-			  0, mt_volt_range7, MT6359_RG_LDO_VSRAM_MD_EN_ADDR,
+			  MT6359_RG_LDO_VSRAM_MD_EN_ADDR,
 			  MT6359_DA_VSRAM_MD_B_EN_ADDR,
 			  MT6359_RG_LDO_VSRAM_MD_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_MD_VOSEL_MASK <<
@@ -728,7 +689,7 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 		   MT6359_RG_VBBCK_VOSEL_MASK << MT6359_RG_VBBCK_VOSEL_SHIFT,
 		   240),
 	MT6359_LDO_LINEAR("ldo_vsram_proc1", VSRAM_PROC1, 500000, 1293750, 6250,
-			  0, mt_volt_range6, MT6359_RG_LDO_VSRAM_PROC1_EN_ADDR,
+			  MT6359_RG_LDO_VSRAM_PROC1_EN_ADDR,
 			  MT6359_DA_VSRAM_PROC1_B_EN_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC1_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC1_VOSEL_MASK <<
@@ -739,7 +700,7 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 		   MT6359_RG_VSIM2_VOSEL_MASK << MT6359_RG_VSIM2_VOSEL_SHIFT,
 		   480),
 	MT6359_LDO_LINEAR("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB,
-			  500000, 1293750, 6250, 0, mt_volt_range6,
+			  500000, 1293750, 6250,
 			  MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_EN_ADDR,
 			  MT6359_DA_VSRAM_OTHERS_B_EN_ADDR,
 			  MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_ADDR,
@@ -748,75 +709,75 @@ static struct mt6359_regulator_info mt6359_regulators[] = {
 };
 
 static struct mt6359_regulator_info mt6359p_regulators[] = {
-	MT6359_BUCK("buck_vs1", VS1, 800000, 2200000, 12500, 0,
-		    mt_volt_range1, MT6359_RG_BUCK_VS1_EN_ADDR,
+	MT6359_BUCK("buck_vs1", VS1, 800000, 2200000, 12500,
+		    MT6359_RG_BUCK_VS1_EN_ADDR,
 		    MT6359_DA_VS1_EN_ADDR, MT6359_RG_BUCK_VS1_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VS1_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VS1_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VS1_LP_ADDR, MT6359_RG_BUCK_VS1_LP_SHIFT,
 		    MT6359_RG_VS1_FPWM_ADDR, MT6359_RG_VS1_FPWM_SHIFT),
-	MT6359_BUCK("buck_vgpu11", VGPU11, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VGPU11_EN_ADDR,
+	MT6359_BUCK("buck_vgpu11", VGPU11, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VGPU11_EN_ADDR,
 		    MT6359_DA_VGPU11_EN_ADDR, MT6359P_RG_BUCK_VGPU11_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VGPU11_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VGPU11_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VGPU11_LP_ADDR,
 		    MT6359_RG_BUCK_VGPU11_LP_SHIFT,
 		    MT6359_RG_VGPU11_FCCM_ADDR, MT6359_RG_VGPU11_FCCM_SHIFT),
-	MT6359_BUCK("buck_vmodem", VMODEM, 400000, 1100000, 6250, 0,
-		    mt_volt_range3, MT6359_RG_BUCK_VMODEM_EN_ADDR,
+	MT6359_BUCK("buck_vmodem", VMODEM, 400000, 1100000, 6250,
+		    MT6359_RG_BUCK_VMODEM_EN_ADDR,
 		    MT6359_DA_VMODEM_EN_ADDR, MT6359_RG_BUCK_VMODEM_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VMODEM_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VMODEM_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VMODEM_LP_ADDR,
 		    MT6359_RG_BUCK_VMODEM_LP_SHIFT,
 		    MT6359_RG_VMODEM_FCCM_ADDR, MT6359_RG_VMODEM_FCCM_SHIFT),
-	MT6359_BUCK("buck_vpu", VPU, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPU_EN_ADDR,
+	MT6359_BUCK("buck_vpu", VPU, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPU_EN_ADDR,
 		    MT6359_DA_VPU_EN_ADDR, MT6359_RG_BUCK_VPU_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPU_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPU_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPU_LP_ADDR, MT6359_RG_BUCK_VPU_LP_SHIFT,
 		    MT6359_RG_VPU_FCCM_ADDR, MT6359_RG_VPU_FCCM_SHIFT),
-	MT6359_BUCK("buck_vcore", VCORE, 506250, 1300000, 6250, 0,
-		    mt_volt_range8, MT6359_RG_BUCK_VCORE_EN_ADDR,
+	MT6359_BUCK("buck_vcore", VCORE, 506250, 1300000, 6250,
+		    MT6359_RG_BUCK_VCORE_EN_ADDR,
 		    MT6359_DA_VCORE_EN_ADDR, MT6359P_RG_BUCK_VCORE_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VCORE_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VCORE_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VCORE_LP_ADDR, MT6359_RG_BUCK_VCORE_LP_SHIFT,
 		    MT6359_RG_VCORE_FCCM_ADDR, MT6359_RG_VCORE_FCCM_SHIFT),
-	MT6359_BUCK("buck_vs2", VS2, 800000, 1600000, 12500, 0,
-		    mt_volt_range4, MT6359_RG_BUCK_VS2_EN_ADDR,
+	MT6359_BUCK("buck_vs2", VS2, 800000, 1600000, 12500,
+		    MT6359_RG_BUCK_VS2_EN_ADDR,
 		    MT6359_DA_VS2_EN_ADDR, MT6359_RG_BUCK_VS2_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VS2_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VS2_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VS2_LP_ADDR, MT6359_RG_BUCK_VS2_LP_SHIFT,
 		    MT6359_RG_VS2_FPWM_ADDR, MT6359_RG_VS2_FPWM_SHIFT),
-	MT6359_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, 0,
-		    mt_volt_range5, MT6359_RG_BUCK_VPA_EN_ADDR,
+	MT6359_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
+		    MT6359_RG_BUCK_VPA_EN_ADDR,
 		    MT6359_DA_VPA_EN_ADDR, MT6359_RG_BUCK_VPA_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPA_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPA_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPA_LP_ADDR, MT6359_RG_BUCK_VPA_LP_SHIFT,
 		    MT6359_RG_VPA_MODESET_ADDR, MT6359_RG_VPA_MODESET_SHIFT),
-	MT6359_BUCK("buck_vproc2", VPROC2, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPROC2_EN_ADDR,
+	MT6359_BUCK("buck_vproc2", VPROC2, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC2_EN_ADDR,
 		    MT6359_DA_VPROC2_EN_ADDR, MT6359_RG_BUCK_VPROC2_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPROC2_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPROC2_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPROC2_LP_ADDR,
 		    MT6359_RG_BUCK_VPROC2_LP_SHIFT,
 		    MT6359_RG_VPROC2_FCCM_ADDR, MT6359_RG_VPROC2_FCCM_SHIFT),
-	MT6359_BUCK("buck_vproc1", VPROC1, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359_RG_BUCK_VPROC1_EN_ADDR,
+	MT6359_BUCK("buck_vproc1", VPROC1, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC1_EN_ADDR,
 		    MT6359_DA_VPROC1_EN_ADDR, MT6359_RG_BUCK_VPROC1_VOSEL_ADDR,
 		    MT6359_RG_BUCK_VPROC1_VOSEL_MASK <<
 		    MT6359_RG_BUCK_VPROC1_VOSEL_SHIFT,
 		    MT6359_RG_BUCK_VPROC1_LP_ADDR,
 		    MT6359_RG_BUCK_VPROC1_LP_SHIFT,
 		    MT6359_RG_VPROC1_FCCM_ADDR, MT6359_RG_VPROC1_FCCM_SHIFT),
-	MT6359_BUCK("buck_vgpu11_sshub", VGPU11_SSHUB, 400000, 1193750, 6250, 0,
-		    mt_volt_range2, MT6359P_RG_BUCK_VGPU11_SSHUB_EN_ADDR,
+	MT6359_BUCK("buck_vgpu11_sshub", VGPU11_SSHUB, 400000, 1193750, 6250,
+		    MT6359P_RG_BUCK_VGPU11_SSHUB_EN_ADDR,
 		    MT6359_DA_VGPU11_EN_ADDR,
 		    MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_ADDR,
 		    MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_MASK <<
@@ -844,7 +805,7 @@ static struct mt6359_regulator_info mt6359p_regulators[] = {
 	MT6359_REG_FIXED("ldo_vusb", VUSB, MT6359P_RG_LDO_VUSB_EN_0_ADDR,
 			 MT6359P_DA_VUSB_B_EN_ADDR, 3000000),
 	MT6359_LDO_LINEAR("ldo_vsram_proc2", VSRAM_PROC2, 500000, 1293750, 6250,
-			  0, mt_volt_range6, MT6359P_RG_LDO_VSRAM_PROC2_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_PROC2_EN_ADDR,
 			  MT6359P_DA_VSRAM_PROC2_B_EN_ADDR,
 			  MT6359P_RG_LDO_VSRAM_PROC2_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC2_VOSEL_MASK <<
@@ -884,7 +845,7 @@ static struct mt6359_regulator_info mt6359p_regulators[] = {
 	MT6359_REG_FIXED("ldo_vaux18", VAUX18, MT6359P_RG_LDO_VAUX18_EN_ADDR,
 			 MT6359P_DA_VAUX18_B_EN_ADDR, 1800000),
 	MT6359_LDO_LINEAR("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750,
-			  6250, 0, mt_volt_range6,
+			  6250,
 			  MT6359P_RG_LDO_VSRAM_OTHERS_EN_ADDR,
 			  MT6359P_DA_VSRAM_OTHERS_B_EN_ADDR,
 			  MT6359P_RG_LDO_VSRAM_OTHERS_VOSEL_ADDR,
@@ -947,7 +908,7 @@ static struct mt6359_regulator_info mt6359p_regulators[] = {
 		   MT6359_RG_VRF18_VOSEL_MASK << MT6359_RG_VRF18_VOSEL_SHIFT,
 		   240),
 	MT6359_LDO_LINEAR("ldo_vsram_md", VSRAM_MD, 500000, 1293750, 6250,
-			  0, mt_volt_range7, MT6359P_RG_LDO_VSRAM_MD_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_MD_EN_ADDR,
 			  MT6359P_DA_VSRAM_MD_B_EN_ADDR,
 			  MT6359P_RG_LDO_VSRAM_MD_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_MD_VOSEL_MASK <<
@@ -968,7 +929,7 @@ static struct mt6359_regulator_info mt6359p_regulators[] = {
 		   MT6359P_RG_VBBCK_VOSEL_MASK << MT6359P_RG_VBBCK_VOSEL_SHIFT,
 		   480),
 	MT6359_LDO_LINEAR("ldo_vsram_proc1", VSRAM_PROC1, 500000, 1293750, 6250,
-			  0, mt_volt_range6, MT6359P_RG_LDO_VSRAM_PROC1_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_PROC1_EN_ADDR,
 			  MT6359P_DA_VSRAM_PROC1_B_EN_ADDR,
 			  MT6359P_RG_LDO_VSRAM_PROC1_VOSEL_ADDR,
 			  MT6359_RG_LDO_VSRAM_PROC1_VOSEL_MASK <<
@@ -979,7 +940,7 @@ static struct mt6359_regulator_info mt6359p_regulators[] = {
 		   MT6359_RG_VSIM2_VOSEL_MASK << MT6359_RG_VSIM2_VOSEL_SHIFT,
 		   480),
 	MT6359_LDO_LINEAR("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB,
-			  500000, 1293750, 6250, 0, mt_volt_range6,
+			  500000, 1293750, 6250,
 			  MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_EN_ADDR,
 			  MT6359P_DA_VSRAM_OTHERS_B_EN_ADDR,
 			  MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_ADDR,
-- 
2.25.1

