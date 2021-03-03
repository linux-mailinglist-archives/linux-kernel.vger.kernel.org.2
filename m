Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6518632BF9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579916AbhCCSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:39559 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhCCQvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:51:45 -0500
IronPort-SDR: U9k8chbhdjna3723hqYXEJQRri068mK8nWOWZJ+r1QVcdWpehcHnkXttHZpF2LOAOS3W5PPnU8
 3HxAStqEvrLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174872084"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174872084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:49:52 -0800
IronPort-SDR: MVNhfEgx77fR+vqb/6TL1HXRYD8KLpzQkPB8Zlj4IA+ZxIstV5OuzFsYSFohAA3c4TCwYsQxsY
 iBhJHtjkuwtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407314152"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2021 08:49:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12E5D1F1; Wed,  3 Mar 2021 18:49:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] mfd: lpc_sch: Partially revert "Add support for Intel Quark X1000"
Date:   Wed,  3 Mar 2021 18:49:44 +0200
Message-Id: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ support for SCH GPIO is not specific to the Intel Quark SoC.
Moreover the IRQ routing is quite interesting there, so while it's
needs a special support, the driver haven't it anyway yet.

Due to above remove basically redundant code of IRQ support.

This reverts commit ec689a8a8155ce8b966bd5d7737a3916f5e48be3.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_sch.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/lpc_sch.c b/drivers/mfd/lpc_sch.c
index f27eb8dabc1c..428a526cbe86 100644
--- a/drivers/mfd/lpc_sch.c
+++ b/drivers/mfd/lpc_sch.c
@@ -26,9 +26,6 @@
 #define GPIO_IO_SIZE	64
 #define GPIO_IO_SIZE_CENTERTON	128
 
-/* Intel Quark X1000 GPIO IRQ Number */
-#define GPIO_IRQ_QUARK_X1000	9
-
 #define WDTBASE		0x84
 #define WDT_IO_SIZE	64
 
@@ -43,30 +40,25 @@ struct lpc_sch_info {
 	unsigned int io_size_smbus;
 	unsigned int io_size_gpio;
 	unsigned int io_size_wdt;
-	int irq_gpio;
 };
 
 static struct lpc_sch_info sch_chipset_info[] = {
 	[LPC_SCH] = {
 		.io_size_smbus = SMBUS_IO_SIZE,
 		.io_size_gpio = GPIO_IO_SIZE,
-		.irq_gpio = -1,
 	},
 	[LPC_ITC] = {
 		.io_size_smbus = SMBUS_IO_SIZE,
 		.io_size_gpio = GPIO_IO_SIZE,
 		.io_size_wdt = WDT_IO_SIZE,
-		.irq_gpio = -1,
 	},
 	[LPC_CENTERTON] = {
 		.io_size_smbus = SMBUS_IO_SIZE,
 		.io_size_gpio = GPIO_IO_SIZE_CENTERTON,
 		.io_size_wdt = WDT_IO_SIZE,
-		.irq_gpio = -1,
 	},
 	[LPC_QUARK_X1000] = {
 		.io_size_gpio = GPIO_IO_SIZE,
-		.irq_gpio = GPIO_IRQ_QUARK_X1000,
 		.io_size_wdt = WDT_IO_SIZE,
 	},
 };
@@ -113,13 +105,13 @@ static int lpc_sch_get_io(struct pci_dev *pdev, int where, const char *name,
 }
 
 static int lpc_sch_populate_cell(struct pci_dev *pdev, int where,
-				 const char *name, int size, int irq,
-				 int id, struct mfd_cell *cell)
+				 const char *name, int size, int id,
+				 struct mfd_cell *cell)
 {
 	struct resource *res;
 	int ret;
 
-	res = devm_kcalloc(&pdev->dev, 2, sizeof(*res), GFP_KERNEL);
+	res = devm_kzalloc(&pdev->dev, sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
 
@@ -135,18 +127,6 @@ static int lpc_sch_populate_cell(struct pci_dev *pdev, int where,
 	cell->ignore_resource_conflicts = true;
 	cell->id = id;
 
-	/* Check if we need to add an IRQ resource */
-	if (irq < 0)
-		return 0;
-
-	res++;
-
-	res->start = irq;
-	res->end = irq;
-	res->flags = IORESOURCE_IRQ;
-
-	cell->num_resources++;
-
 	return 0;
 }
 
@@ -158,7 +138,7 @@ static int lpc_sch_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	int ret;
 
 	ret = lpc_sch_populate_cell(dev, SMBASE, "isch_smbus",
-				    info->io_size_smbus, -1,
+				    info->io_size_smbus,
 				    id->device, &lpc_sch_cells[cells]);
 	if (ret < 0)
 		return ret;
@@ -166,7 +146,7 @@ static int lpc_sch_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		cells++;
 
 	ret = lpc_sch_populate_cell(dev, GPIOBASE, "sch_gpio",
-				    info->io_size_gpio, info->irq_gpio,
+				    info->io_size_gpio,
 				    id->device, &lpc_sch_cells[cells]);
 	if (ret < 0)
 		return ret;
@@ -174,7 +154,7 @@ static int lpc_sch_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		cells++;
 
 	ret = lpc_sch_populate_cell(dev, WDTBASE, "ie6xx_wdt",
-				    info->io_size_wdt, -1,
+				    info->io_size_wdt,
 				    id->device, &lpc_sch_cells[cells]);
 	if (ret < 0)
 		return ret;
-- 
2.30.1

