Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFA325502
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhBYR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:57:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40679 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhBYRwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:22 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLQ6NXvz9v1BB;
        Thu, 25 Feb 2021 18:50:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QvMhW63DNFRf; Thu, 25 Feb 2021 18:50:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLQ5FHxz9v19y;
        Thu, 25 Feb 2021 18:50:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 905668B895;
        Thu, 25 Feb 2021 18:50:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hhm05etgtTnB; Thu, 25 Feb 2021 18:50:40 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E6888B88B;
        Thu, 25 Feb 2021 18:50:40 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 295BD67442; Thu, 25 Feb 2021 17:50:40 +0000 (UTC)
Message-Id: <1bca82b81046b5cf094fbb9163d73c4043455865.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 10/15] powerpc/uaccess: Split out __get_user_nocheck()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One part of __get_user_nocheck() is used for __get_user(),
the other part for unsafe_get_user().

Move the part dedicated to unsafe_get_user() in it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a8c683695ec7..678651a615c3 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -49,7 +49,7 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 	__put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
 #define __get_user(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)
+	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
@@ -216,19 +216,15 @@ do {								\
 #define __long_type(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
-#define __get_user_nocheck(x, ptr, size, do_allow)			\
+#define __get_user_nocheck(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__typeof__(size) __gu_size = (size);			\
 								\
-	if (do_allow) {								\
-		might_fault();					\
-		__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
-	} else {									\
-		__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
-	}									\
+	might_fault();					\
+	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 								\
 	__gu_err;						\
@@ -386,8 +382,14 @@ user_write_access_begin(const void __user *ptr, size_t len)
 #define user_write_access_end		prevent_current_write_to_user
 
 #define unsafe_get_user(x, p, e) do {					\
-	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
-		goto e;							\
+	long __gu_err;						\
+	__long_type(*(p)) __gu_val;				\
+	__typeof__(*(p)) __user *__gu_addr = (p);		\
+								\
+	__get_user_size_allowed(__gu_val, __gu_addr, sizeof(*(p)), __gu_err); \
+	if (__gu_err)						\
+		goto e;						\
+	(x) = (__typeof__(*(p)))__gu_val;			\
 } while (0)
 
 #define unsafe_put_user(x, p, e) \
-- 
2.25.0

