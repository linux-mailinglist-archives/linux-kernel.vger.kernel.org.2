Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2982B3B7E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhF3Hpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhF3Hph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:45:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBEC061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:43:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g22so1414261pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIw5Yrq9q/YX9w76I4+VS10VcJJXkGY5L3EC5IkaPXI=;
        b=MCAdhewHdNIm3Qgxkn8K+aZEiEIJZkCzSapzpMtqL5/dUWeXAty1DOUnmTzIlaPkf7
         +hQ3pPl8W5ooVDTWUg9t4pSphU1lCTvY1EFJFTYIRUFKgaKo0raYu0tWAgd2S03K9+uZ
         1JWTvrlh7nNv0ej+KzT+qic2H/YKQhR36syfm+1gUnJRTsTH9qXzGvP40ytuP7sHSWsK
         T4vg6X2iJ7wXTDYSZAPuenfaZR6UG6zPkm6N08ZN30fJt7i58zI0bClA8zjsrZolYSPD
         lE2gMbNU2+DQlVGa/PXamVy2AKvv4Zsrgq/7gvInW0ah8VfTJ9AEkFnMEHK+y/nHao4M
         GGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIw5Yrq9q/YX9w76I4+VS10VcJJXkGY5L3EC5IkaPXI=;
        b=oFz28IwRUTPj+0gmVCglB+nB+xhuD2s6+R+Y1Ja9TGAeMnd/VfyXNnADz6y8kokPFa
         8pXeRNBtCa/ZH5ZAGjMqDaoLEVzPAthZ3I4+aaojYYzZOjZp0W4VpRF3aC+ThBtS8Un8
         0cBsQmJ1ko+PEouowsLPDVrlcw5Teh2HQDpKtvsXvfAsUB0IjwE53xW6DrGj5M+L2F7r
         FEIC91RphkcNNXDuXqh5kRx8cvnujzDGVOH+63u/X6/7shwGIsqMAQSvzfLCMqNeDn7D
         0TILxSPMLYaW25o9O21D4fQxR8YDBzX+oqMzErrfTe4S9xjEGAx94Bg7ZdKOcCiol/MF
         HFmQ==
X-Gm-Message-State: AOAM530i/yvMFhf/BzTVwxKPvmeLpQSeuleUpKk7L4fTpfz3+y2Y4/vi
        JXtxLRcxirFKaBzF+bt+wxtKRA==
X-Google-Smtp-Source: ABdhPJwSUMRF3UQo4guCNMtUDUu/ZjqTwWyGNvrTl3OFJv6jAa/QdjcqwiivDOfZ9LOgi2D9c9LmJA==
X-Received: by 2002:a63:794:: with SMTP id 142mr1418044pgh.198.1625038988656;
        Wed, 30 Jun 2021 00:43:08 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id o20sm3142586pgv.80.2021.06.30.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 00:43:07 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: hi6421v600: Fix getting wrong drvdata that causes boot failure
Date:   Wed, 30 Jun 2021 15:42:46 +0800
Message-Id: <20210630074246.2305166-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since config.dev = pdev->dev.parent in current code, so
dev_get_drvdata(rdev->dev.parent) actually returns the drvdata of the mfd
device rather than the regulator. Fix it.

Fixes: 9bc146acc331 ("regulator: hi6421v600: Fix setting wrong driver_data")
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Mauro,
Thanks for your analysis.
Could you check if this patch works if you think it's good.
I don't mind applying your earlier fix or this one.
(This one has less code change with single purpose fot the fix,
and this patch does not has other dependency.)

Regards,
Axel
 drivers/regulator/hi6421v600-regulator.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 9b162c0555c3..845bc3b4026d 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -98,10 +98,9 @@ static const unsigned int ldo34_voltages[] = {
 
 static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
-	struct hi6421_spmi_reg_priv *priv;
+	struct hi6421_spmi_reg_priv *priv = rdev_get_drvdata(rdev);
 	int ret;
 
-	priv = dev_get_drvdata(rdev->dev.parent);
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&priv->enable_mutex);
 
@@ -119,9 +118,10 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
+	struct hi6421_spmi_reg_info *sreg;
 	unsigned int reg_val;
 
+	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 
 	if (reg_val & sreg->eco_mode_mask)
@@ -133,9 +133,10 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 					  unsigned int mode)
 {
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
+	struct hi6421_spmi_reg_info *sreg;
 	unsigned int val;
 
+	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
 		val = 0;
@@ -159,7 +160,9 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 				       int input_uV, int output_uV,
 				       int load_uA)
 {
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
+	struct hi6421_spmi_reg_info *sreg;
+
+	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
 
 	if (!sreg->eco_uA || ((unsigned int)load_uA > sreg->eco_uA))
 		return REGULATOR_MODE_NORMAL;
@@ -252,13 +255,12 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&priv->enable_mutex);
-	platform_set_drvdata(pdev, priv);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
 		info = &regulator_info[i];
 
 		config.dev = pdev->dev.parent;
-		config.driver_data = info;
+		config.driver_data = priv;
 		config.regmap = pmic->regmap;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
-- 
2.25.1

