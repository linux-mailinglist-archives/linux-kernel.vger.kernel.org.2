Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD16311CC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBFKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:52:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:52944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhBFKv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:51:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612608588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dwSISahcOfN3NMnONYxvA+Xvjxj9asEhl9tMU+G0iU=;
        b=Mo4F52hs9OAJxH6oqDjd2ntDp9R6F7ZJdn+zPE4y5bLUhZ9kXSzHtT1/3GVi2DosWy+1Tx
        pBjsTb/LSNITlohk/amoDfpckf1C/ScW8KmaztBneh8tyVPIahPVYqgwlYXL4PiRsYG7Am
        RzQCI08jXlLS/z74o6/g8tAKTJ04Nz8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB079AEB9;
        Sat,  6 Feb 2021 10:49:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 6/7] xen/evtch: use smp barriers for user event ring
Date:   Sat,  6 Feb 2021 11:49:31 +0100
Message-Id: <20210206104932.29064-7-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206104932.29064-1-jgross@suse.com>
References: <20210206104932.29064-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring buffer for user events is used in the local system only, so
smp barriers are fine for ensuring consistency.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/evtchn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index a7a85719a8c8..421382c73d88 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -173,7 +173,7 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 
 	if ((u->ring_prod - u->ring_cons) < u->ring_size) {
 		*evtchn_ring_entry(u, u->ring_prod) = evtchn->port;
-		wmb(); /* Ensure ring contents visible */
+		smp_wmb(); /* Ensure ring contents visible */
 		if (u->ring_cons == u->ring_prod++) {
 			wake_up_interruptible(&u->evtchn_wait);
 			kill_fasync(&u->evtchn_async_queue,
@@ -245,7 +245,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 	}
 
 	rc = -EFAULT;
-	rmb(); /* Ensure that we see the port before we copy it. */
+	smp_rmb(); /* Ensure that we see the port before we copy it. */
 	if (copy_to_user(buf, evtchn_ring_entry(u, c), bytes1) ||
 	    ((bytes2 != 0) &&
 	     copy_to_user(&buf[bytes1], &u->ring[0], bytes2)))
-- 
2.26.2

