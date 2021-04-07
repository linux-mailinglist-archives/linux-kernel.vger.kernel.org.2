Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA435611B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbhDGBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE787C0613D8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Lp7zWyr2ROUjDnOgQqp9EncQocBAA2b6/i5LywQL7GQ=;
 b=JEBujiJmSTWdYEc7UtZmGCFy+tbS5UD1rkml1lTz27un8tBkop3pmKK9qOmdQFN78PJm5
 QdI3ifaVwMwmbIBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Lp7zWyr2ROUjDnOgQqp9EncQocBAA2b6/i5LywQL7GQ=;
 b=ZBLnIfbrq/6RNMCWxODmT5W8qYFafannsw9Gj6pTdWHn03bFfT4iWUSrv0lC7A0AQ/YGN
 ghwMAxsaqOHn3bzTP+TeGkMgPiNurvKBaSJWkZUPdNUd5DU679gip6NmxJP//7ocCqB3n2T
 qDXHA5hqETKAqd3GSWwUdbANZFOeO7r7rd4ZC17L2RSPsRUJ0+2eYItyF3iCxGpAW4RmQ+j
 j8aC8Bc2eC/1G6/AwJVuXMomylHnTN1HBMXE5G4Bdxy6Ajp9djsG2v9C7HYmOBUJeMBKvY1
 0q33N01ai7e355VCLJXh4q5GcgSJoawSxl2est8H6nVsuHPQRc79PqaAzQ7w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id A353C160283;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 951AA19F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 09/37] mm: add per-mm mmap sequence counter for speculative page fault handling.
Date:   Tue,  6 Apr 2021 18:44:34 -0700
Message-Id: <20210407014502.24091-10-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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

