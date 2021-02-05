Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB73114F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBEWTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:19:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:49958 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232835AbhBEO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:53 -0500
IronPort-SDR: tAeTuQuNZSuYzhgCVsgoNIv0TYFuSQ5AvLn2FuQ2IQZDDNUwIJAGxqVOL6ziv9lA3ZYx1piMMX
 scyStKI/Qt1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="169120207"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="169120207"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:44 -0800
IronPort-SDR: ay6IjqaqC9ZS6KBSykKI9lL9o4Wo64XAw//iH9XjDccItbIuOIfc5jkt/2nZeMh0Y53k06VlKc
 CU6VFfZpCPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="416226113"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2021 07:16:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B3ACE1C4; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [QEMU] x86: Implement Linear Address Masking support
Date:   Fri,  5 Feb 2021 18:16:22 +0300
Message-Id: <20210205151631.43511-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking feature makes CPU ignore some bits of the virtual
address. These bits can be used to encode metadata.

The feature is enumerated with CPUID.(EAX=07H, ECX=01H):EAX.LAM[bit 26].

CR3.LAM_U57[bit 62] allows to encode 6 bits of metadata in bits 62:57 of
user pointers.

CR3.LAM_U48[bit 61] allows to encode 15 bits of metadata in bits 62:48
of user pointers.

CR4.LAM_SUP[bit 28] allows to encode metadata of supervisor pointers.
If 5-level paging is in use, 6 bits of metadata can be encoded in 62:57.
For 4-level paging, 15 bits of metadata can be encoded in bits 62:48.

QEMU strips address from the metadata bits and gets it to canonical
shape before handling memory access. It has to be done very early before
TLB lookup.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 accel/tcg/cputlb.c        | 54 +++++++++++++++++++++++----------------
 include/hw/core/cpu.h     |  1 +
 target/i386/cpu.c         |  5 ++--
 target/i386/cpu.h         |  7 +++++
 target/i386/excp_helper.c | 28 +++++++++++++++++++-
 target/i386/helper.c      |  2 +-
 6 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 42ab79c1a582..f2d27134474f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1271,6 +1271,17 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
+static vaddr clean_addr(CPUState *cpu, vaddr addr)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->do_clean_addr) {
+        addr = cc->do_clean_addr(cpu, addr);
+    }
+
+    return addr;
+}
+
 /*
  * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
  * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
@@ -1702,9 +1713,11 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
 
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
-static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
+static void *atomic_mmu_lookup(CPUArchState *env, target_ulong address,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
+    CPUState *cpu = env_cpu(env);
+    target_ulong addr = clean_addr(cpu, address);
     size_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
@@ -1720,8 +1733,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     /* Enforce guest required alignment.  */
     if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
         /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, retaddr);
     }
 
     /* Enforce qemu required alignment.  */
@@ -1736,8 +1748,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     /* Check TLB entry and enforce page permissions.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(env_cpu(env), addr, 1 << s_bits, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
+            tlb_fill(cpu, addr, 1 << s_bits, MMU_DATA_STORE, mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             tlbe = tlb_entry(env, mmu_idx, addr);
         }
@@ -1753,8 +1764,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
     /* Let the guest notice RMW on a write-only page.  */
     if (unlikely(tlbe->addr_read != (tlb_addr & ~TLB_NOTDIRTY))) {
-        tlb_fill(env_cpu(env), addr, 1 << s_bits, MMU_DATA_LOAD,
-                 mmu_idx, retaddr);
+        tlb_fill(cpu, addr, 1 << s_bits, MMU_DATA_LOAD, mmu_idx, retaddr);
         /* Since we don't support reads and writes to different addresses,
            and we do have the proper page loaded for write, this shouldn't
            ever return.  But just in case, handle via stop-the-world.  */
@@ -1764,14 +1774,14 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
 
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1 << s_bits,
+        notdirty_write(cpu, addr, 1 << s_bits,
                        &env_tlb(env)->d[mmu_idx].iotlb[index], retaddr);
     }
 
     return hostaddr;
 
  stop_the_world:
-    cpu_loop_exit_atomic(env_cpu(env), retaddr);
+    cpu_loop_exit_atomic(cpu, retaddr);
 }
 
 /*
@@ -1810,10 +1820,12 @@ load_memop(const void *haddr, MemOp op)
 }
 
 static inline uint64_t QEMU_ALWAYS_INLINE
-load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+load_helper(CPUArchState *env, target_ulong address, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
 {
+    CPUState *cpu = env_cpu(env);
+    target_ulong addr = clean_addr(cpu, address);
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
@@ -1829,16 +1841,14 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, access_type,
-                             mmu_idx, retaddr);
+        cpu_unaligned_access(cpu, addr, access_type, mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), addr, size,
-                     access_type, mmu_idx, retaddr);
+            tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
@@ -1861,7 +1871,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         /* Handle watchpoints.  */
         if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
             /* On watchpoint hit, this will longjmp out.  */
