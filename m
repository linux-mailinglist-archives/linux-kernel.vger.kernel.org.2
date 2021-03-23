Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C4346308
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhCWPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:36:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:63207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhCWPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:36:24 -0400
IronPort-SDR: cFQzTPOs/cHx7jF7/h1vY/fOiYKl0Sp1Elwnp5omC7QA0NDTMfhHNdvAjREVJcA56bmSnIKb2X
 S+qgEu96rAtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169834699"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="169834699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:36:24 -0700
IronPort-SDR: gACjoh6jfW1if95pq2MRKmQtj1aMuxNU3bsFtknl1l0glw0vZ/+jFS6YoiaTBhuUlc+gsuPTSy
 Z+jFCxjkF26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="513788553"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2021 08:36:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E54153E; Tue, 23 Mar 2021 17:36:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 4/7] usb: gadget: pch_udc: Move pch_udc_init() to satisfy kernel doc
Date:   Tue, 23 Mar 2021 17:36:23 +0200
Message-Id: <20210323153626.54908-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
References: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc and the content described by it shouldn't be torn apart.
Otherwise validator is not happy:

.../pch_udc.c:573: warning: expecting prototype for pch_udc_reconnect(). Prototype was for pch_udc_init() instead

Fixes: 1c575d2d2e3f ("usb: gadget: pch_udc: Fix usb/gadget/pch_udc: Fix ether gadget connect/disconnect issue")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Fixed typo in the commit message (Sergei)
 drivers/usb/gadget/udc/pch_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 455fd9cde0e6..a5365b524617 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -563,12 +563,13 @@ static void pch_udc_clear_disconnect(struct pch_udc_dev *dev)
 	pch_udc_bit_clr(dev, UDC_DEVCTL_ADDR, UDC_DEVCTL_RES);
 }
 
+static void pch_udc_init(struct pch_udc_dev *dev);
+
 /**
  * pch_udc_reconnect() - This API initializes usb device controller,
  *						and clear the disconnect status.
  * @dev:		Reference to pch_udc_regs structure
  */
-static void pch_udc_init(struct pch_udc_dev *dev);
 static void pch_udc_reconnect(struct pch_udc_dev *dev)
 {
 	pch_udc_init(dev);
-- 
2.30.2

