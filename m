Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1271537B748
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhELH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhELH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:59:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:58:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b15so5931564plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+C0nUFVgs9ztPs7RXQOMTgel0gmWhONAZSzmf96Fjo=;
        b=QZNsg+X+bp5LJd+j53kxqT5tMo/9kPJmEqiRLJECfZxft16/ACFIQ4Z0tdcUtY4atX
         9gQAmNXswArZd/kSESFHQFgjiiCrPg/d7a6MmiPtPQY2Z00LUYaCzcU9toCBZDqSUoaV
         8Jd/Cb6BVSpsuybgqCVI2HSlkr4MGQ+Fhx4O7JlA9UZ56dcUsd1KeYauiLpCdzuNLWmA
         yCenKDGW4MHqb0fkm1dRy1GCCledLGHeDHlGjI8hXa8VSKGufYL5bC9SVBovJC1cKsrn
         Ky7ve+VTKdFVKnJMJfqC4pZkvJmgjrA358gKqNnELCWx9oV9tD9WYrwmR8WJYY4a+tJx
         0kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+C0nUFVgs9ztPs7RXQOMTgel0gmWhONAZSzmf96Fjo=;
        b=OWx1R3cpBVlBcUttF8PC+dB4/pjd3BQUDeb5YJuZ8xw9keb0pcV5sf/B7t1ufEp93Q
         BfS02j2lW2s9nvJBomQtvSI+kFTqypC+PDlPgcgrV0RUDMO2Xz6yhiRVVd+fs9DQ24AZ
         nOOBpJ7LXjUvmCte8I2+zONUHSuR9Tw9Gmsww/abL33knef7XBIHhbPuHDcISeNaANgo
         xHfYKxaPRRDjUWuJE4pyP6ouL5OOrfncYL60/XiL4wlUwnlFOiqhr8UjynOdLllYIIrC
         b9jO8nB9oQwpuUakinR2bl2Sa7g/RahXomSasPlGlx++XlJ71rEZFaaosYUXBei0Q/y1
         ydBQ==
X-Gm-Message-State: AOAM531t2T6TFRYToE2a4dJ6JkOBW94bEmoCqbuLrj0/g9xTPUH6lHZH
        MKUONqUbPT/sd6QR19JStjRS8Q==
X-Google-Smtp-Source: ABdhPJzWLTXBhI7/HmyT3Sa3GQxFblVMuCRO4ZQds+qhV1gqjFKll2kaBNqunFs2mtOOgXkS1NY67A==
X-Received: by 2002:a17:902:b104:b029:ee:beb3:ef0a with SMTP id q4-20020a170902b104b02900eebeb3ef0amr34004970plr.80.1620806314457;
        Wed, 12 May 2021 00:58:34 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id y17sm6650626pfr.119.2021.05.12.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:58:33 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: cros-ec: Fix error code in dev_err message
Date:   Wed, 12 May 2021 15:58:24 +0800
Message-Id: <20210512075824.620580-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show proper error code instead of 0.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cros-ec-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index eb3fc1db4edc..c4754f3cf233 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -225,8 +225,9 @@ static int cros_ec_regulator_probe(struct platform_device *pdev)
 
 	drvdata->dev = devm_regulator_register(dev, &drvdata->desc, &cfg);
 	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-		return PTR_ERR(drvdata->dev);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, drvdata);
-- 
2.25.1

