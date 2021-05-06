Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83A13752A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEFKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhEFKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:55:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054A7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:54:10 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x6-20020a0cda060000b02901c4b3f7d3d9so3835014qvj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eT7PK1MfSj45qzsyr5rJofBwC+yPAyYAfH4B2yGSTNk=;
        b=MvlkqRk1Ya3oqXBoCPvWPVDaHZpwiYg9xXgMMSEFOSvtP8bPibdGJIQUlCq7BhPRzC
         9vW/5dkQrbV0SEZRwqEPqz4UJFY6185V27KIV6dZVlIYUnRRKadPG68/H3i4xPvjczOw
         2f53vvnLftyp08d1K+emWxJGSonZD819wIVfqYxmv6MMbZYMfwlqZDMXENbh9vYB7xmN
         m9qYIdYDaJuUuUV2dxwPTdVvd10Bkd02wBfZdcS9Af7y/vupbUVptDbPvWNBtZnNjpyZ
         gky/omQRCwbXZcvUvXXO+Vbd/DtO5lKCihAbNJIysl+P4jCRFCDetpBU5HRJD20hEaTv
         +GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eT7PK1MfSj45qzsyr5rJofBwC+yPAyYAfH4B2yGSTNk=;
        b=EivdmGRoXAu0nosJ3wzPycQKQHiDw98uGfVIM+xQzZuYSjpqmbwI6WRzR3ZJHnqzwd
         dfp5nxwcxP/YW5kJIqmfgbIwml4ahP9SqaPfq5MC0rZJmmrX0zNToHjt87BvnSmHlvhF
         B0GV6QmSeGjXAPIWIDhsVcDLXHjg02x5T4MTT5fPyeQwcGHDJsxuwFL3SRUpwJF4ELgc
         Mix3YmUOWZU958DOCkOXrYQiB1lLGmEf/E/9EDRIh+SPUzNKlIzmXjZIhjjyv/zgry+u
         psEGya7sTFXgS2Qjft2uQmqqKz4NtvbrkIwIxCr8gNoXSPSFtNNxXs8wnXXN/oL4aOip
         cl/Q==
X-Gm-Message-State: AOAM5318KXLdIoJQi1XNqi8oe2ombCTXV44uTsBqdmwKJjjAr4Fw1Itd
        1cu4z6iiolDE1ekDZu50NTpLwleouM4=
X-Google-Smtp-Source: ABdhPJyc+tQqnZ+TKycxxwOIKHbu/+si7EvDzckjH/oJQY4JiOqj4ec+eRvV8dLxJfYBCyco3PEXBqfvu9M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:14b:3523:e987:8aa8])
 (user=glider job=sendgmr) by 2002:a05:6214:c2d:: with SMTP id
 a13mr3480060qvd.37.1620298449149; Thu, 06 May 2021 03:54:09 -0700 (PDT)
Date:   Thu,  6 May 2021 12:54:04 +0200
Message-Id: <20210506105405.3535023-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 1/2] printk: introduce dump_stack_lvl()
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

v2:
 -- export dump_stack_lvl() (spotted by Marco Elver)
---
 include/linux/printk.h |  1 +
 lib/dump_stack.c       | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

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
index f5a33b6f773f..586e3f2c6a15 100644
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
@@ -125,9 +125,15 @@ asmlinkage __visible void dump_stack(void)
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
+EXPORT_SYMBOL(dump_stack_lvl);
+
+asmlinkage __visible void dump_stack(void)
+{
+	dump_stack_lvl(KERN_DEFAULT);
+}
 EXPORT_SYMBOL(dump_stack);
-- 
2.31.1.527.g47e6f16901-goog

