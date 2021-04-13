Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB935E41C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbhDMQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:37:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32437 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345980AbhDMQhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:37:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FKWTV6Lt0z9v4hC;
        Tue, 13 Apr 2021 18:36:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MiJhxWyqSBib; Tue, 13 Apr 2021 18:36:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWTV5TXjz9v4h8;
        Tue, 13 Apr 2021 18:36:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 694608B7AA;
        Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ovulLW43E61W; Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2661E8B75F;
        Tue, 13 Apr 2021 18:36:48 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CF39D67A15; Tue, 13 Apr 2021 16:36:47 +0000 (UTC)
Message-Id: <3e42149aeff047f50770a72e1617c171edaa86da.1618331293.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/3] powerpc/bitops: Use immediate operand when possible
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Apr 2021 16:36:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we get the following code generation for bitops like
set or clear bit:

	c0009fe0:	39 40 08 00 	li      r10,2048
	c0009fe4:	7c e0 40 28 	lwarx   r7,0,r8
	c0009fe8:	7c e7 53 78 	or      r7,r7,r10
	c0009fec:	7c e0 41 2d 	stwcx.  r7,0,r8

	c000d568:	39 00 18 00 	li      r8,6144
	c000d56c:	7c c0 38 28 	lwarx   r6,0,r7
	c000d570:	7c c6 40 78 	andc    r6,r6,r8
	c000d574:	7c c0 39 2d 	stwcx.  r6,0,r7

Most set bits are constant on lower 16 bits, so it can easily
be replaced by the "immediate" version of the operation. Allow
GCC to choose between the normal or immediate form.

For clear bits, on 32 bits 'rlwinm' can be used instead of 'andc' for
when all bits to be cleared are consecutive. For this we detect
the number of transitions from 0 to 1 in the mask. This is done
by handing the mask with its complement rotated left 1 bit. If this
operation provides a number which is a power of 2, it means there
is only one transition from 0 to 1 in the number, so all 1 bits are
consecutives.
Can't use rol32() which is not defined yet, so do a
raw ((x << 1) | (x >> 31)). For the power of 2, can't use
is_power_of_2() for the same reason, but it can also be easily encoded
as  (mask & (mask - 1)) and even the 0 case which is not a power of
two is acceptable for us.

On 64 bits we don't have any equivalent single operation, we'd need
two 'rldicl' so it is not worth it.

With this patch we get:

	c0009fe0:	7d 00 50 28 	lwarx   r8,0,r10
	c0009fe4:	61 08 08 00 	ori     r8,r8,2048
	c0009fe8:	7d 00 51 2d 	stwcx.  r8,0,r10

	c000d558:	7c e0 40 28 	lwarx   r7,0,r8
	c000d55c:	54 e7 05 64 	rlwinm  r7,r7,0,21,18
	c000d560:	7c e0 41 2d 	stwcx.  r7,0,r8

On pmac32_defconfig, it reduces the text by approx 10 kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2:
- Use "n" instead of "i" as constraint for the rlwinm mask
- Improve mask verification to handle more than single bit masks
---
 arch/powerpc/include/asm/bitops.h | 85 ++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 299ab33505a6..baa7666c1094 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -71,19 +71,57 @@ static inline void fn(unsigned long mask,	\
 	__asm__ __volatile__ (			\
 	prefix					\
 "1:"	PPC_LLARX(%0,0,%3,0) "\n"		\
-	stringify_in_c(op) "%0,%0,%2\n"		\
+	#op "%I2 %0,%0,%2\n"			\
 	PPC_STLCX "%0,0,%3\n"			\
 	"bne- 1b\n"				\
 	: "=&r" (old), "+m" (*p)		\
-	: "r" (mask), "r" (p)			\
+	: "rK" (mask), "r" (p)			\
 	: "cc", "memory");			\
 }
 
 DEFINE_BITOP(set_bits, or, "")
-DEFINE_BITOP(clear_bits, andc, "")
-DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
 DEFINE_BITOP(change_bits, xor, "")
 
