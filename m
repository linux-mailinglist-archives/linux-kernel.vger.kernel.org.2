Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CA31B1C8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 19:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBNSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 13:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhBNSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 13:06:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B120C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 10:06:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u5so1459572wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iK9yYr+JABuVqPrNZO7z5D//Vz9aBBLMOlTC/uk3m6I=;
        b=DHBr9+PBs4YMHPq/LhqY2hDYb+7qDtCwQWnjwdjPG4hSfrWXkdB4MK3fIDSfAVCbRz
         nv9vMYAXFmQ9GVS3bvPkeSfZ8USMexRA0yCQdaycdr8uH+wMrOkExCSoC0jeaH/DS7eX
         DRJ/uUBj+4KBF947qyqIWoxGRvM2Rxc5nrNY3bn+jbJ8AUQJKdl0k5OGztBUPFCHBcwT
         TZTqbvgZcvLwFLduaG6WZo+7ZiN2/lE8A1Lq636S1315Bi3B0MkDy5g0khiW8jpndHr0
         bvCASRkdidXde/yMbNSlJAelgwx7592qQTuyOxq7TsI4YonpmtaDDnXxYlkUzQ5eA/QA
         SkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iK9yYr+JABuVqPrNZO7z5D//Vz9aBBLMOlTC/uk3m6I=;
        b=jGnFN8ETxBHrtbW0PPZ3N5+E/El65DIWWkd1N2E8n56VvwDCiWcV94M3WPUgIj1P9v
         +YHylVr4mmtAdKif2xV5D7ld8cw9gNh3WX9hJ8y3wDoWRYpwANL45iqaEuHv8b5buxEQ
         nNFrVHdYUmoEsrLVKLKlJMCBuHz25e9Jmph0u/nZ0UBzAigXEK8SbO93ABg7YmWPcJkG
         Q/T9iUSnap3ypacuZys6JcLwq8ceHAcUXvrGdty7PsrKgRHCMls0wVo80vt2bXDNOOFk
         UbmoK+bfO8IirAfLpOgDeuhiuL0eVGOYQOjrRhSWp14PDJSE3aplzZ2QCZjkb6i25Qio
         3JIA==
X-Gm-Message-State: AOAM532KLhgYaojOdE5HbtOWpMumrpvDwMpQAjvcLh+d7GPNngNpAAn+
        FaRmbwxJez4GwWANYhfimSoFAGW8PgY/Qw==
X-Google-Smtp-Source: ABdhPJz851Gs652OcKUG4wxADms3P+y/eCKYDu2zBfpJ+QmygBdJ+0+jVIPepiwnlMPVUo7Qc2oFTQ==
X-Received: by 2002:a1c:b0c2:: with SMTP id z185mr10818017wme.67.1613325973902;
        Sun, 14 Feb 2021 10:06:13 -0800 (PST)
Received: from alaa ([197.57.74.212])
        by smtp.gmail.com with ESMTPSA id d20sm20994413wrc.12.2021.02.14.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 10:06:13 -0800 (PST)
From:   Alaa Emad <alaaemadhossney.ae@gmail.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Alaa Emad <alaaemadhossney.ae@gmail.com>
Subject: [PATCH 1/1] staging: hikey9xx: hi6421-spmi-pmic.c: removing
Date:   Sun, 14 Feb 2021 20:06:08 +0200
Message-Id: <20210214180608.8890-1-alaaemadhossney.ae@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/hikey9xx/hi6421-spmi-pmic.c:51: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:52: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:53: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:69: WARNING: please, no space before tabs
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:180: CHECK: Alignment should match open parenthesis
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:238: CHECK: Alignment should match open parenthesis
drivers/staging/hikey9xx/hi6421-spmi-pmic.c:281: WARNING: DT compatible string "hisilicon,hi6421-spmi" appears un-documented -- check ./Documentation/devicetree/bindings/
total: 0 errors, 5 warnings, 2 checks, 297 lines checked

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

