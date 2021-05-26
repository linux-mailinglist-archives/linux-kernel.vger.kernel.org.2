Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4839120E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEZIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhEZIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so41679wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eguwAvzb70gl9qIGz7oSfuMcIr+zDEjogz9qlQbZV1s=;
        b=tNHq8eZ4eE+IKepnCFbyUs7a7dVS3vNhFVEAM2D902fDNphxqG1ZTsznEsaO50RhY8
         /9UZ+jS14c7szcFLCVKkF52NOM58qUqVSyvu7u/adCtx1/aDE5FdjUlCfaLAzka7ZXq0
         9T+opuockIywRnhLvRUR1Qo0SA3vTGyDY4o1IBG9J1U/v2f7dsWrs1BLURMGE9bD11mS
         KcfEBz/zAwKLL3mD8SwAkoP7X/B5RchLAHcV39PF/upEI5DGybP+AnwibmxESavIppMI
         5aFWCsfNnn13wQyY8RGkMdcdzAEBMGiYhD/gE94qtXm57sFt85/FyWJT7tm0m0ItaVWT
         AdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eguwAvzb70gl9qIGz7oSfuMcIr+zDEjogz9qlQbZV1s=;
        b=jtHQh0t7jEtkXziNyL9SwQx17r6Fxhr66NwhsE2zsjvIDtTA7u7CJjhF24PDfHtjCA
         GB/JidsclSv1djbaeQNDbUQ7eVeEahv84D5RFWz5Jm98NYjOR8ra0fFEedXiSOUXEdy0
         Pc8EY4dUGoV2iZ8wpVMw6noWaZfzRELHL8yTWr/ehPnyaFHTOSGOjFH4QVrlWz2VbXnF
         BmVQtevHFVN9ObrUQjQwEGuMO+xWH2l3H3IMkPeodczAUz1ETP9zPYxlSAexPA7qTsJF
         JFKGXfGKkcDZdze3Ip15MCnBqrEWEjWGlcJh4e7/rO/2uz0JmJE+6uYFE+jb20SLtMwQ
         UeAw==
X-Gm-Message-State: AOAM533jODpRIuzX6CaeRH2A95x0gDqc8SGC/Vpbt7ROfMc7hn3PvxgJ
        co8VLpwHi3lzM3UOvbz5jKOVRA==
X-Google-Smtp-Source: ABdhPJxKHx5yKpCANO4YsXniVf+RaDI9Gt4pcKywB3uNVi7LfG2PCWAbIAzxSzxANHkMAKpui+vGHQ==
X-Received: by 2002:a5d:5249:: with SMTP id k9mr31771621wrc.301.1622016650736;
        Wed, 26 May 2021 01:10:50 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        German Rivera <German.Rivera@freescale.com>
Subject: [PATCH 05/10] bus: fsl-mc: dprc-driver: Fix some missing/incorrect function parameter descriptions
Date:   Wed, 26 May 2021 09:10:33 +0100
Message-Id: <20210526081038.544942-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/dprc-driver.c:360: warning: Function parameter or member 'alloc_interrupts' not described in 'dprc_scan_container'
 drivers/bus/fsl-mc/dprc-driver.c:383: warning: Function parameter or member 'irq_num' not described in 'dprc_irq0_handler'
 drivers/bus/fsl-mc/dprc-driver.c:383: warning: Excess function parameter 'irq' description in 'dprc_irq0_handler'
 drivers/bus/fsl-mc/dprc-driver.c:394: warning: Function parameter or member 'irq_num' not described in 'dprc_irq0_handler_thread'
 drivers/bus/fsl-mc/dprc-driver.c:394: warning: Excess function parameter 'irq' description in 'dprc_irq0_handler_thread'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/dprc-driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index e3e2ae41c22b3..315e830b6ecda 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -350,7 +350,8 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
  * dprc_scan_container - Scans a physical DPRC and synchronizes Linux bus state
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
- *
+ * @alloc_interrupts: if true the function allocates the interrupt pool,
+ *                    otherwise the interrupt allocation is delayed
  * Scans the physical DPRC and synchronizes the state of the Linux
  * bus driver with the actual state of the MC by adding and removing
  * devices as appropriate.
@@ -373,10 +374,11 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 	return error;
 }
 EXPORT_SYMBOL_GPL(dprc_scan_container);
+
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
  *
- * @irq: IRQ number of the interrupt being handled
+ * @irq_num: IRQ number of the interrupt being handled
  * @arg: Pointer to device structure
  */
 static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
@@ -387,7 +389,7 @@ static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
 /**
  * dprc_irq0_handler_thread - Handler thread function for DPRC interrupt 0
  *
- * @irq: IRQ number of the interrupt being handled
+ * @irq_num: IRQ number of the interrupt being handled
  * @arg: Pointer to device structure
  */
 static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
-- 
2.31.1

