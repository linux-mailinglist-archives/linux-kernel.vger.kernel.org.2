Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD63345D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCJR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:57:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13035 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhCJR5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfsn5sTvz9tyv8;
        Wed, 10 Mar 2021 18:57:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QaR_BYD6t_W1; Wed, 10 Mar 2021 18:57:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfsn56V7z9tytT;
        Wed, 10 Mar 2021 18:57:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D8FE8B78D;
        Wed, 10 Mar 2021 18:57:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VNdSc2g9C_Su; Wed, 10 Mar 2021 18:57:03 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E3168B77E;
        Wed, 10 Mar 2021 18:57:03 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 864C06756B; Wed, 10 Mar 2021 17:57:02 +0000 (UTC)
Message-Id: <2cdecb6e5a2fcee6c158d18dd254b71ec0e0da4d.1615398498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398498.git.christophe.leroy@csgroup.eu>
References: <cover.1615398498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/8] powerpc/uaccess: Move copy_mc_xxx() functions down
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:57:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_mc_xxx() functions are in the middle of raw_copy functions.

For clarity, move them out of the raw_copy functions block.

They are using access_ok, so they need to be after the general
functions in order to eventually allow the inclusion of
asm-generic/uaccess.h in some future.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 52 +++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 1c1d404514b1..479cb30eabd7 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -351,32 +351,6 @@ do {								\
 extern unsigned long __copy_tofrom_user(void __user *to,
 		const void __user *from, unsigned long size);
 
-#ifdef CONFIG_ARCH_HAS_COPY_MC
-unsigned long __must_check
-copy_mc_generic(void *to, const void *from, unsigned long size);
-
-static inline unsigned long __must_check
-copy_mc_to_kernel(void *to, const void *from, unsigned long size)
-{
-	return copy_mc_generic(to, from, size);
-}
-#define copy_mc_to_kernel copy_mc_to_kernel
-
-static inline unsigned long __must_check
-copy_mc_to_user(void __user *to, const void *from, unsigned long n)
-{
-	if (likely(check_copy_size(from, n, true))) {
-		if (access_ok(to, n)) {
-			allow_write_to_user(to, n);
-			n = copy_mc_generic((void *)to, from, n);
-			prevent_write_to_user(to, n);
-		}
-	}
-
-	return n;
-}
-#endif
-
 #ifdef __powerpc64__
 static inline unsigned long
 raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
@@ -433,6 +407,32 @@ static inline unsigned long clear_user(void __user *addr, unsigned long size)
 extern long strncpy_from_user(char *dst, const char __user *src, long count);
 extern __must_check long strnlen_user(const char __user *str, long n);
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+unsigned long __must_check
+copy_mc_generic(void *to, const void *from, unsigned long size);
+
+static inline unsigned long __must_check
+copy_mc_to_kernel(void *to, const void *from, unsigned long size)
+{
+	return copy_mc_generic(to, from, size);
+}
+#define copy_mc_to_kernel copy_mc_to_kernel
+
+static inline unsigned long __must_check
+copy_mc_to_user(void __user *to, const void *from, unsigned long n)
+{
+	if (likely(check_copy_size(from, n, true))) {
+		if (access_ok(to, n)) {
+			allow_write_to_user(to, n);
+			n = copy_mc_generic((void *)to, from, n);
+			prevent_write_to_user(to, n);
+		}
+	}
+
+	return n;
+}
+#endif
+
 extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 		unsigned size);
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-- 
2.25.0

