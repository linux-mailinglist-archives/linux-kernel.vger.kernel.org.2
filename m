Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98951410F48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhITFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:22:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50588 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhITFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:22:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7DC820000;
        Mon, 20 Sep 2021 05:20:42 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5565D13AC7;
        Mon, 20 Sep 2021 05:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GmdCCgaSGFsSwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 20 Sep 2021 05:20:40 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] locking/rwbase: Optimize rwbase_read_trylock
Date:   Sun, 19 Sep 2021 22:20:30 -0700
Message-Id: <20210920052031.54220-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920052031.54220-1-dave@stgolabs.net>
References: <20210920052031.54220-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a full barrier around the Rmw insn, micro-optimize
for weakly ordered archs such that we only provide the required
ACQUIRE semantics when taking the read lock.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/rwbase_rt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 88191f6e252c..a9034784a5a0 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -59,8 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
-		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
-		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
+		if (likely(atomic_try_cmpxchg_acquire(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
 	return 0;
@@ -183,7 +182,7 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 
 	/*
 	 * _release() is needed in case that reader is in fast path, pairing
-	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 * with atomic_try_cmpxchg_acquire() in rwbase_read_trylock().
 	 */
 	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
-- 
2.26.2

