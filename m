Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF9315130
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhBIOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:04:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7527 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhBIOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:02:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZl2F5sGlz9v0KF;
        Tue,  9 Feb 2021 15:02:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id p6-Bo566TAbD; Tue,  9 Feb 2021 15:02:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZl2F4yJ7z9v0KB;
        Tue,  9 Feb 2021 15:02:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0997E8B7E7;
        Tue,  9 Feb 2021 15:02:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ICB81XodAmk8; Tue,  9 Feb 2021 15:02:14 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEAA28B764;
        Tue,  9 Feb 2021 15:02:14 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9A3F767359; Tue,  9 Feb 2021 14:02:14 +0000 (UTC)
Message-Id: <3ae114740317187e12edbd5ffa9157cb8c396dea.1612879284.git.christophe.leroy@csgroup.eu>
In-Reply-To: <99d4ccb58a20d8408d0e19874393655ad5b40822.1612879284.git.christophe.leroy@csgroup.eu>
References: <99d4ccb58a20d8408d0e19874393655ad5b40822.1612879284.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/3] powerpc/uaccess: Merge raw_copy_to_user_allowed() into
 raw_copy_to_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 14:02:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 17bc43367fc2 ("powerpc/uaccess: Implement
unsafe_copy_to_user() as a simple loop"), raw_copy_to_user_allowed()
is only used by raw_copy_to_user().

Merge raw_copy_to_user_allowed() into raw_copy_to_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2fb1d95f10d3..33b2de642120 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -401,19 +401,13 @@ static inline unsigned long raw_copy_from_user(void *to,
 	return ret;
 }
 
-static inline unsigned long
-raw_copy_to_user_allowed(void __user *to, const void *from, unsigned long n)
-{
-	return __copy_tofrom_user(to, (__force const void __user *)from, n);
-}
-
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	unsigned long ret;
 
 	allow_write_to_user(to, n);
-	ret = raw_copy_to_user_allowed(to, from, n);
+	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
 	prevent_write_to_user(to, n);
 	return ret;
 }
-- 
2.25.0

