Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315D831BB45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhBOOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBOOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:37:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:36:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so9237779wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do2tQb63bcwLymaHKmZud23cc7ctdAohkzhpdwoDJ3M=;
        b=TXZxOMoO6m73IpOCtYlqYKg1OilB6K/peHgJVxGleqgbHnI42xxKv59/DeT+8Oy0b6
         v+JDtsNBUfj1TErC15PmPLuLNd851IZrSBAMfWOHT6nE9lLJ6TudaRAt4eCVVEPKdjMO
         fpRBjigw+cGCTuVuysYHIR/lgN5wa5Off7KrEwvm5bCgxRmVdeEkwv9Vi0txsX1+tOlc
         WKUplZGX2OrsO1oTszq1iJR4sDGJfK8IzrMRIpMgmfVVM1FrRtyQTBOieso1Y5aKArUr
         ov0/wefloQJ0VZ6haNad/2aK3fXNQoFl2jG2dDIDpTralSZRptf5DxC2/kkdcbQxgXSX
         hqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do2tQb63bcwLymaHKmZud23cc7ctdAohkzhpdwoDJ3M=;
        b=OpyvpfRpVmTN4yvdZoepdtGnRswslxIWxcgRxPazG1g0GpZ/jaZ7VMNyhNDjGZhVhj
         n44OXAVqRuEXkHXS/DUgMDNCXltOVLM7m6zF12Vq/RRXYIlluWOnnJM8Ekkl2wQToiT2
         I7dslAnmJQsNYX2w+YVE8jEcwot9sxdR4UdXnQZoJ6cBAg9klrc44wFjla5girZbsnS/
         p/zT+qZdaAgLe9pq0XVYT42W/KN/XldxSzlTHyRPONmJxiF9fhC89t4vvAx7OZ5s+d78
         Xj4GfjRzfpdiDfpWgz+HrFw0+wJ4pGUUADg32kEzGUM19XgFQj+0sha29V0eV89GnTdV
         UObA==
X-Gm-Message-State: AOAM532XofuZYN6T7dmBjoJO4J3jW0ur7sBdIHAQSK1BubQrxtuGOJIE
        qmqDiLUkjCOIexxJrtrCivk=
X-Google-Smtp-Source: ABdhPJyVrllvu0jnkSV2PuUg7VLVVBhu4Oxn4Yc5Gg9oPawn4jnCNuYSHdGS9M6Pp6GuOoFnsMt1QA==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr12782905wrr.409.1613399817374;
        Mon, 15 Feb 2021 06:36:57 -0800 (PST)
Received: from alaa ([197.57.74.212])
        by smtp.gmail.com with ESMTPSA id o13sm9274347wro.15.2021.02.15.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 06:36:56 -0800 (PST)
From:   Alaa Emad <alaaemadhossney.ae@gmail.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Alaa Emad <alaaemadhossney.ae@gmail.com>
Subject: [PATCH resend] staging: hikey9xx: hi6421-spmi-pmic: fixing 
Date:   Mon, 15 Feb 2021 16:36:52 +0200
Message-Id: <20210215143652.14122-1-alaaemadhossney.ae@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following issues in hi6421-spmi-pmic.c file:

drivers/staging/hikey9xx/hi6421-spmi-pmic.c:51: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:52: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:53: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:69: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:180: CHECK: Alignment should match open parenthesis
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:238: CHECK: Alignment should match open parenthesis


Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>

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

