Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC053AF8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhFUXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFUXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:10:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:08:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624316910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=9dLiRFDzGlMpgqL3xRo1LlizM9S7OJKg5apNZ5DmTh0=;
        b=ctr9WC769CfK/Pb+lMJ2Naqg/Ipk8FQypt6S9/Go9tKnPnY32SrRoJ1LTQMvhb6/LJrkn+
        7MpHB0beVk+db7Sd62FCEsHP0K4UYVkSIU1Rr23fSFcklnDW4L5ur6Zbgdnv2TM4YCy/Yr
        qXmVckHERTCJ6AxV6wtrkxf3qCTIargSQOxDshT3IzYref9QaejW7b9Lz9AE6zGuuJ5SDd
        4hlH6DfiSYdk2p0gRvClHW2osgNS1so+UZuwRJM7AQG3Pz+EZjKEXsIkzJaS5fuGqEMxR9
        OMqZuhzfBodeX6uyKPOXjoMLldkyuDYJdpDLWq4K+Jr5yswDBSe9Wiqgdc0KFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624316910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=9dLiRFDzGlMpgqL3xRo1LlizM9S7OJKg5apNZ5DmTh0=;
        b=8VakBpMFoUJ09JMvjzPsLcY96zvqXPSJ8ZO/z9K+GVk/wpjZWijL/AUTnG4mxplXe18QhW
        lPYnSpviy3EXFUDg==
To:     syzbot <syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        elver@google.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
        pcc@google.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] signal: Prevent sigqueue caching after task got released
In-Reply-To: <000000000000148b4b05c419cbbb@google.com>
Date:   Tue, 22 Jun 2021 01:08:30 +0200
Message-ID: <878s32g6j5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a memory leak related to sigqueue caching. This happens
when a thread group leader with child tasks is reaped.

The group leader's sigqueue_cache is correctly freed. The group leader then
reaps the child tasks and if any of them has a signal pending it caches
that signal. That's obviously bogus because nothing will free the cached
signal of the reaped group leader anymore.

Prevent this by setting tsk::sigqueue_cache to an error pointer value in
exit_task_sigqueue_cache().

Add comments to all relevant places.

Fixes: 4bad58ebc8bc ("signal: Allow tasks to cache one sigqueue struct")
Reported-by: syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -435,6 +435,12 @@ static struct sigqueue *
 		 * Preallocation does not hold sighand::siglock so it can't
 		 * use the cache. The lockless caching requires that only
 		 * one consumer and only one producer run at a time.
+		 *
+		 * For the regular allocation case it is sufficient to
+		 * check @q for NULL because this code can only be called
+		 * if the target task @t has not been reaped yet; which
+		 * means this code can never observe the error pointer which is
+		 * written to @t->sigqueue_cache in exit_task_sigqueue_cache().
 		 */
 		q = READ_ONCE(t->sigqueue_cache);
 		if (!q || sigqueue_flags)
@@ -463,13 +469,18 @@ void exit_task_sigqueue_cache(struct tas
 	struct sigqueue *q = tsk->sigqueue_cache;
 
 	if (q) {
-		tsk->sigqueue_cache = NULL;
 		/*
 		 * Hand it back to the cache as the task might
 		 * be self reaping which would leak the object.
 		 */
 		 kmem_cache_free(sigqueue_cachep, q);
 	}
+
+	/*
+	 * Set an error pointer to ensure that @tsk will not cache a
+	 * sigqueue when it is reaping it's child tasks
+	 */
+	tsk->sigqueue_cache = ERR_PTR(-1);
 }
 
 static void sigqueue_cache_or_free(struct sigqueue *q)
@@ -481,6 +492,10 @@ static void sigqueue_cache_or_free(struc
 	 * is intentional when run without holding current->sighand->siglock,
 	 * which is fine as current obviously cannot run __sigqueue_free()
 	 * concurrently.
+	 *
+	 * The NULL check is safe even if current has been reaped already,
+	 * in which case exit_task_sigqueue_cache() wrote an error pointer
+	 * into current->sigqueue_cache.
 	 */
 	if (!READ_ONCE(current->sigqueue_cache))
 		WRITE_ONCE(current->sigqueue_cache, q);
