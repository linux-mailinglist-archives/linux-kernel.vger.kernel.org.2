Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA583B72EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhF2NHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhF2NHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:07:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD4C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:16 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a2so18407996pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKfmz8t47CqIM37pOlVCg+EhrWGwQj3fLRBm0vwCV98=;
        b=XVJAtzCWh1fWlHtSQEACZwh4PdAQ+zvld8uozuCGB4yNAN+Ee2zZ3IFXfQLnahmRGO
         cnfwQA8rr0KJPFcL8hxGdDp9TevcVABSag6SSyQ1h9Rus5xA81hIpcjyyv6VpCRS1Uc6
         p8Cy5kAnxtJfDFsl1tzSjdL8MMR97IrjRdN4vWWnahj5fgIuPM7AaRNr5AykNHjA/27U
         KGQp28XQY9ONzrc39xC93/+vONSgoZmmLzmNykXYLZWRHPwlBy+SoDG6ETFAh8ui9hnw
         Pdum5/G+ae1wtbivCbUIQSuVmCvPFlae/LhqqkkrL2ZFIvjX1pzy8lxuqOmkUkOU9vdF
         xLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKfmz8t47CqIM37pOlVCg+EhrWGwQj3fLRBm0vwCV98=;
        b=tFiHKKlBidZafjWGkVj0Bu6l4nH14bOhCcNFYftv3B6/rQr9o6bu9ypFIkzGF70LlC
         zJ3ifXB6td23r63YyiqX+sQQP2lskgCH0Ig+bLSUV56gu4m7RwGdV3bBauDTqyH/Lvsb
         6rZtdFecovz0YUbFvr7HOK0wakPehvAlN2PPd3k91++ItlECp8rdMkCmgj7foRUtbeSf
         k50gR2GXjCAFNlL5CJ7yZldEGPyI4EprqmEDq87V3L1Qk5YwpY7/aT02G17fK0wfIkXK
         2SwTHVbZlPxAkO7R57UT3TlKicLA9avgdpjfqrWWDJusZyyEhPA3dN/DWxj74KyPBaRb
         jhbA==
X-Gm-Message-State: AOAM532bBWqN28vG0UVt9jbjK+QZCV6NvQLX4r6tdMJGURYd63UcYrwz
        zEjbcs4FdFvftB2DWVku+Wi4Jw==
X-Google-Smtp-Source: ABdhPJyIyYg8JG/Z8Idkq/XBSEaaan7S0+wpaJ8uIBR2zpiPJFkaRA6re4WAPPyBUROAh7m5QKGBnw==
X-Received: by 2002:a63:f54f:: with SMTP id e15mr28671575pgk.64.1624971915852;
        Tue, 29 Jun 2021 06:05:15 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u13sm18766769pga.64.2021.06.29.06.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:05:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>, Wen Su <wen.su@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: mt6359: Remove shift fields from struct mt6359_regulator_info
Date:   Tue, 29 Jun 2021 21:05:02 +0800
Message-Id: <20210629130503.2183574-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629130503.2183574-1-axel.lin@ingics.com>
References: <20210629130503.2183574-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shift setting can be calculated via the corresponding mask field,
so remove these shift fields.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6359-regulator.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index 7ce0bd377a08..de3b0462832c 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -27,7 +27,6 @@
  * @qi: Mask for query enable signal status of regulators.
  * @modeset_reg: for operating AUTO/PWM mode register.
  * @modeset_mask: MASK for operating modeset register.
- * @modeset_shift: SHIFT for operating modeset register.
  */
 struct mt6359_regulator_info {
 	struct regulator_desc desc;
@@ -35,10 +34,8 @@ struct mt6359_regulator_info {
 	u32 qi;
 	u32 modeset_reg;
 	u32 modeset_mask;
-	u32 modeset_shift;
 	u32 lp_mode_reg;
 	u32 lp_mode_mask;
-	u32 lp_mode_shift;
 };
 
 #define MT6359_BUCK(match, _name, min, max, step,		\
@@ -68,10 +65,8 @@ struct mt6359_regulator_info {
 	.qi = BIT(0),						\
 	.lp_mode_reg = _lp_mode_reg,				\
 	.lp_mode_mask = BIT(_lp_mode_shift),			\
-	.lp_mode_shift = _lp_mode_shift,			\
 	.modeset_reg = _modeset_reg,				\
 	.modeset_mask = BIT(_modeset_shift),			\
-	.modeset_shift = _modeset_shift				\
 }
 
 #define MT6359_LDO_LINEAR(match, _name, min, max, step,		\
@@ -282,8 +277,10 @@ static unsigned int mt6359_regulator_get_mode(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	if ((regval & info->modeset_mask) >> info->modeset_shift ==
-		MT6359_BUCK_MODE_FORCE_PWM)
+	regval &= info->modeset_mask;
+	regval >>= ffs(info->modeset_mask) - 1;
+
+	if (regval == MT6359_BUCK_MODE_FORCE_PWM)
 		return REGULATOR_MODE_FAST;
 
 	ret = regmap_read(rdev->regmap, info->lp_mode_reg, &regval);
@@ -310,7 +307,7 @@ static int mt6359_regulator_set_mode(struct regulator_dev *rdev,
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
 		val = MT6359_BUCK_MODE_FORCE_PWM;
-		val <<= info->modeset_shift;
+		val <<= ffs(info->modeset_mask) - 1;
 		ret = regmap_update_bits(rdev->regmap,
 					 info->modeset_reg,
 					 info->modeset_mask,
@@ -319,14 +316,14 @@ static int mt6359_regulator_set_mode(struct regulator_dev *rdev,
 	case REGULATOR_MODE_NORMAL:
 		if (curr_mode == REGULATOR_MODE_FAST) {
 			val = MT6359_BUCK_MODE_AUTO;
-			val <<= info->modeset_shift;
+			val <<= ffs(info->modeset_mask) - 1;
 			ret = regmap_update_bits(rdev->regmap,
 						 info->modeset_reg,
 						 info->modeset_mask,
 						 val);
 		} else if (curr_mode == REGULATOR_MODE_IDLE) {
 			val = MT6359_BUCK_MODE_NORMAL;
-			val <<= info->lp_mode_shift;
+			val <<= ffs(info->lp_mode_mask) - 1;
 			ret = regmap_update_bits(rdev->regmap,
 						 info->lp_mode_reg,
 						 info->lp_mode_mask,
@@ -336,7 +333,7 @@ static int mt6359_regulator_set_mode(struct regulator_dev *rdev,
 		break;
 	case REGULATOR_MODE_IDLE:
 		val = MT6359_BUCK_MODE_LP >> 1;
-		val <<= info->lp_mode_shift;
+		val <<= ffs(info->lp_mode_mask) - 1;
 		ret = regmap_update_bits(rdev->regmap,
 					 info->lp_mode_reg,
 					 info->lp_mode_mask,
-- 
2.25.1

