Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048023874C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbhERJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347859AbhERJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB9C061348
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c14so7535376wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8HlNSywnIkavL/zIcpgi9C3SQjg+1ILx19xA07tItE=;
        b=Z6UuQJQJE8OzmnolFvAI66wj3VrgTvPdkPJlOmuWUhdHBCBObKZ0uCsL3fBc806Zb4
         aT9EVjUe40ZY9D9bcEGL9WsiqYV7rjA6CaeRMi9C1yPCcEmzajr7rg37Te6upfx1STvn
         n0I74VwTfl+XPuwhnt6rt6TxlpSzNwPBJsHr83YcDGGi/UC951zihbkjNAWqLvcKai6j
         B+tGBRU/oNg+scxB3Yy3y9SOf9uI9HOjtuhiENwIXl2MCadHNRmRPppw70K2TUGI4Yc0
         i0twL0zZCdNMAAEEHtLzIub4po047H69a5zDtNa9p3o8n4f7FEhxoj6bcmSFD/OhSQ5/
         zo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8HlNSywnIkavL/zIcpgi9C3SQjg+1ILx19xA07tItE=;
        b=MCwCsG91foPqGAHsPsdYqZZhh9EnoDVS4t5KiR5SnMu0Pgld97R9fAiaTyYJ3IaLoN
         GMIR/Jjze1fUl0p3EPnAerBezyk706iO5OVunXPsIGSmENvx1RCYTIbZhk598JbloAGc
         pNyh6XGEMKYkcM3GVj0TjfOX/oJqAb7T5Afw+n97AxF0aAoN3m3rSaqLeyUNgOhi6YFw
         U7nxpLkBZ+Hw1JHl1nfRwswSnjvFJdabYm/xkCyKVhHyp87INz3QjHe7E+xHIS1eCs21
         GO6H+nnVvMGzZ6ojbnJN744Wx0fSAcUvok4I/9B0hcRp+jIP2HYCeyWJPSGCl2ZF94IB
         oJfg==
X-Gm-Message-State: AOAM532FCBZnDvh2hilhlWSqq/ZSddGSzvmuJTaZhDCQPJUap9nL1sJr
        DKTcKgOUbV9nhCawtQ+O2PNb3XlnJoAx0Mg5
X-Google-Smtp-Source: ABdhPJx1UUqfv4BHIZswYgXTZX54aJ1DIP+CKgReBYH0NJNL1Y41RH5slNA4+TWC7X2yXZIiWOTgIA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr5420767wrq.93.1621328833162;
        Tue, 18 May 2021 02:07:13 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:12 -0700 (PDT)
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
Subject: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
Date:   Tue, 18 May 2021 10:06:58 +0100
Message-Id: <20210518090658.9519-9-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting bit 31 in x8 when performing a syscall will do the following:
- The remainder of x8 is treated as a compat syscall number and is used
  to index the compat syscall table.
- in_compat_syscall will return true for the duration of the syscall.
- VM allocations performed by the syscall will be located in the lower
  4G of the address space.
- Interrupted syscalls are properly restarted as compat syscalls.
- Seccomp will treats the syscall as having AUDIT_ARCH_ARM instead of
  AUDIT_ARCH_AARCH64. This affects the arch value seen by seccomp
  filters and reported by SIGSYS.
- PTRACE_GET_SYSCALL_INFO also treats the syscall as having
  AUDIT_ARCH_ARM. Recent versions of strace will correctly report the
  system call name and parameters when an AArch64 task mixes 32-bit and
  64-bit syscalls.

Previously, setting bit 31 of the syscall number would always cause the
sygscall to return ENOSYS. This allows user programs to reliably detect
kernel support for compat syscall by trying a simple syscall such as
getpid.

The AArch32-private compat syscalls (__ARM_NR_compat_*) are not exposed
through this interface. These syscalls do not make sense in the context
of an AArch64 task.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/include/uapi/asm/unistd.h |  2 ++
 arch/arm64/kernel/signal.c           |  5 +++++
 arch/arm64/kernel/syscall.c          | 21 ++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index f83a70e07df8..5574bc6ab0a3 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define __ARM64_COMPAT_SYSCALL_BIT 0x80000000
+
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6237486ff6bb..463c8a82050e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -795,6 +795,11 @@ static void setup_restart_syscall(struct pt_regs *regs)
 {
 	if (is_compat_task())
 		compat_setup_restart_syscall(regs);
+#ifdef COMPAT
+	else if (in_compat_syscall())
+		regs->regs[8] = __ARM64_COMPAT_SYSCALL_BIT |
+				__NR_compat_restart_syscall;
+#endif
 	else
 		regs->regs[8] = __NR_restart_syscall;
 }
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index e0e9d54de0a2..83747cf4b5b7 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -118,6 +118,11 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 * user-issued syscall(-1). However, requesting a skip and not
 		 * setting the return value is unlikely to do anything sensible
 		 * anyway.
+		 *
+		 * This edge case goes away with CONFIG_COMPAT since a
+		 * user-issued syscall(-1) is interpreted as a
+		 * compat_syscall(0x7fffffff) which still ends up returning
+		 * -ENOSYS in x0.
 		 */
 		if (scno == NO_SYSCALL)
 			regs->regs[0] = -ENOSYS;
@@ -165,7 +170,21 @@ static inline void sve_user_discard(void)
 void do_el0_svc(struct pt_regs *regs)
 {
 	sve_user_discard();
-	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * Setting bit 31 of x8 allows a 64-bit processe to perform compat
+	 * syscalls.
+	 */
+	if (regs->regs[8] & __ARM64_COMPAT_SYSCALL_BIT) {
+		current_thread_info()->use_compat_syscall = true;
+		el0_svc_common(regs,
+			       regs->regs[8] & ~__ARM64_COMPAT_SYSCALL_BIT,
+			       __NR_compat_syscalls, compat_sys_call_table);
+		current_thread_info()->use_compat_syscall = false;
+	} else
+#endif
+		el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.31.1

