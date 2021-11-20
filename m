Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B97457C12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKTHWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhKTHWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:22:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F7C603E7;
        Sat, 20 Nov 2021 07:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637392743;
        bh=ckK4URk1wMxzlI+BdghEifkUq6jXlN+CBzv3AA8PRt8=;
        h=Date:From:To:Cc:Subject:From;
        b=YP8yc1CnpjoRZ3K4zMqHTBIxYVXyeV9AmkEzoNPkTAnUnjspOl+O0ThkBKd1GBgdV
         G2mxSO1EWSUrr8eVI6I6C2qZfOpYORJbB/ZsvEnsdSKUrpWCUGvGEs5EEGMiWjCtT4
         wSQQlJU+KuH/EO+sKoFlXI//t7A/AEZJvg7purRx4vOuU59+iWVT+bJIak2ccsjpVo
         OoGKXXyrigoy9+yhlg0vBUHe3xzHNZZjS1I4JCAIB+ke4MmpQbgTTWdzeWh5Q3Dkln
         pHz5mlGHL7jI0bvElULBJZosnFgth5trTriqndobyL+zd3zW5kvfdVmPfQveBklCnL
         mXBGdvYBZ4bwQ==
Date:   Sat, 20 Nov 2021 15:18:55 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     pawell@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lznuaa@gmail.com
Subject: Re: [PATCH 1/1] usb: cdns3: gadget: fix new urb never complete if ep
 cancel requests before.
Message-ID: <20211120071855.GB3874@Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete '.' please

Reply-To: 
In-Reply-To: <20211117204447.16869-1-Frank.Li@nxp.com>

On 21-11-17 14:44:47, Frank Li wrote:
> This issue was found at android12 MTP.
> 1. MTP submit many out urb request.
> 2. Cancel left requests (>20) when enough data get from host
> 3. Send ACK by IN endpoint.
> 4. MTP submit new out urb request.
> 5. 4's urb never complete.

New out request new complete?

> 
> TRACE LOG:
> 
> MtpServer-2157    [000] d..3  1287.150391: cdns3_ep_dequeue: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -115, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:1 SID: 0
> MtpServer-2157    [000] d..3  1287.150410: cdns3_gadget_giveback: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -104, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:0 SID: 0
> MtpServer-2157    [000] d..3  1287.150433: cdns3_ep_dequeue: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -115, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:1 SID: 0
> MtpServer-2157    [000] d..3  1287.150446: cdns3_gadget_giveback: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -104, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:0 SID: 0
> 	....
> MtpServer-2157    [000] d..1  1293.630410: cdns3_alloc_request: ep1out: req: 00000000afbccb7d, req buff 0000000000000000, length: 0/0 zsi, status: 0, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> MtpServer-2157    [000] d..2  1293.630421: cdns3_ep_queue: ep1out: req: 00000000afbccb7d, req buff 00000000871caf90, length: 0/512 zsi, status: -115, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> MtpServer-2157    [000] d..2  1293.630445: cdns3_wa1: WA1: ep1out set guard
> MtpServer-2157    [000] d..2  1293.630450: cdns3_wa1: WA1: ep1out restore cycle bit
> MtpServer-2157    [000] d..2  1293.630453: cdns3_prepare_trb: ep1out: trb 000000007317b3ee, dma buf: 0xffd5bc00, size: 512, burst: 128 ctrl: 0x00000424 (C=0, T=0, ISP, IOC, Normal) SID:0 LAST_SID:0
> MtpServer-2157    [000] d..2  1293.630460: cdns3_doorbell_epx: ep1out, ep_trbaddr ffd50414
> 	....
> irq/241-5b13000-2154    [000] d..1  1293.680849: cdns3_epx_irq: IRQ for ep1out: 01000408 ISP , ep_traddr: ffd508ac ep_last_sid: 00000000 use_streams: 0
> irq/241-5b13000-2154    [000] d..1  1293.680858: cdns3_complete_trb: ep1out: trb 0000000021a11b54, dma buf: 0xffd50420, size: 16384, burst: 128 ctrl: 0x00001810 (C=0, T=0, CHAIN, LINK) SID:0 LAST_SID:0
> irq/241-5b13000-2154    [000] d..1  1293.680865: cdns3_request_handled: Req: 00000000afbccb7d not handled, DMA pos: 185, ep deq: 88, ep enq: 185, start trb: 184, end trb: 184
> 
> Actually DMA pos already bigger than prevous submit request afbccb7d's TRB (184-184). The reason of (not handled) is that deq position is wrong.

