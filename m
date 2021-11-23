Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17B3459B79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhKWFUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhKWFUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:22 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F563C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x9-20020a056a00188900b0049fd22b9a27so11090043pfh.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gty7Zd/Q5CRamg0gViS3X7VJ+4Eadmw90vku2OpMNR0=;
        b=i/FXNGYOe6PsaAxbsnm5RGEXWjnL3mlA0e019XvhMTOJ5jD4eah5o10OrcCelr/+Kl
         ZCM2ArN5xFg4uUGA14TEzzB9T6xMiVV8vnTqfAgIA8oDmPxZX9uO0g4m7cJz9wDoE60I
         8PaUFXRlW0g5PbblIX6ZjKKdA3R5nPolWGTC0LJY/1HADB+JZ2PXA/qgv2/Vd6DLk0x1
         ACkLigqPuw73RSKSoes5ibDH1aSgWsx5znBsEbKJQ9O9Du1eZTpBTNjVVNtCXH1cLSxM
         UUhv9tSV/ymEW9G/ux+VJtX/iMdy7Ce7KVAUyVi8CHOlReV4hJ1wZRr6H01xEcm3nU4K
         I2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gty7Zd/Q5CRamg0gViS3X7VJ+4Eadmw90vku2OpMNR0=;
        b=1jJH85uf0aQsfrGD+tt7ilVAfoYLq89teYXHa5dGnHDH5psg7+WDQSnrfWeSZFdSV7
         i5VS+72idqsKjucah8+ET5C7A/+Ns2JgX2HKDFhnx1bQGJQQLOfYXSFszWfp0hBB1tnt
         PBiF+5v3/T7xSw7bCHxFDKqox8O3xHmY7EsCz23W6ZqhlLVAh9USCHl3dDtrzyWaxEb0
         EV2O4LRfdhhWBYrbIFbWsLF5F0thqEI7Je+fqU9waeyXmfU4pJDMWDETtW37UQKCC8lh
         OttS0iABN5CJh1pbvhBkEvyV1qdF+geaEa/a7/BlmGOEJsQ8frCn35IFgJXxihbxzHsY
         X4mg==
X-Gm-Message-State: AOAM532QUTA3FddqMCMZAzksHqmvFGcIN0Efv3FJBitA0fcJtxTMEnFl
        oGf3W2ORMWExpdzxhBn1tdXsXJo=
X-Google-Smtp-Source: ABdhPJziBKpM/iqN33lOv4N3gylj/M4b6xWwzkHJc9LwUilKQIHPk1Gw7F/oNFYL6WWGZcDAEEVvryk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a876:2e6a:b5f:3d90])
 (user=pcc job=sendgmr) by 2002:a05:6a00:b4c:b0:481:2a:f374 with SMTP id
 p12-20020a056a000b4c00b00481002af374mr2413056pfo.60.1637644634614; Mon, 22
 Nov 2021 21:17:14 -0800 (PST)
Date:   Mon, 22 Nov 2021 21:16:57 -0800
In-Reply-To: <20211123051658.3195589-1-pcc@google.com>
Message-Id: <20211123051658.3195589-5-pcc@google.com>
Mime-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 4/5] arm64: add support for uaccess logging
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

arm64 does not use CONFIG_GENERIC_ENTRY, so add the support for
uaccess logging directly to the architecture.

Link: https://linux-review.googlesource.com/id/I88de539fb9c4a9d27fa8cccbe201a6e4382faf89
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/kernel/signal.c  | 5 +++++
 arch/arm64/kernel/syscall.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..6023946abe4a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -161,6 +161,7 @@ config ARM64
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ARCH_UACCESS_BUFFER
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ARM_SMCCC
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8f6372b44b65..5bbd98e5c257 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/uaccess-buffer.h>
 
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -919,6 +920,8 @@ static void do_signal(struct pt_regs *regs)
 
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 {
+	bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
+
 	do {
 		if (thread_flags & _TIF_NEED_RESCHED) {
 			/* Unmask Debug and SError for the next task */
@@ -950,6 +953,8 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		local_daif_mask();
 		thread_flags = READ_ONCE(current_thread_info()->flags);
 	} while (thread_flags & _TIF_WORK_MASK);
+
+	uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
 }
 
 unsigned long __ro_after_init signal_minsigstksz;
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a38e84..6de801c1af05 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/ptrace.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
+#include <linux/uaccess-buffer.h>
 
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -139,7 +140,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			goto trace_exit;
 	}
 
+	uaccess_buffer_syscall_entry();
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
+	uaccess_buffer_syscall_exit();
 
 	/*
 	 * The tracing status may have changed under our feet, so we have to
-- 
2.34.0.rc2.393.gf8c9666880-goog

