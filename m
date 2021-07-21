Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFCF3D11E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhGUOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:24:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:52750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239505AbhGUOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="191032125"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="191032125"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 08:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="470184135"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2021 08:01:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 94EF9D7; Wed, 21 Jul 2021 18:02:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 1/2] parport: serial: Get rid of IRQ_NONE abuse
Date:   Wed, 21 Jul 2021 18:02:15 +0300
Message-Id: <20210721150216.64823-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_NONE definition is solely for IRQ handlers and not for generic
probe code. Replace it with plain integer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 96b888bb49c6..14e2427676f0 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -607,11 +607,12 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
                                         def.) */
 		/* TODO: test if sharing interrupts works */
 		irq = dev->irq;
-		if (irq == IRQ_NONE) {
+		if (irq == 0)
+			irq = PARPORT_IRQ_NONE;
+		if (irq == PARPORT_IRQ_NONE) {
 			dev_dbg(&dev->dev,
 				"PCI parallel port detected: I/O at %#lx(%#lx)\n",
 				io_lo, io_hi);
-			irq = PARPORT_IRQ_NONE;
 		} else {
 			dev_dbg(&dev->dev,
 				"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
-- 
2.30.2

