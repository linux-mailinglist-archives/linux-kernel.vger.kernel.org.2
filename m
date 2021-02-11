Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2231881B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBKK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:26:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:42452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhBKKVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:21:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613038661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYH24KPMu2VG4s1NBLZlXtQTIXh2Tv25DANk+uAGYuo=;
        b=u1DgoxnpEm4vOpyw48CO18ajkHrDW1uvBzT3RfgWYFijSi0+reRlAnvlKP1gg0r4P9Pi7i
        Vu5847ApQb2x84mlacvWnCjsZcJwu0yHNhZeZttlgZKVZRpMXgD4XgZOCcNZ5ySrNx83tW
        UvkSODeyNjTFab6FqCgs6SMINmH3iSc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98FF9AF50;
        Thu, 11 Feb 2021 10:17:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 8/8] xen/evtchn: use READ/WRITE_ONCE() for accessing ring indices
Date:   Thu, 11 Feb 2021 11:16:16 +0100
Message-Id: <20210211101616.13788-9-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211101616.13788-1-jgross@suse.com>
References: <20210211101616.13788-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For avoiding read- and write-tearing by the compiler use READ_ONCE()
and WRITE_ONCE() for accessing the ring indices in evtchn.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- modify all accesses (Julien Grall)
---
 drivers/xen/evtchn.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 421382c73d88..620008f89dbe 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -162,6 +162,7 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 {
 	struct user_evtchn *evtchn = data;
 	struct per_user_data *u = evtchn->user;
+	unsigned int prod, cons;
 
 	WARN(!evtchn->enabled,
 	     "Interrupt for port %u, but apparently not enabled; per-user %p\n",
@@ -171,10 +172,14 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 
 	spin_lock(&u->ring_prod_lock);
 
-	if ((u->ring_prod - u->ring_cons) < u->ring_size) {
-		*evtchn_ring_entry(u, u->ring_prod) = evtchn->port;
+	prod = READ_ONCE(u->ring_prod);
+	cons = READ_ONCE(u->ring_cons);
+
+	if ((prod - cons) < u->ring_size) {
+		*evtchn_ring_entry(u, prod) = evtchn->port;
 		smp_wmb(); /* Ensure ring contents visible */
-		if (u->ring_cons == u->ring_prod++) {
+		if (cons == prod++) {
+			WRITE_ONCE(u->ring_prod, prod);
 			wake_up_interruptible(&u->evtchn_wait);
 			kill_fasync(&u->evtchn_async_queue,
 				    SIGIO, POLL_IN);
@@ -210,8 +215,8 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 		if (u->ring_overflow)
 			goto unlock_out;
 
-		c = u->ring_cons;
-		p = u->ring_prod;
+		c = READ_ONCE(u->ring_cons);
+		p = READ_ONCE(u->ring_prod);
 		if (c != p)
 			break;
 
@@ -221,7 +226,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 			return -EAGAIN;
 
 		rc = wait_event_interruptible(u->evtchn_wait,
-					      u->ring_cons != u->ring_prod);
+			READ_ONCE(u->ring_cons) != READ_ONCE(u->ring_prod));
 		if (rc)
 			return rc;
 	}
@@ -251,7 +256,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 	     copy_to_user(&buf[bytes1], &u->ring[0], bytes2)))
 		goto unlock_out;
 
-	u->ring_cons += (bytes1 + bytes2) / sizeof(evtchn_port_t);
+	WRITE_ONCE(u->ring_cons, c + (bytes1 + bytes2) / sizeof(evtchn_port_t));
 	rc = bytes1 + bytes2;
 
  unlock_out:
@@ -552,7 +557,9 @@ static long evtchn_ioctl(struct file *file,
 		/* Initialise the ring to empty. Clear errors. */
 		mutex_lock(&u->ring_cons_mutex);
 		spin_lock_irq(&u->ring_prod_lock);
-		u->ring_cons = u->ring_prod = u->ring_overflow = 0;
+		WRITE_ONCE(u->ring_cons, 0);
+		WRITE_ONCE(u->ring_prod, 0);
+		u->ring_overflow = 0;
 		spin_unlock_irq(&u->ring_prod_lock);
 		mutex_unlock(&u->ring_cons_mutex);
 		rc = 0;
@@ -595,7 +602,7 @@ static __poll_t evtchn_poll(struct file *file, poll_table *wait)
 	struct per_user_data *u = file->private_data;
 
 	poll_wait(file, &u->evtchn_wait, wait);
-	if (u->ring_cons != u->ring_prod)
+	if (READ_ONCE(u->ring_cons) != READ_ONCE(u->ring_prod))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (u->ring_overflow)
 		mask = EPOLLERR;
-- 
2.26.2

