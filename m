Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE76E3874BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbhERJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347856AbhERJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1042899wmn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui6DkSfSUHVuV2NqDDwW1VpfGUapkm0wPnlAdb6e2cM=;
        b=MKnOXAYqobu9vZgnQo2xLbvYvLmegYQO/FLgmDUx3jBKyLlS638sZHMgtsC4NxZNj7
         mHzksuIXaNE9inxo+D5WlitiKZVIgqEgYAi7qItT88oyYVytD6jirj9JThwBdR9F9L0c
         e0U16Cfj1y5r40srtwtIZRG5EcZgBsSLiwDH6ec6SySAkvYVJm2CY+5LNd0kJ4wAyFaZ
         Wh0H17ZFyY9MRYbm/3zQ/ThQfWyyaxbcxwGtq/kZs9e6tOw9AHkLeecKmY/bY5CCKLzl
         p6zCTw2b833Yd7v6Kudv0yHTVYYoJzGuMlDb8LGDfac54oXMCY+p2cHvPNMqg/i9lzxI
         6pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui6DkSfSUHVuV2NqDDwW1VpfGUapkm0wPnlAdb6e2cM=;
        b=BIeUjNdldWrU08o/4DW5vObYdjcljelo/ygWgdKx91EMjiZcChEz0SkXVemvgmz/7O
         DBtsmvEzSKXcDx8QSXQek2FfzoUjXI33DyMvXj7j+nivq2yIEj1qYzX0L4lVmwwMRsZc
         sOjreen1c6JOw/w9oRsG10GaO0XT5Vz8m1APtLP+OWd6X1PRQLDw65CD2vMjwElmYQp6
         mpUBbQCMues4dfUF1+rBkDj4y15/3rt4oRRH3/t6MI1gPBqsQFHdCjpR59XRLfO1U9I7
         apoF10clU3+01pgPCGDEWvDut5Xy2ZkadpsgIwgDETwOhhVdBHwWiu6RQVwDRFAthkfU
         6pZA==
X-Gm-Message-State: AOAM532OS35e2JlZ3ukaUHJV/XH7wtvYVeXGrEwqobEFOJ6PG44fDD0s
        HyghRbOhJYrK01Yn41MjSHE=
X-Google-Smtp-Source: ABdhPJyJ87Lk/qEv0BvAQqI2fLVrmtr4vyBKChU+E38Ab22pnAniKtbWa2D0iOqrXPMptqs07F/bBg==
X-Received: by 2002:a05:600c:35c9:: with SMTP id r9mr3742415wmq.56.1621328830331;
        Tue, 18 May 2021 02:07:10 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:09 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 4/8] arm64: Separate in_compat_syscall from is_compat_task
Date:   Tue, 18 May 2021 10:06:54 +0100
Message-Id: <20210518090658.9519-5-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preliminary work for allowing 64-bit processes to invoke compat
syscalls.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/include/asm/compat.h  | 24 ++++++++++++++++++++----
 arch/arm64/include/asm/ftrace.h  |  2 +-
 arch/arm64/include/asm/syscall.h |  6 +++---
 arch/arm64/kernel/ptrace.c       |  2 +-
 arch/arm64/kernel/syscall.c      |  2 +-
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 23a9fb73c04f..a2f5001f7793 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -178,21 +178,37 @@ struct compat_shmid64_ds {
 	compat_ulong_t __unused5;
 };
 
-static inline int is_compat_task(void)
+static inline bool is_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
 }
 
-static inline int is_compat_thread(struct thread_info *thread)
+static inline bool is_compat_thread(struct thread_info *thread)
 {
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
 
+static inline bool in_compat_syscall(void)
+{
+	return is_compat_task();
+}
+#define in_compat_syscall in_compat_syscall	/* override the generic impl */
+
+static inline bool thread_in_compat_syscall(struct thread_info *thread)
+{
+	return is_compat_thread(thread);
+}
+
 #else /* !CONFIG_COMPAT */
 
-static inline int is_compat_thread(struct thread_info *thread)
+static inline bool is_compat_thread(struct thread_info *thread)
+{
+	return false;
+}
+
+static inline bool thread_in_compat_syscall(struct thread_info *thread)
 {
-	return 0;
+	return false;
 }
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 91fa4baa1a93..f41aad92c67a 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -88,7 +88,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
 static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
-	return is_compat_task();
+	return in_compat_syscall();
 }
 
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..0dfc01ea386c 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -35,7 +35,7 @@ static inline long syscall_get_error(struct task_struct *task,
 {
 	unsigned long error = regs->regs[0];
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (thread_in_compat_syscall(task_thread_info(task)))
 		error = sign_extend64(error, 31);
 
 	return IS_ERR_VALUE(error) ? error : 0;
@@ -54,7 +54,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 	if (error)
 		val = error;
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (thread_in_compat_syscall(task_thread_info(task)))
 		val = lower_32_bits(val);
 
 	regs->regs[0] = val;
@@ -88,7 +88,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
  */
 static inline int syscall_get_arch(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (thread_in_compat_syscall(task_thread_info(task)))
 		return AUDIT_ARCH_ARM;
 
 	return AUDIT_ARCH_AARCH64;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 170f42fd6101..017a82b24f49 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1721,7 +1721,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	 * 32-bit children use an extended user_aarch32_ptrace_view to allow
 	 * access to the TLS register.
 	 */
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return &user_aarch32_view;
 	else if (is_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b9cf12b271d7..e0e9d54de0a2 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -51,7 +51,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = do_ni_syscall(regs, scno);
 	}
 
-	if (is_compat_task())
+	if (in_compat_syscall())
 		ret = lower_32_bits(ret);
 
 	regs->regs[0] = ret;
-- 
2.31.1