-            cpu_check_watchpoint(env_cpu(env), addr, size,
+            cpu_check_watchpoint(cpu, addr, size,
                                  iotlbentry->attrs, BP_MEM_READ, retaddr);
         }
 
@@ -2341,9 +2351,11 @@ store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t val,
 }
 
 static inline void QEMU_ALWAYS_INLINE
-store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+store_helper(CPUArchState *env, target_ulong address, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
+    CPUState *cpu = env_cpu(env);
+    target_ulong addr = clean_addr(cpu, address);
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
@@ -2355,16 +2367,14 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
+            tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
@@ -2386,7 +2396,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         /* Handle watchpoints.  */
         if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
             /* On watchpoint hit, this will longjmp out.  */
-            cpu_check_watchpoint(env_cpu(env), addr, size,
+            cpu_check_watchpoint(cpu, addr, size,
                                  iotlbentry->attrs, BP_MEM_WRITE, retaddr);
         }
 
@@ -2406,7 +2416,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         /* Handle clean RAM pages.  */
         if (tlb_addr & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr);
+            notdirty_write(cpu, addr, size, iotlbentry, retaddr);
         }
 
         haddr = (void *)((uintptr_t)addr + entry->addend);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3d92c967fffa..64817bc10f1b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -171,6 +171,7 @@ struct CPUClass {
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
+    vaddr (*do_clean_addr)(CPUState *cpu, vaddr addr);
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5a8c96072e41..f819f0673103 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -666,7 +666,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57)
 #define TCG_7_0_EDX_FEATURES 0
-#define TCG_7_1_EAX_FEATURES 0
+#define TCG_7_1_EAX_FEATURES CPUID_7_1_EAX_LAM
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -997,7 +997,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
@@ -7290,6 +7290,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TCG
     cc->tcg_initialize = tcg_x86_init;
     cc->tlb_fill = x86_cpu_tlb_fill;
+    cc->do_clean_addr = x86_cpu_clean_addr;
 #endif
     cc->disas_set_info = x86_disas_set_info;
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 88e8586f8fb4..f8477e16685d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -229,6 +229,9 @@ typedef enum X86Seg {
 #define CR0_AM_MASK  (1U << 18)
 #define CR0_PG_MASK  (1U << 31)
 
+#define CR3_LAM_U48  (1ULL << 61)
+#define CR3_LAM_U57  (1ULL << 62)
+
 #define CR4_VME_MASK  (1U << 0)
 #define CR4_PVI_MASK  (1U << 1)
 #define CR4_TSD_MASK  (1U << 2)
@@ -250,6 +253,7 @@ typedef enum X86Seg {
 #define CR4_SMEP_MASK   (1U << 20)
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
+#define CR4_LAM_SUP    (1U << 28)
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -796,6 +800,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
@@ -1924,6 +1930,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
+vaddr x86_cpu_clean_addr(CPUState *cpu, vaddr addr);
 
 #ifndef CONFIG_USER_ONLY
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 191471749fbf..edf8194574b2 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -406,7 +406,7 @@ static int handle_mmu_fault(CPUState *cs, vaddr addr, int size,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e_addr = get_hphys(cs, pml5e_addr, MMU_DATA_STORE, NULL);
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
@@ -700,3 +700,29 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 #endif
 }
+
+static inline int64_t sign_extend64(uint64_t value, int index)
+{
+    int shift = 63 - index;
+    return (int64_t)(value << shift) >> shift;
+}
+
+vaddr x86_cpu_clean_addr(CPUState *cs, vaddr addr)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+    bool la57 = env->cr[4] & CR4_LA57_MASK;
+
+    if (addr >> 63) {
+        if (env->cr[4] & CR4_LAM_SUP) {
+            return sign_extend64(addr, la57 ? 56 : 47);
+        }
+    } else {
+        if (env->cr[3] & CR3_LAM_U57) {
+            return sign_extend64(addr, 56);
+        } else if (env->cr[3] & CR3_LAM_U48) {
+            return sign_extend64(addr, 47);
+        }
+    }
+
+    return addr;
+}
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 034f46bcc210..6c099443ce13 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -753,7 +753,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
-- 
2.26.2

