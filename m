Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9AC309964
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhAaAVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhAaAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63564C0617AB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i7so9422614pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGLhiAHsqIvmXZ1nOh8kB6ci+ExzudIBHsQKMIKw3zY=;
        b=WWmvgw8FNP+oFRjvxB4gRpb3luKsDHJi+ebFm9S0DRJNzh4HfnNBs0LeKmQCHvfiO6
         lJ/jpEry1B1JZDgva43Q1cKc/PCcQTegEoltkzdXLc9RnHqhacDyd6cSj3lIZVE6Opsf
         0BbeAGGxOW7/UQ557GLE13AZUeAWjuWJpncHWVlB8/PD4QXafrak77JmO5C69EztwOkc
         qgCW+8V9rduo0yaiMPg4t4d/pk0csLQTyhZdCRVv4+P7moeO49xDW1OysCTd65ABNIpe
         R6MiAnw2SguKkXpKt+MsESM2salvhwef9xoJWugPH1CbcGSguAFKCKGp5wTeYkMsjg7x
         vTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGLhiAHsqIvmXZ1nOh8kB6ci+ExzudIBHsQKMIKw3zY=;
        b=YidnQGLxW40eSf+oQlxDZZO8fNkrcJMFtN8DqmyiPNhTUt3euEeNtioRgn6oSIN+rb
         y/7Pv8WKg3QQIuPMUqCxjEG5y2L8xr+RbNUbuf4m75OY9A96xjLDg+l7LQEW+NFWqozC
         LcrcqgBW3MAeFYK7qGZYRgdYsxU5+0jRbAjVQE/Nf4/qTJnyd/A1nBJrypyPkIkH6kw7
         1IuhKz+EeLZ+4K6hgyhL0rUkWO9yqGp4qt6OxUyDPBHa9jEm6f7wIPZOnd3vvdTRwaQB
         +Vnw4yPI5MHUtC0IDMMrktUcudm9wZEXRqZq7VDuiYAgu76iR5vOQyXZTa9V8a2R8kOW
         US4g==
X-Gm-Message-State: AOAM533V+NdL1Fo12t7u7gvnezc/Qpm7OkrLNEbJYsfN6TKCdv1ow6dc
        3dhZfaYWFj4fEtaOscOA0VE=
X-Google-Smtp-Source: ABdhPJwGHu1W7bT6MFMn88oqPzaikRtCmjfI/E7R7/8LUIS/ayIBUGVxFUogCBOMo/X9ATYigHvkfw==
X-Received: by 2002:a63:4301:: with SMTP id q1mr10636974pga.430.1612052189837;
        Sat, 30 Jan 2021 16:16:29 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:29 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: [RFC 18/20] mm: make mm_cpumask() volatile
Date:   Sat, 30 Jan 2021 16:11:30 -0800
Message-Id: <20210131001132.3368247-19-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

mm_cpumask() is volatile: a bit might be turned on or off at any given
moment, and it is not protected by any lock. While the kernel coding
guidelines are very prohibitive against the use of volatile, not marking
mm_cpumask() as volatile seems wrong.

Cpumask and bitmap manipulation functions may work fine, as they are
allowed to use either the new or old value. Apparently they do, as no
bugs were reported. However, the fact that mm_cpumask() is not volatile
might lead to theoretical bugs due to compiler optimizations.

For example, cpumask_next() uses _find_next_bit(). A compiler might add
to _find_next_bit() invented loads that would cause __ffs() to run on
different value than the one read before. Consequently, if something
like that happens, the result might be a CPU that was neither set on the
old nor the new mask. I could not find what might go wrong in such a
case, but it seems as an improper result.

