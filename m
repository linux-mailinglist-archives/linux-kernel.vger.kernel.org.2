Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDC35926C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhDIDD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhDIDDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:03:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6167C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M/C0+S9GkpjX4HlvsjOP0dRDmqf61Bew2w/hNmZoZVg=; b=TGr6lSMIJ3ADGH3DQfx3O9CYhF
        GKnfogC3cnc+buV5tctRGWH4FJ3yTJVLgRpf5SXueQKf38B6euRFyAOwal3FYYqRBUiPj3yUtRuuG
        TnFjgqQX5yShFuGluImqMkhqmXYf2X3ui0ZE/cs8gDS4Tx1iKZzZazYv5t60F99lkz+iSEJnOPIPo
        mx66BAxOEc+U3dh8WyQrCOtcZjMRomNLWx1NCD5y0+IZCiAF2HIVLSbobEgkqqJy0mB0LcfmQ3oZI
        J/0pGzKuYdOcITUCE8zE2CMHDBJsFPeQhroT4sEB5Y/Fn15VKaxXAr3uxXC9blzGfUeIN2tyLs4E4
        NiMO/SbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhOY-00HH7g-FP; Fri, 09 Apr 2021 03:01:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] bit_spinlock: Track bit spin locks with lockdep
Date:   Fri,  9 Apr 2021 03:51:31 +0100
Message-Id: <20210409025131.4114078-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users have been converted, require the split_lock parameter
be passed to bit_spin_lock(), bit_spin_unlock() and variants.  Use it
to track the lockdep state of each lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bit_spinlock.h | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index 6c5bbb55b334..a02ce695198a 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -34,30 +34,21 @@ static inline void bit_spin_lock_nested(int bitnum, unsigned long *addr,
 		preempt_disable();
 	}
 #endif
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	__acquire(bitlock);
 }
 
 static inline void bit_spin_lock(int bitnum, unsigned long *addr,
-		...)
+		struct split_lock *lock)
 {
-	preempt_disable();
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
-		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
-		preempt_disable();
-	}
-#endif
-	__acquire(bitlock);
+	bit_spin_lock_nested(bitnum, addr, lock, 0);
 }
 
 /*
  * Return true if it was acquired
  */
 static inline int bit_spin_trylock(int bitnum, unsigned long *addr,
-		...)
+		struct split_lock *lock)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -66,6 +57,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr,
 		return 0;
 	}
 #endif
+	spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	__acquire(bitlock);
 	return 1;
 }
@@ -74,11 +66,12 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr,
  *  bit-based spin_unlock()
  */
 static inline void bit_spin_unlock(int bitnum, unsigned long *addr,
-		...)
+		struct split_lock *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
 #endif
+	spin_release(&lock->dep_map, _RET_IP_);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	clear_bit_unlock(bitnum, addr);
 #endif
@@ -92,11 +85,12 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr,
  *  protecting the rest of the flags in the word.
  */
 static inline void __bit_spin_unlock(int bitnum, unsigned long *addr,
-		...)
+		struct split_lock *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
 #endif
+	spin_release(&lock->dep_map, _RET_IP_);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	__clear_bit_unlock(bitnum, addr);
 #endif
@@ -113,6 +107,7 @@ static inline void __bit_spin_unlock(int bitnum, unsigned long *addr,
 static inline void bit_spin_unlock_assign(unsigned long *addr,
 		unsigned long val, struct split_lock *lock)
 {
+	spin_release(&lock->dep_map, _RET_IP_);
 	smp_store_release(addr, val);
 	preempt_enable();
 	__release(bitlock);
@@ -133,4 +128,3 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 }
 
 #endif /* __LINUX_BIT_SPINLOCK_H */
-
-- 
2.30.2

