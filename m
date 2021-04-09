Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99711359240
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhDICzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhDICy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:54:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63465C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+30ewFdNzqjAsHucIGBTD78Q8j4ynPy1ksGc7GxIwlc=; b=KimaRN12o3OpK/UWzLpc8rpv3t
        xWILfxbR/fEq5PH6kb95hH5kZx1CS+HvZ9ijoYCBScMtReG+hHgtYyVZ1hz0TyZwjBSn1sqhy6E5k
        Reb1maLgYAJDETFzWMB0/nCaKC3isCQDIgUXu6bV1ZJlueZb3w+Jq46Qgso6LIEgqHdQdFPb2/6bK
        uNDkgMYn0skx6Gk2jrv+E8acoq7V2wXMRO+LTM0srC8R3JrC3+QDFV28Uim+NJT8S61GQUxLueujO
        jraJtIxHrrKfyB54NB+C5kf5PoO02yfJZF1lw7PJFm0V6tt9Bq94+qJEXnCSMjTbkJxlp+crJYYQ/
        iSsz9IFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhGW-00HGM9-Gn; Fri, 09 Apr 2021 02:53:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] bit_spinlock: Prepare for split_locks
Date:   Fri,  9 Apr 2021 03:51:17 +0100
Message-Id: <20210409025131.4114078-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make bit_spin_lock() and variants variadic to help with the transition.
The split_lock parameter will become mandatory at the end of the series.
Also add bit_spin_lock_nested() and bit_spin_unlock_assign() which will
both be used by the rhashtable code later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bit_spinlock.h | 43 ++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..6c5bbb55b334 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/split_lock.h>
 
 /*
  *  bit-based spin_lock()
@@ -13,7 +14,8 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static inline void bit_spin_lock_nested(int bitnum, unsigned long *addr,
+		struct split_lock *lock, unsigned int subclass)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -35,10 +37,27 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 	__acquire(bitlock);
 }
 
+static inline void bit_spin_lock(int bitnum, unsigned long *addr,
+		...)
+{
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
+		preempt_enable();
+		do {
+			cpu_relax();
+		} while (test_bit(bitnum, addr));
+		preempt_disable();
+	}
+#endif
+	__acquire(bitlock);
+}
+
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static inline int bit_spin_trylock(int bitnum, unsigned long *addr,
+		...)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -54,7 +73,8 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static inline void bit_spin_unlock(int bitnum, unsigned long *addr,
+		...)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -71,7 +91,8 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static inline void __bit_spin_unlock(int bitnum, unsigned long *addr,
+		...)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -83,6 +104,20 @@ static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
 	__release(bitlock);
 }
 
+/**
+ * bit_spin_unlock_assign - Unlock a bitlock by assignment of new value.
+ * @addr: Address to assign the value to.
+ * @val: New value to assign.
+ * @lock: Split lock that this bitlock is part of.
+ */
+static inline void bit_spin_unlock_assign(unsigned long *addr,
+		unsigned long val, struct split_lock *lock)
+{
+	smp_store_release(addr, val);
+	preempt_enable();
+	__release(bitlock);
+}
+
 /*
  * Return true if the lock is held.
  */
-- 
2.30.2

