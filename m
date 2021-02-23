Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE632270A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhBWIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhBWIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:21:29 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FEFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 00:20:49 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id l1so9481077qtv.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 00:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NFZ3Z7VYF450fBUEwtA9Z/zyGYLmPSNiSMB88RuL4JU=;
        b=j7cibiZCfXDemYKlAZu4iF8Ydgh/9wrX6sCDVp0UFESoX9eXGWos5RI8b+qRDpSx8t
         IW8/NyjjN346EvLNM+zgVtwHcGNkmosxXeZM417zG/AoClkSYM5mGIiHqN6ZD63hbB3x
         Ah415kFdbQoSJhgHttO4hCUMNEfVBpCXOG7ZM/I+ZUSgY3tPQviwAiSHmU98ELStikPP
         vW9GDkH9hizCvzVEM+St52wru6e9FXvBX3fps/5ACOxX8XznSxeArEgnrNMbweNAC9Hy
         GIibNmJWtYnTPO/QuRGTA8L2OdU8SzDAVD8nd2USWkTwlgyWjfmFtULIYZbiIV2AYqUf
         /dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NFZ3Z7VYF450fBUEwtA9Z/zyGYLmPSNiSMB88RuL4JU=;
        b=R/zrKV1tqHX53TAixu0jDnGpJsZxoZ1mx3YodTC8Cy94iE+VpRju6ZhiKM1XzcZvg3
         l/ai1aVbjlE7sHdbjISq8SZnPv7dUaMsxKHkR8pLdWpE+1N9TiBkeCDZlEAUgfA4kvxl
         2hHqCw/7LwcTFYuuyJ22+0NKM+F3uXExkZIMTY6YWEjLzz3VxX4sdnEi+889wxqucFWK
         nR2uedekdrZvrgYIvnKEf0VD+cx6WfmNvzizdXSj2ODSakqKSr+tI4T+b3eJmJTvK0xM
         EuyxgtizJjfAVPLVSymPKZpT534My46UUCtZSTEYJGmAsH/c87hnQK8sGkd0HhsEz9va
         uxAQ==
X-Gm-Message-State: AOAM531s9C7x6ltvSWOCsyQw8PcuHXEMk8q4f/koVA2LSG4k2/ZTmV9J
        Gg94BglCai9TxIVBws3bqtGC76kapw==
X-Google-Smtp-Source: ABdhPJx1NRVKrHqpPRMM5iTAlZPKxUzlr4WuTK0zvX3sr7i35lMezFJLdCXnAVFEoK+nS1bs8NM7AJmq7g==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:855b:f924:6e71:3d5d])
 (user=elver job=sendgmr) by 2002:ad4:5a10:: with SMTP id ei16mr10879866qvb.10.1614068448741;
 Tue, 23 Feb 2021 00:20:48 -0800 (PST)
Date:   Tue, 23 Feb 2021 09:20:43 +0100
Message-Id: <20210223082043.1972742-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH mm] kfence: report sensitive information based on no_hash_pointers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot rely on CONFIG_DEBUG_KERNEL to decide if we're running a
"debug kernel" where we can safely show potentially sensitive
information in the kernel log.

Instead, simply rely on the newly introduced "no_hash_pointers" to print
unhashed kernel pointers, as well as decide if our reports can include
other potentially sensitive information such as registers and corrupted
bytes.

Cc: Timur Tabi <timur@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---

Depends on "lib/vsprintf: no_hash_pointers prints all addresses as
unhashed", which was merged into mainline yesterday:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2bec7d8a42a3885d525e821d9354b6b08fd6adf

---
 Documentation/dev-tools/kfence.rst |  8 ++++----
 mm/kfence/core.c                   | 10 +++-------
 mm/kfence/kfence.h                 |  7 -------
 mm/kfence/kfence_test.c            |  2 +-
 mm/kfence/report.c                 | 18 ++++++++++--------
 5 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 58a0a5fa1ddc..fdf04e741ea5 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -88,8 +88,8 @@ A typical out-of-bounds access looks like this::
 
 The header of the report provides a short summary of the function involved in
 the access. It is followed by more detailed information about the access and
-its origin. Note that, real kernel addresses are only shown for
-``CONFIG_DEBUG_KERNEL=y`` builds.
+its origin. Note that, real kernel addresses are only shown when using the
+kernel command line option ``no_hash_pointers``.
 
 Use-after-free accesses are reported as::
 
@@ -184,8 +184,8 @@ invalidly written bytes (offset from the address) are shown; in this
 representation, '.' denote untouched bytes. In the example above ``0xac`` is
 the value written to the invalid address at offset 0, and the remaining '.'
 denote that no following bytes have been touched. Note that, real values are
-only shown for ``CONFIG_DEBUG_KERNEL=y`` builds; to avoid information
-disclosure for non-debug builds, '!' is used instead to denote invalidly
+only shown if the kernel was booted with ``no_hash_pointers``; to avoid
+information disclosure otherwise, '!' is used instead to denote invalidly
 written bytes.
 
 And finally, KFENCE may also report on invalid accesses to any protected page
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index cfe3d32ac5b7..3b8ec938470a 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -646,13 +646,9 @@ void __init kfence_init(void)
 
 	WRITE_ONCE(kfence_enabled, true);
 	schedule_delayed_work(&kfence_timer, 0);
