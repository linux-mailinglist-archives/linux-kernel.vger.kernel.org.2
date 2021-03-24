Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D11346F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhCXCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhCXCFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:05:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836AC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t18so10907949pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWsj2DeYWnLc9/yzhhDbW3exI1i+s3CCqepcW30l9Lc=;
        b=MydlPqdxPD/RZXfJGvGivV590W54/wXYFSVVKfQ4Zua9apxErbRo+qQ+GEKOEn6iPS
         IfCpFtjdKPuI2DdvFpj+IBTmag/xJnZjtmzqyhLOTjf0dRTUsWYHXzVSEorR8zy0wliy
         8b90K9p/IG0Y5N1XewofVX5QvPaxdeTVpkbXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWsj2DeYWnLc9/yzhhDbW3exI1i+s3CCqepcW30l9Lc=;
        b=Sswq4/tQBZB0FZK/DImu+/pJH289EYLcsCniWk/LtlzR+7wCOBOq4aILiO2bM0By+P
         cdU1hH9yzxkoeZTHLU3qKFBPuIDTG+J7qwH5CR7PcQ1DzXgDNlAjX0m1xZ/uITkQmd6t
         ULo0rsKXOpI4b5KSJUrT2btsdh2+ZbDqc/rTGw5AYIjvmNezCVQCElfwPKlyn22CR4Ze
         MALKZDZCQKDxutsW4381YiY8GmmoWhDH+a6ZId5s/3evCkBorCZjiJsKGRw9c0ShV74w
         i2cTbX16slkeSMhgp1fPu40WbCfh5prx4BtSpZDeNGDPSPsGWK9kkTWUrKrUJrrrIH38
         zwWA==
X-Gm-Message-State: AOAM531LJeLp8lqvlo/fTgAQ5SkvbGaQ9qkvIREAvLvHLgXVHwgCZM+C
        vCuavLBlRc29K2yV1yP8n//MMj3Xp4mi8w==
X-Google-Smtp-Source: ABdhPJwQUYj+45m7nIwY+1Mq5EuK8+aJBVx6aojuHt2uebSXGTgGoQuwt6m7tgpqZU+wQSmouFaGGw==
X-Received: by 2002:a17:90a:f0c9:: with SMTP id fa9mr951129pjb.39.1616551489955;
        Tue, 23 Mar 2021 19:04:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:49 -0700 (PDT)
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
Subject: [PATCH v2 03/12] dump_stack: Add vmlinux build ID to stack traces
Date:   Tue, 23 Mar 2021 19:04:34 -0700
Message-Id: <20210324020443.1815557-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/dump_stack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f5a33b6f773f..136bb942c4a3 100644
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
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s %20phN\n",
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

