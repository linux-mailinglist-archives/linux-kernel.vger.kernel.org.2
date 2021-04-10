Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79C435AA09
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhDJBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhDJBxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A539DC061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so4079503pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzWN9CbYYC0uhkcf98vJtr/wJuyD5tOeLVZbkFqDQS8=;
        b=iHd53conVIlgasJzeoPi1hM+T738Qa+WqzwDIa6Bd4HckH9Cp+/ChGUXolCBMIGoWC
         oWHpOX1ZpeSdrJp2avUh+OZUFJ2+34X+qS7k5BfuPjXKDpVHaQ6PUIL/wYFqDz8BPKx1
         WJnKAVtDpX57vxNsxahUnTAwTodXXkL9Vi4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzWN9CbYYC0uhkcf98vJtr/wJuyD5tOeLVZbkFqDQS8=;
        b=mVedl0yNVKBS+hhlqUQwohnapuJKhuHK02Hk1ZcS+zJDyPE8FgKOCA/PiPVHSgphP0
         oUDhtqMExR9KUWWivQJMz2ZIPuXAwfE1SZzohwrRor1Z2o+6EACC/tgJjzadhJ0zwbY5
         RBOTKoz5xeq1LeedMaVPKoeahe5rFLyeu9E0SSfyI/X8GckSQbpCJ1Cng3HcPL/hPTFJ
         ByxJMw1vSVtN+eYpr+PveBL5RHLIoPak4xAX7keLywpdqtITHZIHT75hfIAfQEnVhgIu
         lGJVqPoWIVSiyUQwUdgvwEWS6VvgfK6djCAQpBhaj1rqu4dSRJBzRw7GObl29LusiTrI
         pIqQ==
X-Gm-Message-State: AOAM531ftoNeTkg/iLJOMrzN8Few2L7ViMseVVLoZLp31EFSyujmtso5
        wgBSqFL7Mv0csc9ulmWON9BTAw==
X-Google-Smtp-Source: ABdhPJwa+pYpyhMYTuUpHulE2rBVGusyrKO6RTsJudYO74iKiZJYKrHsc3Tb2Y8R92Asf5W7AkggLg==
X-Received: by 2002:a17:90b:3909:: with SMTP id ob9mr17103186pjb.181.1618019585284;
        Fri, 09 Apr 2021 18:53:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 04/13] dump_stack: Add vmlinux build ID to stack traces
Date:   Fri,  9 Apr 2021 18:52:51 -0700
Message-Id: <20210410015300.3764485-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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
 lib/Kconfig.debug | 11 +++++++++++
 lib/dump_stack.c  | 13 +++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..5f883e50f406 100644
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

