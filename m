Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB003399CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFCIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:43:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7043 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhFCInh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:43:37 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwfWq3wCGzBC5t;
        Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KGifkoVJYrlT; Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwfWq32frzBC5Z;
        Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DAA98B848;
        Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ItFa-XmzSvDZ; Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BD838B767;
        Thu,  3 Jun 2021 10:41:43 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DB86964BD2; Thu,  3 Jun 2021 08:41:42 +0000 (UTC)
Message-Id: <7745a2c3a08ec46302920a3f48d1cb9b5469dbbb.1622708530.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1622708530.git.christophe.leroy@csgroup.eu>
References: <cover.1622708530.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 07/12] powerpc/32s: Allow disabling KUEP at boot time
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 08:41:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 uses MMU features to enable/disable KUEP at boot time.
But feature fixups are applied way too early on PPC32.

Now that all KUEP related actions are in C following the
conversion of KUEP initial setup and context switch in C,
static branches can be used to enable/disable KUEP.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  6 +++++-
 arch/powerpc/mm/book3s32/kuep.c          | 11 +++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 618ffc8e4ee9..2854d970dabe 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -7,6 +7,10 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/jump_label.h>
+
+extern struct static_key_false disable_kuep_key;
+
 static __always_inline bool kuap_is_disabled(void)
 {
 	return !IS_ENABLED(CONFIG_PPC_KUAP);
@@ -14,7 +18,7 @@ static __always_inline bool kuap_is_disabled(void)
 
 static __always_inline bool kuep_is_disabled(void)
 {
-	return !IS_ENABLED(CONFIG_PPC_KUEP);
+	return !IS_ENABLED(CONFIG_PPC_KUEP) || static_branch_unlikely(&disable_kuep_key);
 }
 
 static inline void kuep_lock(void)
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index 3147e2edcf63..3f6eb6e23fca 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -3,15 +3,18 @@
 #include <asm/kup.h>
 #include <asm/smp.h>
 
+struct static_key_false disable_kuep_key;
+
 void __init setup_kuep(bool disabled)
 {
-	kuep_lock();
+	if (!disabled)
+		kuep_lock();
 
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-	pr_info("Activating Kernel Userspace Execution Prevention\n");
-
 	if (disabled)
-		pr_warn("KUEP cannot be disabled yet on 6xx when compiled in\n");
+		static_branch_enable(&disable_kuep_key);
+	else
+		pr_info("Activating Kernel Userspace Execution Prevention\n");
 }
-- 
2.25.0

