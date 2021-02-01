Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD07030AF51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBASbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhBASPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C4C061355
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so10444746plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8giPwxj7vPgzjb7g95oKc+3Cw8pXaIxrf1NzUl/Xd0=;
        b=FHxNMFgRSe9PUUoCEfgUM4HHAEhSwwIeVu9sU4MrST+0e7/N8ozFRXThlnneG+V6c9
         oBf/Qc0sep8Rye3yznSRXKcY0oxkyHBZlCwsnex9qLO4O93tHdzDdxs7gYGd3aL2DKIU
         2XkO5/iQ0rnGDpSunmhD8ridCUkq1t1+BGDmprZ+EINmi6WxTzWGpFWrC/TNswdrDyZG
         LTgN7EW25cZDkCgNVgK/oLUgyVZztA/V2YXH9OJSdwyQEnkYqWZpgaARCLhbF8UqWnWZ
         KLWqUVVatzwU9pwrljXrHDP2vNbSI7uFWy4f0CzhoOOTsALeMehyUjZ5A9Dz45tU6OsW
         vmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8giPwxj7vPgzjb7g95oKc+3Cw8pXaIxrf1NzUl/Xd0=;
        b=Qzm6vNdKTM3MyXou8MhYgBBDAnl/vZm8j7EWcHiUUrqEp5JFwba4oIeGV7d3qz1/fF
         COjOKzX6RVpLzBgM49G/HUox3+FM9yc3m2h7ChPetGpTrqbGwFTGdUvqd3qnHIjK04vn
         j06A04KgSYVd9KOlUt8qVXQgDNW3Y1MFIuXfFVmx8eK+9i0LcaEUY+o7noS4FM6McMRH
         QWHVKGqtjQULEVHWPFu244eNRV2AsBQ9Z+8ZhFQVuujm19W1a+WdG6QZ3F8i4GW7lWk/
         X3II/PivobD3xc9R8bT+CTy42++Z7Kav+omnUmfqLDj18YIHTvwmx+xgu5+9V+j+dYmL
         tK/w==
X-Gm-Message-State: AOAM530bfYY4ZSrK1hETtJLWx+HusUf5253jb2B2TIGSNb3gn2mbrmlI
        hMS+gHISGxnUqrrWcslG+xTwNZ4K7tmk4A==
X-Google-Smtp-Source: ABdhPJw6bU2hecLs+M0YUQANIhUQ4ncMLPSvLGyOG+7FnT1yOvRALlzNWVwfQ7ZEvU4UQ4JwHfzyEg==
X-Received: by 2002:a17:902:d4d0:b029:df:d246:ca81 with SMTP id o16-20020a170902d4d0b02900dfd246ca81mr18973848plg.58.1612203250804;
        Mon, 01 Feb 2021 10:14:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/31] coresight: etm4x: Check for Software Lock
Date:   Mon,  1 Feb 2021 11:13:36 -0700
Message-Id: <20210201181351.1475223-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The Software lock is not implemented for system instructions
based accesses. So, skip the lock register access in such
cases.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-15-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 04ec13ae22d0..f095ab9949d9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -133,6 +133,21 @@ static void etm4_os_lock(struct etmv4_drvdata *drvdata)
 	isb();
 }
 
+static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
+			 struct csdev_access *csa)
+{
+	/* Software Lock is only accessible via memory mapped interface */
+	if (csa->io_mem)
+		CS_LOCK(csa->base);
+}
+
+static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
+			   struct csdev_access *csa)
+{
+	if (csa->io_mem)
+		CS_UNLOCK(csa->base);
+}
+
 static bool etm4_arch_supported(u8 arch)
 {
 	/* Mask out the minor version number */
@@ -263,7 +278,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
 
-	CS_UNLOCK(drvdata->base);
+
+	etm4_cs_unlock(drvdata, csa);
 	etm4_enable_arch_specific(drvdata);
 
 	etm4_os_unlock(drvdata);
@@ -366,7 +382,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	isb();
 
 done:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
@@ -623,7 +639,7 @@ static void etm4_disable_hw(void *info)
 	struct csdev_access *csa = &csdev->access;
 	int i;
 
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 	etm4_disable_arch_specific(drvdata);
 
 	if (!drvdata->skip_power_up) {
@@ -665,8 +681,7 @@ static void etm4_disable_hw(void *info)
 	}
 
 	coresight_disclaim_device_unlocked(csdev);
-
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(&drvdata->csdev->dev,
 		"cpu: %d disable smp call done\n", drvdata->cpu);
@@ -776,8 +791,7 @@ static void etm4_init_arch_data(void *info)
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
-
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
@@ -942,7 +956,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 /* Set ELx trace filter access in the TRCVICTLR register */
@@ -1323,8 +1337,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	dsb(sy);
 	isb();
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	/* Lock the OS lock to disable trace and external debugger access */
 	etm4_os_lock(drvdata);
 
@@ -1437,7 +1450,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU),
 				      TRCPDCR);
 out:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 	return ret;
 }
 
@@ -1448,8 +1461,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	struct csdev_access *csa = &tmp_csa;
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
 	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
@@ -1534,7 +1546,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	/* Unlock the OS lock to re-enable trace and external debug access */
 	etm4_os_unlock(drvdata);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
-- 
2.25.1

