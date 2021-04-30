Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0564370187
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhD3Txy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:54 -0400
Received: from server.lespinasse.org ([63.205.204.226]:46307 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhD3TxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:24 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Lp7zWyr2ROUjDnOgQqp9EncQocBAA2b6/i5LywQL7GQ=;
 b=LjusKaSBGYg8Bx3zS9rqTLDOjgNifpgywKlBuYYjCZ3gila8jYw1rVUqK+41wEFKbCucK
 R/wftX/VwnQp3lICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Lp7zWyr2ROUjDnOgQqp9EncQocBAA2b6/i5LywQL7GQ=;
 b=JXvW+3Af/q77l6tKiG+MNtKTXIEkcUnjCsKluWpK4GaXu7jaRtcn8qmgMfjPMLgiGmz3N
 I26sPxQDnr/g+hd5JmENpCxgDTON4Ed1ERjv9/tzjYBWUr8n+mSvLpje0W47poDBiqcF4Fd
 +oHdyHHGpLh6UIP3XHnHx+GquBrLfZjyyvf3IZc2+mITquMHqa4ZFqmFEStEru5g2g621q8
 nRGgWvQaKgM20f/t365uawgiPWw+eZxABFDa3rMTTKkTuLyYJ2h0Fy1iJiSC6GUQfIdOU4K
 8RFXi6PN9XUQup5h8+tgSy1VG37RdPbgbujzNIG8pMwoF7chkXxPZRBy+w3Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 4D3D416031F;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 3D67319F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 10/29] mm: add per-mm mmap sequence counter for speculative page fault handling.
Date:   Fri, 30 Apr 2021 12:52:11 -0700
Message-Id: <20210430195232.30491-11-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter's write side is hooked into the existing mmap locking API:
mmap_write_lock() increments the counter to the next (odd) value, and
mmap_write_unlock() increments it again to the next (even) value.

The counter's speculative read side is supposed to be used as follows:

seq = mmap_seq_read_start(mm);
if (seq & 1)
	goto fail;
.... speculative handling here ....
if (!mmap_seq_read_check(mm, seq)
	goto fail;

This API guarantees that, if none of the "fail" tests abort
speculative execution, the speculative code section did not run
concurrently with any mmap writer.

This is very similar to a seqlock, but both the writer and speculative
readers are allowed to block. In the fail case, the speculative reader
does not spin on the sequence counter; instead it should fall back to
a different mechanism such as grabbing the mmap lock read side.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h  |  4 +++
 include/linux/mmap_lock.h | 58 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..70882e628908 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -461,6 +461,10 @@ struct mm_struct {
 					     * counters
 					     */
 		struct rw_semaphore mmap_lock;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		unsigned long mmap_seq;
+#endif
+
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
 					  * are globally strung together off
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8ff276a7560e..8f4eca2d0f43 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -8,8 +8,16 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
 
-#define MMAP_LOCK_INITIALIZER(name) \
-	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+#define MMAP_LOCK_SEQ_INITIALIZER(name) \
+	.mmap_seq = 0,
+#else
+#define MMAP_LOCK_SEQ_INITIALIZER(name)
+#endif
+
+#define MMAP_LOCK_INITIALIZER(name)				\
+	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),	\
+	MMAP_LOCK_SEQ_INITIALIZER(name)
 
 DECLARE_TRACEPOINT(mmap_lock_start_locking);
 DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
@@ -63,13 +71,52 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	mm->mmap_seq = 0;
+#endif
 }
 
+static inline void __mmap_seq_write_lock(struct mm_struct *mm)
+{
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	VM_BUG_ON_MM(mm->mmap_seq & 1, mm);
+	mm->mmap_seq++;
+	smp_wmb();
+#endif
+}
+
+static inline void __mmap_seq_write_unlock(struct mm_struct *mm)
+{
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	smp_wmb();
+	mm->mmap_seq++;
+	VM_BUG_ON_MM(mm->mmap_seq & 1, mm);
+#endif
+}
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static inline unsigned long mmap_seq_read_start(struct mm_struct *mm)
+{
+	unsigned long seq;
+
+	seq = READ_ONCE(mm->mmap_seq);
+	smp_rmb();
+	return seq;
+}
+
+static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq)
+{
+	smp_rmb();
+	return seq == READ_ONCE(mm->mmap_seq);
+}
+#endif
+
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
+	__mmap_seq_write_lock(mm);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
@@ -77,6 +124,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
+	__mmap_seq_write_lock(mm);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
@@ -86,6 +134,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 	__mmap_lock_trace_start_locking(mm, true);
 	error = down_write_killable(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, true, !error);
+	if (likely(!error))
+		__mmap_seq_write_lock(mm);
 	return error;
 }
 
@@ -96,17 +146,21 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
 	__mmap_lock_trace_start_locking(mm, true);
 	ok = down_write_trylock(&mm->mmap_lock) != 0;
 	__mmap_lock_trace_acquire_returned(mm, true, ok);
+	if (likely(ok))
+		__mmap_seq_write_lock(mm);
 	return ok;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
+	__mmap_seq_write_unlock(mm);
 	up_write(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, true);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
+	__mmap_seq_write_unlock(mm);
 	downgrade_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
-- 
2.20.1

