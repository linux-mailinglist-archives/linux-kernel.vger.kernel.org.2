Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7093E459B77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKWFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhKWFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:20 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso11101892pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8YikxNtJWprMq/CBpWme0BytzCpItwTnBs0JI4g7h9M=;
        b=lr6jU+zyqsyUdEReZStYl3G49ZtLUI4FRjCCI6LwgfA4iWEF/hAOiHguW2mLPV1Jtb
         biEpdOkX+tP/eucrb3hTSTUeEZAA8IsY+FefkgpQdDEGEyBdG88kn1vOx1Hd751cdqgq
         RLanQtSikpeJXqg6AAuW28D/m0PfuXZK4I3yzqPhN9RlTWTcekgjkOvF6Vsxi5lwEeNy
         4wfRl9Z9bjQSpxQaX89JGaOgKUnGpJjW2R81rbPp9qxmxlZ8OBNbEJVP3Maxvx6n4LeI
         PP+461MV/ampBKAJSBy4cJER48/666Tg+Hr3u6I8bSlmmHSp8KueiAApUUGR5RSamMw5
         uFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8YikxNtJWprMq/CBpWme0BytzCpItwTnBs0JI4g7h9M=;
        b=QYNF1D2FzaxJ8rYECdEYk3q8yt/v67E8PqntEPjHbgwuEGcLrReHHLnmoNs4vkK63Q
         hgPMG7wzf4am3Ydb3L/keekXqJ0oZkQkryQGlw5KwNGx+jCW/IsAsq8CTnNgmueO2fmD
         q0pAr/1N4o+bWifB0lFYVJMHg2i4Io8VK0X+f8TWFrt5ZxXRYTcrvTeWkK8xI2kHXJ4W
         IFOO5GUVWxsOeQw9Uugdkc7uuN3e3ZYMKAfvc/i8mvFNDC3uCoqZUtWxoUoogIX4KHGt
         gAWuQ2P0onLTsotIBUiibO0Vpd4+frs9zZBOPFCy9AYCviUAQQ7YedoN/0KY1veDB+lu
         d4PQ==
X-Gm-Message-State: AOAM5313nhwraBHSBHqqHRjtuY4NmVe+IJuUr5TtB9HKYMSSEgou8GQp
        6NwktbcMYA8nPg06k3qRCnoZkKQ=
X-Google-Smtp-Source: ABdhPJwFUF+MOVa4cKF7Nt3P3AYhZy5krLbbXlzRU0jE0MJn5GpfDjdnS4lCLzffhUcQ+vx5zPvE5Jk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a876:2e6a:b5f:3d90])
 (user=pcc job=sendgmr) by 2002:a17:90a:a396:: with SMTP id
 x22mr3308358pjp.14.1637644632438; Mon, 22 Nov 2021 21:17:12 -0800 (PST)
Date:   Mon, 22 Nov 2021 21:16:56 -0800
In-Reply-To: <20211123051658.3195589-1-pcc@google.com>
Message-Id: <20211123051658.3195589-4-pcc@google.com>
Mime-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 3/5] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uaccess logging support on architectures that use
CONFIG_GENERIC_ENTRY (currently only s390 and x86).

Link: https://linux-review.googlesource.com/id/I3c5eb19a7e4a1dbe6095f6971f7826c4b0663f7d
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 arch/Kconfig          | 1 +
 kernel/entry/common.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6030298a7e9a..bc9cdbfdb57e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -31,6 +31,7 @@ config HOTPLUG_SMT
 	bool
 
 config GENERIC_ENTRY
+       select HAVE_ARCH_UACCESS_BUFFER
        bool
 
 config KPROBES
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5..e06f88f77a70 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/uaccess-buffer.h>
 
 #include "common.h"
 
@@ -89,6 +90,8 @@ __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 	if (work & SYSCALL_WORK_ENTER)
 		syscall = syscall_trace_enter(regs, syscall, work);
 
+	uaccess_buffer_syscall_entry();
+
 	return syscall;
 }
 
@@ -197,14 +200,17 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	bool uaccess_buffer_pending;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
+	uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
+	uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -271,6 +277,7 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 			local_irq_enable();
 	}
 
+	uaccess_buffer_syscall_exit();
 	rseq_syscall(regs);
 
 	/*
-- 
2.34.0.rc2.393.gf8c9666880-goog

