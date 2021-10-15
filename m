Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00842FD48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhJOVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhJOVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:16:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EA1C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:14:13 -0700 (PDT)
Date:   Fri, 15 Oct 2021 23:14:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634332451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ss/7C0IRTtI0ncyR2UwV+ykEZrfv7NqhHiYm6VTvJB4=;
        b=wUMJ2ZLI63iiSFmNFRTy5EjwAECuE0vYtSpAX1ZUjKqbTr20Rl38IRE86bRfz9Kv/z/fM+
        IXcWxJLD00wE2zl12IJ9F+//e/w62JzQvNu7iSRpTHAXCQKc+wt2eyiuFaEshR6ATPp45g
        qZEE0ca5JnUaVxolAHz9auUxrA2QrveSHiwLdqSLphDMqbbyUIaleh7orbGDQbQpkRQdwu
        +1NLa/8PZT0UmDooT+Jjf7hZd3XDhJmmR1/ym/VYJ1CL3XtMCW5QeYbbAqx2YK+6KNS7EL
        ulGIJPQ2iJ14ilTtsXy3wxnbIFCTLGGJC3+OoQzclXUqQcvOqfPG8Kwd3t5XsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634332451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ss/7C0IRTtI0ncyR2UwV+ykEZrfv7NqhHiYm6VTvJB4=;
        b=C2wGNv2K/QEfwKRmnh4iArsktyCzJ+5v2rVPyYNIJjv9VRaRKMPCN0J1r05mUtgd8kTF38
        0RtZ/mhC7cFbYNAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] mm/scatterlist: Replace the !preemptible warning in
 sg_miter_stop()
Message-ID: <20211015211409.cqopacv3pxdwn2ty@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

sg_miter_stop() checks for disabled preemption before unmapping a page
via kunmap_atomic(). The kernel doc mentions under context that
preemption must be disabled if SG_MITER_ATOMIC is set.

There is no active requirement for the caller to have preemption
disabled before invoking sg_mitter_stop(). The sg_mitter_*()
implementation itself has no such requirement.
In fact, preemption is disabled by kmap_atomic() as part of
sg_miter_next() and remains disabled as long as there is an active
SG_MITER_ATOMIC mapping. This is a consequence of kmap_atomic() and not
a requirement for sg_mitter_*() itself.
The user chooses SG_MITER_ATOMIC because it uses the API in a context
where blocking is not possible or blocking is possible but he chooses a
lower weight mapping which is not available on all CPUs and so it might
need less overhead to setup at a price that now preemption will be
disabled.

The kmap_atomic() implementation on PREEMPT_RT does not disable
preemption. It simply disables CPU migration to ensure that the task
remains on the same CPU while the caller remains preemptible. This in
turn triggers the warning in sg_miter_stop() because preemption is
allowed.

The PREEMPT_RT and !PREEMPT_RT implementation of kmap_atomic() disable
pagefaults as a requirement. It is sufficient to check for this instead
of disabled preemption.

Check for disabled pagefault handler in the SG_MITER_ATOMIC case. Remove
the "preemption disabled" part from the kernel doc as the sg_milter*()
implementation does not care.

[bigeasy: commit description. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/scatterlist.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -828,8 +828,7 @@ static bool sg_miter_get_next_page(struc
  *   stops @miter.
  *
  * Context:
- *   Don't care if @miter is stopped, or not proceeded yet.
- *   Otherwise, preemption disabled if the SG_MITER_ATOMIC is set.
+ *   Don't care.
  *
  * Returns:
  *   true if @miter contains the valid mapping.  false if end of sg
@@ -865,8 +864,7 @@ EXPORT_SYMBOL(sg_miter_skip);
  *   @miter->addr and @miter->length point to the current mapping.
  *
  * Context:
- *   Preemption disabled if SG_MITER_ATOMIC.  Preemption must stay disabled
- *   till @miter is stopped.  May sleep if !SG_MITER_ATOMIC.
+ *   May sleep if !SG_MITER_ATOMIC.
  *
  * Returns:
  *   true if @miter contains the next mapping.  false if end of sg
@@ -906,8 +904,7 @@ EXPORT_SYMBOL(sg_miter_next);
  *   need to be released during iteration.
  *
  * Context:
- *   Preemption disabled if the SG_MITER_ATOMIC is set.  Don't care
- *   otherwise.
+ *   Don't care otherwise.
  */
 void sg_miter_stop(struct sg_mapping_iter *miter)
 {
@@ -922,7 +919,7 @@ void sg_miter_stop(struct sg_mapping_ite
 			flush_dcache_page(miter->page);
 
 		if (miter->__flags & SG_MITER_ATOMIC) {
-			WARN_ON_ONCE(preemptible());
+			WARN_ON_ONCE(!pagefault_disabled());
 			kunmap_atomic(miter->addr);
 		} else
 			kunmap(miter->page);
