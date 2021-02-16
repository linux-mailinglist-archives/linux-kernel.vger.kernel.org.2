Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9136C31CAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBPMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:43:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D91C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:43:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so12846365wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pepuqadm438MArye8Qz+J5Ooe4idQ3PxG+sdr05Ejxs=;
        b=jBWXD2Q8GnJBrWGxpLmNZ6OJKKUIHriasEH/udWvyXNCTU0EpZk01UKFcyMeAhzwkW
         5hEw1Lq2V+6I2w/MMd3qkTNTj7FRofzuelpT9CdASnMkOQOkK5rowh9Ac8olPUG4aqFQ
         /X9LyNc1tG4S+X+lFHuV/V3IjyPlY+CWkCKel2pquPI7RyMg28GQ5FWwRbSunEQ/Bxo1
         GB5ENs6Ewxy71Izc2Qv3FzB/ZvktFPXCsajSHw/dpeeQQBUa00wvQ5qwcyFntc4NS2vi
         GdNnd6Yh8mAiMeta2fjayXujXZgO7UX2PkUhps7wC2IjnEiNaquTZuMG7oKO0LFeThKv
         LD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pepuqadm438MArye8Qz+J5Ooe4idQ3PxG+sdr05Ejxs=;
        b=MKnnKqgMx8u21r9VEMXkHVqVVYhg7359WTnc5FZjsjcNUmKW55ByZew/yet2GX//n2
         Wfgo9R+G0nEtZZe523WqGJr65ZzAhdxeE6urS02sFdJmARnnPHF3O5+15onoeJDv3CZ/
         Muf25P8qwBFBrxvHa9zpuP6wBpwfBvrCF4UCWBs34KE9Ds5E2ZHUpSPpZj5/1hP+oQoY
         JU+lvOQO+k/l4jH643xGKPjeP5y5GoJoA+95Nq4nsZ3hMV9yRsNYYSFBpGimL1DCNs2z
         /ykZzlkFfEMlr5YXxn2Fl2GSYyuA50TCNPxfwxVm0EEi4ET8PvEQmyBZ8sgo0PNY3MVy
         38jQ==
X-Gm-Message-State: AOAM531y8inSNB99p2PmtfJrKIpd6WtVCE3BV2LX0hhOH93S2+hzz+5+
        BsyKsKNYuJU58EC/KpadpXs=
X-Google-Smtp-Source: ABdhPJxUwH4fcUcZgUz0cWJYFkO90RhfO5d6Anb3CTldI5QPBorcihA5qv0LImvJAoJlQDt6s4OclQ==
X-Received: by 2002:adf:e585:: with SMTP id l5mr23086855wrm.85.1613479379692;
        Tue, 16 Feb 2021 04:42:59 -0800 (PST)
Received: from alaa ([197.57.74.212])
        by smtp.gmail.com with ESMTPSA id v204sm3557887wmg.38.2021.02.16.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 04:42:59 -0800 (PST)
From:   Alaa Emad <alaaemadhossney.ae@gmail.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Alaa Emad <alaaemadhossney.ae@gmail.com>
Subject: [PATCH v2] staging: hikey9xx: fix styling issues
Date:   Tue, 16 Feb 2021 14:42:55 +0200
Message-Id: <20210216124255.9353-1-alaaemadhossney.ae@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hi6421-spmi-pmic.c, there are some warnings and Check:

"WARNING: please, no space before tabs" in lines 51,52,53 and 69.
"CHECK: Alignment should match open parenthesis" in lines 180 and 238.

Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 9c5e113e1a81..626140cb96f2 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -48,9 +48,9 @@ enum hi6421_spmi_pmic_irq_list {
 /*
  * The IRQs are mapped as:
  *
- * 	======================  =============   ============	=====
- *	IRQ			MASK REGISTER 	IRQ REGISTER	BIT
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
+ *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
+ *	======================  =============   ============	=====
  *	OTMP			0x0202		0x212		bit 0
  *	VBUS_CONNECT		0x0202		0x212		bit 1
  *	VBUS_DISCONNECT		0x0202		0x212		bit 2
@@ -66,7 +66,7 @@ enum hi6421_spmi_pmic_irq_list {
  *	SIM0_HPD_F		0x0203		0x213		bit 3
  *	SIM1_HPD_R		0x0203		0x213		bit 4
  *	SIM1_HPD_F		0x0203		0x213		bit 5
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
  */
 #define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
 #define SOC_PMIC_IRQ0_ADDR		0x0212
@@ -177,7 +177,7 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++)
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-					HISI_MASK);
+			     HISI_MASK);
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
@@ -235,7 +235,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 		return -ENOMEM;
 
 	ddata->domain = irq_domain_add_simple(np, HISI_IRQ_NUM, 0,
-					     &hi6421_spmi_domain_ops, ddata);
+					      &hi6421_spmi_domain_ops, ddata);
 	if (!ddata->domain) {
 		dev_err(dev, "Failed to create IRQ domain\n");
 		return -ENODEV;
-- 
2.25.1

