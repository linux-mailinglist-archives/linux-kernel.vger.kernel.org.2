Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4263345D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhCJR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:57:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23216 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232809AbhCJR5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfsm6yTHz9tyv7;
        Wed, 10 Mar 2021 18:57:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XlBJvvFHkHRe; Wed, 10 Mar 2021 18:57:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfsm55CNz9tytT;
        Wed, 10 Mar 2021 18:57:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D3728B78D;
        Wed, 10 Mar 2021 18:57:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6d3exhKAqAss; Wed, 10 Mar 2021 18:57:02 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A0178B77E;
        Wed, 10 Mar 2021 18:57:02 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 801CC6756B; Wed, 10 Mar 2021 17:57:01 +0000 (UTC)
Message-Id: <d8ec01fb22f33d87321451d5e5f01cb56dacaa39.1615398498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398498.git.christophe.leroy@csgroup.eu>
References: <cover.1615398498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/8] powerpc/uaccess: Swap clear_user() and __clear_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:57:01 +0000 (UTC)
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
index 2c09cff205ef..1c1d404514b1 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -414,21 +414,20 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 
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

