Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1785328129
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhCAOoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:44:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:9792 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235441AbhCAOoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:44:32 -0500
IronPort-SDR: eLKKnvJSzFyq6DPqHDOGJAlwtHZEWiCqEk/nT+4nbAn49lN/rvgnGhbefm5TlYlLJraGfmKa4/
 22WYKA4N3HyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250533203"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="250533203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:42:46 -0800
IronPort-SDR: ZslpQt0tB16cEU7D/VO7rtSCteKOq0QX0hTegyJ45wtk71ZfayKikYQsyu5XR7YVDjdpNFYs0P
 zRCL/unH7g+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="366727248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2021 06:42:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71D7013A; Mon,  1 Mar 2021 16:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] mfd: intel-lpss: Switch to use the software nodes
Date:   Mon,  1 Mar 2021 16:42:21 +0200
Message-Id: <20210301144222.31290-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Software node was always created for the device if it was
supplied with additional device properties, so those nodes
might as well be constant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 24 +++++++++++++++++++----
 drivers/mfd/intel-lpss-pci.c  | 36 +++++++++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c      |  2 +-
 drivers/mfd/intel-lpss.h      |  4 ++--
 4 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 14a9cd83d4ef..1f396039d58f 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -27,9 +27,13 @@ static const struct property_entry spt_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node spt_i2c_node = {
+	.properties = spt_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info spt_i2c_info = {
 	.clk_rate = 120000000,
-	.properties = spt_i2c_properties,
+	.swnode = &spt_i2c_node,
 };
 
 static const struct property_entry uart_properties[] = {
@@ -39,10 +43,14 @@ static const struct property_entry uart_properties[] = {
 	{ },
 };
 
+static const struct software_node uart_node = {
+	.properties = uart_properties,
+};
+
 static const struct intel_lpss_platform_info spt_uart_info = {
 	.clk_rate = 120000000,
 	.clk_con_id = "baudclk",
-	.properties = uart_properties,
+	.swnode = &uart_node,
 };
 
 static const struct intel_lpss_platform_info bxt_info = {
@@ -56,9 +64,13 @@ static const struct property_entry bxt_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node bxt_i2c_node = {
+	.properties = bxt_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.clk_rate = 133000000,
-	.properties = bxt_i2c_properties,
+	.swnode = &bxt_i2c_node,
 };
 
 static const struct property_entry apl_i2c_properties[] = {
@@ -68,9 +80,13 @@ static const struct property_entry apl_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node apl_i2c_node = {
+	.properties = apl_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info apl_i2c_info = {
 	.clk_rate = 133000000,
-	.properties = apl_i2c_properties,
+	.swnode = &apl_i2c_node,
 };
 
 static const struct acpi_device_id intel_lpss_acpi_ids[] = {
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 7837f77d70d0..79c53617489c 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -70,9 +70,13 @@ static const struct property_entry spt_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node spt_i2c_node = {
+	.properties = spt_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info spt_i2c_info = {
 	.clk_rate = 120000000,
-	.properties = spt_i2c_properties,
+	.swnode = &spt_i2c_node,
 };
 
 static const struct property_entry uart_properties[] = {
@@ -82,10 +86,14 @@ static const struct property_entry uart_properties[] = {
 	{ },
 };
 
+static const struct software_node uart_node = {
+	.properties = uart_properties,
+};
+
 static const struct intel_lpss_platform_info spt_uart_info = {
 	.clk_rate = 120000000,
 	.clk_con_id = "baudclk",
-	.properties = uart_properties,
+	.swnode = &uart_node,
 };
 
 static const struct intel_lpss_platform_info bxt_info = {
@@ -95,7 +103,7 @@ static const struct intel_lpss_platform_info bxt_info = {
 static const struct intel_lpss_platform_info bxt_uart_info = {
 	.clk_rate = 100000000,
 	.clk_con_id = "baudclk",
-	.properties = uart_properties,
+	.swnode = &uart_node,
 };
 
 static const struct property_entry bxt_i2c_properties[] = {
@@ -105,9 +113,13 @@ static const struct property_entry bxt_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node bxt_i2c_node = {
+	.properties = bxt_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.clk_rate = 133000000,
-	.properties = bxt_i2c_properties,
+	.swnode = &bxt_i2c_node,
 };
 
 static const struct property_entry apl_i2c_properties[] = {
@@ -117,9 +129,13 @@ static const struct property_entry apl_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node apl_i2c_node = {
+	.properties = apl_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info apl_i2c_info = {
 	.clk_rate = 133000000,
-	.properties = apl_i2c_properties,
+	.swnode = &apl_i2c_node,
 };
 
 static const struct property_entry glk_i2c_properties[] = {
@@ -129,19 +145,23 @@ static const struct property_entry glk_i2c_properties[] = {
 	{ },
 };
 
+static const struct software_node glk_i2c_node = {
+	.properties = glk_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info glk_i2c_info = {
 	.clk_rate = 133000000,
-	.properties = glk_i2c_properties,
+	.swnode = &glk_i2c_node,
 };
 
 static const struct intel_lpss_platform_info cnl_i2c_info = {
 	.clk_rate = 216000000,
-	.properties = spt_i2c_properties,
+	.swnode = &spt_i2c_node,
 };
 
 static const struct intel_lpss_platform_info ehl_i2c_info = {
 	.clk_rate = 100000000,
-	.properties = bxt_i2c_properties,
+	.swnode = &bxt_i2c_node,
 };
 
 static const struct pci_device_id intel_lpss_pci_ids[] = {
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index b0f0781a6b9c..a9bf10bee796 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -399,7 +399,7 @@ int intel_lpss_probe(struct device *dev,
 	if (ret)
 		return ret;
 
-	lpss->cell->properties = info->properties;
+	lpss->cell->swnode = info->swnode;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index a2fbaed061ba..22dbc4aed793 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -15,14 +15,14 @@
 
 struct device;
 struct resource;
-struct property_entry;
+struct software_node;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
 	int irq;
 	unsigned long clk_rate;
 	const char *clk_con_id;
-	const struct property_entry *properties;
+	const struct software_node *swnode;
 };
 
 int intel_lpss_probe(struct device *dev,
-- 
2.30.1

