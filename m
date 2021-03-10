Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852D93345D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhCJR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:57:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30178 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233392AbhCJR5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:07 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfsr5xqrz9twh2;
        Wed, 10 Mar 2021 18:57:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OFJoXMI6JhO8; Wed, 10 Mar 2021 18:57:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfsr4tG8z9v0W3;
        Wed, 10 Mar 2021 18:57:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 87A1B8B78D;
        Wed, 10 Mar 2021 18:57:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ywr1m5Sj8eQn; Wed, 10 Mar 2021 18:57:06 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B7188B77E;
        Wed, 10 Mar 2021 18:57:06 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9ED896756B; Wed, 10 Mar 2021 17:57:05 +0000 (UTC)
Message-Id: <2dee286d2d6dc9a27d99e31ac564bad4fae2cb49.1615398498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398498.git.christophe.leroy@csgroup.eu>
References: <cover.1615398498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 6/8] powerpc/net: Switch csum_and_copy_{to/from}_user to
 user_access block
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:57:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use user_access_begin() instead of the
might_sleep/access_ok/allow_access sequence.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/checksum_wrappers.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index b895166afc82..f3999cbb2fcc 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -16,16 +16,12 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 {
 	__wsum csum;
 
-	might_sleep();
-
-	if (unlikely(!access_ok(src, len)))
+	if (unlikely(!user_read_access_begin(src, len)))
 		return 0;
 
-	allow_read_from_user(src, len);
-
 	csum = csum_partial_copy_generic((void __force *)src, dst, len);
 
-	prevent_read_from_user(src, len);
+	user_read_access_end();
 	return csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
@@ -34,15 +30,12 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
 	__wsum csum;
 
-	might_sleep();
-	if (unlikely(!access_ok(dst, len)))
+	if (unlikely(!user_write_access_begin(dst, len)))
 		return 0;
 
-	allow_write_to_user(dst, len);
-
 	csum = csum_partial_copy_generic(src, (void __force *)dst, len);
 
-	prevent_write_to_user(dst, len);
+	user_write_access_end();
 	return csum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
-- 
2.25.0