Mark mm_cpumask() result as volatile and propagate the "volatile"
qualifier according to the compiler shouts.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: x86@kernel.org
---
 arch/arm/include/asm/bitops.h         |  4 ++--
 arch/x86/hyperv/mmu.c                 |  2 +-
 arch/x86/include/asm/paravirt_types.h |  2 +-
 arch/x86/include/asm/tlbflush.h       |  2 +-
 arch/x86/mm/tlb.c                     |  4 ++--
 arch/x86/xen/mmu_pv.c                 |  2 +-
 include/asm-generic/bitops/find.h     |  8 ++++----
 include/linux/bitmap.h                | 16 +++++++--------
 include/linux/cpumask.h               | 28 +++++++++++++--------------
 include/linux/mm_types.h              |  4 ++--
 include/linux/smp.h                   |  6 +++---
 kernel/smp.c                          |  8 ++++----
 lib/bitmap.c                          |  8 ++++----
 lib/cpumask.c                         |  8 ++++----
 lib/find_bit.c                        | 10 +++++-----
 15 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index c92e42a5c8f7..c8690c0ff15a 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -162,8 +162,8 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
  */
 extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
 extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
+extern int _find_first_bit_le(const volatile unsigned long *p, unsigned size);
+extern int _find_next_bit_le(const volatile unsigned long *p, int size, int offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 2c87350c1fb0..76ce8a0f19ef 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -52,7 +52,7 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-static void hyperv_flush_tlb_others(const struct cpumask *cpus,
+static void hyperv_flush_tlb_others(const volatile struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b6b02b7c19cc..35b5696aedc7 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -201,7 +201,7 @@ struct pv_mmu_ops {
 	void (*flush_tlb_user)(void);
 	void (*flush_tlb_kernel)(void);
 	void (*flush_tlb_one_user)(unsigned long addr);
-	void (*flush_tlb_others)(const struct cpumask *cpus,
+	void (*flush_tlb_others)(const volatile struct cpumask *cpus,
 				 const struct flush_tlb_info *info);
 
 	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 296a00545056..a4e7c90d11a8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -208,7 +208,7 @@ struct flush_tlb_info {
 void flush_tlb_local(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_others(const volatile struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 48f4b56fc4a7..ba85d6bb4988 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -796,7 +796,7 @@ static bool tlb_is_not_lazy(int cpu, void *data)
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
-STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
+STATIC_NOPV void native_flush_tlb_others(const volatile struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
@@ -824,7 +824,7 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 				(void *)info, 1, cpumask);
 }
 
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_others(const volatile struct cpumask *cpumask,
 		      const struct flush_tlb_info *info)
 {
 	__flush_tlb_others(cpumask, info);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index cf2ade864c30..0f9e1ff1e388 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1247,7 +1247,7 @@ static void xen_flush_tlb_one_user(unsigned long addr)
 	preempt_enable();
 }
 
-static void xen_flush_tlb_others(const struct cpumask *cpus,
+static void xen_flush_tlb_others(const volatile struct cpumask *cpus,
 				 const struct flush_tlb_info *info)
 {
 	struct {
diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..324078362ea1 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -12,8 +12,8 @@
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
-		size, unsigned long offset);
+extern unsigned long find_next_bit(const volatile unsigned long *addr,
+				   unsigned long size, unsigned long offset);
 #endif
 
 #ifndef find_next_and_bit
@@ -27,8 +27,8 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
+extern unsigned long find_next_and_bit(const volatile unsigned long *addr1,
+		const volatile unsigned long *addr2, unsigned long size,
 		unsigned long offset);
 #endif
 
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..769b7a98e12f 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -141,8 +141,8 @@ extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 extern void bitmap_cut(unsigned long *dst, const unsigned long *src,
 		       unsigned int first, unsigned int cut,
 		       unsigned int nbits);
-extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
+extern int __bitmap_and(unsigned long *dst, const volatile unsigned long *bitmap1,
+			const volatile unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
@@ -152,8 +152,8 @@ extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 extern void __bitmap_replace(unsigned long *dst,
 			const unsigned long *old, const unsigned long *new,
 			const unsigned long *mask, unsigned int nbits);
-extern int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
+extern int __bitmap_intersects(const volatile unsigned long *bitmap1,
+			const volatile unsigned long *bitmap2, unsigned int nbits);
 extern int __bitmap_subset(const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
 extern int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
@@ -278,8 +278,8 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
 			(const unsigned long *) (bitmap), (nbits))
 #endif
 
-static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline int bitmap_and(unsigned long *dst, const volatile unsigned long *src1,
+			const volatile unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
@@ -359,8 +359,8 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
 }
 
-static inline int bitmap_intersects(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline int bitmap_intersects(const volatile unsigned long *src1,
+			const volatile unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e30f12..3d7e418aa113 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -158,7 +158,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 }
 
 /* Valid inputs for n are -1 and 0. */
-static inline unsigned int cpumask_next(int n, const struct cpumask *srcp)
+static inline unsigned int cpumask_next(int n, const volatile struct cpumask *srcp)
 {
 	return n+1;
 }
@@ -169,8 +169,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 }
 
 static inline unsigned int cpumask_next_and(int n,
-					    const struct cpumask *srcp,
-					    const struct cpumask *andp)
+					    const volatile struct cpumask *srcp,
+					    const volatile struct cpumask *andp)
 {
 	return n+1;
 }
@@ -183,7 +183,7 @@ static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
 }
 
 /* cpu must be a valid cpu, ie 0, so there's no other choice. */
-static inline unsigned int cpumask_any_but(const struct cpumask *mask,
+static inline unsigned int cpumask_any_but(const volatile struct cpumask *mask,
 					   unsigned int cpu)
 {
 	return 1;
@@ -235,7 +235,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int cpumask_next(int n, const volatile struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -252,8 +252,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+int cpumask_next_and(int n, const volatile struct cpumask *, const volatile struct cpumask *);
+int cpumask_any_but(const volatile struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
@@ -335,7 +335,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+static inline void cpumask_set_cpu(unsigned int cpu, volatile struct cpumask *dstp)
 {
 	set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
@@ -351,7 +351,7 @@ static inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+static inline void cpumask_clear_cpu(int cpu, volatile struct cpumask *dstp)
 {
 	clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
@@ -368,7 +368,7 @@ static inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  *
  * Returns 1 if @cpu is set in @cpumask, else returns 0
  */
-static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static inline int cpumask_test_cpu(int cpu, const volatile struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -428,8 +428,8 @@ static inline void cpumask_clear(struct cpumask *dstp)
  * If *@dstp is empty, returns 0, else returns 1
  */
 static inline int cpumask_and(struct cpumask *dstp,
-			       const struct cpumask *src1p,
-			       const struct cpumask *src2p)
+			       const volatile struct cpumask *src1p,
+			       const volatile struct cpumask *src2p)
 {
 	return bitmap_and(cpumask_bits(dstp), cpumask_bits(src1p),
 				       cpumask_bits(src2p), nr_cpumask_bits);
@@ -521,8 +521,8 @@ static inline bool cpumask_or_equal(const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline bool cpumask_intersects(const struct cpumask *src1p,
-				     const struct cpumask *src2p)
+static inline bool cpumask_intersects(const volatile struct cpumask *src1p,
+				     const volatile struct cpumask *src2p)
 {
 	return bitmap_intersects(cpumask_bits(src1p), cpumask_bits(src2p),
 						      nr_cpumask_bits);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4122a9b8b56f..5a9b8c417f23 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -611,9 +611,9 @@ static inline void mm_init_cpumask(struct mm_struct *mm)
 }
 
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
-static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
+static inline volatile cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
-	return (struct cpumask *)&mm->cpu_bitmap;
+	return (volatile struct cpumask *)&mm->cpu_bitmap;
 }
 
 struct mmu_gather;
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..62b3456fec04 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -59,7 +59,7 @@ void on_each_cpu(smp_call_func_t func, void *info, int wait);
  * Call a function on processors specified by mask, which might include
  * the local one.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
+void on_each_cpu_mask(const volatile struct cpumask *mask, smp_call_func_t func,
 		void *info, bool wait);
 
 /*
@@ -71,7 +71,7 @@ void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
 		      void *info, bool wait);
 
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask);
+			   void *info, bool wait, const volatile struct cpumask *mask);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
@@ -118,7 +118,7 @@ extern void smp_cpus_done(unsigned int max_cpus);
  * Call a function on all other processors
  */
 void smp_call_function(smp_call_func_t func, void *info, int wait);
-void smp_call_function_many(const struct cpumask *mask,
+void smp_call_function_many(const volatile struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
 int smp_call_function_any(const struct cpumask *mask,
diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb..fa6e080251bf 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -604,7 +604,7 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-static void smp_call_function_many_cond(const struct cpumask *mask,
+static void smp_call_function_many_cond(const volatile struct cpumask *mask,
 					smp_call_func_t func, void *info,
 					bool wait, smp_cond_func_t cond_func)
 {
@@ -705,7 +705,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
  */
-void smp_call_function_many(const struct cpumask *mask,
+void smp_call_function_many(const volatile struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
 	smp_call_function_many_cond(mask, func, info, wait, NULL);
@@ -853,7 +853,7 @@ EXPORT_SYMBOL(on_each_cpu);
  * exception is that it may be used during early boot while
  * early_boot_irqs_disabled is set.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
+void on_each_cpu_mask(const volatile struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
 	int cpu = get_cpu();
@@ -892,7 +892,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * from a hardware interrupt handler or from a bottom half handler.
  */
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask)
+			   void *info, bool wait, const volatile struct cpumask *mask)
 {
 	int cpu = get_cpu();
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..6df7b13727d3 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -235,8 +235,8 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
 }
 EXPORT_SYMBOL(bitmap_cut);
 
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
-				const unsigned long *bitmap2, unsigned int bits)
+int __bitmap_and(unsigned long *dst, const volatile unsigned long *bitmap1,
+		 const volatile unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
 	unsigned int lim = bits/BITS_PER_LONG;
@@ -301,8 +301,8 @@ void __bitmap_replace(unsigned long *dst,
 }
 EXPORT_SYMBOL(__bitmap_replace);
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+int __bitmap_intersects(const volatile unsigned long *bitmap1,
+			const volatile unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 35924025097b..28763b992beb 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -15,7 +15,7 @@
  *
  * Returns >= nr_cpu_ids if no further cpus set.
  */
-unsigned int cpumask_next(int n, const struct cpumask *srcp)
+unsigned int cpumask_next(int n, const volatile struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -32,8 +32,8 @@ EXPORT_SYMBOL(cpumask_next);
  *
  * Returns >= nr_cpu_ids if no further cpus set in both.
  */
-int cpumask_next_and(int n, const struct cpumask *src1p,
-		     const struct cpumask *src2p)
+int cpumask_next_and(int n, const volatile struct cpumask *src1p,
+		     const volatile struct cpumask *src2p)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -51,7 +51,7 @@ EXPORT_SYMBOL(cpumask_next_and);
  * Often used to find any cpu but smp_processor_id() in a mask.
  * Returns >= nr_cpu_ids if no cpus set.
  */
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
+int cpumask_any_but(const volatile struct cpumask *mask, unsigned int cpu)
 {
 	unsigned int i;
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index f67f86fd2f62..08cd64aecc96 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -29,8 +29,8 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
+static unsigned long _find_next_bit(const volatile unsigned long *addr1,
+		const volatile unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le)
 {
 	unsigned long tmp, mask;
@@ -74,7 +74,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 /*
  * Find the next set bit in a memory region.
  */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+unsigned long find_next_bit(const volatile unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
@@ -92,8 +92,8 @@ EXPORT_SYMBOL(find_next_zero_bit);
 #endif
 
 #if !defined(find_next_and_bit)
-unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
+unsigned long find_next_and_bit(const volatile unsigned long *addr1,
+		const volatile unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
 	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
-- 
2.25.1

