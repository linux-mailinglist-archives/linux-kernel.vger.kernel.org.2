Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD263B807F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhF3KCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhF3KCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:02:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:00:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so3566070pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsYOnt9j9HICCQWTti4le34/jwD9chrvMowLel+zsdc=;
        b=hg0mq1gatKH0sXRT0it39MR9P4Nlr5cxrJaYhttTzDifYA4cejZcONG33vbfmw74ET
         nsNl6QOIfbRm9H18TWnkdQWGINkcc5laeJJE+LUS3mBiidKCcubFB6Q6MNfgDz1ZN8OU
         Sz2UUodo7CXEMEYGOJ30hsnFKO0s3dRL+pzgFoJCqXc1wz+KZSNtsn5fj+7W/0B8xjyO
         nCyLmzhux1q7k9B+cg2zRRy2LlJfneSIHrtFVMhK5ANBdx+quE+Ulw54BkdAX6GRhxOS
         W+G5coicd1rnW4686CjqFD8UD0PWiBEpneyOGNfP/Rqpy3Lj3K8I0osK8GpzjSug42WO
         yV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsYOnt9j9HICCQWTti4le34/jwD9chrvMowLel+zsdc=;
        b=HjwWYf5SVfLn6hmRdShI779QQc0e+X2kf/pA6p6e3b2RO5duph1GEH2Q0uYZnC4BSo
         J+VTm0PeqbjLY7gqPDUgMcU2Docl73M0p+WBuVh2187vsAwXKxu6a8B+7I5JzrzzZisY
         oS0F/PFH90RHq0T38a7KVi6w/EKJQIXOiH7/4Egc54jGEjd4ZHGTb84dQu3wCE/T33Wd
         dnntOyjuapZb4WJW5gD6RZ1aRrmdexXV8Qf3aabLv78AeGu0AYxg/so6cV31hfTgWREJ
         rRTWgw5hh2cp2WvTTtbM8XRF92G28YwplaKZ0a9ddIIILjVf6yXqyt+74JYmGMJXRwfj
         kxUQ==
X-Gm-Message-State: AOAM533cB/oJPZEtGzebXc8c9ruKZrjy52nYTMwSZ7uISBanudShMb29
        h8Cc86z57nYmKi0BnY4Vs8lWy82WQJqsWRBh
X-Google-Smtp-Source: ABdhPJws+bnH72NYuVIyhadvU6+p2SrBBlZ7FSw/R8Udd1nbD3v2crgkdKIeH1vtOPVblOjEYxKMVw==
X-Received: by 2002:a17:902:ecc6:b029:128:ed8c:a025 with SMTP id a6-20020a170902ecc6b0290128ed8ca025mr10433035plh.64.1625047219270;
        Wed, 30 Jun 2021 03:00:19 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id md10sm6054830pjb.42.2021.06.30.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:00:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: hi6421: Fix getting wrong drvdata
Date:   Wed, 30 Jun 2021 17:59:59 +0800
Message-Id: <20210630095959.2411543-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since config.dev = pdev->dev.parent in current code, so
dev_get_drvdata(rdev->dev.parent) call in hi6421_regulator_enable
returns the drvdata of the mfd device rather than the regulator. Fix it.

This was broken while converting to use simplified DT parsing because the
config.dev changed from pdev->dev to pdev->dev.parent for parsing the
parent's of_node.

Fixes: 29dc269a85ef ("regulator: hi6421: Convert to use simplified DT parsing")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This is similar to the hi6421v600 regression issue.
 drivers/regulator/hi6421-regulator.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index bff8c515dcde..d144a4bdb76d 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -366,9 +366,8 @@ static struct hi6421_regulator_info
 
 static int hi6421_regulator_enable(struct regulator_dev *rdev)
 {
-	struct hi6421_regulator_pdata *pdata;
+	struct hi6421_regulator_pdata *pdata = rdev_get_drvdata(rdev);
 
-	pdata = dev_get_drvdata(rdev->dev.parent);
 	/* hi6421 spec requires regulator enablement must be serialized:
 	 *  - Because when BUCK, LDO switching from off to on, it will have
 	 *    a huge instantaneous current; so you can not turn on two or
@@ -385,9 +384,10 @@ static int hi6421_regulator_enable(struct regulator_dev *rdev)
 
 static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
+	struct hi6421_regulator_info *info;
 	unsigned int reg_val;
 
+	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 	if (reg_val & info->mode_mask)
 		return REGULATOR_MODE_IDLE;
@@ -397,9 +397,10 @@ static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 
 static unsigned int hi6421_regulator_buck_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
+	struct hi6421_regulator_info *info;
 	unsigned int reg_val;
 
+	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 	if (reg_val & info->mode_mask)
 		return REGULATOR_MODE_STANDBY;
@@ -410,9 +411,10 @@ static unsigned int hi6421_regulator_buck_get_mode(struct regulator_dev *rdev)
 static int hi6421_regulator_ldo_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
-	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
+	struct hi6421_regulator_info *info;
 	unsigned int new_mode;
 
+	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
 		new_mode = 0;
@@ -434,9 +436,10 @@ static int hi6421_regulator_ldo_set_mode(struct regulator_dev *rdev,
 static int hi6421_regulator_buck_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
-	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
+	struct hi6421_regulator_info *info;
 	unsigned int new_mode;
 
+	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
 		new_mode = 0;
@@ -459,7 +462,9 @@ static unsigned int
 hi6421_regulator_ldo_get_optimum_mode(struct regulator_dev *rdev,
 			int input_uV, int output_uV, int load_uA)
 {
-	struct hi6421_regulator_info *info = rdev_get_drvdata(rdev);
+	struct hi6421_regulator_info *info;
+
+	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 
 	if (load_uA > info->eco_microamp)
 		return REGULATOR_MODE_NORMAL;
@@ -543,14 +548,13 @@ static int hi6421_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 	mutex_init(&pdata->lock);
-	platform_set_drvdata(pdev, pdata);
 
 	for (i = 0; i < ARRAY_SIZE(hi6421_regulator_info); i++) {
 		/* assign per-regulator data */
 		info = &hi6421_regulator_info[i];
 
 		config.dev = pdev->dev.parent;
-		config.driver_data = info;
+		config.driver_data = pdata;
 		config.regmap = pmic->regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, &info->desc,
-- 
2.25.1

