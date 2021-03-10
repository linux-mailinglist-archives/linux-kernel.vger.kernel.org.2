Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8F333C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhCJMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:10:43 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49184 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhCJMKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:10:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DwWB33MXvz9txr0;
        Wed, 10 Mar 2021 13:10:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 50zCdInSTEKv; Wed, 10 Mar 2021 13:10:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DwWB26L47z9txqx;
        Wed, 10 Mar 2021 13:10:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2DEB8B78A;
        Wed, 10 Mar 2021 13:10:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id L-0L8waMBKwJ; Wed, 10 Mar 2021 13:10:35 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 576EA8B77E;
        Wed, 10 Mar 2021 13:10:35 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EB1536755D; Wed, 10 Mar 2021 12:10:34 +0000 (UTC)
Message-Id: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Force inlining of cpu_has_feature() to avoid build
 failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 12:10:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code relies on constant folding of cpu_has_feature() based
on possible and always true values as defined per
CPU_FTRS_ALWAYS and CPU_FTRS_POSSIBLE.

Build failure is encountered with for instance
book3e_all_defconfig on kisskb in the AMDGPU driver which uses
cpu_has_feature(CPU_FTR_VSX_COMP) to decide whether calling
kernel_enable_vsx() or not.

The failure is due to cpu_has_feature() not being inlined with
that configuration with gcc 4.9.

In the same way as commit acdad8fb4a15 ("powerpc: Force inlining of
mmu_has_feature to fix build failure"), for inlining of
cpu_has_feature().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cpu_has_feature.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 7897d16e0990..727d4b321937 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -7,7 +7,7 @@
 #include <linux/bug.h>
 #include <asm/cputable.h>
 
-static inline bool early_cpu_has_feature(unsigned long feature)
+static __always_inline bool early_cpu_has_feature(unsigned long feature)
 {
 	return !!((CPU_FTRS_ALWAYS & feature) ||
 		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
@@ -46,7 +46,7 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 	return static_branch_likely(&cpu_feature_keys[i]);
 }
 #else
-static inline bool cpu_has_feature(unsigned long feature)
+static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	return early_cpu_has_feature(feature);
 }
-- 
2.25.0

