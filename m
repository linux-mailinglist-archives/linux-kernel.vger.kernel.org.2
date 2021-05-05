Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49A737376D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEEJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhEEJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:24:29 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F217C061249
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 02:22:24 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id c2-20020a1cb3020000b029013850c82dbcso1378818wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wCz4gV2e+5K4MB6JxYwBbscE6sKEio407rEyY2MGY98=;
        b=S6kUPs22EGrft6blYtjEGYMOKkcseB7dyKRuvHwv6FWPqqI+3IgTwzCDzAJYunFAlK
         PZibgqo49jDOi88DI3Ds2n4ps/UPu7d4khBB9C3e6p2aw1Upe4iAk0nyqPHTCuf7gVES
         EYzW8ztOP2rdzgRxWlSb7YFDit/YkngZnwhuW2GaUWFP4H0LJ6G8jmLcsken7yHwkhRv
         r705tCbA2ixHADImSZcNePR+HtWQvUpFauE5+BRkxHXcg3T9kPOeF98hND723lUcoBan
         nzo+rxoiDUEVwHfBChF5CaxGUmsOGvCJlsIL7w4ZYGdq7ax7E4b/SzgIyo0A0fhSqAIA
         PiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wCz4gV2e+5K4MB6JxYwBbscE6sKEio407rEyY2MGY98=;
        b=QElEkte4rPTIoEk3qVKQVp74OhXOWJ14flhf6lIPpgtxrkEW8Z8uPMERrYNzRR2AS0
         B5yFa3BL8RpoC1A1mhtNZoi3Pc7dGD3H+5fyqD/O3qFLL3+SIVSWxUPNaVFSEZPxVkfJ
         nKlmrta7oykET2cR6wVLXCkBsEuxjADbqnScrG95pQMUssyaMBkpJf6271HtgvcONt4x
         0udqyNNkpOhiG2TJ19YoWx1vTVSMVMnNsI1N/GtL6wmXvV65Q/jGUMD0yobFSPbSrt4d
         cRToumcPJe8UBJPID6PzbDmsI3ydNve9y0vuChJM0z6p2G9J8c/Ly6RlUXWBtKhPCtQn
         lnjQ==
X-Gm-Message-State: AOAM532Q7JTiULpsP377Curus/YdmmX0EBwkodEZrnkGNv9DoPRiNHwk
        xl5NrydkZ701cX9tKrVMGkRezp0A5ww=
X-Google-Smtp-Source: ABdhPJxTQtjw8VeY7Gb9pY/BwC0VE8mLm/Fu+gF+SYKk7/L83qteJIjgq8IlITJ8HulfMAX1AWBVgKSBdqM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:75a3:1d6a:25a4:791b])
 (user=glider job=sendgmr) by 2002:a05:600c:b4c:: with SMTP id
 k12mr8976119wmr.186.1620206542513; Wed, 05 May 2021 02:22:22 -0700 (PDT)
Date:   Wed,  5 May 2021 11:22:17 +0200
Message-Id: <20210505092218.2422386-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 1/2] printk: introduce dump_stack_lvl()
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, mingo@kernel.org
Cc:     bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>, he@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_stack() is used for many different cases, which may require a log
level consistent with other kernel messages surrounding the dump_stack()
call.
Without that, certain systems that are configured to ignore the default
level messages will miss stack traces in critical error reports.

This patch introduces dump_stack_lvl() that behaves similarly to
dump_stack(), but accepts a custom log level.
The old dump_stack() becomes equal to dump_stack_lvl(KERN_DEFAULT).

A somewhat similar patch has been proposed in 2012:
https://lore.kernel.org/lkml/1332493269.2359.9.camel@hebo/
, but wasn't merged.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: he, bo <bo.he@intel.com>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/printk.h |  1 +
 lib/dump_stack.c       | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..abe274305d79 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -206,6 +206,7 @@ void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
+extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f5a33b6f773f..3d2c324a4929 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -73,10 +73,10 @@ void show_regs_print_info(const char *log_lvl)
 	dump_stack_print_info(log_lvl);
 }
 
-static void __dump_stack(void)
+static void __dump_stack(const char *log_lvl)
 {
-	dump_stack_print_info(KERN_DEFAULT);
-	show_stack(NULL, NULL, KERN_DEFAULT);
+	dump_stack_print_info(log_lvl);
+	show_stack(NULL, NULL, log_lvl);
 }
 
 /**
@@ -87,7 +87,7 @@ static void __dump_stack(void)
 #ifdef CONFIG_SMP
 static atomic_t dump_lock = ATOMIC_INIT(-1);
 
-asmlinkage __visible void dump_stack(void)
+asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
 	unsigned long flags;
 	int was_locked;
@@ -117,7 +117,7 @@ asmlinkage __visible void dump_stack(void)
 		goto retry;
 	}
 
-	__dump_stack();
+	__dump_stack(log_lvl);
 
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
@@ -125,9 +125,14 @@ asmlinkage __visible void dump_stack(void)
 	local_irq_restore(flags);
 }
 #else
-asmlinkage __visible void dump_stack(void)
+asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
-	__dump_stack();
+	__dump_stack(log_lvl);
 }
 #endif
+
+asmlinkage __visible void dump_stack(void)
+{
+	dump_stack_lvl(KERN_DEFAULT);
+}
 EXPORT_SYMBOL(dump_stack);
-- 
2.31.1.527.g47e6f16901-goog

