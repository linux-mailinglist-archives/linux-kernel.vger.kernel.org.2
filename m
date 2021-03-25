Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6052349A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCYTYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:24:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:45790 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCYTXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:23:39 -0400
IronPort-SDR: T52ZengW2qrDRGDlmqemAyRMsdolFte6AWZsAd12pym+dpoeFDKiqiAW6wact7zPsaQW2CJ9pa
 Zw2Cw6BCw5Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="252361417"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="252361417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 12:23:39 -0700
IronPort-SDR: 8XoTRiTBoInAQeThsSpFVNuSrmA/UDezC793YWALlqhC6Ku6HojnjqxMlHSbqOdnilpmz0aOPv
 s2ZD2/j/nD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="416155750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2021 12:23:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5D93236; Thu, 25 Mar 2021 21:23:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick with const
Date:   Thu, 25 Mar 2021 21:23:47 +0200
Message-Id: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus rightfully noticed, the driver plays dirty trick with const,
i.e. it assigns a place holder data structure to the const field
in the MFD cell and then drops the const by explicit casting. This
is not how it should be.

Replace cell parameter by bar and assign local pointer res to the
respective non-const place holder in the intel_quark_i2c_setup()
and intel_quark_gpio_setup().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 7f90e6f022ba..f2bce2ade510 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -157,17 +157,16 @@ static void intel_quark_unregister_i2c_clk(struct device *dev)
 	clk_unregister(quark_mfd->i2c_clk);
 }
 
-static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
+static int intel_quark_i2c_setup(struct pci_dev *pdev, int bar)
 {
+	struct mfd_cell *cell = &intel_quark_mfd_cells[bar];
+	struct resource *res = intel_quark_i2c_res;
 	const struct dmi_system_id *dmi_id;
 	struct dw_i2c_platform_data *pdata;
-	struct resource *res = (struct resource *)cell->resources;
 	struct device *dev = &pdev->dev;
 
-	res[INTEL_QUARK_IORES_MEM].start =
-		pci_resource_start(pdev, MFD_I2C_BAR);
-	res[INTEL_QUARK_IORES_MEM].end =
-		pci_resource_end(pdev, MFD_I2C_BAR);
+	res[INTEL_QUARK_IORES_MEM].start = pci_resource_start(pdev, bar);
+	res[INTEL_QUARK_IORES_MEM].end = pci_resource_end(pdev, bar);
 
 	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
 	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
@@ -189,16 +188,15 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	return 0;
 }
 
-static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
+static int intel_quark_gpio_setup(struct pci_dev *pdev, int bar)
 {
+	struct mfd_cell *cell = &intel_quark_mfd_cells[bar];
+	struct resource *res = intel_quark_gpio_res;
 	struct dwapb_platform_data *pdata;
-	struct resource *res = (struct resource *)cell->resources;
 	struct device *dev = &pdev->dev;
 
-	res[INTEL_QUARK_IORES_MEM].start =
-		pci_resource_start(pdev, MFD_GPIO_BAR);
-	res[INTEL_QUARK_IORES_MEM].end =
-		pci_resource_end(pdev, MFD_GPIO_BAR);
+	res[INTEL_QUARK_IORES_MEM].start = pci_resource_start(pdev, bar);
+	res[INTEL_QUARK_IORES_MEM].end = pci_resource_end(pdev, bar);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -252,11 +250,11 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		goto err_unregister_i2c_clk;
 
-	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
+	ret = intel_quark_i2c_setup(pdev, MFD_I2C_BAR);
 	if (ret)
 		goto err_free_irq_vectors;
 
-	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[MFD_GPIO_BAR]);
+	ret = intel_quark_gpio_setup(pdev, MFD_GPIO_BAR);
 	if (ret)
 		goto err_free_irq_vectors;
 
-- 
2.30.2

