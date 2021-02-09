Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC0315273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhBIPOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhBIPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:14:28 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B5C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:13:47 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b201so3045774wmb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SX0HiwfnPZUJT/hHYA0MIVTfSj70h4+JBgQfnaAr/u4=;
        b=pHK0u1wb/U/XIFExQx2+la0yPbi2HiObpWHcMDueY02GzwNDf6wDzk2gCsMOWgVriQ
         wwc6YOORAQFxUUr6RHSe9pm1gp7SIYf1QLXwPt1IZao9+mZXiFxM2her7vWOb/ECj9II
         ZOsTA7Me6ZfdZBhSYtyZnjxcz4ciiURntrzujonwBSCk0DMbbI1LFANy99uwWUO+fhzS
         tMlW61c0VTYoQwclgY0I01m2nepLPrex5L+uRCxZYXRHlbPy/tN4fqiw41anPj4ND/RQ
         iJmT4oDzsMsGoLIpq1GphHlnTnmtE4vQ2TPoyJUsNr4wr5Yv1h2sbP+fL9f9iP8k9Z4g
         mz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SX0HiwfnPZUJT/hHYA0MIVTfSj70h4+JBgQfnaAr/u4=;
        b=nPjb3GDmh8T8Vp2KoZkmDGgzuY7GSZCprG34k4O4ZwN69zYYOltLcuyYrUnlcPwZbP
         q2ZDT+xR10cCr2ROxCBSXsmQIWmDWH5KvlWz4FHScCexhjyfpDDJbFTbb4gawuYVXnBW
         d6HdzWrBiZlup4vs1ZLv3to+NXs9Kgd+p0zxSc02tC3Uv3FOu8vlq8F6POk4R6xF9CQE
         IgSOzJECJaLaM1K1KY9T9JTDDw10KoRPPbZAu78Lc+DS033mQyCl/7J4QAgAIC8lRDPc
         rFFgU4nXPgEhFHRh/y3eDY640x8DvKry/3gwg2ozchklyUOCkbgUnwxnUYXxgsK10fI4
         K5cw==
X-Gm-Message-State: AOAM530STQn9+v5vX3F4gv25//KzBozZAkrjF4O++xHgAXhNIz7yWd5T
        geK6PKpkUd9kJ1JbAUChFJ0+obRbVg==
X-Google-Smtp-Source: ABdhPJy/bfHoIxfvMhq6l/VKJ239p+BDKbsuCzNlG+/0qxtUuQigDelDtEAz0BJI1akEhB9WzcYa1mSk1A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:51c9:b9a4:3e29:2cd0])
 (user=elver job=sendgmr) by 2002:a1c:64c3:: with SMTP id y186mr3902730wmb.58.1612883626184;
 Tue, 09 Feb 2021 07:13:46 -0800 (PST)
Date:   Tue,  9 Feb 2021 16:13:29 +0100
Message-Id: <20210209151329.3459690-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH mm] kfence: make reporting sensitive information configurable
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot rely on CONFIG_DEBUG_KERNEL to decide if we're running a
"debug kernel" where we can safely show potentially sensitive
information in the kernel log.

Therefore, add the option CONFIG_KFENCE_REPORT_SENSITIVE to decide if we
should add potentially sensitive information to KFENCE reports. The
default behaviour remains unchanged.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kfence.rst | 6 +++---
 lib/Kconfig.kfence                 | 8 ++++++++
 mm/kfence/core.c                   | 2 +-
 mm/kfence/kfence.h                 | 3 +--
 mm/kfence/report.c                 | 6 +++---
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 58a0a5fa1ddc..5280d644f826 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -89,7 +89,7 @@ A typical out-of-bounds access looks like this::
 The header of the report provides a short summary of the function involved in
 the access. It is followed by more detailed information about the access and
 its origin. Note that, real kernel addresses are only shown for
-``CONFIG_DEBUG_KERNEL=y`` builds.
+``CONFIG_KFENCE_REPORT_SENSITIVE=y`` builds.
 
 Use-after-free accesses are reported as::
 
@@ -184,8 +184,8 @@ invalidly written bytes (offset from the address) are shown; in this
 representation, '.' denote untouched bytes. In the example above ``0xac`` is
 the value written to the invalid address at offset 0, and the remaining '.'
 denote that no following bytes have been touched. Note that, real values are
-only shown for ``CONFIG_DEBUG_KERNEL=y`` builds; to avoid information
-disclosure for non-debug builds, '!' is used instead to denote invalidly
+only shown for ``CONFIG_KFENCE_REPORT_SENSITIVE=y`` builds; to avoid
+information disclosure otherwise, '!' is used instead to denote invalidly
 written bytes.
 
 And finally, KFENCE may also report on invalid accesses to any protected page
diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 78f50ccb3b45..141494a5f530 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -55,6 +55,14 @@ config KFENCE_NUM_OBJECTS
 	  pages are required; with one containing the object and two adjacent
 	  ones used as guard pages.
 
+config KFENCE_REPORT_SENSITIVE
+	bool "Show potentially sensitive information in reports"
+	default y if DEBUG_KERNEL
+	help
+	  Show potentially sensitive information such as unhashed pointers,
+	  context bytes on memory corruptions, as well as dump registers in
+	  KFENCE reports.
+
 config KFENCE_STRESS_TEST_FAULTS
 	int "Stress testing of fault handling and error reporting" if EXPERT
 	default 0
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index cfe3d32ac5b7..5f7e02db5f53 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -648,7 +648,7 @@ void __init kfence_init(void)
 	schedule_delayed_work(&kfence_timer, 0);
 	pr_info("initialized - using %lu bytes for %d objects", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS);
-	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+	if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE))
 		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
 			(void *)(__kfence_pool + KFENCE_POOL_SIZE));
 	else
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 1accc840dbbe..48a8196b947b 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -16,8 +16,7 @@
 
 #include "../slab.h" /* for struct kmem_cache */
 
-/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_KFENCE_REPORT_SENSITIVE
 #define PTR_FMT "%px"
 #else
 #define PTR_FMT "%p"
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 901bd7ee83d8..5e2dbabbab1d 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -148,9 +148,9 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
 	for (cur = (const u8 *)address; cur < end; cur++) {
 		if (*cur == KFENCE_CANARY_PATTERN(cur))
 			pr_cont(" .");
-		else if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+		else if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE))
 			pr_cont(" 0x%02x", *cur);
-		else /* Do not leak kernel memory in non-debug builds. */
+		else /* Do not leak kernel memory. */
 			pr_cont(" !");
 	}
 	pr_cont(" ]");
@@ -242,7 +242,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 
 	/* Print report footer. */
 	pr_err("\n");
-	if (IS_ENABLED(CONFIG_DEBUG_KERNEL) && regs)
+	if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE) && regs)
 		show_regs(regs);
 	else
 		dump_stack_print_info(KERN_ERR);
-- 
2.30.0.478.g8a0d178c01-goog

