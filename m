Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38C5343F52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCVLLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D7D16198C;
        Mon, 22 Mar 2021 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616411491;
        bh=PIATEq0u/wSjiMEG6090auCWmWeUTwMBz/84iBJJ1gg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ts8IRIei1uCjGHkY2kksQPEPY3wyhG535du+Zod2UJmWQk0VSliHxkQLTiGWBiHR1
         jnwovHv0AnpJLOJ8UqEjKi3T7nb+WZl6far7JqjDV0paoQK3g+sn+3SNO5yKTTWDvl
         uQBjMqKpxRIb2ALwc8XqtZiBhQyGM3E6mi05JTNj4+nwnvLYK0bvoDEdAZb309fShy
         NcW/9tNQbktldNjHIf+bn6jHkSq974UoUfKYlN7hRSEuM1sl9r2p7OHKqtJiCTN3Xp
         PEWa9pO1AzOMPNxM4b6fy+TV8vXzpbsNlUQh6kuCaaF2RZlPpfGypYr167xBzW4AFM
         hNjsKJlG9/6nA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOITM-0008Ll-G6; Mon, 22 Mar 2021 12:11:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] USB: xhci: drop workaround for forced irq threading
Date:   Mon, 22 Mar 2021 12:11:40 +0100
Message-Id: <20210322111140.32056-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force-threaded interrupt handlers used to run with interrupts enabled,
something which could lead to deadlocks in case a threaded handler
shared a lock with code running in hard interrupt context (e.g. timer
callbacks) and did not explicitly disable interrupts.

Since commit 81e2073c175b ("genirq: Disable interrupts for force
threaded handlers") interrupt handlers always run with interrupts
disabled on non-RT so that drivers no longer need to do handle forced
threading ("threadirqs").

Drop the now obsolete workaround added by commit 63aea0dbab90 ("USB:
xhci: fix lock-inversion problem").

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ce38076901e2..20f5ded29b3b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3015,12 +3015,11 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	union xhci_trb *event_ring_deq;
 	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
 	u64 temp_64;
 	u32 status;
 	int event_loop = 0;
 
-	spin_lock_irqsave(&xhci->lock, flags);
+	spin_lock(&xhci->lock);
 	/* Check if the xHC generated the interrupt, or the irq is shared */
 	status = readl(&xhci->op_regs->status);
 	if (status == ~(u32)0) {
@@ -3083,7 +3082,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	ret = IRQ_HANDLED;
 
 out:
-	spin_unlock_irqrestore(&xhci->lock, flags);
+	spin_unlock(&xhci->lock);
 
 	return ret;
 }
-- 
2.26.3

