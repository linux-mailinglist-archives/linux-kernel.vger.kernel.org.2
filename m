Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687763891AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbhESOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:45:40 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35235 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354545AbhESOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:45:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FlbG93L2tz9sWT;
        Wed, 19 May 2021 16:43:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T_PZjOGCd8yp; Wed, 19 May 2021 16:43:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbG92QRyz9sWQ;
        Wed, 19 May 2021 16:43:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1763F8B7F5;
        Wed, 19 May 2021 16:43:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9uqlt0qv50it; Wed, 19 May 2021 16:43:29 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EC838B7E0;
        Wed, 19 May 2021 16:43:28 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6CAE564C3A; Wed, 19 May 2021 14:43:28 +0000 (UTC)
Message-Id: <0320e5b41a794fd456ab8c5993bbfadcf9e1d8b4.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 01/12] powerpc/inst: Fix sparse detection on
 get_user_instr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 May 2021 14:43:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_instr() lacks sparse detection for the __user tag.

This is because __gui_ptr is assigned with a cast.

Fix that by adding a __chk_user_ptr()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 268d3bd073c8..887ef150fdda 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -12,6 +12,8 @@
 	unsigned long __gui_ptr = (unsigned long)ptr;			\
 	struct ppc_inst __gui_inst;					\
 	unsigned int __prefix, __suffix;				\
+									\
+	__chk_user_ptr(ptr);						\
 	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
 	if (__gui_ret == 0) {						\
 		if ((__prefix >> 26) == OP_PREFIX) {			\
@@ -29,7 +31,10 @@
 })
 #else /* !CONFIG_PPC64 */
 #define ___get_user_instr(gu_op, dest, ptr)				\
-	gu_op((dest).val, (u32 __user *)(ptr))
+({									\
+	__chk_user_ptr(ptr);						\
+	gu_op((dest).val, (u32 __user *)(ptr));				\
+})
 #endif /* CONFIG_PPC64 */
 
 #define get_user_instr(x, ptr) \
-- 
2.25.0

