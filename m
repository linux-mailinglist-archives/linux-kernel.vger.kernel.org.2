Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C93254F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhBYRzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:55:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32382 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232806AbhBYRwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLN73Lbz9v1B7;
        Thu, 25 Feb 2021 18:50:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id k--8Mv5N6gi5; Thu, 25 Feb 2021 18:50:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLN4xYBz9v19y;
        Thu, 25 Feb 2021 18:50:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E73F8B895;
        Thu, 25 Feb 2021 18:50:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 51pdV6ubWDJQ; Thu, 25 Feb 2021 18:50:38 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 400C88B88B;
        Thu, 25 Feb 2021 18:50:38 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 18AEE67442; Thu, 25 Feb 2021 17:50:38 +0000 (UTC)
Message-Id: <8a128f921114bfbad3e3f0b468bbe01f4d89c4dc.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 08/15] powerpc/uaccess: Remove __chk_user_ptr() in
 __get/put_user
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d02f6b7dab82 ("powerpc/uaccess: Evaluate macro arguments once,
before user access is allowed") changed the __chk_user_ptr()
argument from the passed ptr pointer to the locally
declared __gu_addr. But __gu_addr is locally defined as __user
so the check is pointless.

During kernel build __chk_user_ptr() voids and is only evaluated
during sparse checks so it should have been armless to leave the
original pointer check there.

Nevertheless, this check is indeed redundant with the assignment
above which casts the ptr pointer to the local __user __gu_addr.
In case of mismatch, sparse will detect it there, so the
__check_user_ptr() is not needed anywhere else than in access_ok().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a6d3563cf3ee..a9f2639ca3a8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -78,7 +78,6 @@ __pu_failed:							\
 	__typeof__(size) __pu_size = (size);			\
 								\
 	might_fault();						\
-	__chk_user_ptr(__pu_addr);				\
 	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err);	\
 								\
 	__pu_err;						\
@@ -197,7 +196,6 @@ extern long __get_user_bad(void);
 #define __get_user_size_allowed(x, ptr, size, retval)		\
 do {								\
 	retval = 0;						\
-	__chk_user_ptr(ptr);					\
 	if (size > sizeof(x))					\
 		(x) = __get_user_bad();				\
 	switch (size) {						\
@@ -230,7 +228,6 @@ do {								\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__typeof__(size) __gu_size = (size);			\
 								\
-	__chk_user_ptr(__gu_addr);				\
 	if (do_allow) {								\
 		might_fault();					\
 		__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
-- 
2.25.0

