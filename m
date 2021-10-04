Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E434211E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhJDOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:49:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:17170 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234744AbhJDOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:49:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="248715217"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="248715217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="713430012"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2021 07:41:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7472170; Mon,  4 Oct 2021 17:41:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] usb: gadget: udc: core: Use pr_fmt() to prefix messages
Date:   Mon,  4 Oct 2021 17:41:25 +0300
Message-Id: <20211004144126.49154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating, use pr_fmt() to prefix pr_*() messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 14fdf918ecfe..f66ac6f8011e 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -6,6 +6,8 @@
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
+#define pr_fmt(fmt)	"UDC core: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -1555,14 +1557,14 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 
 	if (!driver->match_existing_only) {
 		list_add_tail(&driver->pending, &gadget_driver_pending_list);
-		pr_info("udc-core: couldn't find an available UDC - added [%s] to list of pending drivers\n",
+		pr_info("couldn't find an available UDC - added [%s] to list of pending drivers\n",
 			driver->function);
 		ret = 0;
 	}
 
 	mutex_unlock(&udc_lock);
 	if (ret)
-		pr_warn("udc-core: couldn't find an available UDC or it's busy\n");
+		pr_warn("couldn't find an available UDC or it's busy\n");
 	return ret;
 found:
 	ret = udc_bind_to_driver(udc, driver);
-- 
2.33.0

