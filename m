Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE63B72EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhF2NHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhF2NHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:07:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE7C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g21so15430655pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrWs2dcQQbgOae2afCRNt5dMIBQMgs08LTHn8M2WFwg=;
        b=W/VJ9uwFGEFVmSckJPfKA46s+bbC+0CKNOIKrivOK33+cZviPX5bIEZzmgxz68zruP
         cEwvcKZs0Fx7bYKhc0HvaPZdVq2TpgFkgJhoQPg1pZ7jksgBl/4RerDmi+aWgYmP7Fy9
         q09cUx8sASxsTj100nus9BYQSpuhUoAQ+aDQdTlt5rJUMmE5HX6hnbzIWQZHzN/+v0HP
         N/cwf0qpNuN57gS4xvWR8zbkhanYUVjZopaLS3qTeSNgVygxWPjH5xVzb5WsEzW38t8q
         e1bTB3wSZ4gEd7mAnMX99N8m33LuL3t/3qwOdM5ktH43YGD8+T56qn+MQDaGC+JviEZw
         KlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrWs2dcQQbgOae2afCRNt5dMIBQMgs08LTHn8M2WFwg=;
        b=iW4HVfc4o9g5b8aYY7AAiroEH/6wjlzUal53Hce7xLMI/fuiZLRRhzogGsE+E+hQ/6
         6IS4rs9GFsRy3DcKpme/8CfJaQlPQKcjclUb2oLNnMuPeWvWXpDy/5VPBHZJcK4yDWGk
         Xa+Vy0bIQmntJcoi2HF9UmGfC5IG3xG3EOJbOafq8m4YQWKwrLnzFsRCw2QzyZLQXVg/
         wXiOTfJGNbpfTdpevz6Jr2A+RM1vuFYrG8mAgWUaraXF1lOX9HsjIt7uAY7ncamiJViN
         vC39QAhPKthZ2L0xoHvw7uAzymrqvKbSOm8suOPLhQsMWwakWn017NedM8JfuIuQk6sN
         YeHw==
X-Gm-Message-State: AOAM5300pna8M4DXQ5+10I1wXLT/9+HR3j7UoAMgHjdh/RHsbuvFUQfV
        CbmXZCxflZWuOZNSLMvi0FSTDg==
X-Google-Smtp-Source: ABdhPJxeKX8hi/esqw5TO9vNZ9dpHw2w/oMYdY2ij0Il3pTsGjSzBttJgQ/8/xirZghrbI8oB5AvBg==
X-Received: by 2002:aa7:8254:0:b029:2ed:b41:fefc with SMTP id e20-20020aa782540000b02902ed0b41fefcmr30374718pfn.42.1624971918745;
        Tue, 29 Jun 2021 06:05:18 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u13sm18766769pga.64.2021.06.29.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:05:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>, Wen Su <wen.su@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: mt6397: Remove modeset_shift from struct mt6397_regulator_info
Date:   Tue, 29 Jun 2021 21:05:03 +0800
Message-Id: <20210629130503.2183574-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629130503.2183574-1-axel.lin@ingics.com>
References: <20210629130503.2183574-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shift setting can be calculated via the corresponding mask field,
so remove modeset_shift.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6397-regulator.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 0a30df5e414f..b9bf7ade1f8a 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -32,7 +32,6 @@ struct mt6397_regulator_info {
 	u32 vselctrl_mask;
 	u32 modeset_reg;
 	u32 modeset_mask;
-	u32 modeset_shift;
 };
 
 #define MT6397_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
@@ -61,7 +60,6 @@ struct mt6397_regulator_info {
 	.vselctrl_mask = BIT(1),					\
 	.modeset_reg = _modeset_reg,					\
 	.modeset_mask = BIT(_modeset_shift),				\
-	.modeset_shift = _modeset_shift					\
 }
 
 #define MT6397_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
@@ -175,11 +173,11 @@ static int mt6397_regulator_set_mode(struct regulator_dev *rdev,
 		goto err_mode;
 	}
 
-	dev_dbg(&rdev->dev, "mt6397 buck set_mode %#x, %#x, %#x, %#x\n",
-		info->modeset_reg, info->modeset_mask,
-		info->modeset_shift, val);
+	dev_dbg(&rdev->dev, "mt6397 buck set_mode %#x, %#x, %#x\n",
+		info->modeset_reg, info->modeset_mask, val);
+
+	val <<= ffs(info->modeset_mask) - 1;
 
-	val <<= info->modeset_shift;
 	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
 				 info->modeset_mask, val);
 err_mode:
@@ -204,7 +202,10 @@ static unsigned int mt6397_regulator_get_mode(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	switch ((regval & info->modeset_mask) >> info->modeset_shift) {
+	regval &= info->modeset_mask;
+	regval >>= ffs(info->modeset_mask) - 1;
+
+	switch (regval) {
 	case MT6397_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
 	case MT6397_BUCK_MODE_FORCE_PWM:
-- 
2.25.1

