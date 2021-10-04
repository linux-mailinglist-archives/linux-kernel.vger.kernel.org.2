Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E58421147
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhJDO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:26:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:12746 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhJDO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:26:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="206258020"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="206258020"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="483062659"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2021 07:18:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92A8D170; Mon,  4 Oct 2021 17:18:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>, Ferry Toth <ftoth@exalondelft.nl>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to the right controller"
Date:   Mon,  4 Oct 2021 17:18:39 +0300
Message-Id: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the right
controller") changed the device for the UDC and broke the user space scripts
that instantiate the USB gadget(s) via ConfigFS.

Revert it for now until the better solution will be proposed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8e66a70adae6..13664609ed3c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4253,7 +4253,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 
-	usb_initialize_gadget(dwc->sysdev, dwc->gadget, dwc_gadget_release);
+	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
 	dev				= &dwc->gadget->dev;
 	dev->platform_data		= dwc;
 	dwc->gadget->ops		= &dwc3_gadget_ops;
-- 
2.33.0

