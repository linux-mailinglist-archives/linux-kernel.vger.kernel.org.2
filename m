Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E423297C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbhCAWxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbhCARtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97EC0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so2258438pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVE/bx78p1Ohby8zNkOl0gucO214tKEGiHBxBns0gcE=;
        b=btIgcCaxmiUVM7UT3OWA8BmJTk/+c1nEOdM0svmhEi9nk5egjF9B+0QBvn3lnf/FRA
         rT+mPQ5+r70N7VsXcJNHLcyBnKKK+62qrZ4kHjnB0Sc4klN6tEZFEfUXpyRAhc708CR6
         tsiKA76MZ869aNYNtOVtJXttdjk7gqq4/1VEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVE/bx78p1Ohby8zNkOl0gucO214tKEGiHBxBns0gcE=;
        b=gI0XU8jBJzthjEegrqwqkLTU0J3XCWVGy5nnbJ4e89UMNzx5SObLh7EwRf47Wl0Wtr
         ClXDXDj5maleCR6sFKmGrNb2ovtacWJcPJPOkh4jile9zZdHV9yo+3R8O/m4V8M8raXT
         Z4ODjLK1p4mZ3jseHur5H0pA6p67MvSukV2mY6BzNBpZuJbZ8dOfSoWhzQxNjKzOvyAy
         6sj0AlZTtriHoXZaaLa7pjseX2lUHEcOPaRDKNjFXMCgwddX7l3OLZDm5OZlIXmZVtOZ
         OnhVBB1RS5FAQkit9nyibtgwlUSgdFPWNNdC+l9hV84Htkvkzv7pSunQuL9zhb/xOLl1
         /+YA==
X-Gm-Message-State: AOAM530uUrzHjmSkdhpSQEAST7Q3ac44VZFjABfiP85oArqug5QYqr75
        ju0Fi8KYPz4CcpAFZmxAcC3vOw==
X-Google-Smtp-Source: ABdhPJwrvFxU7Q/80MZM4KbScQSB+h/ctW+FZFXvI60mjpQ5nrsQv63w9TpgKoqU+Df/w2w6ZjiXoQ==
X-Received: by 2002:a63:5703:: with SMTP id l3mr14760600pgb.344.1614620874530;
        Mon, 01 Mar 2021 09:47:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 2/7] dump_stack: Add vmlinux build ID to stack traces
Date:   Mon,  1 Mar 2021 09:47:44 -0800
Message-Id: <20210301174749.1269154-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the running kernel's build ID to the stacktrace information header.
This makes it simpler for developers to locate the vmlinux with full
debug info for a particular kernel stacktrace. Combined with
scripts/decode_stracktrace.sh a developer can download the correct
vmlinux from a debuginfod server and find the exact line number and file
for the functions in a stacktrace.

This is especially useful for pstore or crash debugging where the kernel
crashes and the recovery kernel may be different or the debug symbols
don't exist on the device due to space concerns. The stacktrace can be
analyzed after the crash with the matching vmlinux to understand where
in the function something went wrong.

Example stacktrace from lkdtm:

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc0134fbca0
 x29: ffffffc0134fbca0 x28: ffffff92d53ba240
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000000000000 x24: ffffffe3622352c0
 x23: 0000000000000020 x22: ffffffe362233366
 x21: ffffffe3622352e0 x20: ffffffc0134fbde0
 x19: 0000000000000008 x18: 0000000000000000
 x17: ffffff929b6536fc x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000012
 x13: ffffffe380ed892c x12: ffffffe381d05068
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000001 x8 : ffffffe362237000
 x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 0000000000000008 x2 : ffffff93fef25a70
 x1 : ffffff93fef15788 x0 : ffffffe3622352e0
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm]
  direct_entry+0x16c/0x1b4 [lkdtm]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace 3d95032303e59e68 ]---

The hex string aa23f7a1231c229de205662d5a9e0d4c580f19a1 is the build ID,
following the kernel version number.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/dump_stack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f5a33b6f773f..a13f3ea218d3 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/buildid.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -45,13 +46,13 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s %s\n",
 	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
+	       init_utsname()->version, vmlinux_build_id());
 
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
-- 
https://chromeos.dev