-	pr_info("initialized - using %lu bytes for %d objects", KFENCE_POOL_SIZE,
-		CONFIG_KFENCE_NUM_OBJECTS);
-	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
-		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
-			(void *)(__kfence_pool + KFENCE_POOL_SIZE));
-	else
-		pr_cont("\n");
+	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
+		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
+		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
 }
 
 void kfence_shutdown_cache(struct kmem_cache *s)
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 1accc840dbbe..24065321ff8a 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -16,13 +16,6 @@
 
 #include "../slab.h" /* for struct kmem_cache */
 
-/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
-#ifdef CONFIG_DEBUG_KERNEL
-#define PTR_FMT "%px"
-#else
-#define PTR_FMT "%p"
-#endif
-
 /*
  * Get the canary byte pattern for @addr. Use a pattern that varies based on the
  * lower 3 bits of the address, to detect memory corruptions with higher
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index db1bb596acaf..4acf4251ee04 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -146,7 +146,7 @@ static bool report_matches(const struct expect_report *r)
 		break;
 	}
 
-	cur += scnprintf(cur, end - cur, " 0x" PTR_FMT, (void *)r->addr);
+	cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
 
 	spin_lock_irqsave(&observed.lock, flags);
 	if (!report_available())
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 901bd7ee83d8..4a424de44e2d 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -19,6 +19,8 @@
 
 #include "kfence.h"
 
+extern bool no_hash_pointers;
+
 /* Helper function to either print to a seq_file or to console. */
 __printf(2, 3)
 static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
@@ -118,7 +120,7 @@ void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *met
 	}
 
 	seq_con_printf(seq,
-		       "kfence-#%zd [0x" PTR_FMT "-0x" PTR_FMT
+		       "kfence-#%zd [0x%p-0x%p"
 		       ", size=%d, cache=%s] allocated by task %d:\n",
 		       meta - kfence_metadata, (void *)start, (void *)(start + size - 1), size,
 		       (cache && cache->name) ? cache->name : "<destroyed>", meta->alloc_track.pid);
@@ -148,7 +150,7 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
 	for (cur = (const u8 *)address; cur < end; cur++) {
 		if (*cur == KFENCE_CANARY_PATTERN(cur))
 			pr_cont(" .");
-		else if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+		else if (no_hash_pointers)
 			pr_cont(" 0x%02x", *cur);
 		else /* Do not leak kernel memory in non-debug builds. */
 			pr_cont(" !");
@@ -201,7 +203,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 
 		pr_err("BUG: KFENCE: out-of-bounds %s in %pS\n\n", get_access_type(is_write),
 		       (void *)stack_entries[skipnr]);
-		pr_err("Out-of-bounds %s at 0x" PTR_FMT " (%luB %s of kfence-#%zd):\n",
+		pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%zd):\n",
 		       get_access_type(is_write), (void *)address,
 		       left_of_object ? meta->addr - address : address - meta->addr,
 		       left_of_object ? "left" : "right", object_index);
@@ -210,24 +212,24 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 	case KFENCE_ERROR_UAF:
 		pr_err("BUG: KFENCE: use-after-free %s in %pS\n\n", get_access_type(is_write),
 		       (void *)stack_entries[skipnr]);
-		pr_err("Use-after-free %s at 0x" PTR_FMT " (in kfence-#%zd):\n",
+		pr_err("Use-after-free %s at 0x%p (in kfence-#%zd):\n",
 		       get_access_type(is_write), (void *)address, object_index);
 		break;
 	case KFENCE_ERROR_CORRUPTION:
 		pr_err("BUG: KFENCE: memory corruption in %pS\n\n", (void *)stack_entries[skipnr]);
-		pr_err("Corrupted memory at 0x" PTR_FMT " ", (void *)address);
+		pr_err("Corrupted memory at 0x%p ", (void *)address);
 		print_diff_canary(address, 16, meta);
 		pr_cont(" (in kfence-#%zd):\n", object_index);
 		break;
 	case KFENCE_ERROR_INVALID:
 		pr_err("BUG: KFENCE: invalid %s in %pS\n\n", get_access_type(is_write),
 		       (void *)stack_entries[skipnr]);
-		pr_err("Invalid %s at 0x" PTR_FMT ":\n", get_access_type(is_write),
+		pr_err("Invalid %s at 0x%p:\n", get_access_type(is_write),
 		       (void *)address);
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
 		pr_err("BUG: KFENCE: invalid free in %pS\n\n", (void *)stack_entries[skipnr]);
-		pr_err("Invalid free of 0x" PTR_FMT " (in kfence-#%zd):\n", (void *)address,
+		pr_err("Invalid free of 0x%p (in kfence-#%zd):\n", (void *)address,
 		       object_index);
 		break;
 	}
@@ -242,7 +244,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 
 	/* Print report footer. */
 	pr_err("\n");
-	if (IS_ENABLED(CONFIG_DEBUG_KERNEL) && regs)
+	if (no_hash_pointers && regs)
 		show_regs(regs);
 	else
 		dump_stack_print_info(KERN_ERR);
-- 
2.30.0.617.g56c4b15f3c-goog

