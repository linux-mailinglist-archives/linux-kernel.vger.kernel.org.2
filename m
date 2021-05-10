Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387AD377F95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhEJJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:25 -0400
Received: from foss.arm.com ([217.140.110.172]:50842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhEJJlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4758F1435;
        Mon, 10 May 2021 02:40:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C52D3F73B;
        Mon, 10 May 2021 02:40:11 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au, nickhu@andestech.com,
        palmer@dabbelt.com, paulus@samba.org, paul.walmsley@sifive.com,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: [PATCH 08/33] locking/atomic: atomic: simplify ifdeffery
Date:   Mon, 10 May 2021 10:37:28 +0100
Message-Id: <20210510093753.40683-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that asm-generic/atomic.h is only used by architectures without any
architecture-specific atomic definitions, we know that there will be no
architecture-specific implementations to override, and can remove the
ifdeffery this has previously required, bringing it into line with
asm-generic/atomic64.h.

At the same time, we can implement atomic_add() and atomic_sub()
directly using ATOMIC_OP(), since we know architectures won't provide
atomic_add_return() or atomic_sub_return().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/atomic.h | 46 ++++----------------------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index d4bf803d6491..316c82a27b0a 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -93,65 +93,27 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 
 #endif /* CONFIG_SMP */
 
-#ifndef atomic_add_return
 ATOMIC_OP_RETURN(add, +)
-#endif
-
-#ifndef atomic_sub_return
 ATOMIC_OP_RETURN(sub, -)
-#endif
 
-#ifndef atomic_fetch_add
 ATOMIC_FETCH_OP(add, +)
-#endif
-
-#ifndef atomic_fetch_sub
 ATOMIC_FETCH_OP(sub, -)
-#endif
-
-#ifndef atomic_fetch_and
 ATOMIC_FETCH_OP(and, &)
-#endif
-
-#ifndef atomic_fetch_or
 ATOMIC_FETCH_OP(or, |)
-#endif
-
-#ifndef atomic_fetch_xor
 ATOMIC_FETCH_OP(xor, ^)
-#endif
 
-#ifndef atomic_and
+ATOMIC_OP(add, +)
+ATOMIC_OP(sub, -)
 ATOMIC_OP(and, &)
-#endif
-
-#ifndef atomic_or
 ATOMIC_OP(or, |)
-#endif
-
-#ifndef atomic_xor
 ATOMIC_OP(xor, ^)
-#endif
 
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#ifndef atomic_read
-#define atomic_read(v)	READ_ONCE((v)->counter)
-#endif
-
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
-
-static inline void atomic_add(int i, atomic_t *v)
-{
-	atomic_add_return(i, v);
-}
-
-static inline void atomic_sub(int i, atomic_t *v)
-{
-	atomic_sub_return(i, v);
-}
+#define atomic_read(v)			READ_ONCE((v)->counter)
+#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
 
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
-- 
2.11.0

