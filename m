Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E723D8842
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhG1Gvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:51:48 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:55169
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233111AbhG1Gvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Tsk7dHdWsL
        EbmV3FNfViCC4F9wAAdUC2y4rEc+9Pyjk=; b=QLdJCAL5t4H826FNnhHMNNB7cV
        74QntP1txnNwaAs+owBLYRRdnzNCaEoPI/k1mzQkoM9jSp6uO3/U9q4YWpWxW+DT
        2W0EzXZuIdkoIxyuQObIm91HTuK9dm3g7HTVPjDfmJXPzFJkHdveFpSC65jCsPol
        ouo7rLJbcmPetyzx4=
Received: from lexp.lan (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogDX3YXH_QBhrklqAQ--.51338S2;
        Wed, 28 Jul 2021 14:48:41 +0800 (CST)
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jiashuo Liang <liangjs@pku.edu.cn>
Subject: [PATCH] mm/pkeys: Remove unused parameter in arch_set_user_pkey_access
Date:   Wed, 28 Jul 2021 14:47:04 +0800
Message-Id: <20210728064704.268879-1-liangjs@pku.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogDX3YXH_QBhrklqAQ--.51338S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryDtryUur4kWF43JrWkZwb_yoWxJw17pF
        9Fkw1vgrW7Ga4jqFyDK397ZFy3Cry0gr1a9ryxK343ZFnFvw1rJF1rZr42kr92yrykG3WS
        kws2gFn5Zr4qgaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVAFwVW8AwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUb2Nt3UUUUU==
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwEQBVPy7sYrGgABsu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_set_user_pkey_access function never uses its first parameter
(struct task_struct *tsk).  It is only able to set the pkey permissions for
the current task as implemented, and existing kernel code only passes
"current" to arch_set_user_pkey_access.  So remove the ambiguous parameter
to make the code clean.

Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
---
 arch/powerpc/include/asm/pkeys.h |  8 +++-----
 arch/powerpc/mm/book3s64/pkeys.c |  3 +--
 arch/x86/include/asm/pkeys.h     | 12 ++++--------
 arch/x86/kernel/fpu/xstate.c     |  3 +--
 arch/x86/mm/pkeys.c              |  3 +--
 include/linux/pkeys.h            |  3 +--
 mm/mprotect.c                    |  2 +-
 7 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 59a2c7dbc78f..e905b2ab31e2 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -143,10 +143,8 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-				       unsigned long init_val);
-static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-					    unsigned long init_val)
+extern int __arch_set_user_pkey_access(int pkey, unsigned long init_val);
+static inline int arch_set_user_pkey_access(int pkey, unsigned long init_val)
 {
 	if (!mmu_has_feature(MMU_FTR_PKEY))
 		return -EINVAL;
@@ -160,7 +158,7 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	if (pkey == 0)
 		return init_val ? -EINVAL : 0;
 
-	return __arch_set_user_pkey_access(tsk, pkey, init_val);
+	return __arch_set_user_pkey_access(pkey, init_val);
 }
 
 static inline bool arch_pkeys_enabled(void)
diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index a2d9ad138709..dc77c0a27291 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -333,8 +333,7 @@ static inline void init_iamr(int pkey, u8 init_bits)
  * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
  * specified in @init_val.
  */
-int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-				unsigned long init_val)
+int __arch_set_user_pkey_access(int pkey, unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
 	u64 new_iamr_bits = 0x0ul;
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 5c7bcaa79623..26d872bdee49 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -11,8 +11,7 @@
  */
 #define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
+extern int arch_set_user_pkey_access(int pkey, unsigned long init_val);
 
 static inline bool arch_pkeys_enabled(void)
 {
@@ -43,8 +42,7 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
+extern int __arch_set_user_pkey_access(int pkey, unsigned long init_val);
 
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | VM_PKEY_BIT3)
 
@@ -120,10 +118,8 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
+extern int arch_set_user_pkey_access(int pkey, unsigned long init_val);
+extern int __arch_set_user_pkey_access(int pkey, unsigned long init_val);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..565de4a49c0a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -912,8 +912,7 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * This will go out and modify PKRU register to set the access
  * rights for @pkey to @init_val.
  */
-int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-			      unsigned long init_val)
+int arch_set_user_pkey_access(int pkey, unsigned long init_val)
 {
 	u32 old_pkru, new_pkru_bits = 0;
 	int pkey_shift;
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e44e938885b7..fafc10ea7cf1 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -42,8 +42,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	 * Set up PKRU so that it denies access for everything
 	 * other than execution.
 	 */
-	ret = arch_set_user_pkey_access(current, execute_only_pkey,
-			PKEY_DISABLE_ACCESS);
+	ret = arch_set_user_pkey_access(execute_only_pkey, PKEY_DISABLE_ACCESS);
 	/*
 	 * If the PKRU-set operation failed somehow, just return
 	 * 0 and effectively disable execute-only support.
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 6beb26b7151d..c8a5d96ab461 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -33,8 +33,7 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return -EINVAL;
 }
 
-static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-			unsigned long init_val)
+static inline int arch_set_user_pkey_access(int pkey, unsigned long init_val)
 {
 	return 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..fe2c4755d833 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -689,7 +689,7 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 	if (pkey == -1)
 		goto out;
 
-	ret = arch_set_user_pkey_access(current, pkey, init_val);
+	ret = arch_set_user_pkey_access(pkey, init_val);
 	if (ret) {
 		mm_pkey_free(current->mm, pkey);
 		goto out;
-- 
2.32.0

