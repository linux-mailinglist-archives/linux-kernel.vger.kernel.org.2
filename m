Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A387426DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbhJHPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:44:43 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50989 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243304AbhJHPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:44:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsqD0Yxvz9sSx;
        Fri,  8 Oct 2021 17:41:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NC0z9TksW59j; Fri,  8 Oct 2021 17:41:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspy0XVDz9sSw;
        Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 068318B78B;
        Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YFm0mG-KS1Qj; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F29F48B79E;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198FempI1129652
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198FemIV1129651;
        Fri, 8 Oct 2021 17:40:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/16] powerpc/kuap: Add a generic intermediate layer
Date:   Fri,  8 Oct 2021 17:40:31 +0200
Message-Id: <d8d7de27f424c2e1977da80cf812a56d16da2ddd.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the following functions generic to all platforms.
- bad_kuap_fault()
- kuap_assert_locked()
- kuap_save_and_lock() (PPC32 only)
- kuap_kernel_restore()
- kuap_get_and_assert_locked()

And for all platforms except book3s/64
- allow_user_access()
- prevent_user_access()
- prevent_user_access_return()
- restore_user_access()

Prepend __ in front of the name of platform specific ones.

For now the generic just calls the platform specific, but
next patch will move redundant parts of specific functions
into the generic one.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 22 +++---
 arch/powerpc/include/asm/book3s/64/kup.h     | 10 ++-
 arch/powerpc/include/asm/kup.h               | 71 +++++++++++++++++---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 20 +++---
 4 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 0923dfcb04f7..8f04602dffff 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -80,7 +80,7 @@ static inline void kuap_unlock(unsigned long addr, bool ool)
 		kuap_unlock_all_ool();
 }
 
-static inline void kuap_save_and_lock(struct pt_regs *regs)
+static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	unsigned long kuap = current->thread.kuap;
 
@@ -99,7 +99,7 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 {
 }
 
-static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
 	if (kuap_is_disabled())
 		return;
@@ -117,7 +117,7 @@ static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 	kuap_unlock(regs->kuap, false);
 }
 
-static inline unsigned long kuap_get_and_assert_locked(void)
+static inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	unsigned long kuap = current->thread.kuap;
 
@@ -129,13 +129,13 @@ static inline unsigned long kuap_get_and_assert_locked(void)
 	return kuap;
 }
 
-static inline void kuap_assert_locked(void)
+static inline void __kuap_assert_locked(void)
 {
-	kuap_get_and_assert_locked();
+	__kuap_get_and_assert_locked();
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      u32 size, unsigned long dir)
+static __always_inline void __allow_user_access(void __user *to, const void __user *from,
+						u32 size, unsigned long dir)
 {
 	if (kuap_is_disabled())
 		return;
@@ -149,7 +149,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 	kuap_unlock_one((__force u32)to);
 }
 
-static __always_inline void prevent_user_access(unsigned long dir)
+static __always_inline void __prevent_user_access(unsigned long dir)
 {
 	u32 kuap = current->thread.kuap;
 
@@ -165,7 +165,7 @@ static __always_inline void prevent_user_access(unsigned long dir)
 	kuap_lock(kuap, true);
 }
 
-static inline unsigned long prevent_user_access_return(void)
+static inline unsigned long __prevent_user_access_return(void)
 {
 	unsigned long flags = current->thread.kuap;
 
@@ -180,7 +180,7 @@ static inline unsigned long prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void restore_user_access(unsigned long flags)
+static inline void __restore_user_access(unsigned long flags)
 {
 	if (kuap_is_disabled())
 		return;
@@ -192,7 +192,7 @@ static inline void restore_user_access(unsigned long flags)
 }
 
 static inline bool
-bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+__bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	unsigned long kuap = regs->kuap;
 
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 170339969b7c..03d61c5205a4 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -268,8 +268,7 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 	 */
 }
 
-static inline void kuap_kernel_restore(struct pt_regs *regs,
-					   unsigned long amr)
+static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
 {
 	if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
 		if (unlikely(regs->amr != amr)) {
@@ -287,7 +286,7 @@ static inline void kuap_kernel_restore(struct pt_regs *regs,
 	 */
 }
 
-static inline unsigned long kuap_get_and_assert_locked(void)
+static inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
 		unsigned long amr = mfspr(SPRN_AMR);
@@ -298,7 +297,7 @@ static inline unsigned long kuap_get_and_assert_locked(void)
 	return 0;
 }
 
-static inline void kuap_assert_locked(void)
+static inline void __kuap_assert_locked(void)
 {
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		WARN_ON_ONCE(mfspr(SPRN_AMR) != AMR_KUAP_BLOCKED);
@@ -339,8 +338,7 @@ static inline void set_kuap(unsigned long value)
 	isync();
 }
 
-static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
-				  bool is_write)
+static inline bool __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	if (!mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		return false;
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 34ff86e3686e..3dbd3f77b413 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -44,17 +44,17 @@ void setup_kuap(bool disabled);
 static inline void setup_kuap(bool disabled) { }
 
 static inline bool
-bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+__bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	return false;
 }
 
