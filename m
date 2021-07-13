Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2691C3C67D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGMBK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhGMBK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:10:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99EC0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:07:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l11-20020a056902072bb029055ab4873f4cso24757834ybt.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7H0LpH2GONNn9NZv/9WQ2DtXytau5fXoMsvDyHJxp/k=;
        b=dTAoo+q0qbQgCS41Gdj1LWtAie7mvnRvIbE6SOosY1cmw0UIQPBZPzSQ3OxVOodjIc
         XNrqpXxoLbkVyDLOBT5N7DFyBDuRuo9Ut+9Ytrliq2+tLJR9d7dxannIfJaJMwp9TUCd
         rcCk66OU5WvubvAv0CUp6kx8whXhaLAuXh75F/ubnHdtrxWDP/KjasZyLGs4EVmsWEol
         VlCMwvZUtFBoa3tDU3Nnd/qG6YBuYxkC6F32CN8qw9BXxinhqayPoAgOhscO0IywLr8t
         urbUi2VBSxIlQrSjPgfvLMCS/ptotR9UuS0eEcsjOH6x6D2KnUox86HEFgD7pP0VPlsJ
         Sl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7H0LpH2GONNn9NZv/9WQ2DtXytau5fXoMsvDyHJxp/k=;
        b=rUsYV+IqHbymQZIS6A2yTxYiT6ivaHvWl6+xeG76vKvMZOS7sNA3H9F3iau6tCaL28
         Jq7kUcjUxI9VtBPSpAznZM8q2TPQjpEOIWkiKe9AV7AygHK59Z2VzEPuUfGmhxjzsnvH
         GNdJ9cCeTkaxJmF/5A2iRKRPBoGTyDFzqnC6Z6vtPFwB7GxdPEy/z5fz1Q7ssJPf/OmS
         Nypx9ovqKC/THm/iePeU0HV7jxX1g3RNcoM8NgdmmEXnxQm3+z2iRXUlTk8n/TJgUsO6
         Gr3pnleIhndhuDaImQzHXjSq74bhjLuvyjohs9mgIruPQZ62cYSBrfD2PQZV63b9uqDy
         IwTQ==
X-Gm-Message-State: AOAM533YPEPTtgTDllQf7x1UsLoLQtclGb75XkQRhY7g7Z0nkTWqf26f
        UzxywUQ7QEUGSmoCRljQrvFnjEpqPC1qkQ==
X-Google-Smtp-Source: ABdhPJzVEPryMD2mdP4K1xXXE739W7TL0c7V7rfydnJFmN5qonRJOWwtYyr1uQ+585D/H+aJMYCj2sfMgRSxQQ==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:e7ee:3440:9a37:23d8])
 (user=woodylin job=sendgmr) by 2002:a5b:b01:: with SMTP id
 z1mr2302389ybp.341.1626138457207; Mon, 12 Jul 2021 18:07:37 -0700 (PDT)
Date:   Tue, 13 Jul 2021 09:05:36 +0800
Message-Id: <20210713010536.3161822-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] mm/kasan: move kasan.fault to mm/kasan/report.c
From:   Woody Lin <woodylin@google.com>
To:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Woody Lin <woodylin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the boot parameter 'kasan.fault' from hw_tags.c to report.c, so it
can support all KASAN modes - generic, and both tag-based.

Signed-off-by: Woody Lin <woodylin@google.com>
---
 Documentation/dev-tools/kasan.rst | 13 ++++++----
 mm/kasan/hw_tags.c                | 43 -------------------------------
 mm/kasan/kasan.h                  |  1 -
 mm/kasan/report.c                 | 29 ++++++++++++++++++---
 4 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 83ec4a556c19..21dc03bc10a4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -181,9 +181,16 @@ By default, KASAN prints a bug report only for the first invalid memory access.
 With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
 effectively disables ``panic_on_warn`` for KASAN reports.
 
+Alternatively, independent of ``panic_on_warn`` the ``kasan.fault=`` boot
+parameter can be used to control panic and reporting behaviour:
+
+- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
+  report or also panic the kernel (default: ``report``). The panic happens even
+  if ``kasan_multi_shot`` is enabled.
+
 Hardware tag-based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore, it supports
