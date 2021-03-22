Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9117345198
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCVVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:18052 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhCVVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:45 -0400
IronPort-SDR: anEx+cU/FCVmVgaCRyoI6xSxbDlhiXC803A/xGxk22zDme5MUQMsGi3jLuZwb9dIDsSxBxF5Ak
 /aGppxr7Sy2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275450705"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="275450705"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:43 -0700
IronPort-SDR: kcJzkMBvTylVZcAJLbQSX8/gKfeP75lgycbjcZXw1ANfZ238ejUhxSG8c+rTIB59tCKJVnCYY4
 SHj7+QJocTIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="592752296"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2021 14:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3EA0B2C4; Mon, 22 Mar 2021 23:11:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iago Abal <mail@iagoabal.eu>
Subject: [PATCH v1 3/6] usb: gadget: pch_udc: Revert d3cb25a12138 completely
Date:   Mon, 22 Mar 2021 23:11:46 +0200
Message-Id: <20210322211149.6658-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d3cb25a12138 ("usb: gadget: udc: fix spin_lock in pch_udc")
obviously was not thought through and had made the situation even worse
than it was before. Two changes after almost reverted it. but a few
leftovers have been left as it. With this revert d3cb25a12138 completely.

While at it, narrow down the scope of unlocked section to prevent
potential race when prot_stall is assigned.

Fixes: d3cb25a12138 ("usb: gadget: udc: fix spin_lock in pch_udc")
Fixes: 9903b6bedd38 ("usb: gadget: pch-udc: fix lock")
Fixes: 1d23d16a88e6 ("usb: gadget: pch_udc: reorder spin_[un]lock to avoid deadlock")
Cc: Iago Abal <mail@iagoabal.eu>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 5bb83a2705ad..5421075df01c 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -596,18 +596,22 @@ static void pch_udc_reconnect(struct pch_udc_dev *dev)
 static inline void pch_udc_vbus_session(struct pch_udc_dev *dev,
 					  int is_active)
 {
+	unsigned long		iflags;
+
+	spin_lock_irqsave(&dev->lock, iflags);
 	if (is_active) {
 		pch_udc_reconnect(dev);
 		dev->vbus_session = 1;
 	} else {
 		if (dev->driver && dev->driver->disconnect) {
-			spin_lock(&dev->lock);
+			spin_unlock_irqrestore(&dev->lock, iflags);
 			dev->driver->disconnect(&dev->gadget);
-			spin_unlock(&dev->lock);
+			spin_lock_irqsave(&dev->lock, iflags);
 		}
 		pch_udc_set_disconnect(dev);
 		dev->vbus_session = 0;
 	}
+	spin_unlock_irqrestore(&dev->lock, iflags);
 }
 
 /**
@@ -1166,20 +1170,25 @@ static int pch_udc_pcd_selfpowered(struct usb_gadget *gadget, int value)
 static int pch_udc_pcd_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct pch_udc_dev	*dev;
+	unsigned long		iflags;
 
 	if (!gadget)
 		return -EINVAL;
+
 	dev = container_of(gadget, struct pch_udc_dev, gadget);
+
+	spin_lock_irqsave(&dev->lock, iflags);
 	if (is_on) {
 		pch_udc_reconnect(dev);
 	} else {
 		if (dev->driver && dev->driver->disconnect) {
-			spin_lock(&dev->lock);
+			spin_unlock_irqrestore(&dev->lock, iflags);
 			dev->driver->disconnect(&dev->gadget);
-			spin_unlock(&dev->lock);
+			spin_lock_irqsave(&dev->lock, iflags);
 		}
 		pch_udc_set_disconnect(dev);
 	}
+	spin_unlock_irqrestore(&dev->lock, iflags);
 
 	return 0;
 }
-- 
2.30.2

