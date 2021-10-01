Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7241F2CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbhJARRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:17:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:37267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhJARRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:17:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248067337"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248067337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 01 Oct 2021 10:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="619278641"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2021 10:15:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02BD3B8; Fri,  1 Oct 2021 20:15:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: spi-nor: intel-spi: Add support for Intel Ice Lake-N SPI serial flash
Date:   Fri,  1 Oct 2021 20:15:30 +0300
Message-Id: <20211001171530.15283-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP.
Add Ice Lake-N PCI ID to the driver list of supported devices.

The device can be found on MacBookPro16,2 [1].

[1]: https://linux-hardware.org/?probe=f1c5cf0c43

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 1bc53b8bb88a..f9bcd2dabb4f 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -70,6 +70,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x19e0), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1bca), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
-- 
2.33.0

