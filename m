Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E435E41E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbhDMQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:37:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37477 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346000AbhDMQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:37:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FKWTX6Cc3z9vBLN;
        Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7z0KEN-lxBd0; Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWTX51mTz9v4h8;
        Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 586E78B7AA;
        Tue, 13 Apr 2021 18:36:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Wm6VGzvOlh3o; Tue, 13 Apr 2021 18:36:50 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 193D58B75F;
        Tue, 13 Apr 2021 18:36:50 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EC4E167A15; Tue, 13 Apr 2021 16:36:49 +0000 (UTC)
Message-Id: <770c0963b9e1fd519b2fa9aabf5c19a6bf25bd30.1618331293.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3e42149aeff047f50770a72e1617c171edaa86da.1618331293.git.christophe.leroy@csgroup.eu>
References: <3e42149aeff047f50770a72e1617c171edaa86da.1618331293.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/3] powerpc/atomics: Remove atomic_inc()/atomic_dec() and
 friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Apr 2021 16:36:49 +0000 (UTC)
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
v2: New
---
 arch/powerpc/include/asm/atomic.h | 95 -------------------------------
 1 file changed, 95 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index eb1bdf14f67c..00ba5d9e837b 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -118,71 +118,6 @@ ATOMIC_OPS(xor, xor, "", K)
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-static __inline__ void atomic_inc(atomic_t *v)
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
-#define atomic_inc atomic_inc
-
-static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
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
-static __inline__ void atomic_dec(atomic_t *v)
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
-#define atomic_dec atomic_dec
-
-static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
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
-#define atomic_inc_return_relaxed atomic_inc_return_relaxed
-#define atomic_dec_return_relaxed atomic_dec_return_relaxed
-
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_cmpxchg_relaxed(v, o, n) \
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
@@ -252,36 +187,6 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
-/**
- * atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, so long as @v is non-zero.
- * Returns non-zero if @v was non-zero, and zero otherwise.
- */
-static __inline__ int atomic_inc_not_zero(atomic_t *v)
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
-#define atomic_inc_not_zero(v) atomic_inc_not_zero((v))
-
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1, even if
-- 
2.25.0

