Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75630345E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCWMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:34:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:55919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhCWMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:34:25 -0400
IronPort-SDR: cxepZ0proOUjeeoRoS/1gU6avvYcXqNqBBcTZZo9YHdZULZ1LVR9I3zI6VEk6B0owhNCkeKHIL
 1YoYnXM7pAOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="187148782"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="187148782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 05:34:25 -0700
IronPort-SDR: AKbrtfZcgIrB3XnIZ1tz1gKQxjmckt+OYZ21+TehLwqJkXmOvU+xjTSO88mPDcV6nlR4EwfD9g
 GcEgj1qZR6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="376047086"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2021 05:34:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABFFA2C4; Tue, 23 Mar 2021 14:34:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/2] mfd: intel_quark_i2c_gpio: Reuse BAR definitions for MFD cell indexing
Date:   Tue, 23 Mar 2021 14:34:32 +0200
Message-Id: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's convenient and less error prone to use definitions to address
different cells in an array. For this purpose we may reuse existing
BAR definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used explicit indices for MFD cells in the array (Lee)
 drivers/mfd/intel_quark_i2c_gpio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 7af22d1399e1..52728a963c17 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -98,15 +98,7 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio = {
 };
 
 static struct mfd_cell intel_quark_mfd_cells[] = {
-	{
-		.id = MFD_GPIO_BAR,
-		.name = "gpio-dwapb",
-		.acpi_match = &intel_quark_acpi_match_gpio,
-		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
-		.resources = intel_quark_gpio_res,
-		.ignore_resource_conflicts = true,
-	},
-	{
+	[MFD_I2C_BAR] = {
 		.id = MFD_I2C_BAR,
 		.name = "i2c_designware",
 		.acpi_match = &intel_quark_acpi_match_i2c,
@@ -114,6 +106,14 @@ static struct mfd_cell intel_quark_mfd_cells[] = {
 		.resources = intel_quark_i2c_res,
 		.ignore_resource_conflicts = true,
 	},
+	[MFD_GPIO_BAR] = {
+		.id = MFD_GPIO_BAR,
+		.name = "gpio-dwapb",
+		.acpi_match = &intel_quark_acpi_match_gpio,
+		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
+		.resources = intel_quark_gpio_res,
+		.ignore_resource_conflicts = true,
+	},
 };
 
 static const struct pci_device_id intel_quark_mfd_ids[] = {
@@ -245,11 +245,11 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[1]);
+	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
 	if (ret)
 		goto err_unregister_i2c_clk;
 
-	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[0]);
+	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[MFD_GPIO_BAR]);
 	if (ret)
 		goto err_unregister_i2c_clk;
 
-- 
2.30.2

