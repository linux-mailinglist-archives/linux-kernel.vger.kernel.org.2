Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430D23254DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhBYRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:53:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55971 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbhBYRvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:51:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLF3zHqz9v1B1;
        Thu, 25 Feb 2021 18:50:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id N_gD3E-k-nUz; Thu, 25 Feb 2021 18:50:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLF380Dz9v19y;
        Thu, 25 Feb 2021 18:50:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 435E28B895;
        Thu, 25 Feb 2021 18:50:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xzWfidmHlRZR; Thu, 25 Feb 2021 18:50:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E72F8B88B;
        Thu, 25 Feb 2021 18:50:31 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DF2EA67442; Thu, 25 Feb 2021 17:50:30 +0000 (UTC)
Message-Id: <e0538c71167bd90224a8727fea9ed5b75612e2d7.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 01/15] powerpc/uaccess: Remove __get_user_allowed() and
 unsafe_op_wrap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two macros have only one user which is unsafe_get_user().

Put everything in one place and remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 78e2a3990eab..8cbf3e3874f1 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -53,9 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-#define __get_user_allowed(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
-
 #define __get_user_inatomic(x, ptr) \
 	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
 #define __put_user_inatomic(x, ptr) \
@@ -482,8 +479,11 @@ user_write_access_begin(const void __user *ptr, size_t len)
 #define user_write_access_begin	user_write_access_begin
 #define user_write_access_end		prevent_current_write_to_user
 
-#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
-#define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
+#define unsafe_get_user(x, p, e) do {					\
+	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
+		goto e;							\
+} while (0)
+
 #define unsafe_put_user(x, p, e) \
 	__unsafe_put_user_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
 
-- 
2.25.0

