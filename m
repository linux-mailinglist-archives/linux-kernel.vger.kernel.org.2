Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F156A34630C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhCWPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:36:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:13473 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232855AbhCWPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:36:24 -0400
IronPort-SDR: 3qUiHcaZ5CYu//YJsf1hd/BgztOyohH/Ta4/MTohUUPlAFccAP5utwX498mktvoKMWdDqWv4ng
 5tLlcIxpVgWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190532519"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190532519"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:36:22 -0700
IronPort-SDR: hIENFlx5lkKVCZfZSMha1fZv/UONj/ZMBbkg8p/aSmHXQOhkHFxDEDIgr3sur+PgRXqNyzamyt
 EgkGivARci+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="415039755"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2021 08:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2363D49E; Tue, 23 Mar 2021 17:36:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/7] usb: gadget: pch_udc: Check if driver is present before calling ->setup()
Date:   Tue, 23 Mar 2021 17:36:21 +0200
Message-Id: <20210323153626.54908-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
References: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a separate routine for VBUS sense, the interrupt may occur
before gadget driver is present. Hence, ->setup() call may oops the kernel:

[   55.245843] BUG: kernel NULL pointer dereference, address: 00000010
...
[   55.245843] EIP: pch_udc_isr.cold+0x162/0x33f
...
[   55.245843]  <IRQ>
[   55.245843]  ? pch_udc_svc_data_out+0x160/0x160

Check if driver is present before calling ->setup().

Fixes: f646cf94520e ("USB device driver of Topcliff PCH")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo in the Subject
 drivers/usb/gadget/udc/pch_udc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index c517186384bc..2e3510dd026c 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -2298,6 +2298,21 @@ static void pch_udc_svc_data_out(struct pch_udc_dev *dev, int ep_num)
 		pch_udc_set_dma(dev, DMA_DIR_RX);
 }
 
+static int pch_udc_gadget_setup(struct pch_udc_dev *dev)
+	__must_hold(&dev->lock)
+{
+	int rc;
+
+	/* In some cases we can get an interrupt before driver gets setup */
+	if (!dev->driver)
+		return -ESHUTDOWN;
+
+	spin_unlock(&dev->lock);
+	rc = dev->driver->setup(&dev->gadget, &dev->setup_data);
+	spin_lock(&dev->lock);
+	return rc;
+}
+
 /**
  * pch_udc_svc_control_in() - Handle Control IN endpoint interrupts
  * @dev:	Reference to the device structure
@@ -2369,15 +2384,12 @@ static void pch_udc_svc_control_out(struct pch_udc_dev *dev)
 			dev->gadget.ep0 = &dev->ep[UDC_EP0IN_IDX].ep;
 		else /* OUT */
 			dev->gadget.ep0 = &ep->ep;
-		spin_lock(&dev->lock);
 		/* If Mass storage Reset */
 		if ((dev->setup_data.bRequestType == 0x21) &&
 		    (dev->setup_data.bRequest == 0xFF))
 			dev->prot_stall = 0;
 		/* call gadget with setup data received */
-		setup_supported = dev->driver->setup(&dev->gadget,
-						     &dev->setup_data);
-		spin_unlock(&dev->lock);
+		setup_supported = pch_udc_gadget_setup(dev);
 
 		if (dev->setup_data.bRequestType & USB_DIR_IN) {
 			ep->td_data->status = (ep->td_data->status &
@@ -2625,9 +2637,7 @@ static void pch_udc_svc_intf_interrupt(struct pch_udc_dev *dev)
 		dev->ep[i].halted = 0;
 	}
 	dev->stall = 0;
-	spin_unlock(&dev->lock);
-	dev->driver->setup(&dev->gadget, &dev->setup_data);
-	spin_lock(&dev->lock);
+	pch_udc_gadget_setup(dev);
 }
 
 /**
@@ -2662,9 +2672,7 @@ static void pch_udc_svc_cfg_interrupt(struct pch_udc_dev *dev)
 	dev->stall = 0;
 
 	/* call gadget zero with setup data received */
-	spin_unlock(&dev->lock);
-	dev->driver->setup(&dev->gadget, &dev->setup_data);
-	spin_lock(&dev->lock);
+	pch_udc_gadget_setup(dev);
 }
 
 /**
-- 
2.30.2

