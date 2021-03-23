Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAD34630D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCWPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:36:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:13473 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232907AbhCWPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:36:25 -0400
IronPort-SDR: P87sFH9xvtjaMaTbjiF021+li7bIMWU0kMxtulqhAmqgbDOqEtxnXujSrMEmAmB0iI6IKB15Fn
 I0dLJ4NlThsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190532526"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190532526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 08:36:24 -0700
IronPort-SDR: vtDaTiLMQF/hLAK1uvGUTbaWJxzG5f75koFPQqk2rsO/YkMXfN/mmvyAv/AkHx3jUFpDPKj0Hx
 3X2k4qyt6e3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452187446"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2021 08:36:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30B6B4DB; Tue, 23 Mar 2021 17:36:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 3/7] usb: gadget: pch_udc: Check for DMA mapping error
Date:   Tue, 23 Mar 2021 17:36:22 +0200
Message-Id: <20210323153626.54908-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
References: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA mapping might fail, we have to check it with dma_mapping_error().
Otherwise DMA-API is not happy:

  DMA-API: pch_udc 0000:02:02.4: device driver failed to check map error[device address=0x00000000027ee678] [size=64 bytes] [mapped as single]

Fixes: abab0c67c061 ("usb: pch_udc: Fixed issue which does not work with g_serial")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/usb/gadget/udc/pch_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 2e3510dd026c..455fd9cde0e6 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -2946,7 +2946,7 @@ static int init_dma_pools(struct pch_udc_dev *dev)
 	dev->dma_addr = dma_map_single(&dev->pdev->dev, ep0out_buf,
 				       UDC_EP0OUT_BUFF_SIZE * 4,
 				       DMA_FROM_DEVICE);
-	return 0;
+	return dma_mapping_error(&dev->pdev->dev, dev->dma_addr);
 }
 
 static int pch_udc_start(struct usb_gadget *g,
-- 
2.30.2

