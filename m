Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA193950F4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhE3Mmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 08:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3Mmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 08:42:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B13C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:41:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j12so6265180pgh.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEm2IiRLQFheRXp4oiBPyjN0y451oAuF0ZcGpstUmjE=;
        b=GIUgOuAhGj6VnkrYw2OsLR5ggSVOrNMkwUmgiXnzWJFXQgAcFF9vtKgPjNM+yrr8iM
         OTSHGvJ330awNMzvHTkjP4SDRjZwtRFQ6YI9LAMyLnD51KfhR+ratORXziSzDgnLZet5
         ROMe7kCbl8Reh3zm0vvKenDDt6iJfliNpMYEBJwH99E09GQswMlKubpIM5awIp0l6/oH
         KjqkrcZa+dULo+sSHgDGjpEfpoez2RZk4QKn+6WzBvghqpDe2hk8tOSLI63y85Dmk0TH
         lMkpDE6qfRuWOQv4GB1BlbNaspqWzoX+m3cRZXOms2M9FI8BQAMlm8jHsNPJHDU/0cKh
         wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEm2IiRLQFheRXp4oiBPyjN0y451oAuF0ZcGpstUmjE=;
        b=Hfh2ezsPr/cyYDXgDs8fGM/a1zhlajtns/L8uDdMeDXr+DS6iX+k5PMo6HcC2THPTN
         tXuMf/yeaPcw07IxmbNXqC8Enz9tljw/0JsZb3ohTxOm6iCtd9u0iN6qq7aR2n2cc/tR
         asbdwnjXRlEzBtz6W8ZrELWyvAPbItnzkXQqYeAbvcROJRUbAJGrHENwxen3HixaNTDn
         VyhmH33R6VoI12XjS44MLGes631TOIotYh7I3KBQZ8N/A+3uIFD75Waxwl0bDjzbO95C
         0xKdknoynnGNyVvaV5Sza2UXRswcpaFX1jc6siXZZ/sVBzX4z9PagT/xmNduxgCkJ+L2
         R8cQ==
X-Gm-Message-State: AOAM533QTQzOOu5RZsmPmqUYLr/dmn+6/dNrHzx/btjGcq2dYTZQu15d
        Owj+1vZA7Ge9aNOYwE+d44lY63RMlvJqaHBL
X-Google-Smtp-Source: ABdhPJxPl/zVZXj5BZjJd+bGrSItCwlNulrUnlDUY4vGX0LWWfE5SRyOYpb3eSkmTICb7i0B2Lg3Qw==
X-Received: by 2002:a65:584d:: with SMTP id s13mr18276277pgr.97.1622378473988;
        Sun, 30 May 2021 05:41:13 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id c11sm8661658pjr.32.2021.05.30.05.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 05:41:13 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT 1/2] regulator: rtmv20: Fix .set_current_limit/.get_current_limit callbacks
Date:   Sun, 30 May 2021 20:41:00 +0800
Message-Id: <20210530124101.477727-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code does not set .curr_table and .n_linear_ranges settings,
so it cannot use the regulator_get/set_current_limit_regmap helpers.
If we setup the curr_table, it will has 200 entries.
Implement customized .set_current_limit/.get_current_limit callbacks
instead.

Fixes: b8c054a5eaf0 ("regulator: rtmv20: Adds support for Richtek RTMV20 load switch regulator")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi ChiYuan,
I don't have this h/w to test.
Please help to review and test this patch.

Thanks,
Axel

 drivers/regulator/rtmv20-regulator.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 852fb2596ffd..5adc552dffd5 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -103,9 +103,47 @@ static int rtmv20_lsw_disable(struct regulator_dev *rdev)
 	return 0;
 }
 
+static int rtmv20_lsw_set_current_limit(struct regulator_dev *rdev, int min_uA,
+					int max_uA)
+{
+	int sel;
+
+	if (min_uA > RTMV20_LSW_MAXUA || max_uA < RTMV20_LSW_MINUA)
+		return -EINVAL;
+
+	if (max_uA > RTMV20_LSW_MAXUA)
+		max_uA = RTMV20_LSW_MAXUA;
+
+	sel = (max_uA - RTMV20_LSW_MINUA) / RTMV20_LSW_STEPUA;
+
+	/* Ensure the selected setting is still in range */
+	if ((sel * RTMV20_LSW_STEPUA + RTMV20_LSW_MINUA) < min_uA)
+		return -EINVAL;
+
+	sel <<= ffs(rdev->desc->csel_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->csel_reg,
+				  rdev->desc->csel_mask, sel);
+}
+
+static int rtmv20_lsw_get_current_limit(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->csel_reg, &val);
+	if (ret)
+		return ret;
+
+	val &= rdev->desc->csel_mask;
+	val >>= ffs(rdev->desc->csel_mask) - 1;
+
+	return val * RTMV20_LSW_STEPUA + RTMV20_LSW_MINUA;
+}
+
 static const struct regulator_ops rtmv20_regulator_ops = {
-	.set_current_limit = regulator_set_current_limit_regmap,
-	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = rtmv20_lsw_set_current_limit,
+	.get_current_limit = rtmv20_lsw_get_current_limit,
 	.enable = rtmv20_lsw_enable,
 	.disable = rtmv20_lsw_disable,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.25.1

