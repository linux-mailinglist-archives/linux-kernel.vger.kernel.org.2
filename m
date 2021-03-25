Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C23349363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCYNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:57257 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCYNy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:54:59 -0400
IronPort-SDR: 3gJmhW46VE0/d7taVIVCxCksrcC+wKsAWxh1L2oxZpk/oZphJR7Q/+mMAewP6/tyj103WjvRMq
 vptGTxQdyZgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170283047"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170283047"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:54:59 -0700
IronPort-SDR: /eB4PJQA4glh94MsZ2AaMlTxxZBxQRy1dUR2xvh363LEQ+P/7oO4iokCVZCest2mLGjjX0wSaa
 GzBubCd0GG7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409375487"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2021 06:54:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A6AFE7; Thu, 25 Mar 2021 15:55:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/4] usb: gadget: pch_udc: switch over to usb_gadget_map/unmap_request()
Date:   Thu, 25 Mar 2021 15:55:05 +0200
Message-Id: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have generic implementations for a reason, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 78 +++-----------------------------
 1 file changed, 6 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 070f43fd5bb6..6a96d4a3df2d 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -383,11 +383,8 @@ MODULE_PARM_DESC(speed_fs, "true for Full speed operation");
  * @td_data_last:	last dma desc. of chain
  * @queue:		associated queue
  * @dma_going:		DMA in progress for request
- * @dma_mapped:		DMA memory mapped for request
  * @dma_done:		DMA completed for request
  * @chain_len:		chain length
- * @buf:		Buffer memory for align adjustment
- * @dma:		DMA memory for align adjustment
  */
 struct pch_udc_request {
 	struct usb_request		req;
@@ -396,11 +393,8 @@ struct pch_udc_request {
 	struct pch_udc_data_dma_desc	*td_data_last;
 	struct list_head		queue;
 	unsigned			dma_going:1,
-					dma_mapped:1,
 					dma_done:1;
 	unsigned			chain_len;
-	void				*buf;
-	dma_addr_t			dma;
 };
 
 static inline u32 pch_udc_readl(struct pch_udc_dev *dev, unsigned long reg)
@@ -1482,33 +1476,7 @@ static void complete_req(struct pch_udc_ep *ep, struct pch_udc_request *req,
 		status = req->req.status;
 
 	dev = ep->dev;
-	if (req->dma_mapped) {
-		if (req->dma == DMA_ADDR_INVALID) {
-			if (ep->in)
-				dma_unmap_single(&dev->pdev->dev, req->req.dma,
-						 req->req.length,
-						 DMA_TO_DEVICE);
-			else
-				dma_unmap_single(&dev->pdev->dev, req->req.dma,
-						 req->req.length,
-						 DMA_FROM_DEVICE);
-			req->req.dma = DMA_ADDR_INVALID;
-		} else {
-			if (ep->in)
-				dma_unmap_single(&dev->pdev->dev, req->dma,
-						 req->req.length,
-						 DMA_TO_DEVICE);
-			else {
-				dma_unmap_single(&dev->pdev->dev, req->dma,
-						 req->req.length,
-						 DMA_FROM_DEVICE);
-				memcpy(req->req.buf, req->buf, req->req.length);
-			}
-			kfree(req->buf);
-			req->dma = DMA_ADDR_INVALID;
-		}
-		req->dma_mapped = 0;
-	}
+	usb_gadget_unmap_request(&dev->gadget, &req->req, ep->in);
 	ep->halted = 1;
 	spin_unlock(&dev->lock);
 	if (!ep->in)
@@ -1586,12 +1554,9 @@ static int pch_udc_create_dma_chain(struct pch_udc_ep *ep,
 	if (req->chain_len > 1)
 		pch_udc_free_dma_chain(ep->dev, req);
 
-	if (req->dma == DMA_ADDR_INVALID)
-		td->dataptr = req->req.dma;
-	else
-		td->dataptr = req->dma;
-
+	td->dataptr = req->req.dma;
 	td->status = PCH_UDC_BS_HST_BSY;
+
 	for (; ; bytes -= buf_len, ++len) {
 		td->status = PCH_UDC_BS_HST_BSY | min(buf_len, bytes);
 		if (bytes <= buf_len)
@@ -1797,7 +1762,6 @@ static struct usb_request *pch_udc_alloc_request(struct usb_ep *usbep,
 	if (!req)
 		return NULL;
 	req->req.dma = DMA_ADDR_INVALID;
-	req->dma = DMA_ADDR_INVALID;
 	INIT_LIST_HEAD(&req->queue);
 	if (!ep->dev->dma_addr)
 		return &req->req;
@@ -1880,39 +1844,9 @@ static int pch_udc_pcd_queue(struct usb_ep *usbep, struct usb_request *usbreq,
 		return -ESHUTDOWN;
 	spin_lock_irqsave(&dev->lock, iflags);
 	/* map the buffer for dma */
-	if (usbreq->length &&
-	    ((usbreq->dma == DMA_ADDR_INVALID) || !usbreq->dma)) {
-		if (!((unsigned long)(usbreq->buf) & 0x03)) {
-			if (ep->in)
-				usbreq->dma = dma_map_single(&dev->pdev->dev,
-							     usbreq->buf,
-							     usbreq->length,
-							     DMA_TO_DEVICE);
-			else
-				usbreq->dma = dma_map_single(&dev->pdev->dev,
-							     usbreq->buf,
-							     usbreq->length,
-							     DMA_FROM_DEVICE);
-		} else {
-			req->buf = kzalloc(usbreq->length, GFP_ATOMIC);
-			if (!req->buf) {
-				retval = -ENOMEM;
-				goto probe_end;
-			}
-			if (ep->in) {
-				memcpy(req->buf, usbreq->buf, usbreq->length);
-				req->dma = dma_map_single(&dev->pdev->dev,
-							  req->buf,
-							  usbreq->length,
-							  DMA_TO_DEVICE);
-			} else
-				req->dma = dma_map_single(&dev->pdev->dev,
-							  req->buf,
-							  usbreq->length,
-							  DMA_FROM_DEVICE);
-		}
-		req->dma_mapped = 1;
-	}
+	retval = usb_gadget_map_request(&dev->gadget, usbreq, ep->in);
+	if (retval)
+		goto probe_end;
 	if (usbreq->length > 0) {
 		retval = prepare_dma(ep, req, GFP_ATOMIC);
 		if (retval)
-- 
2.30.2

