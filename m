Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700A3FFED7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbhICLTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:19:47 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51003 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348913AbhICLTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1FfR0HRVz9sTB;
        Fri,  3 Sep 2021 13:18:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JNlPXwFlFMcy; Fri,  3 Sep 2021 13:18:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1FfQ6W00z9sT0;
        Fri,  3 Sep 2021 13:18:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAE788B8E3;
        Fri,  3 Sep 2021 13:18:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Zo4FWRz5dsEJ; Fri,  3 Sep 2021 13:18:38 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68FA38B764;
        Fri,  3 Sep 2021 13:18:38 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 12EE963D74; Fri,  3 Sep 2021 11:18:38 +0000 (UTC)
Message-Id: <803779fffb4ee0801746b2173d37cea3b273f821.1630667612.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 03/11] powerpc/machdep: Remove
 CONFIG_PPC_HAS_FEATURE_CALLS
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 11:18:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last user was removed by commit 7bbd827750e6 ("[PATCH] ppc64: very
basic desktop g5 sound support").

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a68311077d32..f6f8344f4a0c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -10,11 +10,6 @@
 
 #include <asm/setup.h>
 
-/* We export this macro for external modules like Alsa to know if
- * ppc_md.feature_call is implemented or not
- */
-#define CONFIG_PPC_HAS_FEATURE_CALLS
-
 struct pt_regs;
 struct pci_bus;	
 struct device_node;
-- 
2.25.0

