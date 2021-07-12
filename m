Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71E3C5EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhGLPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGLPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:20:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B53C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:17:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so22758358ybp.17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F183fJF48DpZvlb4sVM7Y2bwjFLi2q0xYlbUr8FWRkE=;
        b=f0JkJ7lvBJfJtIAjU6wL7qzRJ62AYz6RjtViMo2dXx101iMEkCske1jkFG6HF6TsJJ
         8K7DhyLGDRhHyz5SJZb6FXFd08PB9Qef++AvYTElwJt5L5mwHycJXbLnn+iKr3XNvy6v
         hfUvYpCUpo0DtDUw2UOYlfESWpKaa4Mv0PAmCxP3PXKY9DPTTDXA0rVkF4YhscI2Zc5H
         cpgxyT+fasSHS24W0ngZG1RlXXXD7exhN6Fdiq4fBYpzeC3FsFLimnEd6P9o7d9/GAGy
         HD3jN6QmDGDu3cInXg8Qa4WlqAU0sJCYkZ6HA1pzRzFohuss9UT1f0CUMlGrYz/MC0Lz
         fSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F183fJF48DpZvlb4sVM7Y2bwjFLi2q0xYlbUr8FWRkE=;
        b=St6hFQYBbnP/R61R4fplwJoVwrTY5r8doAQ2much7sk4QG8CPqEhrcfzyUe2T9W6Z9
         jBekWEAUtqcXGJZ6uIWg3LZPIGKoBiV7AeiV4Alkv61+hcrzZejeLnc/URoQH+B3Znu8
         O+mCNqMlqpvtbqddRjz7TI66pfgYabk6dtFK83LVbOAoYVPFk3XxFr6XohgaqpDJjgad
         NbTZOnXr6IhVlntuhtqNafdawHtn4mt9W9fBMHzuqHFaH00GEXeBMqbq5mh4H4F3Z81e
         2vrUr4Ka6jx/sO7RYUFW9kxve607/iLVs2igxZNjWxjmvLASHJxbdCGM4TrXFyJAuwdS
         7y5g==
X-Gm-Message-State: AOAM530p8TU0zkKQfHFTZvxiFyA1Tr/BE04hJz2KI89qMil6wXJXY4Kd
        gSbZOKwkZNIs4OZMmGcVpbeUelMcIqx38A==
X-Google-Smtp-Source: ABdhPJxDkRH1i50vWXcU/dGZQhUI5goWEwRgfXl39ENxqBS+H3PWEjl5MQeb+f9trduPLydFdzfIn6+6Z79tgw==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:8c53:eec1:7238:4b4e])
 (user=woodylin job=sendgmr) by 2002:a25:6046:: with SMTP id
 u67mr62050233ybb.6.1626103038450; Mon, 12 Jul 2021 08:17:18 -0700 (PDT)
Date:   Mon, 12 Jul 2021 23:16:18 +0800
Message-Id: <20210712151618.1549371-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] mm/kasan: move kasan.fault to mm/kasan/report.c
From:   Woody Lin <woodylin@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
 Documentation/dev-tools/kasan.rst |  2 ++
 mm/kasan/hw_tags.c                | 43 -------------------------------
 mm/kasan/report.c                 | 29 ++++++++++++++++++---
 3 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 83ec4a556c19..ab8e27d45632 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -203,6 +203,8 @@ boot parameters that allow disabling KASAN or controlling its features.
   report or also panic the kernel (default: ``report``). The panic happens even
   if ``kasan_multi_shot`` is enabled.
 
+  Note: The boot parameter 'kasan.fault' is supported by all KASAN modes.
+
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

