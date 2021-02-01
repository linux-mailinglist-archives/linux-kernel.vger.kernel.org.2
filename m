Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8C30AF4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhBASaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhBASPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF82C061224
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so326606pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6MZF2I+EtOQE1SlYRYLpgst5vG63s12bYpfROsNq20=;
        b=IjBy6Xq2lMnYRbP3Ejtc/LmkvMh2Sa8jSyuaoWtu9fcSvCcqKm0qp7nk2bcNawnQrz
         T/U70s2x+j51GKG54IsMh2yzO2gRYDGWJS+qyns0vvMTVT9BrpJl7eDSSCCr74PEiAfr
         swpE1OdZgudfL26fV0tOp32pzdvXqBHiCjlSCSP3Jc29tYdAlSmNG4ErxaBqmqjDxg8P
         m7csedHcUOe3oVM1h9g8nAEHgPv2StUwXklYGMLkZn0jntYzDqD/j7gy/EvRp4ZpEAMk
         RdJwLHKezgqvIhwE3K4KAWQhAJDXN9PpcgnT3Gs0CFIQqWhi6k5lYJLNFohgjUMFKK7X
         vMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6MZF2I+EtOQE1SlYRYLpgst5vG63s12bYpfROsNq20=;
        b=IYG+3cqq/I1EeRm4vMxEqphvK90A9Uen5PgAH+XhfJP12frSgfxS6pRogzP1c5O+0W
         EdksF+lzSCIXrlQxZ+fbqHqLVsXXaW6bYbZM6aDFHGUHttSYIcj9K4o1u//PCXVr2yKy
         /RoLAp0GQMliFp7QKHhj++mIIyH5zl03xxzHv7gO6M8a0Khi/ow+YX84ia6WQ8JYe+Hj
         P7qRwZxi96Pa6Qjanb2RvPjbZc3W9k4u27d8CtqoHZ9cl+vamEvEWzaYIs9Mj96eBBcx
         erxfPUB2+huUu6jDSkEDKohxdNZgbR/z/Hf7iLlIWAJnrSp0qnhK2sZItzk4UOOYfZ+n
         zC3Q==
X-Gm-Message-State: AOAM5319xtXnDJYLVa7zhv9OE2R1QYZlFnqheqAhYp+gwDaS6kWbpKvk
        itIxzXImnpVRbvQYxzYsO0kmsw==
X-Google-Smtp-Source: ABdhPJyQScyV4qottp3h9tV17KkDMs4Qrdf8uhR12hijrNHwEevNIqNPuBNvQ5MmIR4bXeMzIcrg9w==
X-Received: by 2002:a17:90a:5c81:: with SMTP id r1mr109235pji.175.1612203262477;
        Mon, 01 Feb 2021 10:14:22 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:21 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/31] coresight: etm4x: Add support for sysreg only devices
Date:   Mon,  1 Feb 2021 11:13:47 -0700
Message-Id: <20210201181351.1475223-28-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for devices with system instruction access only.
They don't have a memory mapped interface and thus are not
AMBA devices. System register access is not permitted to
TRCPDCR and thus skip access to them.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-26-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 68 +++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index fc26ecbc2d87..c6238e208685 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 
@@ -1736,9 +1737,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 			return -ENOMEM;
 	}
 
-	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1762,6 +1760,11 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!drvdata->arch)
 		return -EINVAL;
 
+	/* TRCPDCR is not accessible with system instructions. */
+	if (!desc.access.io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
@@ -1820,6 +1823,25 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int etm4_probe_platform_dev(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	/*
+	 * System register based devices could match the
+	 * HW by reading appropriate registers on the HW
+	 * and thus we could skip the PID.
+	 */
+	ret = etm4_probe(&pdev->dev, NULL, 0);
+
+	pm_runtime_put(&pdev->dev);
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1869,6 +1891,17 @@ static int __exit etm4_remove_amba(struct amba_device *adev)
 	return 0;
 }
 
+static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		ret = etm4_remove_dev(drvdata);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1903,6 +1936,21 @@ static struct amba_driver etm4x_amba_driver = {
 	.id_table	= etm4_ids,
 };
 
+static const struct of_device_id etm4_sysreg_match[] = {
+	{ .compatible	= "arm,coresight-etm4x-sysreg" },
+	{}
+};
+
+static struct platform_driver etm4_platform_driver = {
+	.probe		= etm4_probe_platform_dev,
+	.remove		= etm4_remove_platform_dev,
+	.driver			= {
+		.name			= "coresight-etm4x",
+		.of_match_table		= etm4_sysreg_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+
 static int __init etm4x_init(void)
 {
 	int ret;
@@ -1915,16 +1963,26 @@ static int __init etm4x_init(void)
 
 	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
-		pr_err("Error registering etm4x driver\n");
-		etm4_pm_clear();
+		pr_err("Error registering etm4x AMBA driver\n");
+		goto clear_pm;
 	}
 
+	ret = platform_driver_register(&etm4_platform_driver);
+	if (!ret)
+		return 0;
+
+	pr_err("Error registering etm4x platform driver\n");
+	amba_driver_unregister(&etm4x_amba_driver);
+
+clear_pm:
+	etm4_pm_clear();
 	return ret;
 }
 
 static void __exit etm4x_exit(void)
 {
 	amba_driver_unregister(&etm4x_amba_driver);
+	platform_driver_unregister(&etm4_platform_driver);
 	etm4_pm_clear();
 }
 
-- 
2.25.1

