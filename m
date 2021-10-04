Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522354211A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhJDOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:43:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:55606 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234721AbhJDOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:43:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="225772059"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="225772059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="711257352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2021 07:41:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1B8D183; Mon,  4 Oct 2021 17:41:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] usb: gadget: udc: core: Print error code in usb_gadget_probe_driver()
Date:   Mon,  4 Oct 2021 17:41:26 +0300
Message-Id: <20211004144126.49154-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211004144126.49154-1-andriy.shevchenko@linux.intel.com>
References: <20211004144126.49154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the UDC is not found, print also the error code for easier debugging.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index f66ac6f8011e..d6265118647b 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1564,7 +1564,7 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 
 	mutex_unlock(&udc_lock);
 	if (ret)
-		pr_warn("couldn't find an available UDC or it's busy\n");
+		pr_warn("couldn't find an available UDC or it's busy: %d\n", ret);
 	return ret;
 found:
 	ret = udc_bind_to_driver(udc, driver);
-- 
2.33.0

