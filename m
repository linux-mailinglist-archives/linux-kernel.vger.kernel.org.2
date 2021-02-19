Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAADF31FC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBSPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:43:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhBSPmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:42:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613749239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYiBLOOS0jKaGXZR/xdp5WHTi+5sOW1v2m88NDrZNbI=;
        b=mqlyaLZe/YgvYSsQIvPpN9XoaMOuiHW3Pbur9d3Wz3NOMHY4Oy4s66u3aQWq9fxarixX/O
        Ey3afn8U9k0KK6JKqUCXGc1zWME5EppFL1W/JOkfTp3ilVzkPrWMZUrxql+Y+EqqtO2aWl
        dpSxPChifLttkm90i7WQkWP8NL1KFr4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FC36B114;
        Fri, 19 Feb 2021 15:40:39 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v3 7/8] xen/evtchn: use smp barriers for user event ring
Date:   Fri, 19 Feb 2021 16:40:29 +0100
Message-Id: <20210219154030.10892-8-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210219154030.10892-1-jgross@suse.com>
References: <20210219154030.10892-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring buffer for user events is local to the given kernel instance,
so smp barriers are fine for ensuring consistency.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
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

