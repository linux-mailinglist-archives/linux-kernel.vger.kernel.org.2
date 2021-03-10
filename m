Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80181334599
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhCJRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35929 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhCJRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfdy4k3fzB09Zh;
        Wed, 10 Mar 2021 18:46:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SYegPfdj-NsR; Wed, 10 Mar 2021 18:46:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfdy3t56z9tytQ;
        Wed, 10 Mar 2021 18:46:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 325A68B77E;
        Wed, 10 Mar 2021 18:46:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VvrnuTwU3aZ0; Wed, 10 Mar 2021 18:46:48 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E1BC58B78D;
        Wed, 10 Mar 2021 18:46:47 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B5F3067568; Wed, 10 Mar 2021 17:46:47 +0000 (UTC)
Message-Id: <b6552149209aebd887a6977272b06a41256bdb9f.1615398265.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 08/15] powerpc/uaccess: Remove __unsafe_put_user_goto()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:46:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__unsafe_put_user_goto() is just an intermediate layer to
__put_user_size_goto() without added value other than doing
the __user pointer type checking.

Do the __user pointer type checking in __put_user_size_goto()
and remove __unsafe_put_user_goto().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index c4bbc64758a0..a6d3563cf3ee 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -130,23 +130,17 @@ __pu_failed:							\
 
 #define __put_user_size_goto(x, ptr, size, label)		\
 do {								\
+	__typeof__(*(ptr)) __user *__pus_addr = (ptr);		\
+								\
 	switch (size) {						\
-	case 1: __put_user_asm_goto(x, ptr, label, "stb"); break;	\
-	case 2: __put_user_asm_goto(x, ptr, label, "sth"); break;	\
-	case 4: __put_user_asm_goto(x, ptr, label, "stw"); break;	\
-	case 8: __put_user_asm2_goto(x, ptr, label); break;	\
+	case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;	\
+	case 2: __put_user_asm_goto(x, __pus_addr, label, "sth"); break;	\
+	case 4: __put_user_asm_goto(x, __pus_addr, label, "stw"); break;	\
+	case 8: __put_user_asm2_goto(x, __pus_addr, label); break;		\
 	default: __put_user_bad();				\
 	}							\
 } while (0)
 
-#define __unsafe_put_user_goto(x, ptr, size, label)		\
-do {								\
-	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
-	__chk_user_ptr(ptr);					\
-	__put_user_size_goto((x), __pu_addr, (size), label);	\
-} while (0)
-
-
 extern long __get_user_bad(void);
 
 /*
@@ -405,7 +399,7 @@ user_write_access_begin(const void __user *ptr, size_t len)
 } while (0)
 
 #define unsafe_put_user(x, p, e) \
-	__unsafe_put_user_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
+	__put_user_size_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
 
 #define unsafe_copy_to_user(d, s, l, e) \
 do {									\
-- 
2.25.0

