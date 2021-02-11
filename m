Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8A319042
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhBKQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:44:15 -0500
Received: from foss.arm.com ([217.140.110.172]:53546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhBKPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:35:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078891424;
        Thu, 11 Feb 2021 07:34:15 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2182C3F73D;
        Thu, 11 Feb 2021 07:34:13 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can read beyond buffer limits
Date:   Thu, 11 Feb 2021 15:33:50 +0000
Message-Id: <20210211153353.29094-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211153353.29094-1-vincenzo.frascino@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_unaligned_zeropad() and __get/put_kernel_nofault() functions can
read passed some buffer limits which may include some MTE granule with a
different tag.

When MTE async mode is enable, the load operation crosses the boundaries
and the next granule has a different tag the PE sets the TFSR_EL1.TF1 bit
as if an asynchronous tag fault is happened.

Enable Tag Check Override (TCO) in these functions  before the load and
disable it afterwards to prevent this to happen.

Note: The same condition can be hit in MTE sync mode but we deal with it
through the exception handling.
In the current implementation, mte_async_mode flag is set only at boot
time but in future kasan might acquire some runtime features that
that change the mode dynamically, hence we disable it when sync mode is
selected for future proof.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: Branislav Rankov <Branislav.Rankov@arm.com>
Tested-by: Branislav Rankov <Branislav.Rankov@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/uaccess.h        | 24 ++++++++++++++++++++++++
 arch/arm64/include/asm/word-at-a-time.h |  4 ++++
 arch/arm64/kernel/mte.c                 | 16 ++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0deb88467111..a857f8f82aeb 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -188,6 +188,26 @@ static inline void __uaccess_enable_tco(void)
 				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
 }
 
+/* Whether the MTE asynchronous mode is enabled. */
+DECLARE_STATIC_KEY_FALSE(mte_async_mode);
+
+/*
+ * These functions disable tag checking only if in MTE async mode
+ * since the sync mode generates exceptions synchronously and the
+ * nofault or load_unaligned_zeropad can handle them.
+ */
+static inline void __uaccess_disable_tco_async(void)
+{
+	if (static_branch_unlikely(&mte_async_mode))
+		 __uaccess_disable_tco();
+}
+
+static inline void __uaccess_enable_tco_async(void)
+{
+	if (static_branch_unlikely(&mte_async_mode))
+		__uaccess_enable_tco();
+}
+
 static inline void uaccess_disable_privileged(void)
 {
 	__uaccess_disable_tco();
@@ -307,8 +327,10 @@ do {									\
 do {									\
 	int __gkn_err = 0;						\
 									\
+	__uaccess_enable_tco_async();					\
 	__raw_get_mem("ldr", *((type *)(dst)),				\
 		      (__force type *)(src), __gkn_err);		\
+	__uaccess_disable_tco_async();					\
 	if (unlikely(__gkn_err))					\
 		goto err_label;						\
 } while (0)
@@ -380,8 +402,10 @@ do {									\
 do {									\
 	int __pkn_err = 0;						\
 									\
+	__uaccess_enable_tco_async();					\
 	__raw_put_mem("str", *((type *)(src)),				\
 		      (__force type *)(dst), __pkn_err);		\
+	__uaccess_disable_tco_async();					\
 	if (unlikely(__pkn_err))					\
 		goto err_label;						\
 } while(0)
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index 3333950b5909..c62d9fa791aa 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -55,6 +55,8 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset;
 
+	__uaccess_enable_tco_async();
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	ldr	%0, %3\n"
@@ -76,6 +78,8 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	: "=&r" (ret), "=&r" (offset)
 	: "r" (addr), "Q" (*(unsigned long *)addr));
 
+	__uaccess_disable_tco_async();
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 706b7ab75f31..65ecb86dd886 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -26,6 +26,10 @@ u64 gcr_kernel_excl __ro_after_init;
 
 static bool report_fault_once = true;
 
+/* Whether the MTE asynchronous mode is enabled. */
+DEFINE_STATIC_KEY_FALSE(mte_async_mode);
+EXPORT_SYMBOL_GPL(mte_async_mode);
+
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
@@ -119,12 +123,24 @@ static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
 void mte_enable_kernel_sync(void)
 {
 	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
+
+	/*
+	 * This function is called on each active smp core at boot
+	 * time, hence we do not need to take cpu_hotplug_lock again.
+	 */
+	static_branch_disable_cpuslocked(&mte_async_mode);
 }
 EXPORT_SYMBOL_GPL(mte_enable_kernel_sync);
 
 void mte_enable_kernel_async(void)
 {
 	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
+
+	/*
+	 * This function is called on each active smp core at boot
+	 * time, hence we do not need to take cpu_hotplug_lock again.
+	 */
+	static_branch_enable_cpuslocked(&mte_async_mode);
 }
 EXPORT_SYMBOL_GPL(mte_enable_kernel_async);
 
-- 
2.30.0

