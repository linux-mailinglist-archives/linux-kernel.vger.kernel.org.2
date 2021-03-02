Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCD32A7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579085AbhCBQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:14370 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572968AbhCBOIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:11 -0500
IronPort-SDR: 0ho4jQ7YmMGLKIMRynxwbKypLuRqpAsXzkAUdJbjoRvn6gv9LV1bS3inYT75cjoVwPrQQGXDYp
 W1i/3oVry+IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166052176"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="166052176"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:56:35 -0800
IronPort-SDR: VEMh6AVOuh5XXgXupaOVaZ6/yGrxmzRpuG1sow66gz5dwH9lWho6rakMIbOBiWOXRMWsktXOrg
 1AB1Qy8lvtLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="599675853"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2021 05:56:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 265E8F4; Tue,  2 Mar 2021 15:56:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 5/5] mfd: intel_quark_i2c_gpio: Reuse BAR definitions for MFD cell indexing
Date:   Tue,  2 Mar 2021 15:56:20 +0200
Message-Id: <20210302135620.89958-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
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
 drivers/mfd/intel_quark_i2c_gpio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 7af22d1399e1..40871ce34e82 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -98,14 +98,6 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio = {
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
 	{
 		.id = MFD_I2C_BAR,
 		.name = "i2c_designware",
@@ -114,6 +106,14 @@ static struct mfd_cell intel_quark_mfd_cells[] = {
 		.resources = intel_quark_i2c_res,
 		.ignore_resource_conflicts = true,
 	},
+	{
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
2.30.1

