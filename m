Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75E345196
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhCVVMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:18052 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCVVLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:43 -0400
IronPort-SDR: 10jgB+8kIi30/1/1FwYYe2yWT3sWIJKQsRq9O2IZF5FuopBxusU9MN4L4qI0hc0fcuKEBYEp7V
 l0LiuXl7rWnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275450701"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="275450701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:43 -0700
IronPort-SDR: 8Fe0dVdtS7ZdHq4akg4ZfIPAaIDyOFMlySbFM+g0Ui2U4RlNVLgK3KRFu7CE8DKF9X1ZZgwZXA
 WIsUBMhx38fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="592752295"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2021 14:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35590E7; Mon, 22 Mar 2021 23:11:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/6] usb: gardet: pch_udc: Check if driver is present before calling ->setup()
Date:   Mon, 22 Mar 2021 23:11:45 +0200
Message-Id: <20210322211149.6658-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
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
 drivers/usb/gadget/udc/pch_udc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 2e2dca391007..5bb83a2705ad 100644
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

