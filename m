Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F97346310
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhCWPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:36:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:19715 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhCWPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:36:27 -0400
IronPort-SDR: 2gxe7B/3W8bOTUOFJ4Tkb/NAW4w0PC637s+24aSXuqhljM4zoL7uA/galL3WikbJf6WbJDzr3f
 5RBM4wKIJy1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210582825"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="210582825"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:36:27 -0700
IronPort-SDR: +EWCsj6VAid93VXh004dz3/zjnNWg6+IPdvWlPL35mk3gKxYKQ0CfK7WA/o3ew35u4rQE/bzJp
 hFH2KBBL6V2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="413420887"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2021 08:36:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BFF049E; Tue, 23 Mar 2021 17:36:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iago Abal <mail@iagoabal.eu>
Subject: [PATCH v2 5/7] usb: gadget: pch_udc: Revert d3cb25a12138 completely
Date:   Tue, 23 Mar 2021 17:36:24 +0200
Message-Id: <20210323153626.54908-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
References: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
 drivers/usb/gadget/udc/pch_udc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index a5365b524617..58cea8d3d68f 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -597,18 +597,22 @@ static void pch_udc_reconnect(struct pch_udc_dev *dev)
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
@@ -1167,20 +1171,25 @@ static int pch_udc_pcd_selfpowered(struct usb_gadget *gadget, int value)
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

