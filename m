Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68C399DED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:40:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A1C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 02:38:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5129973pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJVx2e8jat3LPO0MA1mW/6NjqK86xYwclQVAjIDvpFA=;
        b=kBobC8J/q1beY+q9QDF5JLY0qin7W7RjZ64fi3os6tbVPFzE0I4A5pxH7B9owHQj5M
         ClyOMue/B/dQFcY7pookBtDqUSCxiDECsajGir9/wigxLOstMCZOq7opaxxoBS/T/q6b
         Os1MNKphrsEx3mN9zOOqPn7kOSmCV9UIKm5yKi7AlHtMRPTVji+jk/87RfTqjaXWhydb
         zt9iiK+T1Ia+DQ8st4rSUnXKjiy8GwD8p6e6hooP5WkDyxHbC4Ubxdazdcg9LwAp5ZLM
         KR2sijgKvtrPoQM4du14qPgLE6AJrVu2Qogt9NNysFBKzRbGZ/yPc06QgqF87DmSom4M
         eIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJVx2e8jat3LPO0MA1mW/6NjqK86xYwclQVAjIDvpFA=;
        b=AXuKkSJBxtGGhCt9MvaTRYjZL+a+qBO0jWs75krX0YNOlkK4wtXji7RZtx+BpmE5CU
         pB4wAJFndsk9ZaS9m/IJ/VyLAzcXkb9OKDG4OV+U/FMCYOp/3N45G6JCbtYG2Evs/JGu
         /HoK2QvoVsZQGMCpOGu4xrbIm/0Yth3BujjCCBq+ZsIFwd1nAw7aAx/H7jpuloaLYEnJ
         xUbiIOd4rN28ZVb8YIHPtF186r4RBQeDhGU1nYky0e2TLNndKRaASljr20AdVX77uzSb
         yC2XGhs+ihWnb7G/jGXUvqKkm13aBS4mGMSJ18PuP1pbyxsJ2LWa9zYsxSpMgBIcGKUm
         avRw==
X-Gm-Message-State: AOAM530uHt/do6Lo7b0IjUEbb5FvpPYtcopivXkLAeSp5BOY0u0JKd2N
        RBqLAhZyeE00Wr/dbDUqP19+mQ==
X-Google-Smtp-Source: ABdhPJzQ32iQ8G9hEXLzGLpc27HQPuir4y1ykDqoWbVXwHhz3UjreiRgIwLCksgyAtEczTsEilwa7A==
X-Received: by 2002:a17:90a:5507:: with SMTP id b7mr10062739pji.27.1622713112150;
        Thu, 03 Jun 2021 02:38:32 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id s23sm1712113pjg.15.2021.06.03.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:38:31 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
Date:   Thu,  3 Jun 2021 17:38:09 +0800
Message-Id: <20210603093809.1108629-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rt6160-regulator.c | 35 +++++++---------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index 4588ae0748a5..69550284083d 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -46,6 +46,10 @@ struct rt6160_priv {
 	bool enable_state;
 };
 
+static const unsigned int rt6160_ramp_tables[] = {
+	1000, 2500, 5000, 10000
+};
+
 static int rt6160_enable(struct regulator_dev *rdev)
 {
 	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
@@ -140,31 +144,6 @@ static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
 }
 
-static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int target)
-{
-	struct regmap *regmap = rdev_get_regmap(rdev);
-	const int ramp_tables[] = { 1000, 2500, 5000, 10000 };
-	unsigned int i, sel;
-
-	/* Find closest larger or equal */
-	for (i = 0; i < ARRAY_SIZE(ramp_tables); i++) {
-		sel = i;
-
-		/* If ramp delay is equal to 0, directly set ramp speed to fastest */
-		if (target == 0) {
-			sel = ARRAY_SIZE(ramp_tables) - 1;
-			break;
-		}
-
-		if (target <= ramp_tables[i])
-			break;
-	}
-
-	sel <<= ffs(RT6160_RAMPRATE_MASK) - 1;
-
-	return regmap_update_bits(regmap, RT6160_REG_CNTL, RT6160_RAMPRATE_MASK, sel);
-}
-
 static int rt6160_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
 {
 	struct regmap *regmap = rdev_get_regmap(rdev);
@@ -203,7 +182,7 @@ static const struct regulator_ops rt6160_regulator_ops = {
 	.set_mode = rt6160_set_mode,
 	.get_mode = rt6160_get_mode,
 	.set_suspend_voltage = rt6160_set_suspend_voltage,
-	.set_ramp_delay = rt6160_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 	.get_error_flags = rt6160_get_error_flags,
 };
 
@@ -292,6 +271,10 @@ static int rt6160_probe(struct i2c_client *i2c)
 	priv->desc.vsel_reg = RT6160_REG_VSELH;
 	priv->desc.vsel_mask = RT6160_VSEL_MASK;
 	priv->desc.n_voltages = RT6160_N_VOUTS;
+	priv->desc.ramp_reg = RT6160_REG_CNTL;
+	priv->desc.ramp_mask = RT6160_RAMPRATE_MASK;
+	priv->desc.ramp_delay_table = rt6160_ramp_tables;
+	priv->desc.n_ramp_values = ARRAY_SIZE(rt6160_ramp_tables);
 	priv->desc.of_map_mode = rt6160_of_map_mode;
 	priv->desc.ops = &rt6160_regulator_ops;
 	if (priv->vsel_active_low)
-- 
2.25.1

