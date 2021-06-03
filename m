Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABD399D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:15:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41211 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:15:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwgDy3dCCzBCBn;
        Thu,  3 Jun 2021 11:13:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wukhei5NwqNx; Thu,  3 Jun 2021 11:13:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwgDy2kMSzBCBP;
        Thu,  3 Jun 2021 11:13:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B2FB8B84B;
        Thu,  3 Jun 2021 11:13:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2VCQW90XFg8F; Thu,  3 Jun 2021 11:13:54 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F41CE8B767;
        Thu,  3 Jun 2021 11:13:53 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2206B64931; Thu,  3 Jun 2021 09:13:54 +0000 (UTC)
Message-Id: <8479a862e165a57a855292d47e24c259a578f5a0.1622711627.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/kuap: Force inlining of all first level KUAP helpers.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 09:13:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All KUAP helpers defined in asm/kup.h are single line functions
that should be inlined. But on book3s/32 build, we get many
instances of <prevent_write_to_user.constprop.0>.

Force inlining of those helpers.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Was previously part of a series, resending standalone as it really is independant.
---
 arch/powerpc/include/asm/kup.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ec96232529ac..a35ded8bedcd 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -96,51 +96,51 @@ static __always_inline void setup_kup(void)
 	setup_kuap(disable_kuap);
 }
 
-static inline void allow_read_from_user(const void __user *from, unsigned long size)
+static __always_inline void allow_read_from_user(const void __user *from, unsigned long size)
 {
 	barrier_nospec();
 	allow_user_access(NULL, from, size, KUAP_READ);
 }
 
-static inline void allow_write_to_user(void __user *to, unsigned long size)
+static __always_inline void allow_write_to_user(void __user *to, unsigned long size)
 {
 	allow_user_access(to, NULL, size, KUAP_WRITE);
 }
 
-static inline void allow_read_write_user(void __user *to, const void __user *from,
-					 unsigned long size)
+static __always_inline void allow_read_write_user(void __user *to, const void __user *from,
+						  unsigned long size)
 {
 	barrier_nospec();
 	allow_user_access(to, from, size, KUAP_READ_WRITE);
 }
 
-static inline void prevent_read_from_user(const void __user *from, unsigned long size)
+static __always_inline void prevent_read_from_user(const void __user *from, unsigned long size)
 {
 	prevent_user_access(NULL, from, size, KUAP_READ);
 }
 
-static inline void prevent_write_to_user(void __user *to, unsigned long size)
+static __always_inline void prevent_write_to_user(void __user *to, unsigned long size)
 {
 	prevent_user_access(to, NULL, size, KUAP_WRITE);
 }
 
-static inline void prevent_read_write_user(void __user *to, const void __user *from,
-					   unsigned long size)
+static __always_inline void prevent_read_write_user(void __user *to, const void __user *from,
+						    unsigned long size)
 {
 	prevent_user_access(to, from, size, KUAP_READ_WRITE);
 }
 
-static inline void prevent_current_access_user(void)
+static __always_inline void prevent_current_access_user(void)
 {
 	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
 }
 
-static inline void prevent_current_read_from_user(void)
+static __always_inline void prevent_current_read_from_user(void)
 {
 	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
 }
 
-static inline void prevent_current_write_to_user(void)
+static __always_inline void prevent_current_write_to_user(void)
 {
 	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
 }
-- 
2.25.0

