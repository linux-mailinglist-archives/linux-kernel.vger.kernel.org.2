Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D83D3D55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGWPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:35:51 -0400
Received: from mail.efficios.com ([167.114.26.124]:47446 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGWPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:35:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B46E73509AD;
        Fri, 23 Jul 2021 12:16:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Vv3fqSZ7-o-r; Fri, 23 Jul 2021 12:16:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 41C6F3506E4;
        Fri, 23 Jul 2021 12:16:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 41C6F3506E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627056982;
        bh=6uXfkfILWS/hjkIxpM3cZ53shlkjQ7dJQVaCxCyX/Jg=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=Oj0vD3Es7mNm8yAHH84QwpxF7FNpWmTZVlthKcrxjE3PdfmKoPTK2JkqIw7zvooFH
         gT9eYNRqDN+oTsVyr1Ge8MHmrH+sTUZWdOaFUu+4ITNNjzvBYuqU8RNNG5JWP+j2V+
         kNoXNMSkk7tHwYyPYJ7xsZFI8yLa09K1U/Kf5KP/XuCgaHGFqf+HUOTrDp+WBoFh2t
         cGgMsCfGzX8MHB1kYTnYn8S1ONu/OP8fm2gwquxdPMFZA5lwOqTggQqzSjVYoWyM0W
         ySpoPGHibMW5dr0YHRzbdbPg+269kB/tDEQqk1wRHjy6vM6htxj9byVvFv9bxRAluv
         877PtsKA90ZKw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yl1wa60YfICS; Fri, 23 Jul 2021 12:16:22 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id 24AB53509AB;
        Fri, 23 Jul 2021 12:16:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Subject: [RFC PATCH 2/2] Revert "csky: Add support for restartable sequence"
Date:   Fri, 23 Jul 2021 12:16:00 -0400
Message-Id: <20210723161600.19688-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9866d141a0977ace974400bf1f793dfc163409ce.

The csky rseq support has been merged without ever notifying the rseq
maintainers, and without any of the required asssembler glue in the rseq
selftests, which means it is entirely untested.

It is also derived from a non-upstream riscv patch which has known bugs.

The assembly part of this revert should be carefully reviewed by the
architecture maintainer because it touches code which has changed since
the merge of the reverted patch.

The rseq selftests assembly glue should be introduced at the same time
as the architecture rseq support. Without the presence of any test, I
recommend reverting rseq support from csky for now.

Link: https://lore.kernel.org/lkml/1257037909.25426.1626705790861.JavaMai=
l.zimbra@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/Kconfig         | 1 -
 arch/csky/kernel/entry.S  | 4 ----
 arch/csky/kernel/signal.c | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 2716f6395ba7..c9655f09e591 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -66,7 +66,6 @@ config CSKY
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index d89afe3b24cc..cc2a7e84c8e5 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -50,10 +50,6 @@ ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
 	context_tracking
-#ifdef CONFIG_RSEQ_DEBUG
-	mov     a0, sp
-	jbsr    rseq_syscall
-#endif
 	psrset  ee, ie
=20
 	lrw     r9, __NR_syscalls
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 312f046d452d..3cf08732b142 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -175,8 +175,6 @@ static void handle_signal(struct ksignal *ksig, struc=
t pt_regs *regs)
 	sigset_t *oldset =3D sigmask_to_save();
 	int ret;
=20
-	rseq_signal_deliver(ksig, regs);
-
 	/* Are we from a system call? */
 	if (in_syscall(regs)) {
 		/* Avoid additional syscall restarting via ret_from_exception */
@@ -262,6 +260,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs=
,
=20
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(NULL, regs);
 	}
 }
--=20
2.20.1