%s/prevous/previous. Ok, so the reason is dep position is wrong, and
%cdns3_trb_handled returns false, so the completion is not called?

> 
> The TRB link is below when irq happen.
> 
> 	DEQ LINK LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> Original code check LINK TRB, but DEQ just move one step.
> 
> 	LINK DEQ LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> This patch skip all LINK TRB and sync DEQ to trb's start.
> 
> 	LINK LINK LINK LINK LINK .... DEQ = TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Jun Li <jun.li@nxp.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 1f3b4a1422126..01d0e09a87ad7 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -337,17 +337,21 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
>  	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
>  }
>  
> -static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
> +static void cdns3_sync_deq_to_trb(struct cdns3_request *priv_req)
>  {
>  	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
> -	int current_trb = priv_req->start_trb;
> +	struct cdns3_trb *trb =  priv_ep->trb_pool + priv_ep->dequeue;
>  
> -	while (current_trb != priv_req->end_trb) {
> -		cdns3_ep_inc_deq(priv_ep);
> -		current_trb = priv_ep->dequeue;
> -	}
> +	if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> +		while (priv_ep->dequeue != priv_req->start_trb) {
> +			dev_dbg(priv_ep->cdns3_dev->dev, "Remove TRB_LINK");
> +			trb = priv_ep->trb_pool + priv_ep->dequeue;
> +			WARN_ON_ONCE(TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) != TRB_LINK);
> +			trace_cdns3_complete_trb(priv_ep, trb);
>  
> -	cdns3_ep_inc_deq(priv_ep);
> +			cdns3_ep_inc_deq(priv_ep);
> +		}
> +	}
>  }
>  
>  /**
> @@ -1518,10 +1522,7 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
>  		trb = priv_ep->trb_pool + priv_ep->dequeue;
>  
>  		/* Request was dequeued and TRB was changed to TRB_LINK. */
> -		if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> -			trace_cdns3_complete_trb(priv_ep, trb);
> -			cdns3_move_deq_to_next_trb(priv_req);
> -		}
> +		cdns3_sync_deq_to_trb(priv_req);

So, the issue is it doesn't skip all link trb's handler? How about below
change?


diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a142212..8463e5429cb0 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -337,19 +337,6 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
 	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
 }
 
-static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
-{
-	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
-	int current_trb = priv_req->start_trb;
-
-	while (current_trb != priv_req->end_trb) {
-		cdns3_ep_inc_deq(priv_ep);
-		current_trb = priv_ep->dequeue;
-	}
-
-	cdns3_ep_inc_deq(priv_ep);
-}
-
 /**
  * cdns3_allow_enable_l1 - enable/disable permits to transition to L1.
  * @priv_dev: Extended gadget object
@@ -1517,10 +1504,11 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
 		trb = priv_ep->trb_pool + priv_ep->dequeue;
 
-		/* Request was dequeued and TRB was changed to TRB_LINK. */
-		if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+		/* The TRB was changed as link TRB, and the request was handled at .ep_deuque */
+		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
 			trace_cdns3_complete_trb(priv_ep, trb);
-			cdns3_move_deq_to_next_trb(priv_req);
+			cdns3_ep_inc_deq(priv_ep);
+			trb = priv_ep->trb_pool + priv_ep->dequeue;
 		}
 
 		if (!request->stream_id) {

-- 

Thanks,
Peter Chen

