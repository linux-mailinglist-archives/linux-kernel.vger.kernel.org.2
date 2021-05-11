Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AF379BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEKAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhEKAj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:39:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3174FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so441791pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ynYGl5UzCAI8Z+mYNfO53zDfkVZf3g2YtZ7n0ejF90=;
        b=nJvjKvnJ460aSmch34NXJ3pvJo3t9mXPHmCQycIbc+WjzGnivPlZpA/8aMvcdM/R0M
         XlLDshHQZ6fM+H7ZIcj2PHhfT18xbTsm/nlliTFrUxLmOT3zYZoZEfTOsmBQ1r3CPAfp
         y/vyWrzETcrkvX76Cu2WAemCticVDxvxdRwaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ynYGl5UzCAI8Z+mYNfO53zDfkVZf3g2YtZ7n0ejF90=;
        b=MCHBRzz2vSnbCTwBYfT6t7NvryHdwpq5pizuOrPqkVwSx4r0yFaLxHbEJI31A+3DTR
         AkER1PF83YG2TYe4fb0mjlEudnsKFcMneMmYPRhLs4TBMkSB9f1DJ1/ZtSVSFTMW+Hqq
         d5kj2yiarr55zXpPhrrEksrD0DhP8Wj1Dkff9m1cJCxLbIvGp84kp8EyiEddJPk+2dWU
         QjLGNmEyiTiiD6uoqxXKgrbjGlm1KejsBb9ApTM0p6KY7IwwdhP+QRIiwQCADHXNAMZE
         geStHUhG7Pw43sdQxLQWnNombB3WTggRH+9LrOyHcPYPR2KmoioZaNNI4Tuew6nEb6HM
         yRAQ==
X-Gm-Message-State: AOAM5309JmGJj/SmnH3r+4jp87cXbhVcMdTjkbsqjavRzjdJdqPCNJ8y
        4fBxYnS7yiu9ZFvobqL6TQLveQ==
X-Google-Smtp-Source: ABdhPJwAV7xZmINgh+oWPLXJvfbM4Kx+zzH20VMGDU/BddtUznv9KSXSUoaTQWSHBwCyAw/sqNTdNg==
X-Received: by 2002:a17:902:9006:b029:ed:7f89:49d8 with SMTP id a6-20020a1709029006b02900ed7f8949d8mr27257048plp.52.1620693532750;
        Mon, 10 May 2021 17:38:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 04/13] dump_stack: Add vmlinux build ID to stack traces
Date:   Mon, 10 May 2021 17:38:36 -0700
Message-Id: <20210511003845.2429846-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the running kernel's build ID[1] to the stacktrace information
header.  This makes it simpler for developers to locate the vmlinux with
full debuginfo for a particular kernel stacktrace. Combined with
scripts/decode_stracktrace.sh, a developer can download the correct
vmlinux from a debuginfod[2] server and find the exact file and line
number for the functions plus offsets in a stacktrace.

This is especially useful for pstore crash debugging where the kernel
crashes are recorded in the pstore logs and the recovery kernel is
different or the debuginfo doesn't exist on the device due to space
concerns (the data can be large and a security concern). The stacktrace
can be analyzed after the crash by using the build ID to find the
matching vmlinux and understand where in the function something went
wrong.

Example stacktrace from lkdtm:

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]

The hex string aa23f7a1231c229de205662d5a9e0d4c580f19a1 is the build ID,
following the kernel version number. Put it all behind a config option,
STACKTRACE_BUILD_ID, so that kernel developers can remove this
information if they decide it is too much.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  4 ++++
 lib/Kconfig.debug       | 11 +++++++++++
 lib/buildid.c           |  2 ++
 lib/dump_stack.c        | 13 +++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index f375900cf9ed..3e8d77a93ec4 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,7 +10,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
 void init_vmlinux_build_id(void);
+#else
+static inline void init_vmlinux_build_id(void) { }
+#endif
 
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 417c3d3e521b..aa6d8e528879 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,17 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config STACKTRACE_BUILD_ID
+	bool "Show build ID information in stacktraces"
+	depends on PRINTK
+	help
+	  Selecting this option adds build ID information for symbols in
+	  stacktraces printed with the printk format '%p[SR]b'.
+
+	  This option is intended for distros where debuginfo is not easily
+	  accessible but can be downloaded given the build ID of the vmlinux or
+	  kernel module where the function is located.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
diff --git a/lib/buildid.c b/lib/buildid.c
index 1103ed46214f..6f1e2903740b 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -174,6 +174,7 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
 
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
 
 /**
@@ -187,3 +188,4 @@ void __init init_vmlinux_build_id(void)
 
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
 }
+#endif
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f5a33b6f773f..d685331b065f 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/buildid.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -36,6 +37,14 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
 	va_end(args);
 }
 
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#define BUILD_ID_FMT " %20phN"
+#define BUILD_ID_VAL vmlinux_build_id
+#else
+#define BUILD_ID_FMT "%s"
+#define BUILD_ID_VAL ""
+#endif
+
 /**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
@@ -45,13 +54,13 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT "\n",
 	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
+	       init_utsname()->version, BUILD_ID_VAL);
 
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
-- 
https://chromeos.dev

