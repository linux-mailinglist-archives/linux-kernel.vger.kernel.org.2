Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33F930AEF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBASTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhBASPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D58C061222
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so81242pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBNis2Le7mMZDVQZFpE5Weqxv7IPb4FFDDpAkRZVBuo=;
        b=oGJdf3twifKKOxzMWTxbHs26h/jfYISQ7r0dqOxkpJHd2XrT3wAyyea0/RKuT7ghdA
         RPcqX24YF6x69/+aMYjktfs4dwXDXgswZPfMFPNvgFlYeIM/LCZaZ/peMYll/Z+Wxz3H
         rHhKDeLLs3voRJdSjeytXDcFPoZbniDG1bywZMcp2h7/HJfR5ekwiiPYjW+JH16zyw1l
         Vv1BxiUt0iV66TLE8arp+7EFntLwckLCpuNlod7H807liZGiT9AatoWXoQL18k/Rhhu4
         xR58q4OkUXRqdlZwNk8PIhduapiX/CKV5vJPMqdolTYmm7Nxft9xIuUsFM/9mwXfO4Zj
         R32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBNis2Le7mMZDVQZFpE5Weqxv7IPb4FFDDpAkRZVBuo=;
        b=R9aqwhGLJWHkfL0DHLquYgPTEUL228v0ce+8XV4IaXQbgY62oYoREJVj+Zrh/O8NAQ
         dsxM0azwioJe/6NNntlE61wQ3ronLtiLc4OmW0I779tIp+/CKgrgBydhyCnyG9Zp3Qvw
         7ojz+WBLWuXumXTU5oH/DfqidbUuKEKJpJveY83YEfWVIzXAOnxGg91Rd/ecOMIxq5IC
         xZasM+s6ggEJJipUdDktaeOJXzmDthSW6DhWBq8Cm1ZGoIeyV49NPIsDxHWPq1K9tdZo
         1PSddoYD/4+LGaL3BkkagDYFK7K8wJxCkEvFcVXDvMb3x4oR1Yyv+cva8cs9dSc6LsRl
         eozg==
X-Gm-Message-State: AOAM531SXkUepCXR0a5k5EIjU/GcFufQSMQPJdh4UgvOP32VsGchnyJU
        EflBKaXwWZQ9yHroZJIoygPpfJWutzuCmg==
X-Google-Smtp-Source: ABdhPJypa4yLATjeTzQd8p2ebrRP6WZKQ97kLu31Gwa7amDvHqhCSbOxnwQ6dXzcieuiqVBhDe0Odw==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr118981pjb.63.1612203260425;
        Mon, 01 Feb 2021 10:14:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/31] coresight: etm4x: Refactor probing routine
Date:   Mon,  1 Feb 2021 11:13:45 -0700
Message-Id: <20210201181351.1475223-26-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

CoreSight ETM with system register access may not have a
memory mapped i/o access. Refactor the ETM specific probing
into a common routine to allow reusing the code for such ETMs.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-24-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 62 ++++++++++++-------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 48d8e99e31eb..c3e458af618a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1708,14 +1708,11 @@ static void etm4_pm_clear(void)
 	}
 }
 
-static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
+static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 {
 	int ret;
-	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct etmv4_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
 
@@ -1739,11 +1736,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1773,7 +1765,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
@@ -1793,7 +1785,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
 		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
@@ -1803,11 +1794,30 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->boot_enable = true;
 	}
 
-	etm4_check_arch_features(drvdata, id->id);
+	etm4_check_arch_features(drvdata, etm_pid);
 
 	return 0;
 }
 
+static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
+{
+	void __iomem *base;
+	struct device *dev = &adev->dev;
+	struct resource *res = &adev->res;
+	int ret;
+
+	/* Validity for the resource is already checked by the AMBA core */
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = etm4_probe(dev, base, id->id);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1824,15 +1834,12 @@ static void clear_etmdrvdata(void *info)
 	etmdrvdata[cpu] = NULL;
 }
 
-static int etm4_remove(struct amba_device *adev)
+static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 {
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
-
 	etm_perf_symlink(drvdata->csdev, false);
-
 	/*
-	 * Taking hotplug lock here to avoid racing between etm4_remove and
-	 * CPU hotplug call backs.
+	 * Taking hotplug lock here to avoid racing between etm4_remove_dev()
+	 * and CPU hotplug call backs.
 	 */
 	cpus_read_lock();
 	/*
@@ -1851,6 +1858,15 @@ static int etm4_remove(struct amba_device *adev)
 	return 0;
 }
 
+static int __exit etm4_remove_amba(struct amba_device *adev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	if (drvdata)
+		return etm4_remove_dev(drvdata);
+	return 0;
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1874,14 +1890,14 @@ static const struct amba_id etm4_ids[] = {
 
 MODULE_DEVICE_TABLE(amba, etm4_ids);
 
-static struct amba_driver etm4x_driver = {
+static struct amba_driver etm4x_amba_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
 		.owner  = THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
-	.probe		= etm4_probe,
-	.remove         = etm4_remove,
+	.probe		= etm4_probe_amba,
+	.remove         = etm4_remove_amba,
 	.id_table	= etm4_ids,
 };
 
@@ -1895,7 +1911,7 @@ static int __init etm4x_init(void)
 	if (ret)
 		return ret;
 
-	ret = amba_driver_register(&etm4x_driver);
+	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
 		pr_err("Error registering etm4x driver\n");
 		etm4_pm_clear();
@@ -1906,7 +1922,7 @@ static int __init etm4x_init(void)
 
 static void __exit etm4x_exit(void)
 {
-	amba_driver_unregister(&etm4x_driver);
+	amba_driver_unregister(&etm4x_amba_driver);
 	etm4_pm_clear();
 }
 
-- 
2.25.1

