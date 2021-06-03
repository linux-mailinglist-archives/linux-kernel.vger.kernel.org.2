Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B9399DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFCJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:30:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29766 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFCJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:30:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwgZX2yWZzBCVY;
        Thu,  3 Jun 2021 11:29:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HAtdFCewVrBX; Thu,  3 Jun 2021 11:29:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwgZW1ZNSzBCVQ;
        Thu,  3 Jun 2021 11:29:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A0068B849;
        Thu,  3 Jun 2021 11:29:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jMiMNMyY7Yjv; Thu,  3 Jun 2021 11:29:07 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED2968B848;
        Thu,  3 Jun 2021 11:29:06 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CB2756493B; Thu,  3 Jun 2021 09:29:06 +0000 (UTC)
Message-Id: <da81837b452e8b9f1657b529b9c3050dc10b9770.1622712515.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4c54997edd3548fa54717915e7c6ebaf60f208c0.1622712515.git.christophe.leroy@csgroup.eu>
References: <4c54997edd3548fa54717915e7c6ebaf60f208c0.1622712515.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 5/6] powerpc/nohash: Remove DEBUG_CLAMP_LAST_CONTEXT
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 09:29:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_CLAMP_LAST_CONTEXT was there in the old days to reduce
number of contexts in order to ease debugging implementation
of context switching, but that's been quite stable during
years now.

As it is not user selectable, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/mmu_context.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 78369580b9ff..d9f590b9e636 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -21,7 +21,6 @@
  *     also clear mm->cpu_vm_mask bits when processes are migrated
  */
 
-//#define DEBUG_CLAMP_LAST_CONTEXT   31
 //#define DEBUG_HARDER
 
 /* We don't use DEBUG because it tends to be compiled in always nowadays
@@ -74,9 +73,7 @@ void *abatron_pteptrs[2];
  * -- BenH
  */
 #define FIRST_CONTEXT 1
-#ifdef DEBUG_CLAMP_LAST_CONTEXT
-#define LAST_CONTEXT DEBUG_CLAMP_LAST_CONTEXT
-#elif defined(CONFIG_PPC_8xx)
+#if defined(CONFIG_PPC_8xx)
 #define LAST_CONTEXT 16
 #elif defined(CONFIG_PPC_47x)
 #define LAST_CONTEXT 65535
-- 
2.25.0

