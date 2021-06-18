Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7143A3ACB79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFRM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:52722 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhFRM5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:17 -0400
IronPort-SDR: C167ZtJ+q2PBXZFvrmR5RcuNj/GZwRO9DvYBisjfO0KelrV0/sH8lEKLbQXDKyHvrr//qg0qqR
 RdWRUubYsEmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193860548"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193860548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:55:01 -0700
IronPort-SDR: COX9DIYQr35UKATIIgxvken6RZzw1T1XyBW4H+4EApcccaGEx1Ii4eijWu65Bq9CWzc8r2IRgS
 0zojhocLnKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="451385574"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2021 05:54:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A40796D8; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 6/8] platform/x86: intel_skl_int3472: Provide skl_int3472_unregister_clock()
Date:   Fri, 18 Jun 2021 15:55:14 +0300
Message-Id: <20210618125516.53510-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of APIs to be properly layered provide
skl_int3472_unregister_clock().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 .../x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c | 6 ++++++
 .../platform/x86/intel-int3472/intel_skl_int3472_common.h   | 2 ++
 .../platform/x86/intel-int3472/intel_skl_int3472_discrete.c | 5 ++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
index 60c7128f44ee..1700e7557a82 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
@@ -130,6 +130,12 @@ int skl_int3472_register_clock(struct int3472_discrete_device *int3472)
 	return ret;
 }
 
+void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472)
+{
+	clkdev_drop(int3472->clock.cl);
+	clk_unregister(int3472->clock.clk);
+}
+
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 				   struct acpi_resource_gpio *agpio)
 {
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
index 50f73c6eab44..714fde73b524 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
@@ -111,7 +111,9 @@ int skl_int3472_tps68470_probe(struct i2c_client *client);
 union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev,
 					       char *id);
 int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb);
+
 int skl_int3472_register_clock(struct int3472_discrete_device *int3472);
+void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472);
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 				   struct acpi_resource_gpio *agpio);
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
index 2638d375e226..17c6fe830765 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
@@ -400,10 +400,9 @@ int skl_int3472_discrete_remove(struct platform_device *pdev)
 	struct int3472_discrete_device *int3472 = platform_get_drvdata(pdev);
 
 	gpiod_remove_lookup_table(&int3472->gpios);
-	clk_unregister(int3472->clock.clk);
 
-	if (int3472->clock.cl)
-		clkdev_drop(int3472->clock.cl);
+	if (int3472->clock.ena_gpio)
+		skl_int3472_unregister_clock(int3472);
 
 	gpiod_put(int3472->clock.ena_gpio);
 	gpiod_put(int3472->clock.led_gpio);
-- 
2.30.2

