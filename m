Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855C5325503
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhBYR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:58:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61262 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbhBYRwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLR6F12z9v1BC;
        Thu, 25 Feb 2021 18:50:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9Jsce-AnIQyj; Thu, 25 Feb 2021 18:50:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLR5TlDz9v19y;
        Thu, 25 Feb 2021 18:50:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 954088B895;
        Thu, 25 Feb 2021 18:50:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iZayMdJjEipo; Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5505E8B88B;
        Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 303EB67442; Thu, 25 Feb 2021 17:50:41 +0000 (UTC)
Message-Id: <ecb5aa9ad0806366c87db35669e44bc6458ae624.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 11/15] powerpc/uaccess: Rename __get/put_user_check/nocheck
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_check() becomes get_user()
__put_user_check() becomes put_user()
__get_user_nocheck() becomes __get_user()
__put_user_nocheck() becomes __put_user()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 678651a615c3..616a3a7928c2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -43,16 +43,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
  * exception handling means that it's no longer "just"...)
  *
  */
-#define get_user(x, ptr) \
-	__get_user_check((x), (ptr), sizeof(*(ptr)))
-#define put_user(x, ptr) \
-	__put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
-#define __get_user(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
-#define __put_user(x, ptr) \
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
 #define __put_user_size(x, ptr, size, retval)			\
 do {								\
 	__label__ __pu_failed;					\
@@ -68,12 +58,12 @@ __pu_failed:							\
 	prevent_write_to_user(ptr, size);			\
 } while (0)
 
-#define __put_user_nocheck(x, ptr, size)			\
+#define __put_user(x, ptr)					\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
-	__typeof__(*(ptr)) __pu_val = (x);			\
-	__typeof__(size) __pu_size = (size);			\
+	__typeof__(*(ptr)) __pu_val = (__typeof__(*(ptr)))(x);	\
+	__typeof__(sizeof(*(ptr))) __pu_size = sizeof(*(ptr));	\
 								\
 	might_fault();						\
 	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err);	\
@@ -81,12 +71,12 @@ __pu_failed:							\
 	__pu_err;						\
 })
 
-#define __put_user_check(x, ptr, size)					\
+#define put_user(x, ptr)						\
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__typeof__(size) __pu_size = (size);				\
+	__typeof__(*(ptr)) __pu_val = (__typeof__(*(ptr)))(x);		\
+	__typeof__(sizeof(*(ptr))) __pu_size = sizeof(*(ptr));		\
 									\
 	might_fault();							\
 	if (access_ok(__pu_addr, __pu_size))				\
@@ -216,12 +206,12 @@ do {								\
 #define __long_type(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
-#define __get_user_nocheck(x, ptr, size)			\
+#define __get_user(x, ptr)					\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
-	__typeof__(size) __gu_size = (size);			\
+	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
 								\
 	might_fault();					\
 	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
@@ -230,12 +220,12 @@ do {								\
 	__gu_err;						\
 })
 
-#define __get_user_check(x, ptr, size)					\
+#define get_user(x, ptr)						\
 ({									\
 	long __gu_err = -EFAULT;					\
 	__long_type(*(ptr)) __gu_val = 0;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	__typeof__(size) __gu_size = (size);				\
+	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));		\
 									\
 	might_fault();							\
 	if (access_ok(__gu_addr, __gu_size))				\
-- 
2.25.0

