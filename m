Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF3331690
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhCHSsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCHSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:48:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0638C06175F;
        Mon,  8 Mar 2021 10:48:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so12565047wrr.10;
        Mon, 08 Mar 2021 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYv3V7gTu6MLHgcxb9OwqCDS7QHOQoeQWh1TACaie74=;
        b=vPqoZ4LvRRSZxNAXRBOR1RZnwkg6DMHKkyWHomUDdPXSECHndjjzBw2RzO//xH9owW
         aStCIoqxL+JLVY617/9zKYmI07+REKpLuUpVPRuXr/8cVj+HFkU1rl2A2PTinjnkyanN
         Y+pK3qaS9N+IGLBdMotTSf5/x5/aX66dSwfTd8jsHcKwQRxQKGTMHaCltaHSYOrOmDBh
         J+TmiY2ZRvOpWdo+KkYquyndf+ZPyiEmhy6wTJc4KGjPVRbVPZW56yzRZUTLkghdcUSG
         TSTec+opQyWERHowfGPNUA4dHDVWtB71/tPiFOf8jWs2NPBCe3ugx9mJiBPWqhME/pFL
         9E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYv3V7gTu6MLHgcxb9OwqCDS7QHOQoeQWh1TACaie74=;
        b=riXYPhcqEoIgvnFCUzEsBT7+a1MXcL8WcLaF8WUr9NLEjOXvFG0czHIMnJdax0q4jA
         zGe+rT/r55pvosgVWEkRVFbQtKw6rNr6M9i6dJ1AAnhS+eIepnTgBJSfOzffEoWB8n2P
         7pK5Iz02WI5GAvY077dxvl3XDCIBw20doMG1jJ2phgByuGBOm7bKUUQoHYax5uhWBBfA
         flP0LFKA6j/T9CNKoGTcOJaPuoz5srfdKpyrwLlbeDLF82K5GS9j/9cRzMAnCM100HRN
         a9OalARKcU3bR24FABBhSxlnrtbOJZax+ernmYMTuSpzsniECQYpMBeFaLwuZlaDsPaV
         TC5Q==
X-Gm-Message-State: AOAM532YgOpIAjrVKDgEClvfeu/jdOIeUfmEwen3hfly0nFGwSXYEt6x
        lL7FzK3JhLPdW9YEBXlISUo=
X-Google-Smtp-Source: ABdhPJzRqwyWHExTSEj5wIjF3kaVDv6LnYQmZgIc2DWyZOfM4R62A4p5HKlRo21kBImCFGGseM6wVw==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr23398644wrq.27.1615229318747;
        Mon, 08 Mar 2021 10:48:38 -0800 (PST)
Received: from xws.localdomain (pd9ea322b.dip0.t-ipconnect.de. [217.234.50.43])
        by smtp.gmail.com with ESMTPSA id z3sm19758877wrw.96.2021.03.08.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:48:38 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/surface: dtx: Add support for native SSAM devices
Date:   Mon,  8 Mar 2021 19:48:18 +0100
Message-Id: <20210308184819.437438-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308184819.437438-1-luzmaximilian@gmail.com>
References: <20210308184819.437438-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for native SSAM devices to the DTX driver. This allows
support for the Surface Book 3, on which the DTX device is not present
in ACPI.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/Kconfig       |  4 ++
 drivers/platform/surface/surface_dtx.c | 90 +++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 98cf564fb17a..3105f651614f 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -120,6 +120,10 @@ config SURFACE_DTX
 	  behavior of this process, which includes the option to abort it in
 	  case the base is still in use or speed it up in case it is not.
 
+	  Note that this module can be built without support for the Surface
+	  Aggregator Bus (i.e. CONFIG_SURFACE_AGGREGATOR_BUS=n). In that case,
+	  some devices, specifically the Surface Book 3, will not be supported.
+
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
 	depends on DMI
diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 1301fab0ea14..85451eb94d98 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -27,6 +27,7 @@
 #include <linux/workqueue.h>
 
 #include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
 #include <linux/surface_aggregator/dtx.h>
 
 
@@ -1194,7 +1195,94 @@ static struct platform_driver surface_dtx_platform_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-module_platform_driver(surface_dtx_platform_driver);
+
+
+/* -- SSAM device driver. --------------------------------------------------- */
+
+#ifdef CONFIG_SURFACE_AGGREGATOR_BUS
+
+static int surface_dtx_ssam_probe(struct ssam_device *sdev)
+{
+	struct sdtx_device *ddev;
+
+	ddev = sdtx_device_create(&sdev->dev, sdev->ctrl);
+	if (IS_ERR(ddev))
+		return PTR_ERR(ddev);
+
+	ssam_device_set_drvdata(sdev, ddev);
+	return 0;
+}
+
+static void surface_dtx_ssam_remove(struct ssam_device *sdev)
+{
+	sdtx_device_destroy(ssam_device_get_drvdata(sdev));
+}
+
+static const struct ssam_device_id surface_dtx_ssam_match[] = {
+	{ SSAM_SDEV(BAS, 0x01, 0x00, 0x00) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, surface_dtx_ssam_match);
+
+static struct ssam_device_driver surface_dtx_ssam_driver = {
+	.probe = surface_dtx_ssam_probe,
+	.remove = surface_dtx_ssam_remove,
+	.match_table = surface_dtx_ssam_match,
+	.driver = {
+		.name = "surface_dtx",
+		.pm = &surface_dtx_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int ssam_dtx_driver_register(void)
+{
+	return ssam_device_driver_register(&surface_dtx_ssam_driver);
+}
+
+static void ssam_dtx_driver_unregister(void)
+{
+	ssam_device_driver_unregister(&surface_dtx_ssam_driver);
+}
+
+#else /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
+static int ssam_dtx_driver_register(void)
+{
+	return 0;
+}
+
+static void ssam_dtx_driver_unregister(void)
+{
+}
+
+#endif /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
+
+/* -- Module setup. --------------------------------------------------------- */
+
+static int __init surface_dtx_init(void)
+{
+	int status;
+
+	status = ssam_dtx_driver_register();
+	if (status)
+		return status;
+
+	status = platform_driver_register(&surface_dtx_platform_driver);
+	if (status)
+		ssam_dtx_driver_unregister();
+
+	return status;
+}
+module_init(surface_dtx_init);
+
+static void __exit surface_dtx_exit(void)
+{
+	platform_driver_unregister(&surface_dtx_platform_driver);
+	ssam_dtx_driver_unregister();
+}
+module_exit(surface_dtx_exit);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Detachment-system driver for Surface System Aggregator Module");
-- 
2.30.1

