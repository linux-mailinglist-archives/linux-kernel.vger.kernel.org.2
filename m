Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70513254FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhBYR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:57:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3096 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhBYRwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLT6T7Tz9v1BF;
        Thu, 25 Feb 2021 18:50:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bufoj8NCcU2h; Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLT5Ssvz9v19y;
        Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96DAD8B895;
        Thu, 25 Feb 2021 18:50:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sOO75PUKSqhN; Thu, 25 Feb 2021 18:50:43 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 651528B88B;
        Thu, 25 Feb 2021 18:50:43 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E11F67442; Thu, 25 Feb 2021 17:50:43 +0000 (UTC)
Message-Id: <d62271da6eca26c98ba4624ec829c8d341c521ae.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 13/15] powerpc/uaccess: Swap clear_user() and
 __clear_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is clear_user() which is expected to call __clear_user(),
not the reverse.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 671c083f2f2f..b3bd1fb42242 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -283,21 +283,20 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 
 unsigned long __arch_clear_user(void __user *addr, unsigned long size);
 
-static inline unsigned long clear_user(void __user *addr, unsigned long size)
+static inline unsigned long __clear_user(void __user *addr, unsigned long size)
 {
-	unsigned long ret = size;
+	unsigned long ret;
+
 	might_fault();
-	if (likely(access_ok(addr, size))) {
-		allow_write_to_user(addr, size);
-		ret = __arch_clear_user(addr, size);
-		prevent_write_to_user(addr, size);
-	}
+	allow_write_to_user(addr, size);
+	ret = __arch_clear_user(addr, size);
+	prevent_write_to_user(addr, size);
 	return ret;
 }
 
-static inline unsigned long __clear_user(void __user *addr, unsigned long size)
+static inline unsigned long clear_user(void __user *addr, unsigned long size)
 {
-	return clear_user(addr, size);
+	return likely(access_ok(addr, size)) ? __clear_user(addr, size) : size;
 }
 
 extern long strncpy_from_user(char *dst, const char __user *src, long count);
-- 
2.25.0

