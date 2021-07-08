Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F453BF706
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGHIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhGHIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 01:43:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p17so2048973plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4X56iU4N0E+ayaaRhTpJj7zvU3AsIErwbtf4WUrMOX4=;
        b=abKm7nXfVZFt9n9AK0hzyALrAYUSVBDSHoibzI+wMgOOFUCtcwKZcDklDg0oypMdnZ
         aumSkyGlQn7nmgtGY2eMcTzkpxAwwtsb9rNgA1LSyXer9qAuFGcrMt4dMQs0kB8z0Pm0
         rJQstvWvVLP5tv8f83fPK3I5FXpFxgUw4Wijk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4X56iU4N0E+ayaaRhTpJj7zvU3AsIErwbtf4WUrMOX4=;
        b=NpejzVDrp5JATRj9xOOlOJM8JAOcGaipLahQrqB+k/+p+qIL/DWCK6m76oevCVWfSc
         3Ll6IZoDMzQf1v97ihODhObZMYBw1ppWdIQF2HYv9fa257LeVk1lEmPFjzdQP/miC6oJ
         /3+TxEDNbtiuUrOtJu/44y3Dv7UnMlQbKYkTqbMa2lmbG4WcwR/YYotr4KFk7ODwpPa4
         JsRlNOtU7550HXN1CPuq0wg3OO8UerMEmohFDZGM9AOaoVB0dr06l1IDoDiTGfibywCZ
         VMI+UoPM0554A8cDlgwEBg9PqBvAmfrvuu4krMOVyVDI3hEC811NHQ26bOcRsVFgmcWo
         0vuA==
X-Gm-Message-State: AOAM531om3EATIO0lIpqoWhT7rXUTzTH8kY3dgxVZwqScRpPkLD/YdC1
        IPyg9uEDzR/vPgssq/S8RZHwtA==
X-Google-Smtp-Source: ABdhPJwiIDoPmZy8pzUM6Kg1dXNKRIBXDHjKKlnSzgiOzOnWNNjpvkbYx7J5i713ZeOLIDSkeCrLeg==
X-Received: by 2002:a17:90a:6903:: with SMTP id r3mr15518869pjj.105.1625733785397;
        Thu, 08 Jul 2021 01:43:05 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:45e5:3e18:ee2f:e9d7])
        by smtp.gmail.com with ESMTPSA id n3sm1901559pfn.216.2021.07.08.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 01:43:04 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: fix unmatched num_trbs_free
Date:   Thu,  8 Jul 2021 16:43:01 +0800
Message-Id: <20210708164256.1.Ib344a977b52486ec81b60f9820338f1b43655f8d@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unlinked urbs are queued to the cancelled td list, many tds
might be located after hw dequeue pointer and just marked as no-op
but not reclaimed to num_trbs_free. This bias can leads to unnecessary
ring expansions and leaks in atomic pool.

To prevent this bias, this patch counts free TRBs every time xhci moves
dequeue pointer. This patch utilizes existing
update_ring_for_set_deq_completion() function, renamed it to move_deq().

When it walks through to the new dequeue pointer, it also counts
free TRBs manually. This patch adds a fast path for the most cases
where the new dequeue pointer is still in the current segment.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-ring.c | 106 +++++++++++++++++------------------
 1 file changed, 52 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 3c12a6fc406b..6414ffe33581 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -152,6 +152,54 @@ static void next_trb(struct xhci_hcd *xhci,
 	}
 }
 
+/* Forward dequeue pointer to the specific position,
+ * walk through the ring and reclaim free trb slots to num_trbs_free
+ */
+static int move_deq(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
+		    struct xhci_segment *new_seg, union xhci_trb *new_deq)
+{
+	unsigned int steps;
+	union xhci_trb *deq;
+	struct xhci_segment *seg = ep_ring->deq_seg;
+
+	/* direct paths */
+	if (ep_ring->dequeue == new_deq) {
+		return 0;
+	} else if ((ep_ring->deq_seg == new_seg) &&
+	    (ep_ring->dequeue <= new_deq)) {
+		steps = new_deq - ep_ring->dequeue;
+		deq = new_deq;
+		goto found;
+	}
+
+	/* fast walk to the next segment */
+	seg = seg->next;
+	steps = (TRBS_PER_SEGMENT - 1) -
+		(ep_ring->dequeue - ep_ring->deq_seg->trbs);
+	deq = &seg->trbs[0];
+
+	while (deq != new_deq) {
+		if (trb_is_link(deq)) {
+			seg = seg->next;
+			deq = seg->trbs;
+		} else {
+			steps++;
+			deq++;
+		}
+		if (deq == ep_ring->dequeue) {
+			xhci_warn(xhci, "Unable to find new dequeue pointer\n");
+			return -ENOENT;
+		}
+	}
+
+found:
+	ep_ring->deq_seg = seg;
+	ep_ring->dequeue = deq;
+	ep_ring->num_trbs_free += steps;
+
+	return 0;
+}
+
 /*
  * See Cycle bit rules. SW is the consumer for the event ring only.
  */
