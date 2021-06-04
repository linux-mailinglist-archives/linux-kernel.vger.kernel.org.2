Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5575739B19D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhFDEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:51:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20153 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhFDEvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:51:13 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fx9KL701mzBCV3;
        Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6CNN0Kx6X-RP; Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fx9KL66j6zBCTp;
        Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFB078B863;
        Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZBiW63Y-2ydM; Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 530FE8B764;
        Fri,  4 Jun 2021 06:49:26 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D284764C47; Fri,  4 Jun 2021 04:49:25 +0000 (UTC)
Message-Id: <3dca510ce555335261a47c4799167da698f569c0.1622782111.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc/8xx: Allow disabling KUAP at boot time
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Jun 2021 04:49:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 uses MMU features to enable/disable KUAP at boot time.
But feature fixups are applied way too early on PPC32.

But since commit c16728835eec ("powerpc/32: Manage KUAP in C"),
all KUAP is in C so it is now possible to use static branches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Added missing linux/jump_label.h which leads to build failure when CONFIG_JUMP_LABEL_FEATURE_CHECKS is not selected
---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 43 ++++++++++++++++++--
 arch/powerpc/mm/nohash/8xx.c                 | 10 +++--
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 295ef5639609..f6a3c1935e75 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -9,10 +9,22 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/jump_label.h>
+
 #include <asm/reg.h>
 
+extern struct static_key_false disable_kuap_key;
+
+static __always_inline bool kuap_is_disabled(void)
+{
+	return static_branch_unlikely(&disable_kuap_key);
+}
+
 static inline void kuap_save_and_lock(struct pt_regs *regs)
 {
+	if (kuap_is_disabled())
+		return;
+
 	regs->kuap = mfspr(SPRN_MD_AP);
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
@@ -23,12 +35,20 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 
 static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
+	if (kuap_is_disabled())
+		return;
+
 	mtspr(SPRN_MD_AP, regs->kuap);
 }
 
 static inline unsigned long kuap_get_and_assert_locked(void)
 {
-	unsigned long kuap = mfspr(SPRN_MD_AP);
+	unsigned long kuap;
+
+	if (kuap_is_disabled())
+		return MD_APG_INIT;
+
+	kuap = mfspr(SPRN_MD_AP);
 
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
 		WARN_ON_ONCE(kuap >> 16 != MD_APG_KUAP >> 16);
@@ -38,25 +58,36 @@ static inline unsigned long kuap_get_and_assert_locked(void)
 
 static inline void kuap_assert_locked(void)
 {
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && !kuap_is_disabled())
 		kuap_get_and_assert_locked();
 }
 
 static inline void allow_user_access(void __user *to, const void __user *from,
 				     unsigned long size, unsigned long dir)
 {
+	if (kuap_is_disabled())
+		return;
+
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
 
 static inline void prevent_user_access(void __user *to, const void __user *from,
 				       unsigned long size, unsigned long dir)
 {
+	if (kuap_is_disabled())
+		return;
+
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 
 static inline unsigned long prevent_user_access_return(void)
 {
-	unsigned long flags = mfspr(SPRN_MD_AP);
+	unsigned long flags;
+
+	if (kuap_is_disabled())
+		return MD_APG_INIT;
+
+	flags = mfspr(SPRN_MD_AP);
 
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 
@@ -65,12 +96,18 @@ static inline unsigned long prevent_user_access_return(void)
 
 static inline void restore_user_access(unsigned long flags)
 {
+	if (kuap_is_disabled())
+		return;
+
 	mtspr(SPRN_MD_AP, flags);
 }
 
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
+	if (kuap_is_disabled())
+		return false;
+
 	return !((regs->kuap ^ MD_APG_KUAP) & 0xff000000);
 }
 
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 71bfdbedacee..a8d44e9342f3 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -256,12 +256,16 @@ void __init setup_kuep(bool disabled)
 #endif
 
 #ifdef CONFIG_PPC_KUAP
+struct static_key_false disable_kuap_key;
+
 void __init setup_kuap(bool disabled)
 {
-	pr_info("Activating Kernel Userspace Access Protection\n");
+	if (disabled) {
+		static_branch_enable(&disable_kuap_key);
+		return;
+	}
 
-	if (disabled)
-		pr_warn("KUAP cannot be disabled yet on 8xx when compiled in\n");
+	pr_info("Activating Kernel Userspace Access Protection\n");
 
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
-- 
2.25.0

