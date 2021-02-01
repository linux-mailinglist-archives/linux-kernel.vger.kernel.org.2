Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF030AEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhBASTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhBASPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:30 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D80C06121D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a20so87544pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZ0qc4FQm15rLxsjsyvmy33IGQ5QIQNw22305IvB1H4=;
        b=OF9Ql11LG+gDLcy/2U6/rozE5uggjn0RcpCYJSBEDxPryxGcJJEYj5JifZQb530/dv
         tzlLLR8ZXbU5vcJDK9k+o4XwJjsbq+5orcGSH/CbeXB0lb9MNY/q2ashSbGlC0RjvT8N
         5PeFWqDHabeMVfPiZjeWDNB8rBaWJSzulFMIxwVOkOuEQqOv9Wa20EOE7nJNW06nWcN1
         dCcoSCGh7sfbG8Yo53wUBf82d3PCJli0743wnekcgdiJLqas3uXARkoRGiX/9UfJMK+Z
         cHY9rgdYFcw32iyrjXHce5HpxS3MlMSi+97MVpj4X+85gFgRlrfquTiTsoW0LxYtF95W
         CxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZ0qc4FQm15rLxsjsyvmy33IGQ5QIQNw22305IvB1H4=;
        b=bF8sHLExBxyoXZhJqUMzayWzIETmE6WFU5kX0Z0kFpt15NfqEmvEVKjNQu4VAFstXQ
         rOd6jFg8d4YM4qRIkimf95tyxQh+uf0kcFLWffZcPMrWRUG+x9sGqA5Gsp+L9XuJUmqc
         eQPXTMWKnjENm4zO3h3uX8Nub19daQXv3Hgw1RgGm1KsIZ9FEch8qZNStQHAoadWIsIs
         tMMfMLy+Z7SAkRBNJrp+s8WrPKvHNGCQWqikgn0fq3WGt+3VJomrmFcebcc4Y6NMFvxG
         eb6F8h3Wc5qTcdYXuhJ7a6CgELa4Ecg1uGJdsHxSS+pAvRERkKz8g4p7R+8tEpu07Qv+
         Tmnw==
X-Gm-Message-State: AOAM531DjeAdDBMyZsvE+HJlrgIGr38pbugnuWFWJ0q5/OLOBgCBnL24
        DtaxOFtXikf151AtFZavn7+EEg==
X-Google-Smtp-Source: ABdhPJydriz8XQSVP4xtpVuwejzTBocd5o9fD1om/EzM/gOK3gKA30RbAcaNlT4sdox1xT/COCfh8w==
X-Received: by 2002:a17:90a:d912:: with SMTP id c18mr151485pjv.102.1612203255251;
        Mon, 01 Feb 2021 10:14:15 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:14 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/31] coresight: etm4x: Detect access early on the target CPU
Date:   Mon,  1 Feb 2021 11:13:40 -0700
Message-Id: <20210201181351.1475223-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

In preparation to detect the support for system instruction
support, move the detection of the device access to the target
CPU.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-19-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 59da9efae9c2..bfe3b8224d9a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -59,6 +59,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
+struct etm4_init_arg {
+	struct etmv4_drvdata	*drvdata;
+	struct csdev_access	*csa;
+};
+
 /*
  * Check if TRCSSPCICRn(i) is implemented for a given instance.
  *
@@ -776,6 +781,22 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
+static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
+				   struct csdev_access *csa)
+{
+	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
+	return true;
+}
+
+static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
+				   struct csdev_access *csa)
+{
+	if (drvdata->base)
+		return etm4_init_iomem_access(drvdata, csa);
+
+	return false;
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -784,11 +805,22 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr3;
 	u32 etmidr4;
 	u32 etmidr5;
-	struct etmv4_drvdata *drvdata = info;
-	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
-	struct csdev_access *csa = &tmp_csa;
+	struct etm4_init_arg *init_arg = info;
+	struct etmv4_drvdata *drvdata;
+	struct csdev_access *csa;
 	int i;
 
+	drvdata = init_arg->drvdata;
+	csa = init_arg->csa;
+
+	/*
+	 * If we are unable to detect the access mechanism,
+	 * or unable to detect the trace unit type, fail
+	 * early.
+	 */
+	if (!etm4_init_csdev_access(drvdata, csa))
+		return;
+
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
@@ -1634,6 +1666,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etmv4_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct etm4_init_arg init_arg = { 0 };
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1661,7 +1694,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
-	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	spin_lock_init(&drvdata->spinlock);
 
@@ -1673,8 +1705,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
+	init_arg.drvdata = drvdata;
+	init_arg.csa = &desc.access;
+
 	if (smp_call_function_single(drvdata->cpu,
-				etm4_init_arch_data,  drvdata, 1))
+				etm4_init_arch_data,  &init_arg, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (etm4_arch_supported(drvdata->arch) == false)
-- 
2.25.1

