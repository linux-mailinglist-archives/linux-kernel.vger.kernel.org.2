Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B343F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhCVLMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0959261984;
        Mon, 22 Mar 2021 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616411566;
        bh=t1MYx5aUZFlCch7gUWh/6mVYccvkxqMykhxOqpoK5zI=;
        h=From:To:Cc:Subject:Date:From;
        b=tds2Btir1wi9mjV/WNuTXrD4sePcVbK2iXaTo+5tg7BeVjTDpy9XrUxbx+azS30I3
         XaCfDeYEqN6eEef6BoNAF3iKUodjkRWGoBbzt2x8odDW3e8yJyIy4w2g1vhIAG7y4h
         j/PJrNthAAaVASEoaLmWnanfAfGPDn87k13nTbAJNC1NKmAEFq1fXjobStsB4Or8mr
         Xf0KUhwu7AkgjkufjuR3z8tuqF8H3meoU75oYeR5fHZUTrSXM98dLI4/ZPAN4itxUX
         mV634SPqFQSKysBnClM5nZ+drFaeXZtjZDy8t+9FWt4+O8iLsod/EUafOrx6swDje4
         z00Hh4eSRn9NQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOIUZ-0008N9-74; Mon, 22 Mar 2021 12:13:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] USB: ehci: drop workaround for forced irq threading
Date:   Mon, 22 Mar 2021 12:12:49 +0100
Message-Id: <20210322111249.32141-1-johan@kernel.org>
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

Drop the now obsolete workaround added by commit a1227f3c1030 ("usb:
ehci: fix deadlock when threadirqs option is used").

Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/host/ehci-hcd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1926b328b6aa..403bd3d6991f 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -705,15 +705,8 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	u32			status, masked_status, pcd_status = 0, cmd;
 	int			bh;
-	unsigned long		flags;
 
-	/*
-	 * For threadirqs option we use spin_lock_irqsave() variant to prevent
-	 * deadlock with ehci hrtimer callback, because hrtimer callbacks run
-	 * in interrupt context even when threadirqs is specified. We can go
-	 * back to spin_lock() variant when hrtimer callbacks become threaded.
-	 */
-	spin_lock_irqsave(&ehci->lock, flags);
+	spin_lock(&ehci->lock);
 
 	status = ehci_readl(ehci, &ehci->regs->status);
 
@@ -731,7 +724,7 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 
 	/* Shared IRQ? */
 	if (!masked_status || unlikely(ehci->rh_state == EHCI_RH_HALTED)) {
-		spin_unlock_irqrestore(&ehci->lock, flags);
+		spin_unlock(&ehci->lock);
 		return IRQ_NONE;
 	}
 
@@ -842,7 +835,7 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 
 	if (bh)
 		ehci_work (ehci);
-	spin_unlock_irqrestore(&ehci->lock, flags);
+	spin_unlock(&ehci->lock);
 	if (pcd_status)
 		usb_hcd_poll_rh_status(hcd);
 	return IRQ_HANDLED;
-- 
2.26.3

