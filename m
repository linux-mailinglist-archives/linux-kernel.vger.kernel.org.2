Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D83ACD46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhFROQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:16:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE234C061767
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:14:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g6so7801610pfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvGGydPfxJPTCbBZHjXWcmwTH4QszJeUIL9ROnYW6B8=;
        b=WAToPKOtsLQP1XdybIZCFClE+6Fww3bS3j9cYufBJJu6KMB1z12dCOvveg9yWFP6Q6
         j4dn/wkqpLElg1dtf8avYv9pDHv9Wbt4NeBoCOzb+o7QmVMTDN5eLkED5Sr0lAlNVqRu
         E/gh4xCNZM46N+mtgZUsuyCg0S/ppY8pshYn7G9CaD020E6prKgAFUGHJD8jHyptw6Q/
         +gx2GMQPBvu7fcH/pX4ZcQz7KFfCgxdy8PLw1j3KbvWIwA2alhFtbdnXgzM/7Of5OhUJ
         auTdhPbS0qZOt+wCiiyYbplH7QuBxgNG/wUUgMEBLYDJghnsj6mk/y8BpGG16ibOjAFa
         ApMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvGGydPfxJPTCbBZHjXWcmwTH4QszJeUIL9ROnYW6B8=;
        b=dgl7J4c9fNMQkcS0/KAvp/YyHMOySqUA2/R5uyxSlzGB40aNst9q7tP32+Mw9iKj1V
         Cujlro5w0sqDjDSTbb+KvPwLfT9sGP/B5qeBDiIG0E2F6V4XpT7zOz9L6f3pQatGTsOn
         X4AymQjB/7lsPvG+KnuSrvkBfpe47amI7JNFkDm0sxUS4dPB/EWaoPcDZO98KRk7N/jH
         eOD6h5n9pkTI4Ye+rhQBOJrpROebRvjwNZdDgWwXsF74qx6OMJ8NSCcUm12HUf9PZRB2
         RuZGj6ygKW8lk1Y3Aiae/Bj682vujTat8z52isW9SPwFaxvao/7HO4FmeELkdxkUbBkS
         50jw==
X-Gm-Message-State: AOAM5338n/HscYn9XIWjtLTvnnFwXm9+bVdVIsd6AQSMhQWtGX/zmzV2
        hAjKb+tCalfltRiU+1ybOWh43w==
X-Google-Smtp-Source: ABdhPJwAjwQ2URWJof6f9wf0caDabN5nD2RH6piTgFPrAclb1VyyIRfwTX/ZcRL1aBVftyVfUrZS3g==
X-Received: by 2002:a65:4c05:: with SMTP id u5mr10274306pgq.430.1624025669186;
        Fri, 18 Jun 2021 07:14:29 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id y7sm2431874pja.8.2021.06.18.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:14:28 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9052: Simplify checking DVC controlled regulators
Date:   Fri, 18 Jun 2021 22:14:12 +0800
Message-Id: <20210618141412.4014912-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618141412.4014912-1-axel.lin@ingics.com>
References: <20210618141412.4014912-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only DVC controlled regulators have activate_bit set, so just check
activate_bit we can know if the regulator is DVC controlled.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9052-regulator.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 23fa429ebe76..74ab8d615d1f 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -207,7 +207,6 @@ static int da9052_regulator_set_voltage_sel(struct regulator_dev *rdev,
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
 	struct da9052_regulator_info *info = regulator->info;
-	int id = rdev_get_id(rdev);
 	int ret;
 
 	ret = da9052_reg_update(regulator->da9052, rdev->desc->vsel_reg,
@@ -218,16 +217,9 @@ static int da9052_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	/* Some LDOs and DCDCs are DVC controlled which requires enabling of
 	 * the activate bit to implment the changes on the output.
 	 */
-	switch (id) {
-	case DA9052_ID_BUCK1:
-	case DA9052_ID_BUCK2:
-	case DA9052_ID_BUCK3:
-	case DA9052_ID_LDO2:
-	case DA9052_ID_LDO3:
+	if (info->activate_bit)
 		ret = da9052_reg_update(regulator->da9052, DA9052_SUPPLY_REG,
 					info->activate_bit, info->activate_bit);
-		break;
-	}
 
 	return ret;
 }
@@ -238,22 +230,14 @@ static int da9052_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
 	struct da9052_regulator_info *info = regulator->info;
-	int id = rdev_get_id(rdev);
 	int ret = 0;
 
 	/* The DVC controlled LDOs and DCDCs ramp with 6.25mV/µs after enabling
 	 * the activate bit.
 	 */
-	switch (id) {
-	case DA9052_ID_BUCK1:
-	case DA9052_ID_BUCK2:
-	case DA9052_ID_BUCK3:
-	case DA9052_ID_LDO2:
-	case DA9052_ID_LDO3:
+	if (info->activate_bit)
 		ret = DIV_ROUND_UP(abs(new_sel - old_sel) * info->step_uV,
 				   6250);
-		break;
-	}
 
 	return ret;
 }
-- 
2.25.1