+static __always_inline bool is_rlwinm_mask_valid(unsigned long x)
+{
+	x = x & ~((x << 1) | (x >> 31));/* Flag transitions from 0 to 1 */
+
+	return !(x & (x - 1));		/* Is there only one transition */
+}
+
+#define DEFINE_CLROP(fn, prefix)					\
+static inline void fn(unsigned long mask, volatile unsigned long *_p)	\
+{									\
+	unsigned long old;						\
+	unsigned long *p = (unsigned long *)_p;				\
+									\
+	if (IS_ENABLED(CONFIG_PPC32) &&					\
+	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(mask)) {	\
+		asm volatile (						\
+			prefix						\
+		"1:"	"lwarx	%0,0,%3\n"				\
+			"rlwinm	%0,%0,0,%2\n"				\
+			"stwcx.	%0,0,%3\n"				\
+			"bne- 1b\n"					\
+			: "=&r" (old), "+m" (*p)			\
+			: "n" (~mask), "r" (p)				\
+			: "cc", "memory");				\
+	} else {							\
+		asm volatile (						\
+			prefix						\
+		"1:"	PPC_LLARX(%0,0,%3,0) "\n"			\
+			"andc %0,%0,%2\n"				\
+			PPC_STLCX "%0,0,%3\n"				\
+			"bne- 1b\n"					\
+			: "=&r" (old), "+m" (*p)			\
+			: "r" (mask), "r" (p)				\
+			: "cc", "memory");				\
+	}								\
+}
+
+DEFINE_CLROP(clear_bits, "")
+DEFINE_CLROP(clear_bits_unlock, PPC_RELEASE_BARRIER)
+
 static inline void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
@@ -116,12 +154,12 @@ static inline unsigned long fn(			\
 	__asm__ __volatile__ (				\
 	prefix						\
 "1:"	PPC_LLARX(%0,0,%3,eh) "\n"			\
-	stringify_in_c(op) "%1,%0,%2\n"			\
+	#op "%I2 %1,%0,%2\n"				\
 	PPC_STLCX "%1,0,%3\n"				\
 	"bne- 1b\n"					\
 	postfix						\
 	: "=&r" (old), "=&r" (t)			\
-	: "r" (mask), "r" (p)				\
+	: "rK" (mask), "r" (p)				\
 	: "cc", "memory");				\
 	return (old & mask);				\
 }
@@ -130,11 +168,42 @@ DEFINE_TESTOP(test_and_set_bits, or, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 DEFINE_TESTOP(test_and_set_bits_lock, or, "",
 	      PPC_ACQUIRE_BARRIER, 1)
-DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
-	      PPC_ATOMIC_EXIT_BARRIER, 0)
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
+static inline unsigned long test_and_clear_bits(unsigned long mask, volatile unsigned long *_p)
+{
+	unsigned long old, t;
+	unsigned long *p = (unsigned long *)_p;
+
+	if (IS_ENABLED(CONFIG_PPC32) &&
+	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(mask)) {
+		asm volatile (
+			PPC_ATOMIC_ENTRY_BARRIER
+		"1:"	"lwarx %0,0,%3\n"
+			"rlwinm	%1,%0,0,%2\n"
+			"stwcx. %1,0,%3\n"
+			"bne- 1b\n"
+			PPC_ATOMIC_EXIT_BARRIER
+			: "=&r" (old), "=&r" (t)
+			: "n" (~mask), "r" (p)
+			: "cc", "memory");
+	} else {
+		asm volatile (
+			PPC_ATOMIC_ENTRY_BARRIER
+		"1:"	PPC_LLARX(%0,0,%3,0) "\n"
+			"andc	%1,%0,%2\n"
+			PPC_STLCX "%1,0,%3\n"
+			"bne- 1b\n"
+			PPC_ATOMIC_EXIT_BARRIER
+			: "=&r" (old), "=&r" (t)
+			: "r" (mask), "r" (p)
+			: "cc", "memory");
+	}
+
+	return (old & mask);
+}
+
 static inline int arch_test_and_set_bit(unsigned long nr,
 					volatile unsigned long *addr)
 {
-- 
2.25.0

