Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A068E30AF79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBASe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBASPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:12 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7CC06121F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id f63so12122365pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mulIk3ZrpE5FmYY+nWkpdZpOoqpgj1FNbaDnu2ujq+w=;
        b=nOI4G0Uy3JaK29ToCTHfujgSB2s+miEtNlNmpocpfe9bDEGt2+a/IRxBywLrEaPC1i
         rF/9zR5q2Uzc4xePqi/DmL+2M3xHnljczSmCG2PvBMJ7BzASHmgfh1fDCq1NFLwyYrwk
         0OeZpYeaeVbWXp6rRjdjJcucQ5AzMyPNDrF8y2dLXveAzUyNYlkVAVyljgP8cCzYMz7k
         Ovt3FEHCTGz341HpzUTNyeQ6jt61tQ5mbl8qZ53k9A4e6rp2KhKKJnFQxkThzFqKnttR
         oW4CnVfagGotdPZx6VWpJJgHdvDMTqrOtipi3C2rM/Ua11DAuP8xhY3ordmfFpaQZJna
         IqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mulIk3ZrpE5FmYY+nWkpdZpOoqpgj1FNbaDnu2ujq+w=;
        b=giXBS4b7BwhNrgnu7wlnv0vM2NJxVPVYkpI3BSTPerNJc4o1qA50vX4Wrwij8FzdyI
         ihsODg8X6Yz5TTeomrStZzi02MkNH6qz5SZUPnBO5QEgXyTOTnigP9LqHy5dVJvY5GYn
         fJDzkazCoR8ey1GIAttsNxX3R58oYUgfZ0IZXNAmA9AcsKb4Tz2WKRsNRBKov7o7u1zM
         /5aOZkaKkZ8mfJzqszD+rkmV5R/SSqWJnqadP8DFVrbEKfTv3cHvVq7UrGIAZ0a4AQze
         GsuVTbEZgzc2LXe7HhQbTCwRfsUDgUVg7dQTXe+Yr8W6D3bzoU6klX5OJWdU1PPlkGCd
         v6JA==
X-Gm-Message-State: AOAM533SVNtp10iU6xh/DtwLmXM9i6RJ8Lg8NM48JQC1kxGEjrx2oCjx
        5tl2couFyAHCH2J1N8RUtjynGQ==
X-Google-Smtp-Source: ABdhPJwMheySL7CbzlylXy2ujduMFE//Br4b0BODTt1GBMR8Gc4EROdsCa9qBvKyFP8PPUd9UFmnTA==
X-Received: by 2002:a63:220b:: with SMTP id i11mr18245078pgi.2.1612203256188;
        Mon, 01 Feb 2021 10:14:16 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:15 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/31] coresight: etm4x: Use TRCDEVARCH for component discovery
Date:   Mon,  1 Feb 2021 11:13:41 -0700
Message-Id: <20210201181351.1475223-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We have been using TRCIDR1 for detecting the ETM version. This
is in preparation for the future IP support.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-20-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bfe3b8224d9a..a09a653fc5b0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -153,18 +153,6 @@ static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
 		CS_UNLOCK(csa->base);
 }
 
-static bool etm4_arch_supported(u8 arch)
-{
-	/* Mask out the minor version number */
-	switch (arch & 0xf0) {
-	case ETM_ARCH_V4:
-		break;
-	default:
-		return false;
-	}
-	return true;
-}
-
 static int etm4_cpu_id(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -784,6 +772,26 @@ static const struct coresight_ops etm4_cs_ops = {
 static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
+	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
+	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
+
+	/*
+	 * All ETMs must implement TRCDEVARCH to indicate that
+	 * the component is an ETMv4. To support any broken
+	 * implementations we fall back to TRCIDR1 check, which
+	 * is not really reliable.
+	 */
+	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
+		drvdata->arch = etm_devarch_to_arch(devarch);
+	} else {
+		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
+			smp_processor_id(), devarch);
+
+		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
+			return false;
+		drvdata->arch = etm_trcidr_to_arch(idr1);
+	}
+
 	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	return true;
 }
@@ -800,7 +808,6 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
-	u32 etmidr1;
 	u32 etmidr2;
 	u32 etmidr3;
 	u32 etmidr4;
@@ -865,14 +872,6 @@ static void etm4_init_arch_data(void *info)
 	/* TSSIZE, bits[28:24] Global timestamp size field */
 	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
 
-	/* base architecture of trace unit */
-	etmidr1 = etm4x_relaxed_read32(csa, TRCIDR1);
-	/*
-	 * TRCARCHMIN, bits[7:4] architecture the minor version number
-	 * TRCARCHMAJ, bits[11:8] architecture major versin number
-	 */
-	drvdata->arch = BMVAL(etmidr1, 4, 11);
-
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
 	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
@@ -1712,7 +1711,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 				etm4_init_arch_data,  &init_arg, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (etm4_arch_supported(drvdata->arch) == false)
+	if (!drvdata->arch)
 		return -EINVAL;
 
 	etm4_init_trace_id(drvdata);
@@ -1744,7 +1743,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
-		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
+		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
+		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
-- 
2.25.1

