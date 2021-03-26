Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5486734A785
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCZMsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:48:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:22778 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhCZMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:48:31 -0400
IronPort-SDR: ZH7muB9MwD8djIAJ6spqo1kdbWRqe40Z7tBmdFEsb4/wzFMDKL/qkr48ZY5eoS+csoVrzvDac3
 1Ym5xzXcy4lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="171129942"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="171129942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 05:48:30 -0700
IronPort-SDR: FqGKEAEklaM6rQ4gyf9TbEqXPDRfT60HqKnjrxZuyPuhac7EiBWs1oIkihpcOvGYl0Fup2WHj2
 +IR7yPn8PwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="605510313"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2021 05:48:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 633AD6F1; Fri, 26 Mar 2021 14:48:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick with const
Date:   Fri, 26 Mar 2021 14:48:42 +0200
Message-Id: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus rightfully noticed, the driver plays dirty trick with const,
i.e. it assigns a place holder data structure to the const field
in the MFD cell and then drops the const by explicit casting. This is
not how it should be.

Assign local pointers of the cell and resource to the respective
non-const place holders in the intel_quark_i2c_setup() and
intel_quark_gpio_setup().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: eliminated bar parameter (Lee)
 drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 7f90e6f022ba..9a5f84b93776 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -157,17 +157,16 @@ static void intel_quark_unregister_i2c_clk(struct device *dev)
 	clk_unregister(quark_mfd->i2c_clk);
 }
 
-static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
+static int intel_quark_i2c_setup(struct pci_dev *pdev)
 {
+	struct mfd_cell *cell = &intel_quark_mfd_cells[MFD_I2C_BAR];
+	struct resource *res = intel_quark_i2c_res;
 	const struct dmi_system_id *dmi_id;
 	struct dw_i2c_platform_data *pdata;
-	struct resource *res = (struct resource *)cell->resources;
 	struct device *dev = &pdev->dev;
 
-	res[INTEL_QUARK_IORES_MEM].start =
-		pci_resource_start(pdev, MFD_I2C_BAR);
-	res[INTEL_QUARK_IORES_MEM].end =
-		pci_resource_end(pdev, MFD_I2C_BAR);
+	res[INTEL_QUARK_IORES_MEM].start = pci_resource_start(pdev, MFD_I2C_BAR);
+	res[INTEL_QUARK_IORES_MEM].end = pci_resource_end(pdev, MFD_I2C_BAR);
 
 	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
 	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
@@ -189,16 +188,15 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	return 0;
 }
 
-static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
+static int intel_quark_gpio_setup(struct pci_dev *pdev)
 {
+	struct mfd_cell *cell = &intel_quark_mfd_cells[MFD_GPIO_BAR];
+	struct resource *res = intel_quark_gpio_res;
 	struct dwapb_platform_data *pdata;
-	struct resource *res = (struct resource *)cell->resources;
 	struct device *dev = &pdev->dev;
 
-	res[INTEL_QUARK_IORES_MEM].start =
-		pci_resource_start(pdev, MFD_GPIO_BAR);
-	res[INTEL_QUARK_IORES_MEM].end =
-		pci_resource_end(pdev, MFD_GPIO_BAR);
+	res[INTEL_QUARK_IORES_MEM].start = pci_resource_start(pdev, MFD_GPIO_BAR);
+	res[INTEL_QUARK_IORES_MEM].end = pci_resource_end(pdev, MFD_GPIO_BAR);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -252,11 +250,11 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		goto err_unregister_i2c_clk;
 
-	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
+	ret = intel_quark_i2c_setup(pdev);
 	if (ret)
 		goto err_free_irq_vectors;
 
-	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[MFD_GPIO_BAR]);
+	ret = intel_quark_gpio_setup(pdev);
 	if (ret)
 		goto err_free_irq_vectors;
 
-- 
2.30.2

