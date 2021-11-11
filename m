Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD744D0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhKKESi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhKKESG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206DC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w132-20020a25c78a000000b005c27f083240so7401166ybe.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ntofycQrrKyjdZ/xevrvdrst/0Q1NzSqv6fz5tankak=;
        b=gceKUjWvmF0+ZwI5jMjAripAyefr+NcGjHG86mS+1X6ZgzBsJ0GMEUgo9nU4tqlh3C
         UJ/fHxjwFm5IKc3p0UJSegM0TQxhMhhTQgLsF1TDT+8fbw0TEr/O6UMGTNlrJWUmyBww
         VNMzFv90YMr4eAnZtZlqUyX0WGxs3Z95iCQ/QvuxB3Ab5yPKHwGBLUh2usNo7gC1fkCN
         BUCt6g0djIUO7OtS6NeFzH4mmLeJHgFqgZ9H5EFPcCUC7SZXoexdJc2s2v4P7dkGrqBh
         m9E53R06OYKnkBTestGmeBmAcrQ4uFuoomgIzUtIWx4mqrRF2RL9QdcaYhT+2cwjIIN5
         Pb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ntofycQrrKyjdZ/xevrvdrst/0Q1NzSqv6fz5tankak=;
        b=ZOr/IlA2wpYkmC+xUHM0F1MN6V2UYbNgmY5IotxhmASIg5KwZY8BTFsM5HqoexDMSH
         opM0EXGJp8dqjjF0iF6nDvq3o6hnSZ1CRIdbva2GKdG0XMW9e9euS31b0wWKoEJN2Vfo
         4dMJnvCCvKmCEIXPyrr7aaWwi2OlSHKUeN4iQbYhlB4xVTJrWQpfhkUk0SJgs2JYm2S1
         2Fp53AwNeu4fZjbJIjHfwvTPfkymOScB4B8/Ue45jzadwch0yPLuarDvD7t7NKLBp7/T
         IoKapiCYIDyBdQ3yBhwrNwsVapSQXQ6GYdgc3YEsqEtpRVJWRFh5l9nks8DQCY/ea5Es
         pAJA==
X-Gm-Message-State: AOAM53283pX43GvAy5nKYJ+nddyCM6N6I4wcuCWenq7Ql4dINLAzgZka
        MlHdtFKiJKWiL+xuBWDSeEhDM6VPkF4=
X-Google-Smtp-Source: ABdhPJw2SP0Ijj5EgGAkmYtCyDaBhEy/yk5UVGKior7fvF1duxzSSTOoATf86iwUvsUBbZWLbs/UMzufsjI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a25:5954:: with SMTP id n81mr4721722ybb.435.1636604116986;
 Wed, 10 Nov 2021 20:15:16 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:01 -0700
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
Message-Id: <20211111041510.402534-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 01/10] mm: x86, arm64: add arch_has_hw_pte_young()
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures automatically set the accessed bit in PTEs, e.g.,
x86 and arm64 v8.2. On architectures that do not have this capability,
clearing the accessed bit in a PTE triggers a page fault following the
TLB miss of this PTE.

Being aware of this capability can help make better decisions, i.e.,
whether to limit the size of each batch of PTEs and the burst of
batches when clearing the accessed bit.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/pgtable.h    | 13 ++++++++-----
 arch/arm64/kernel/cpufeature.c      | 10 ++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 arch/x86/include/asm/pgtable.h      |  6 +++---
 include/linux/pgtable.h             | 13 +++++++++++++
 mm/memory.c                         | 14 +-------------
 7 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ef6be92b1921..99518b4b2a9e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -779,6 +779,11 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
+static inline bool system_has_hw_af(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && cpus_have_const_cap(ARM64_HW_AF);
+}
+
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index dfa76afa0ccf..880ae658a69a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -993,13 +993,16 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  * page after fork() + CoW for pfn mappings. We don't always have a
  * hardware-managed access flag on arm64.
  */
-static inline bool arch_faults_on_old_pte(void)
+static inline bool arch_has_hw_pte_young(bool local)
 {
-	WARN_ON(preemptible());
+	if (local) {
+		WARN_ON(preemptible());
+		return cpu_has_hw_af();
+	}
 
-	return !cpu_has_hw_af();
+	return system_has_hw_af();
 }
-#define arch_faults_on_old_pte		arch_faults_on_old_pte
+#define arch_has_hw_pte_young		arch_has_hw_pte_young
 
 /*
  * Experimentally, it's cheap to set the access flag in hardware and we
@@ -1007,7 +1010,7 @@ static inline bool arch_faults_on_old_pte(void)
  */
 static inline bool arch_wants_old_prefaulted_pte(void)
 {
-	return !arch_faults_on_old_pte();
+	return arch_has_hw_pte_young(true);
 }
 #define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ec7036ef7e1..940615d33845 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2157,6 +2157,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
+	{
+		.desc = "Hardware update of the Access flag",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HW_AF,
+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
+		.min_field_value = 1,
+		.matches = has_cpuid_feature,
+	},
 #endif
 	{
 		.desc = "CRC32 instructions",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 49305c2e6dfd..d52f50671e60 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -35,6 +35,7 @@ HAS_STAGE2_FWB
 HAS_SYSREG_GIC_CPUIF
 HAS_TLB_RANGE
 HAS_VIRT_HOST_EXTN
+HW_AF
 HW_DBM
 KVM_PROTECTED_MODE
 MISMATCHED_CACHE_TYPE
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..c60b16f8b741 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1397,10 +1397,10 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
 
-#define arch_faults_on_old_pte arch_faults_on_old_pte
-static inline bool arch_faults_on_old_pte(void)
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(bool local)
 {
-	return false;
+	return true;
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..a64c6124c137 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,19 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef arch_has_hw_pte_young
+/*
+ * Return whether the accessed bit is supported by the local CPU or all CPUs.
+ *
+ * Those arches which have hw access flag feature need to implement their own
+ * helper. By default, "false" means pagefault will be hit on old pte.
+ */
+static inline bool arch_has_hw_pte_young(bool local)
+{
+	return false;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index c52be6d6b605..012fad94bc77 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -121,18 +121,6 @@ int randomize_va_space __read_mostly =
 					2;
 #endif
 
-#ifndef arch_faults_on_old_pte
-static inline bool arch_faults_on_old_pte(void)
-{
-	/*
-	 * Those arches which don't have hw access flag feature need to
-	 * implement their own helper. By default, "true" means pagefault
-	 * will be hit on old pte.
-	 */
-	return true;
-}
-#endif
-
 #ifndef arch_wants_old_prefaulted_pte
 static inline bool arch_wants_old_prefaulted_pte(void)
 {
@@ -2769,7 +2757,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young(true) && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-- 
2.34.0.rc0.344.g81b53c2807-goog