-static inline void kuap_assert_locked(void) { }
-static inline void kuap_save_and_lock(struct pt_regs *regs) { }
+static inline void __kuap_assert_locked(void) { }
+static inline void __kuap_save_and_lock(struct pt_regs *regs) { }
 static inline void kuap_user_restore(struct pt_regs *regs) { }
-static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
+static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
 
-static inline unsigned long kuap_get_and_assert_locked(void)
+static inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	return 0;
 }
@@ -65,14 +65,65 @@ static inline unsigned long kuap_get_and_assert_locked(void)
  * platforms.
  */
 #ifndef CONFIG_PPC_BOOK3S_64
-static inline void allow_user_access(void __user *to, const void __user *from,
-				     unsigned long size, unsigned long dir) { }
-static inline void prevent_user_access(unsigned long dir) { }
-static inline unsigned long prevent_user_access_return(void) { return 0UL; }
-static inline void restore_user_access(unsigned long flags) { }
+static inline void __allow_user_access(void __user *to, const void __user *from,
+				       unsigned long size, unsigned long dir) { }
+static inline void __prevent_user_access(unsigned long dir) { }
+static inline unsigned long __prevent_user_access_return(void) { return 0UL; }
+static inline void __restore_user_access(unsigned long flags) { }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif /* CONFIG_PPC_KUAP */
 
+static __always_inline bool
+bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+{
+	return __bad_kuap_fault(regs, address, is_write);
+}
+
+static __always_inline void kuap_assert_locked(void)
+{
+	__kuap_assert_locked();
+}
+
+#ifdef CONFIG_PPC32
+static __always_inline void kuap_save_and_lock(struct pt_regs *regs)
+{
+	__kuap_save_and_lock(regs);
+}
+#endif
+
+static __always_inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
+{
+	__kuap_kernel_restore(regs, amr);
+}
+
+static __always_inline unsigned long kuap_get_and_assert_locked(void)
+{
+	return __kuap_get_and_assert_locked();
+}
+
+#ifndef CONFIG_PPC_BOOK3S_64
+static __always_inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size, unsigned long dir)
+{
+	__allow_user_access(to, from, size, dir);
+}
+
+static __always_inline void prevent_user_access(unsigned long dir)
+{
+	__prevent_user_access(dir);
+}
+
+static __always_inline unsigned long prevent_user_access_return(void)
+{
+	return __prevent_user_access_return();
+}
+
+static __always_inline void restore_user_access(unsigned long flags)
+{
+	__restore_user_access(flags);
+}
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 static __always_inline void setup_kup(void)
 {
 	setup_kuep(disable_kuep);
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 882a0bc7887a..a5db84164afd 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -20,7 +20,7 @@ static __always_inline bool kuap_is_disabled(void)
 	return static_branch_unlikely(&disable_kuap_key);
 }
 
-static inline void kuap_save_and_lock(struct pt_regs *regs)
+static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	if (kuap_is_disabled())
 		return;
@@ -33,7 +33,7 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 {
 }
 
-static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
 	if (kuap_is_disabled())
 		return;
@@ -41,7 +41,7 @@ static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 	mtspr(SPRN_MD_AP, regs->kuap);
 }
 
-static inline unsigned long kuap_get_and_assert_locked(void)
+static inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	unsigned long kuap;
 
@@ -56,14 +56,14 @@ static inline unsigned long kuap_get_and_assert_locked(void)
 	return kuap;
 }
 
-static inline void kuap_assert_locked(void)
+static inline void __kuap_assert_locked(void)
 {
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && !kuap_is_disabled())
 		kuap_get_and_assert_locked();
 }
 
-static inline void allow_user_access(void __user *to, const void __user *from,
-				     unsigned long size, unsigned long dir)
+static inline void __allow_user_access(void __user *to, const void __user *from,
+				       unsigned long size, unsigned long dir)
 {
 	if (kuap_is_disabled())
 		return;
@@ -71,7 +71,7 @@ static inline void allow_user_access(void __user *to, const void __user *from,
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
 
-static inline void prevent_user_access(unsigned long dir)
+static inline void __prevent_user_access(unsigned long dir)
 {
 	if (kuap_is_disabled())
 		return;
@@ -79,7 +79,7 @@ static inline void prevent_user_access(unsigned long dir)
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 
-static inline unsigned long prevent_user_access_return(void)
+static inline unsigned long __prevent_user_access_return(void)
 {
 	unsigned long flags;
 
@@ -93,7 +93,7 @@ static inline unsigned long prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void restore_user_access(unsigned long flags)
+static inline void __restore_user_access(unsigned long flags)
 {
 	if (kuap_is_disabled())
 		return;
@@ -102,7 +102,7 @@ static inline void restore_user_access(unsigned long flags)
 }
 
 static inline bool
-bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+__bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	if (kuap_is_disabled())
 		return false;
-- 
2.31.1

