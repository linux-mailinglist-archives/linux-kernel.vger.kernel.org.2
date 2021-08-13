Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1123EB637
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbhHMNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:46:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:10688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240714AbhHMNqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:46:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215289058"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="215289058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 06:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="591138855"
Received: from mattu-haswell.fi.intel.com ([10.237.72.170])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2021 06:45:07 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     wat@codeaurora.org, ikjn@chromium.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathias.nyman@linux.intel.com
Subject: [RFT PATCH] xhci: fix failure to give back some cached cancelled URBs.
Date:   Fri, 13 Aug 2021 16:47:29 +0300
Message-Id: <20210813134729.2402607-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <39525c12-e8f3-8587-5714-5a22ca1e8e4f@linux.intel.com>
References: <39525c12-e8f3-8587-5714-5a22ca1e8e4f@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only TDs with status TD_CLEARING_CACHE will be given back after
cache is cleared with a set TR deq command.

xhci_invalidate_cached_td() failed to set the TD_CLEARING_CACHE status
for some cancelled TDs as it assumed an endpoint only needs to clear the
TD it stopped on from cache. There are some cases this isn't true.

For example with streams as an endpoint may have several
stream rings, each stopping on different TDs.

* FIXME *, explain that streams case isn't fully solved by this, but it's
 x100 better than before as we give back the URBs and thread won't hang.
 Some of the streams TRB cache still isn't cleared, and may point to data
 in URBs we alrady gave back. xHC controller may touch this.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 40 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0faa67a689d..9017986241f5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -942,17 +942,21 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 					 td->urb->stream_id);
 		hw_deq &= ~0xf;
 
-		if (td->cancel_status == TD_HALTED) {
-			cached_td = td;
-		} else if (trb_in_td(xhci, td->start_seg, td->first_trb,
-			      td->last_trb, hw_deq, false)) {
+		if (td->cancel_status == TD_HALTED ||
+		    trb_in_td(xhci, td->start_seg, td->first_trb, td->last_trb, hw_deq, false)) {
 			switch (td->cancel_status) {
 			case TD_CLEARED: /* TD is already no-op */
 			case TD_CLEARING_CACHE: /* set TR deq command already queued */
 				break;
 			case TD_DIRTY: /* TD is cached, clear it */
 			case TD_HALTED:
-				/* FIXME  stream case, several stopped rings */
+				td->cancel_status = TD_CLEARING_CACHE;
+				if (cached_td)
+					/* FIXME  stream case, several stopped rings */
+					xhci_dbg(xhci,
+						 "Move dq past stream %u URB %p instead of stream %u URB %p\n",
+						 td->urb->stream_id, td->urb,
+						 cached_td->urb->stream_id, cached_td->urb);
 				cached_td = td;
 				break;
 			}
@@ -961,18 +965,24 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 			td->cancel_status = TD_CLEARED;
 		}
 	}
-	if (cached_td) {
-		cached_td->cancel_status = TD_CLEARING_CACHE;
 
-		err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
-						cached_td->urb->stream_id,
-						cached_td);
-		/* Failed to move past cached td, try just setting it noop */
-		if (err) {
-			td_to_noop(xhci, ring, cached_td, false);
-			cached_td->cancel_status = TD_CLEARED;
+	/* If there's no need to move the dequeue pointer then we're done */
+	if (!cached_td)
+		return 0;
+
+	err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
+					cached_td->urb->stream_id,
+					cached_td);
+	if (err) {
+		/* Failed to move past cached td, just set cached TDs to no-op */
+		list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
+			if (td->cancel_status != TD_CLEARING_CACHE)
+				continue;
+			xhci_dbg(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
+				 td->urb);
+			td_to_noop(xhci, ring, td, false);
+			td->cancel_status = TD_CLEARED;
 		}
-		cached_td = NULL;
 	}
 	return 0;
 }
-- 
2.25.1

