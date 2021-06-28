Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497493B5950
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhF1G6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:58:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62519 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhF1G6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:58:45 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GCz0c3JJxzBD3H;
        Mon, 28 Jun 2021 08:56:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mGG8CusSe2ok; Mon, 28 Jun 2021 08:56:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GCz0Y0YjCzBD2H;
        Mon, 28 Jun 2021 08:56:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BDE798B781;
        Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PK5cYC-pTAkN; Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F0E78B77F;
        Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8A36E64BE3; Mon, 28 Jun 2021 06:56:12 +0000 (UTC)
Message-Id: <b9c2a9add0f11754539e24c6f421bd2009327c36.1624863323.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/4xx: Fix setup_kuep() on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jun 2021 06:56:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SMP, setup_kuep() is also called from start_secondary() since
commit 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").

start_secondary() is not an __init function.

Remove the __init marker from setup_kuep() and bail out when
not caller on the first CPU as the work is already done.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 10248dcba120 ("powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)")
Fixes: 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/44x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
index 7da6d1e9fc9b..20c18bd5b9a0 100644
--- a/arch/powerpc/mm/nohash/44x.c
+++ b/arch/powerpc/mm/nohash/44x.c
@@ -241,8 +241,11 @@ void __init mmu_init_secondary(int cpu)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC_KUEP
-void __init setup_kuep(bool disabled)
+void setup_kuep(bool disabled)
 {
+	if (smp_processor_id() != boot_cpuid)
+		return;
+
 	if (disabled)
 		patch_instruction_site(&patch__tlb_44x_kuep, ppc_inst(PPC_RAW_NOP()));
 	else
-- 
2.25.0

