Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79134519C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhCVVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:5132 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhCVVLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:47 -0400
IronPort-SDR: lq+mZuGXpe7I/XgDGC0jUFWJKimD1xjTfv5kWHbsA+YxsAXD0jQ34sZQlykEuJBjG2MGHV1fOS
 nsCXyYgejRGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210424058"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210424058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:47 -0700
IronPort-SDR: 2Oa3bjkD7NcBddGdIwiMO200ixVuKTIHtCHhg0Y6oOIIfX6Z0gKKTlFeL0A3ovt/fAiDpmZPoF
 AcH8gVpRLg3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="451871773"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2021 14:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C1CC11F; Mon, 22 Mar 2021 23:11:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/6] usb: gadget: pch_udc: Drop unneeded cpu_to_le32() call
Date:   Mon, 22 Mar 2021 23:11:44 +0200
Message-Id: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Either way ~0 will be in the correct byte order,
hence drop unneeded cpu_to_le32() call. Moreover,
it makes sparse happy, otherwise it complains:

pch_udc.c:1813:27: warning: incorrect type in assignment (different base types)
pch_udc.c:1813:27:    expected unsigned int [usertype] dataptr
pch_udc.c:1813:27:    got restricted __le32 [usertype]

Fixes: f646cf94520e ("USB device driver of Topcliff PCH")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index a3c1fc924268..2e2dca391007 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1756,7 +1756,7 @@ static struct usb_request *pch_udc_alloc_request(struct usb_ep *usbep,
 	}
 	/* prevent from using desc. - set HOST BUSY */
 	dma_desc->status |= PCH_UDC_BS_HST_BSY;
-	dma_desc->dataptr = cpu_to_le32(DMA_ADDR_INVALID);
+	dma_desc->dataptr = DMA_ADDR_INVALID;
 	req->td_data = dma_desc;
 	req->td_data_last = dma_desc;
 	req->chain_len = 1;
-- 
2.30.2

