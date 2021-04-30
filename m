Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736F370245
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhD3UjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbhD3UjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:39:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3261C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so2321886wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui6DkSfSUHVuV2NqDDwW1VpfGUapkm0wPnlAdb6e2cM=;
        b=LrhdOKUGUFfXCyWFt7HLknvpkMXYjiEIA6UVQiNNPlbWxGp5pfQgkb0bK+AvlftqHS
         XiMltR66b7FeuedUWtb0OsVGYcLKvGO+Z9PrBwWa/gMDH528nUaufkeZdgM9qkHN/AQI
         FDbXsYNhCWugRbtXV15E9amprf95zJgbC+w839/RJ1mpsUvaZ3jwP9w+XRn4tWstVeW2
         gx0YPCdfkrZ/P8dTwlC68DR1fzBfMREKowbJXsjcVF3Xrkmb7739jje6NRhPwQGR7s1T
         2CWcxARxQHHIdCOM8xq9V/jT3p5aCjZ8uwSpkITyI9L38NT+n3U9Eiu69/3kFArvtjli
         2+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui6DkSfSUHVuV2NqDDwW1VpfGUapkm0wPnlAdb6e2cM=;
        b=VeZIL8/vlCIMIrbxwZNNDCGAyDWcmUPLWa/NVTXgN2srJUbCeojO7SGpa5JliiblUu
         d6Zd2a/R/7TlmUkdxB28wAv9+4KBLT4E/Wmn9lsEQGTpw+d1vf2Ilvgv7/K9OtKnv/dS
         uL4zsBhNE2FQv/Tx3mqH1U5NZtni5ZjEcJv2wIYuXxZGRWFs+dU7wQSKhdFu7yZ1v84z
         8+F4I7nhZKTyV13ppbSKPHJlb0KxDUE8stlylIunK7J4J6l5b+0rQ9/sIqUuY6pWojc6
         l+Tt0rq4Bbsn537xFkmNAsuzzF/pvMkizwXZSfxFr8yMb+Bhb1VvZPzbXKMAZ559p81g
         pYvQ==
X-Gm-Message-State: AOAM5328LmgOoKS/lDKhA4SGp5ZXcVFlu/P1Selv4rdubcmxbFYSStCi
        UFQFMIjZc4ajUVhu0cjeaR8=
X-Google-Smtp-Source: ABdhPJyTHBndFXkjFdom/U4HEVWfjckId3zpjoxhg/QpWesoAnLGaCTD92JSSVKQiaSvXXDctoVAEg==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr18656069wmq.110.1619815091714;
        Fri, 30 Apr 2021 13:38:11 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:11 -0700 (PDT)
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
Subject: [PATCH v4 4/8] arm64: Separate in_compat_syscall from is_compat_task
Date:   Fri, 30 Apr 2021 21:37:53 +0100
Message-Id: <20210430203757.47653-3-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
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

