Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09534519A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhCVVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:12:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:11980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhCVVLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:44 -0400
IronPort-SDR: Vnj1v1MEDgER03XVQQooig2GRuefWXUc8kN4NOzfexyyb/RjHhSh7W7bdN22mggnf3Nb8wwU7+
 hF4Ny3nimjaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251703778"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251703778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:11:43 -0700
IronPort-SDR: cu7FV9JPSSrvfnA7KF4jd9cbxwa9O9bJ14iJNB8GBbvWPDwyISdb+o+VuwNf9hHcHdAdl/FAtD
 FN61i+TTX2tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="390624893"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2021 14:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46E3747A; Mon, 22 Mar 2021 23:11:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/6] usb: gadget: pch_udc: Move pch_udc_init() to satisfy kernel doc
Date:   Mon, 22 Mar 2021 23:11:47 +0200
Message-Id: <20210322211149.6658-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc and the content described by it shouldn't be teared apart.
Otherwise validator is not happy:

.../pch_udc.c:573: warning: expecting prototype for pch_udc_reconnect(). Prototype was for pch_udc_init() instead

Fixes: 1c575d2d2e3f ("usb: gadget: pch_udc: Fix usb/gadget/pch_udc: Fix ether gadget connect/disconnect issue")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 5421075df01c..984c9299d2c6 100644
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

