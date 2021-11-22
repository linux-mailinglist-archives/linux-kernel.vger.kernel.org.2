Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D382D458E01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhKVMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:09:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:55369 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239466AbhKVMJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:09:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="234596792"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="234596792"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="649432949"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2021 04:06:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2721B8; Mon, 22 Nov 2021 14:06:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
Date:   Mon, 22 Nov 2021 14:06:03 +0200
Message-Id: <20211122120604.3909-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122120604.3909-1-andriy.shevchenko@linux.intel.com>
References: <20211122120604.3909-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Fix error in table for PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S that caused it
and PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4 to be missing their fourth port.

Fixes: 78d3820b9bd3 ("serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()")
Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 5d43de143f33..b793d848aeb6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2291,12 +2291,19 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
-		.vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
 		.setup      = pci_pericom_setup_four_at_eight,
 	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup_four_at_eight,
+	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
-- 
2.33.0

