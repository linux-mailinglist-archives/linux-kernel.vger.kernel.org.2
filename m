Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099B3B3B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFYERS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:17:18 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:49348 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYERQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:17:16 -0400
X-Greylist: delayed 157693 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2021 00:17:15 EDT
X-QQ-mid: bizesmtp36t1624594476td5unj9e
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 25 Jun 2021 12:14:29 +0800 (CST)
X-QQ-SSF: 0100000000000050B000B00A0000000
X-QQ-FEAT: 6dXuswn9i1UZJ5ssvg6bVgPuvO5eiQ1b5PwONVj1OD1z6n0XnbvWufy5TFXwC
        rszzkL78x6VgMHVPpG2+wLKbQMLaJ/AwLHo3BtauWUTqh4c2YGu5X6lRHFoHRV+jknNSeoP
        x2tF4eFNZAukyLeSKJA47RojSYNox7ZIgiFACmeeET7NDb4tNCK1Q3fOjZh/j44r7blN52T
        C9ISvy2uaeTt0YY73ULWkaA4R6S4frSahLhEDbHo529HUPJEMfQWcDxnUAAXdpm3xrp6cIW
        waMfxm6C/d04E1c2DoGbLB69RVWoMzYR8gvoe5HeI0OkfY5Gs+08bhWB0=
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jinchao Wang <wjc@cdjrlc.com>
Subject: [PATCH] arm64: Prefer unsigned int to bare use of unsigned
Date:   Fri, 25 Jun 2021 12:14:22 +0800
Message-Id: <20210625041422.62394-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 arch/arm64/include/asm/uaccess.h |  2 +-
 arch/arm64/kernel/perf_event.c   | 18 +++++++++---------
 arch/arm64/kernel/smp.c          |  4 ++--
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/mm/ptdump.c           |  4 ++--
 arch/arm64/net/bpf_jit.h         |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b5f08621fa29..cc12bea6c0cd 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -465,7 +465,7 @@ struct page;
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset, size_t len);
 extern unsigned long __must_check __copy_user_flushcache(void *to, const void __user *from, unsigned long n);
 
-static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned int size)
 {
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, __uaccess_mask_ptr(src), size);
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index d07788dad388..42691fa90d8e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -39,7 +39,7 @@
  * be supported on any given implementation. Unsupported events will
  * be disabled at run-time based on the PMCEID registers.
  */
-static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
+static const unsigned int armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
@@ -52,7 +52,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
 };
 
-static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -76,7 +76,7 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 };
 
-static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_OP_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -87,7 +87,7 @@ static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
 };
 
-static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_OP_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -104,7 +104,7 @@ static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
 };
 
-static const unsigned armv8_a73_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_a73_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_OP_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -113,7 +113,7 @@ static const unsigned armv8_a73_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
 };
 
-static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						   [PERF_COUNT_HW_CACHE_OP_MAX]
 						   [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -134,7 +134,7 @@ static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
 };
 
-static const unsigned armv8_vulcan_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+static const unsigned int armv8_vulcan_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					      [PERF_COUNT_HW_CACHE_OP_MAX]
 					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
@@ -979,9 +979,9 @@ static void armv8pmu_reset(void *info)
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
-				   const unsigned (*extra_event_map)
+				   const unsigned int (*extra_event_map)
 						  [PERF_COUNT_HW_MAX],
-				   const unsigned (*extra_cache_map)
+				   const unsigned int (*extra_cache_map)
 						  [PERF_COUNT_HW_CACHE_MAX]
 						  [PERF_COUNT_HW_CACHE_OP_MAX]
 						  [PERF_COUNT_HW_CACHE_RESULT_MAX])
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..8d93a019b74b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -890,7 +890,7 @@ static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if ((unsigned)ipinr < NR_IPI)
+	if ((unsigned int)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
 
 	switch (ipinr) {
@@ -939,7 +939,7 @@ static void do_handle_IPI(int ipinr)
 		break;
 	}
 
-	if ((unsigned)ipinr < NR_IPI)
+	if ((unsigned int)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fc6a34eb4d2d..f3c9c1f60852 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1215,7 +1215,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_REG_LIST: {
 		struct kvm_reg_list __user *user_list = argp;
 		struct kvm_reg_list reg_list;
-		unsigned n;
+		unsigned int n;
 
 		r = -ENOEXEC;
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 1c403536c9bb..d6366283fd95 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -206,7 +206,7 @@ static struct pg_level pg_level[] = {
 static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
 			size_t num)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < num; i++, bits++) {
 		const char *s;
@@ -333,7 +333,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 
 static void __init ptdump_initialize(void)
 {
-	unsigned i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		if (pg_level[i].bits)
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index cc0cf0f5c7c3..04e3bc0c5655 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -123,7 +123,7 @@
 /* Rd = Rn << shift */
 #define A64_LSL(sf, Rd, Rn, shift) ({	\
 	int sz = (sf) ? 64 : 32;	\
-	A64_UBFM(sf, Rd, Rn, (unsigned)-(shift) % sz, sz - 1 - (shift)); \
+	A64_UBFM(sf, Rd, Rn, (unsigned int)-(shift) % sz, sz - 1 - (shift)); \
 })
 /* Rd = Rn >> shift */
 #define A64_LSR(sf, Rd, Rn, shift) A64_UBFM(sf, Rd, Rn, shift, (sf) ? 63 : 31)
-- 
2.31.1



