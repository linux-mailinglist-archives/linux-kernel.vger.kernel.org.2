Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94F93345A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhCJRrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3719 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbhCJRqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwff45XpSz9tyv7;
        Wed, 10 Mar 2021 18:46:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CbeIPE1Enk2P; Wed, 10 Mar 2021 18:46:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwff43x90z9tytH;
        Wed, 10 Mar 2021 18:46:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EA218B78D;
        Wed, 10 Mar 2021 18:46:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id r1PsR-B0Xn9t; Wed, 10 Mar 2021 18:46:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CCFE8B77E;
        Wed, 10 Mar 2021 18:46:54 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E084767568; Wed, 10 Mar 2021 17:46:53 +0000 (UTC)
Message-Id: <def8a39289e02653cfb1583b3b19837de9efed3a.1615398265.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 14/15] powerpc/uaccess: Introduce __get_user_size_goto()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:46:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have got two places doing a goto based on the result
of __get_user_size_allowed().

Refactor that into __get_user_size_goto().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 671c083f2f2f..e3e53e88cb26 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -183,6 +183,15 @@ do {								\
 	}							\
 } while (0)
 
+#define __get_user_size_goto(x, ptr, size, label)		\
+do {								\
+	long __gus_retval;					\
+								\
+	__get_user_size_allowed(x, ptr, size, __gus_retval);	\
+	if (__gus_retval)					\
+		goto label;					\
+} while (0)
+
 /*
  * This is a type: either unsigned long, if the argument fits into
  * that type, or otherwise unsigned long long.
@@ -352,13 +361,10 @@ user_write_access_begin(const void __user *ptr, size_t len)
 #define user_write_access_end		prevent_current_write_to_user
 
 #define unsafe_get_user(x, p, e) do {					\
-	long __gu_err;						\
 	__long_type(*(p)) __gu_val;				\
 	__typeof__(*(p)) __user *__gu_addr = (p);		\
 								\
-	__get_user_size_allowed(__gu_val, __gu_addr, sizeof(*(p)), __gu_err); \
-	if (__gu_err)						\
-		goto e;						\
+	__get_user_size_goto(__gu_val, __gu_addr, sizeof(*(p)), e); \
 	(x) = (__typeof__(*(p)))__gu_val;			\
 } while (0)
 
@@ -389,14 +395,8 @@ do {									\
 #define HAVE_GET_KERNEL_NOFAULT
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-do {									\
-	int __kr_err;							\
-									\
-	__get_user_size_allowed(*((type *)(dst)), (__force type __user *)(src),\
-			sizeof(type), __kr_err);			\
-	if (unlikely(__kr_err))						\
-		goto err_label;						\
-} while (0)
+	__get_user_size_goto(*((type *)(dst)),				\
+		(__force type __user *)(src), sizeof(type), err_label)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 	__put_user_size_goto(*((type *)(src)),				\
-- 
2.25.0

