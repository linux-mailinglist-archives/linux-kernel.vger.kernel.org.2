Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6004D4135DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhIUPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:11:35 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:55499 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhIUPLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:11:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HDPx81lGBz9sT9;
        Tue, 21 Sep 2021 17:10:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x7o_Pt_yIspL; Tue, 21 Sep 2021 17:10:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HDPx80ZxCz9sSw;
        Tue, 21 Sep 2021 17:10:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F10708B773;
        Tue, 21 Sep 2021 17:10:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id emZZtB7P4WA0; Tue, 21 Sep 2021 17:10:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 993F88B765;
        Tue, 21 Sep 2021 17:10:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18LF9rjF1071866
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 17:09:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18LF9rkY1071865;
        Tue, 21 Sep 2021 17:09:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/3] powerpc/atomics: Remove atomic_inc()/atomic_dec() and friends
Date:   Tue, 21 Sep 2021 17:09:49 +0200
Message-Id: <0bc64a2f18726055093dbb2e479cefc60a409cfd.1632236981.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e6f815d9181bab09df3b350af51149437863e9f9.1632236981.git.christophe.leroy@csgroup.eu>
References: <e6f815d9181bab09df3b350af51149437863e9f9.1632236981.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that atomic_add() and atomic_sub() handle immediate operands,
atomic_inc() and atomic_dec() have no added value compared to the
generic fallback which calls atomic_add(1) and atomic_sub(1).

Also remove atomic_inc_not_zero() which fallsback to
atomic_add_unless() which itself fallsback to
atomic_fetch_add_unless() which now handles immediate operands.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: rebased

v2: New
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/atomic.h | 95 -------------------------------
 1 file changed, 95 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index ce0d5a013c58..395d1feb5790 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -118,71 +118,6 @@ ATOMIC_OPS(xor, xor, "", K)
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-static __inline__ void arch_atomic_inc(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc\n\
-	addic	%0,%0,1\n"
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define arch_atomic_inc arch_atomic_inc
-
-static __inline__ int arch_atomic_inc_return_relaxed(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc_return_relaxed\n"
-"	addic	%0,%0,1\n"
-"	stwcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-static __inline__ void arch_atomic_dec(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec\n\
-	addic	%0,%0,-1\n"
-"	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define arch_atomic_dec arch_atomic_dec
-
-static __inline__ int arch_atomic_dec_return_relaxed(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec_return_relaxed\n"
-"	addic	%0,%0,-1\n"
-"	stwcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
-#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
-
 #define arch_atomic_cmpxchg(v, o, n) \
 	(arch_cmpxchg(&((v)->counter), (o), (n)))
 #define arch_atomic_cmpxchg_relaxed(v, o, n) \
@@ -255,36 +190,6 @@ static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
-/**
- * atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, so long as @v is non-zero.
- * Returns non-zero if @v was non-zero, and zero otherwise.
- */
-static __inline__ int arch_atomic_inc_not_zero(atomic_t *v)
-{
-	int t1, t2;
-
-	__asm__ __volatile__ (
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%2		# atomic_inc_not_zero\n\
-	cmpwi	0,%0,0\n\
-	beq-	2f\n\
-	addic	%1,%0,1\n"
-"	stwcx.	%1,0,%2\n\
-	bne-	1b\n"
-	PPC_ATOMIC_EXIT_BARRIER
-	"\n\
-2:"
-	: "=&r" (t1), "=&r" (t2)
-	: "r" (&v->counter)
-	: "cc", "xer", "memory");
-
-	return t1;
-}
-#define arch_atomic_inc_not_zero(v) arch_atomic_inc_not_zero((v))
-
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1, even if
-- 
2.31.1