@@ -1245,52 +1293,6 @@ void xhci_stop_endpoint_command_watchdog(struct timer_list *t)
 			"xHCI host controller is dead.");
 }
 
-static void update_ring_for_set_deq_completion(struct xhci_hcd *xhci,
-		struct xhci_virt_device *dev,
-		struct xhci_ring *ep_ring,
-		unsigned int ep_index)
-{
-	union xhci_trb *dequeue_temp;
-	int num_trbs_free_temp;
-	bool revert = false;
-
-	num_trbs_free_temp = ep_ring->num_trbs_free;
-	dequeue_temp = ep_ring->dequeue;
-
-	/* If we get two back-to-back stalls, and the first stalled transfer
-	 * ends just before a link TRB, the dequeue pointer will be left on
-	 * the link TRB by the code in the while loop.  So we have to update
-	 * the dequeue pointer one segment further, or we'll jump off
-	 * the segment into la-la-land.
-	 */
-	if (trb_is_link(ep_ring->dequeue)) {
-		ep_ring->deq_seg = ep_ring->deq_seg->next;
-		ep_ring->dequeue = ep_ring->deq_seg->trbs;
-	}
-
-	while (ep_ring->dequeue != dev->eps[ep_index].queued_deq_ptr) {
-		/* We have more usable TRBs */
-		ep_ring->num_trbs_free++;
-		ep_ring->dequeue++;
-		if (trb_is_link(ep_ring->dequeue)) {
-			if (ep_ring->dequeue ==
-					dev->eps[ep_index].queued_deq_ptr)
-				break;
-			ep_ring->deq_seg = ep_ring->deq_seg->next;
-			ep_ring->dequeue = ep_ring->deq_seg->trbs;
-		}
-		if (ep_ring->dequeue == dequeue_temp) {
-			revert = true;
-			break;
-		}
-	}
-
-	if (revert) {
-		xhci_dbg(xhci, "Unable to find new dequeue pointer\n");
-		ep_ring->num_trbs_free = num_trbs_free_temp;
-	}
-}
-
 /*
  * When we get a completion for a Set Transfer Ring Dequeue Pointer command,
  * we need to clear the set deq pending flag in the endpoint ring state, so that
@@ -1377,8 +1379,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			/* Update the ring's dequeue segment and dequeue pointer
 			 * to reflect the new position.
 			 */
-			update_ring_for_set_deq_completion(xhci, ep->vdev,
-				ep_ring, ep_index);
+			move_deq(xhci, ep_ring, ep->queued_deq_seg,
+				 ep->queued_deq_ptr);
 		} else {
 			xhci_warn(xhci, "Mismatch between completed Set TR Deq Ptr command & xHCI internal state.\n");
 			xhci_warn(xhci, "ep deq seg = %p, deq ptr = %p\n",
@@ -2212,9 +2214,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	}
 
 	/* Update ring dequeue pointer */
-	ep_ring->dequeue = td->last_trb;
-	ep_ring->deq_seg = td->last_trb_seg;
-	ep_ring->num_trbs_free += td->num_trbs - 1;
+	move_deq(xhci, ep_ring, td->last_trb_seg, td->last_trb);
 	inc_deq(xhci, ep_ring);
 
 	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
@@ -2434,9 +2434,7 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	frame->actual_length = 0;
 
 	/* Update ring dequeue pointer */
-	ep->ring->dequeue = td->last_trb;
-	ep->ring->deq_seg = td->last_trb_seg;
-	ep->ring->num_trbs_free += td->num_trbs - 1;
+	move_deq(xhci, ep->ring, td->last_trb_seg, td->last_trb);
 	inc_deq(xhci, ep->ring);
 
 	return xhci_td_cleanup(xhci, td, ep->ring, status);
-- 
2.32.0.93.g670b81a890-goog

