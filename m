Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FAB315131
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBIOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:04:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6413 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231874AbhBIODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:03:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZl2D0xCNz9v0KD;
        Tue,  9 Feb 2021 15:02:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vzzvUCSzVgen; Tue,  9 Feb 2021 15:02:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZl2D050pz9v0KB;
        Tue,  9 Feb 2021 15:02:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E4838B7EA;
        Tue,  9 Feb 2021 15:02:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wvj3lYxnwGWG; Tue,  9 Feb 2021 15:02:13 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0A908B7E9;
        Tue,  9 Feb 2021 15:02:12 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 84DEE67359; Tue,  9 Feb 2021 14:02:12 +0000 (UTC)
Message-Id: <99d4ccb58a20d8408d0e19874393655ad5b40822.1612879284.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/3] powerpc/uaccess: get rid of small constant size cases
 in raw_copy_{to,from}_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 14:02:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copied from commit 4b842e4e25b1 ("x86: get rid of small
constant size cases in raw_copy_{to,from}_user()")

Very few call sites where that would be triggered remain, and none
of those is anywhere near hot enough to bother.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 41 ------------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 93d33f7e8b53..a4d2569173ac 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -398,26 +398,6 @@ static inline unsigned long raw_copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
 	unsigned long ret;
-	if (__builtin_constant_p(n) && (n <= 8)) {
-		ret = 1;
-
-		switch (n) {
-		case 1:
-			__get_user_size(*(u8 *)to, from, 1, ret);
-			break;
-		case 2:
-			__get_user_size(*(u16 *)to, from, 2, ret);
-			break;
-		case 4:
-			__get_user_size(*(u32 *)to, from, 4, ret);
-			break;
-		case 8:
-			__get_user_size(*(u64 *)to, from, 8, ret);
-			break;
-		}
-		if (ret == 0)
-			return 0;
-	}
 
 	allow_read_from_user(from, n);
 	ret = __copy_tofrom_user((__force void __user *)to, from, n);
@@ -428,27 +408,6 @@ static inline unsigned long raw_copy_from_user(void *to,
 static inline unsigned long
 raw_copy_to_user_allowed(void __user *to, const void *from, unsigned long n)
 {
-	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
-
-		switch (n) {
-		case 1:
-			__put_user_size_allowed(*(u8 *)from, (u8 __user *)to, 1, ret);
-			break;
-		case 2:
-			__put_user_size_allowed(*(u16 *)from, (u16 __user *)to, 2, ret);
-			break;
-		case 4:
-			__put_user_size_allowed(*(u32 *)from, (u32 __user *)to, 4, ret);
-			break;
-		case 8:
-			__put_user_size_allowed(*(u64 *)from, (u64 __user *)to, 8, ret);
-			break;
-		}
-		if (ret == 0)
-			return 0;
-	}
-
 	return __copy_tofrom_user(to, (__force const void __user *)from, n);
 }
 
-- 
2.25.0