-boot parameters that allow disabling KASAN or controlling its features.
+additional boot parameters that allow disabling KASAN or controlling features:
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
@@ -199,10 +206,6 @@ boot parameters that allow disabling KASAN or controlling its features.
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on``).
 
-- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``). The panic happens even
-  if ``kasan_multi_shot`` is enabled.
-
 Implementation details
 ----------------------
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 4ea8c368b5b8..51903639e55f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -37,16 +37,9 @@ enum kasan_arg_stacktrace {
 	KASAN_ARG_STACKTRACE_ON,
 };
 
-enum kasan_arg_fault {
-	KASAN_ARG_FAULT_DEFAULT,
-	KASAN_ARG_FAULT_REPORT,
-	KASAN_ARG_FAULT_PANIC,
-};
-
 static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
-static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
 
 /* Whether KASAN is enabled at all. */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
@@ -59,9 +52,6 @@ EXPORT_SYMBOL_GPL(kasan_flag_async);
 /* Whether to collect alloc/free stack traces. */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 
-/* Whether to panic or print a report and disable tag checking on fault. */
-bool kasan_flag_panic __ro_after_init;
-
 /* kasan=off/on */
 static int __init early_kasan_flag(char *arg)
 {
@@ -113,23 +103,6 @@ static int __init early_kasan_flag_stacktrace(char *arg)
 }
 early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
 
-/* kasan.fault=report/panic */
-static int __init early_kasan_fault(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (!strcmp(arg, "report"))
-		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
-	else if (!strcmp(arg, "panic"))
-		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-early_param("kasan.fault", early_kasan_fault);
-
 /* kasan_init_hw_tags_cpu() is called for each CPU. */
 void kasan_init_hw_tags_cpu(void)
 {
@@ -197,22 +170,6 @@ void __init kasan_init_hw_tags(void)
 		break;
 	}
 
-	switch (kasan_arg_fault) {
-	case KASAN_ARG_FAULT_DEFAULT:
-		/*
-		 * Default to no panic on report.
-		 * Do nothing, kasan_flag_panic keeps its default value.
-		 */
-		break;
-	case KASAN_ARG_FAULT_REPORT:
-		/* Do nothing, kasan_flag_panic keeps its default value. */
-		break;
-	case KASAN_ARG_FAULT_PANIC:
-		/* Enable panic on report. */
-		kasan_flag_panic = true;
-		break;
-	}
-
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 98e3059bfea4..9d57383ce1fa 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -36,7 +36,6 @@ static inline bool kasan_async_mode_enabled(void)
 
 #endif
 
-extern bool kasan_flag_panic __ro_after_init;
 extern bool kasan_flag_async __ro_after_init;
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8fff1825b22c..884a950c7026 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -39,6 +39,31 @@ static unsigned long kasan_flags;
 #define KASAN_BIT_REPORTED	0
 #define KASAN_BIT_MULTI_SHOT	1
 
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+	KASAN_ARG_FAULT_REPORT,
+	KASAN_ARG_FAULT_PANIC,
+};
+
+static enum kasan_arg_fault kasan_arg_fault __ro_after_init = KASAN_ARG_FAULT_DEFAULT;
+
+/* kasan.fault=report/panic */
+static int __init early_kasan_fault(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "report"))
+		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
+	else if (!strcmp(arg, "panic"))
+		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.fault", early_kasan_fault);
+
 bool kasan_save_enable_multi_shot(void)
 {
 	return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
@@ -102,10 +127,8 @@ static void end_report(unsigned long *flags, unsigned long addr)
 		panic_on_warn = 0;
 		panic("panic_on_warn set ...\n");
 	}
-#ifdef CONFIG_KASAN_HW_TAGS
-	if (kasan_flag_panic)
+	if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
 		panic("kasan.fault=panic set ...\n");
-#endif
 	kasan_enable_current();
 }
 
-- 
2.32.0.93.g670b81a890-goog

