Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E78404735
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhIIIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:47:17 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:62999 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhIIIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:47:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wujinhua@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UnmHZDR_1631177152;
Received: from VM20210331-21.tbsite.net(mailfrom:wujinhua@linux.alibaba.com fp:SMTPD_---0UnmHZDR_1631177152)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Sep 2021 16:45:56 +0800
From:   Jinhua Wu <wujinhua@linux.alibaba.com>
To:     x86@kernel.org
Cc:     zelin.deng@linux.alibaba.com, jiayu.ni@linux.alibaba.com,
        wujinhua@linux.alibaba.com, ak@linux.intel.com,
        luming.yu@intel.com, fan.du@intel.com,
        artie.ding@linux.alibaba.com, tony.luck@intel.com,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        pawan.kumar.gupta@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, ricardo.neri-calderon@linux.intel.com,
        peterz@infradead.org
Subject: [PATCH] perf: optimize clear page in Intel specified model with movq instruction
Date:   Thu,  9 Sep 2021 16:45:51 +0800
Message-Id: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear page is the most time-consuming procedure in page fault handling.
Kernel use fast-string instruction to clear page. We found that in specified
Intel model such as CPX and ICX, the movq instruction perform much better
than fast-string instruction when corresponding page is not in cache.
But when the page is in cache, fast string perform better. We show the test
result in the following:

machine: Intel CPX

Allocated memory size      Page fault latency per 4K byte
                          rep stosb             movq
--------------------    ----------------  ------------------
        8MB               2057.13ns           1338.38ns
        64MB              1850.71ns           1200.20ns
        512MB             1918.40ns           1196.91ns
        4096MB            1931.24ns           1189.41ns

We can find that there is 40% performance improvement. So we add a blacklist
for Intel specified model, in which we use movq instruction to clear page.

Signed-off-by: Jinhua Wu <wujinhua@linux.alibaba.com>
Signed-off-by: Jiayu Ni <jiayu.ni@linux.alibaba.com>
Signed-off-by: Artie Ding <artie.ding@linux.alibaba.com>
---
 arch/x86/include/asm/page_64.h | 18 ++++++++++++------
 arch/x86/kernel/cpu/intel.c    | 22 ++++++++++++++++++++++
 arch/x86/mm/init.c             |  9 +++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc..1fedfbe 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -7,6 +7,8 @@
 #ifndef __ASSEMBLY__
 #include <asm/alternative.h>
 
+#include <linux/jump_label.h>
+
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
 extern unsigned long phys_base;
@@ -43,15 +45,19 @@ static inline unsigned long __phys_addr_nodebug(unsigned long x)
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
+extern struct static_key_false clear_page_movq_key;
 
 static inline void clear_page(void *page)
 {
-	alternative_call_2(clear_page_orig,
-			   clear_page_rep, X86_FEATURE_REP_GOOD,
-			   clear_page_erms, X86_FEATURE_ERMS,
-			   "=D" (page),
-			   "0" (page)
-			   : "cc", "memory", "rax", "rcx");
+	if (static_branch_unlikely(&clear_page_movq_key))
+		clear_page_orig(page);
+	else
+		alternative_call_2(clear_page_orig,
+				clear_page_rep, X86_FEATURE_REP_GOOD,
+				clear_page_erms, X86_FEATURE_ERMS,
+				"=D" (page),
+				"0" (page)
+				: "cc", "memory", "rax", "rcx");
 }
 
 void copy_page(void *to, void *from);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43..3366da0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -38,6 +38,28 @@
 #include <asm/apic.h>
 #endif
 
+/* Optimize clear page with movq in specific Intel CPU */
+#include <asm/cpu_device_id.h>
+#include <linux/jump_label.h>
+
+DEFINE_STATIC_KEY_FALSE(clear_page_movq_key);
+EXPORT_SYMBOL_GPL(clear_page_movq_key);
+
+extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
+
+const struct x86_cpu_id faststring_blacklist_match[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_XEON_D, 0)
+};
+
+void enable_clear_page_movq(void)
+{
+    if (x86_match_cpu(faststring_blacklist_match))
+		static_branch_enable(&clear_page_movq_key);
+}
+
+
 enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 23a14d8..480c189 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -28,6 +28,12 @@
 #include <asm/memtype.h>
 
 /*
+ * Optimize clear page with movq in specific Intel CPU
+ * Definition in intel.c
+ */
+extern void enable_clear_page_movq(void);
+
+/*
  * We need to define the tracepoints somewhere, and tlb.c
  * is only compiled when SMP=y.
  */
@@ -775,6 +781,9 @@ void __init init_mem_mapping(void)
 
 	x86_init.hyper.init_mem_mapping();
 
+	/* Optimize clear page with mov in specific Intel CPU */
+	enable_clear_page_movq();
+
 	early_memtest(0, max_pfn_mapped << PAGE_SHIFT);
 }
 
-- 
1.8.3.1

