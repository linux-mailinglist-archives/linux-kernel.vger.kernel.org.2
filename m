Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CB33459C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhCJRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:5569 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhCJRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:51 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwff04GfWz9tytR;
        Wed, 10 Mar 2021 18:46:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zYHaVkIdeRa8; Wed, 10 Mar 2021 18:46:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwff03QK1z9tytH;
        Wed, 10 Mar 2021 18:46:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42C758B78D;
        Wed, 10 Mar 2021 18:46:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yfqViobHjMXv; Wed, 10 Mar 2021 18:46:50 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E61CD8B77E;
        Wed, 10 Mar 2021 18:46:49 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C4A3067568; Wed, 10 Mar 2021 17:46:49 +0000 (UTC)
Message-Id: <d7d839e994f49fae4ff7b70fac72bd951272436b.1615398265.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 10/15] powerpc/uaccess: Remove calls to __get_user_bad()
 and __put_user_bad()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:46:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_bad() and __put_user_bad() are functions that are
declared but not defined, in order to make the link fail in
case they are called.

Nowadays, we have BUILD_BUG() and BUILD_BUG_ON() for that, and
they have the advantage to break the build earlier as it breaks
it at compile time instead of link time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a9f2639ca3a8..a8c683695ec7 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -53,8 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-extern long __put_user_bad(void);
-
 #define __put_user_size(x, ptr, size, retval)			\
 do {								\
 	__label__ __pu_failed;					\
@@ -136,12 +134,10 @@ do {								\
 	case 2: __put_user_asm_goto(x, __pus_addr, label, "sth"); break;	\
 	case 4: __put_user_asm_goto(x, __pus_addr, label, "stw"); break;	\
 	case 8: __put_user_asm2_goto(x, __pus_addr, label); break;		\
-	default: __put_user_bad();				\
+	default: BUILD_BUG();					\
 	}							\
 } while (0)
 
-extern long __get_user_bad(void);
-
 /*
  * This does an atomic 128 byte aligned load from userspace.
  * Upto caller to do enable_kernel_vmx() before calling!
@@ -196,14 +192,13 @@ extern long __get_user_bad(void);
 #define __get_user_size_allowed(x, ptr, size, retval)		\
 do {								\
 	retval = 0;						\
-	if (size > sizeof(x))					\
-		(x) = __get_user_bad();				\
+	BUILD_BUG_ON(size > sizeof(x));				\
 	switch (size) {						\
 	case 1: __get_user_asm(x, (u8 __user *)ptr, retval, "lbz"); break;	\
 	case 2: __get_user_asm(x, (u16 __user *)ptr, retval, "lhz"); break;	\
 	case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break;	\
 	case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;	\
-	default: (x) = __get_user_bad();			\
+	default: BUILD_BUG();					\
 	}							\
 } while (0)
 
-- 
2.25.0

