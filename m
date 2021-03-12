Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E371A338FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhCLOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:22:52 -0500
Received: from foss.arm.com ([217.140.110.172]:54576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhCLOWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:22:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FBBA1063;
        Fri, 12 Mar 2021 06:22:31 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9F13F793;
        Fri, 12 Mar 2021 06:22:29 -0800 (PST)
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
Subject: [PATCH v15 4/8] kasan: Add report for async mode
Date:   Fri, 12 Mar 2021 14:22:06 +0000
Message-Id: <20210312142210.21326-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210312142210.21326-1-vincenzo.frascino@arm.com>
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN provides an asynchronous mode of execution.

Add reporting functionality for this mode.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  6 ++++++
 mm/kasan/kasan.h      | 16 ++++++++++++++++
 mm/kasan/report.c     | 17 ++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 44c147dae7e3..9f5faefd1744 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -377,6 +377,12 @@ static inline void *kasan_reset_tag(const void *addr)
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+void kasan_report_async(void);
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 265ad35a04ad..02957cec1a61 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -7,17 +7,33 @@
 #include <linux/stackdepot.h>
 
 #ifdef CONFIG_KASAN_HW_TAGS
+
 #include <linux/static_key.h>
+
 DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
+extern bool kasan_flag_async __ro_after_init;
+
 static inline bool kasan_stack_collection_enabled(void)
 {
 	return static_branch_unlikely(&kasan_flag_stacktrace);
 }
+
+static inline bool kasan_async_mode_enabled(void)
+{
+	return kasan_flag_async;
+}
 #else
+
 static inline bool kasan_stack_collection_enabled(void)
 {
 	return true;
 }
+
+static inline bool kasan_async_mode_enabled(void)
+{
+	return false;
+}
+
 #endif
 
 extern bool kasan_flag_panic __ro_after_init;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 87b271206163..8b0843a2cdd7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -87,7 +87,8 @@ static void start_report(unsigned long *flags)
 
 static void end_report(unsigned long *flags, unsigned long addr)
 {
-	trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
+	if (!kasan_async_mode_enabled())
+		trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
@@ -360,6 +361,20 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags, (unsigned long)object);
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+void kasan_report_async(void)
+{
+	unsigned long flags;
+
+	start_report(&flags);
+	pr_err("BUG: KASAN: invalid-access\n");
+	pr_err("Asynchronous mode enabled: no access details available\n");
+	pr_err("\n");
+	dump_stack();
+	end_report(&flags, 0);
+}
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 				unsigned long ip)
 {
-- 
2.30.0

