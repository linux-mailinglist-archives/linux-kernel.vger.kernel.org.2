Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1D34F725
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhCaDFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhCaDF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8ECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w8so8766439pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wsTLIIw7+y8v2jyNC2LbraKjpJpaIpFe+dOzwsLwG8=;
        b=JHkKnhv3JhlznRU5kOoHXkmpF/Li1MYxBu3jCLLOeAN7/lY8HJ/46oFCBFIg4C2UF3
         0bAHlTInztl+pWcWG2p+gQBxroNI/EDjRTAAKkG1/Sx0ZFP963ge2pmwVPYlz4gsk1Ma
         FYJqQpfUSej9mjPQuLlDedbjOka7y0vuyvfm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wsTLIIw7+y8v2jyNC2LbraKjpJpaIpFe+dOzwsLwG8=;
        b=KD//1LDD3PXd2dkoIk2BPq62TMURdAON+1ytMp+0nIwMZus68oZ9gDWonJ7YeY1GCz
         qwIMelKjKXmPOiGrWuvlR0yUyBwCyGaHM8ejF73QmThh6GDh6EFu39sQlC5MZvPN08bJ
         r+o8+wsqdbiO7CgmO/DoxtPqzoKoQa4OppBc2/Y72IE5YZNuPR/1POcD0WEDQITq9Yu3
         fQ9A9U6BuRK0Tv0iJVijrSRVc0bsVoV1oX1hwzLQ7CtpAC0v9D7QSlwhhFbjSAVLR1Sx
         mjr/MTtvbwcP0s3U3x5NNAtwjJdsCeDME+dSGcAh5/s67cTbYVt2fpcG7MmZs3GNEACu
         SVgw==
X-Gm-Message-State: AOAM5336QI8DsWTkkybKs27mHbEvjrG1XUZfGp/viIOlitI/PngEDMTw
        0hodr5pApCYGLxIc1ucNCwE4iA==
X-Google-Smtp-Source: ABdhPJzk98d6xgkVDojYFbNEpsr6KuTCT8ob4LSASrQr/PjxS3hXf3Ti799g+JSmlCkR35pLj8rdpg==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr1332898pjh.29.1617159927057;
        Tue, 30 Mar 2021 20:05:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:26 -0700 (PDT)
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
Subject: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
Date:   Tue, 30 Mar 2021 20:05:11 -0700
Message-Id: <20210331030520.3816265-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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
 lib/dump_stack.c  | 12 ++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index f5a33b6f773f..07e0214c2d4d 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/buildid.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -36,6 +37,12 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
 	va_end(args);
 }
 
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#define BUILD_ID_STR " %20phN"
+#else
+#define BUILD_ID_STR "%s"
+#endif
+
 /**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
@@ -45,13 +52,14 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_STR "\n",
 	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
+	       init_utsname()->version,
+	       IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) ? vmlinux_build_id : "");
 
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
-- 
https://chromeos.dev

