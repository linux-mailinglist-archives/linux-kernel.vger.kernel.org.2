Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51373FDE3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbhIAPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhIAPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:08:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:07:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b7so4455011iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRXHbmaEaGE+PnP0Hxwon25Pm+E/2vhd0SiI0QyMNKE=;
        b=CuTa59lnrAZ+gQXya5Qucc/TrW9f0Oo8wdJwbSC8EPGNudbXiBNPMkdZyUdBq5BRTa
         VkLsJHJv9Q/YZapGFDVv9kTB5uHAAGnKtkxinAzFtJmYqEMYGPahiB0gp7KeEb9FsIl7
         k/p6uk9sv0rkXb1l2kOR6aLhx2nsISqqlcc4FuA1uqfrteCigqVoCPmlBVGu8c36aPKE
         eLYTjDKw/Jvu0H9xO5Wv3llV6l6WBjM5DIfuqoAm0M5ZOVivpbgWj2BtR7+uGgaadv9U
         iB2g4klV7R/nDK4e2Nxsuc61t4TJFCMIHQ/Lr3t+IUjQr4Cy+gIHFxi+P9bCh9KdbT1e
         lUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRXHbmaEaGE+PnP0Hxwon25Pm+E/2vhd0SiI0QyMNKE=;
        b=hAs7e91MGxsp65/PAnl7717OfPMGnFPpBonW6bpGu7ubcaMSxX8Li7G8jC0tn9liey
         YU82vb8J9BjQxWiGvMrGFGx7Jedk29YFtaaIOiBDu8G616bCacvbU1tQ9hKtBvS7wcih
         1Mn2On9b9anBqHIbGQXXbOa8qR8l0wyFt76sL9N9VvFaFLpulysPLCM5DLNNYAn4XKAt
         gsUOdkK4vwOfwAGdoH/wMsu4D+24eUfxO0N05h6jQRTcgeJfDL1LrRA7ZjBD/uQ3dm60
         nhUBy1R/Fo8vHsnMM5BZOiKjF2lELun7UWuC0o51mpxSTNSKMZ6JUQRuQy6XUa+gugHu
         ud2g==
X-Gm-Message-State: AOAM532OJpTm9187jEnkb83LqXhy6+oPXptzgs86c1PLSAM7u2REM2Pc
        1fm/9jqigalY0Js7Vn3FVrrGRq1a/45h2g==
X-Google-Smtp-Source: ABdhPJzfbFnDB7lopFADO/Q6ZQzIU9BJjJ9iG8oWRLqP+vAROUg2XpoazkGY2wXglIFueg/uEPIGfQ==
X-Received: by 2002:a02:908a:: with SMTP id x10mr98548jaf.30.1630508866715;
        Wed, 01 Sep 2021 08:07:46 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q15sm135364ilm.60.2021.09.01.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:07:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 64C5527C0054;
        Wed,  1 Sep 2021 11:07:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 11:07:45 -0400
X-ME-Sender: <xms:O5cvYR4KUCOlIImpRokot4HZ7uJgCEMA01TiEUe9WA5RGbrnkY6SqQ>
    <xme:O5cvYe5eyZGD94xFCRn_GOgdCwBgxG-v5iDvPhwfYrmi71XMJAGTonnjZaafnBsNv
    LsaDQ3iAGA1RFvqvA>
X-ME-Received: <xmr:O5cvYYeXz9zjSP3UXCU5koqcViHkzG60Tlof4UuFjuH2ZRq2aTxB5BYkrL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:O5cvYaI63o1ONAzkjg1eUpqAmcsaJqY3AlyWeCgPXLqb7ztlX02Vog>
    <xmx:O5cvYVJH6NUog5h2YQoRTTnZIh22oAw2RvJDYgBSUb1kvO3nrgtFzQ>
    <xmx:O5cvYTymeCD03C3XxjqaRPneMxgtk6J5DdjtuLwC87rqs-CWhJrYkA>
    <xmx:QJcvYfy_tEFyLhRcZMAmuMI0YykjxVXbfqT2mmFD82eKsggpbJb2tpcrCYs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 11:07:39 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] locking: rwbase: Take care of ordering guarantee for fastpath reader
Date:   Wed,  1 Sep 2021 23:06:27 +0800
Message-Id: <20210901150627.620830-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readers of rwbase can lock and unlock without taking any inner lock, if
that happens, we need the ordering provided by atomic operations to
satisfy the ordering semantics of lock/unlock. Without that, considering
the follow case:

	{ X = 0 initially }

	CPU 0			CPU 1
	=====			=====
				rt_write_lock();
				X = 1
				rt_write_unlock():
				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
				  // ->readers is READER_BIAS.
	rt_read_lock():
	  if ((r = atomic_read(->readers)) < 0) // True
	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
	  <acquire the read lock via fast path>

	r1 = X;	// r1 may be 0, because nothing prevent the reordering
	        // of "X=1" and atomic_add() on CPU 1.

Therefore audit every usage of atomic operations that may happen in a
fast path, and add necessary barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Hi Thomas and Peter,

Sorry I'm late for the party of PREEMPT_RT lock review. Just want to
point the problem with this patch. Not even compile test, but show the
idea and check if I'm missing something subtle.

Regards,
Boqun


 kernel/locking/rwbase_rt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba15088e640..a1886fd8bde6 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -41,6 +41,12 @@
  * The risk of writer starvation is there, but the pathological use cases
  * which trigger it are not necessarily the typical RT workloads.
  *
+ * Fast-path orderings:
+ * The lock/unlock of readers can run in fast paths: lock and unlock are only
+ * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
+ * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
+ * and _release() to provide necessary ordering guarantee.
+ *
  * Common code shared between RT rw_semaphore and rwlock
  */
 
@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * dec_and_test() is fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * _release() is needed in case that reader is in fast path, pairing
+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 */
+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -216,8 +229,14 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	 */
 	rwbase_set_and_save_current_state(state);
 
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	/*
+	 * Block until all readers have left the critical section.
+	 *
+	 * _acqurie() is needed in case that the reader side runs in the fast
+	 * path, pairing with the atomic_dec_and_test() in rwbase_read_unlock(),
+	 * provides ACQUIRE.
+	 */
+	for (; atomic_read_acquire(&rwb->readers);) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			__set_current_state(TASK_RUNNING);
@@ -229,6 +248,9 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		/*
 		 * Schedule and wait for the readers to leave the critical
 		 * section. The last reader leaving it wakes the waiter.
+		 *
+		 * _acquire() is not needed, because we can rely on the smp_mb()
+		 * in set_current_state() to provide ACQUIRE.
 		 */
 		if (atomic_read(&rwb->readers) != 0)
 			rwbase_schedule();
@@ -253,7 +275,11 @@ static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
+	/*
+	 * _acquire() is needed in case reader is in the fast path, pairing with
+	 * rwbase_read_unlock(), provides ACQUIRE.
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
-- 
2.32.0

