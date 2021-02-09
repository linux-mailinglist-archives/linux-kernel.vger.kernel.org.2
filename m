Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720A3314866
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBIF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBIF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:59:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A15C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 21:58:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o7so11815375pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODatsDn099m1+CSNXdXnLWPiY9mo47t7WiVoBOMsqJM=;
        b=ITYn8yeve6X0LP8vu1azTHZL3fHOPrCmhckFGudStojQpknzAJs7D4QKaaiwLbnfq8
         Dj+lPpahBquRa6CCNF/Q0GHGPWcD1wzhZrCHR2NruaNKwH74xQLQd37e/SxHh27NCbzK
         IsKQPUTN/xTEoOva05nzUfFtFxV2Pn31i8avuqrm4c1outYc2EZtl37HWGZApF8imT1z
         Yz1nQaLlY/idr21LV+GZ4zUuaAwmuTUFcvDfmR1js4XuPSBHg0z0z98h1Z+dhFKQ5dwl
         4xbFNjV2c7X9Gh7mzEYvQvoUxOLp6qFr3mvZKFKRE7lWz1f5B8RTMlmaSysBDS4tztcA
         AacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODatsDn099m1+CSNXdXnLWPiY9mo47t7WiVoBOMsqJM=;
        b=XS3blk0hl8SBmEmh8wynG1S7NZF8/Bw4u47Hhn9N+i8r3NVoZYrrQIGES1u+gUWmrl
         qhucajMmu9b8Rv5NUnoNSDAZe92Ow+fZtQAgAeyTCUD9FMNs9UpNe5BOmlegYAcSBMzE
         Qn1+m/CkahZKOnqcO8sRnWsNQo0ov9WlTO7iK7WyrmC3EYHgydQ7e6CsmyaJf0xLGsRF
         VOzO1102jwalgsfhbjDbq6pk6Ft+/CLfrnuATdQkGvIBLnFA4jsX6KmE6QKTQ/OZwwKA
         c3uIyvTr8aChhwGszLCl3yrj29c5Dw+fpLBzZ9h/teeT2SElZ4pNoOfNNIX+lXlLkZga
         8mdA==
X-Gm-Message-State: AOAM533dbOKxC7GgkyhbR+YQzCMxhua27ODEEdu1zKtgvAOiFg0ZWYdD
        0iSQANTPjp1amj2TotghC64=
X-Google-Smtp-Source: ABdhPJwlw20G9EgFTRzEe7KMBF1IQKc7axH9HOzMkh4Imf/afuWmvnWiFLIH/uTBa70nMl8UMOxSkw==
X-Received: by 2002:a63:ff09:: with SMTP id k9mr21025829pgi.175.1612850301680;
        Mon, 08 Feb 2021 21:58:21 -0800 (PST)
Received: from localhost.localdomain ([122.164.88.77])
        by smtp.gmail.com with ESMTPSA id v4sm1062095pff.156.2021.02.08.21.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 21:58:21 -0800 (PST)
From:   Atul Gopinathan <leoatul12@gmail.com>
To:     mchehab+huawei@kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Atul Gopinathan <leoatul12@gmail.com>
Subject: [PATCH] staging: hikey9xx: fix checkpatch error and warning
Date:   Tue,  9 Feb 2021 11:27:04 +0530
Message-Id: <20210209055703.7211-1-leoatul12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following types of checkpatch error and warning:

ERROR: code indent should use tabs where possible
WARNING: struct phy_ops should normally be const

Signed-off-by: Atul Gopinathan <leoatul12@gmail.com>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c     | 2 +-
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 2 +-
 drivers/staging/hikey9xx/phy-hi3670-usb3.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 2301f4fcd48d..9c5e113e1a81 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -177,7 +177,7 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++)
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-				        HISI_MASK);
+					HISI_MASK);
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index c801bb840962..f6a14e9c3cbf 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -106,7 +106,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 	ret = regmap_update_bits(pmic->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask,
-			         rdev->desc->enable_mask);
+				 rdev->desc->enable_mask);
 
 	/* Avoid powering up multiple devices at the same time */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 8918f3665f8e..e7e579ce0302 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -585,7 +585,7 @@ static int hi3670_phy_exit(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops hi3670_phy_ops = {
+static const struct phy_ops hi3670_phy_ops = {
 	.init		= hi3670_phy_init,
 	.exit		= hi3670_phy_exit,
 	.owner		= THIS_MODULE,
-- 
2.27.0

