Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D189A379735
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhEJSy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:54:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37861 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhEJSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:46 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNli2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNli2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672813;
        bh=JHPMbGMh79H+cjWsMsA8mi8L+qKBD13Dnd8qkFhJLEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orfPQg52ynpp6lA+HdEOWMgTL2lQkJdgEz6MT3x5zJoJjPJtPRzPSr4venJ9IFAuv
         5KM+DSSWXtmqopsxBIeo8cFVPZn4RCS0c19Q6yXwebUBaa/2DIlZerazHIK0psKHKb
         GE68TArtjQEDH9vRCapm1QdUTXZi1ARZ3/ucE2GqOD5wW93rMJMWIgj9sTxIb9CbYZ
         n2yH14KoCC5zJ9TAxtSPPg2oGxcifC4+QCHd89SNCiHbLFrtQrvCAGUcF/iRRNWS0O
         hKRJmCXuFFoSExA9Tic6QCpvUGz7vjAG5t9xWoqdl50iNFdbYTalTLMH01QyI7oh/H
         731/8EmOnBCNQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 6/7] x86/regs: syscall_get_nr() returns -1 for a non-system call
Date:   Mon, 10 May 2021 11:53:15 -0700
Message-Id: <20210510185316.3307264-7-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_nr() is defined to return -1 for a non-system call or a
ptrace/seccomp restart; not just any arbitrary number. See comment in
<asm-generic/syscall.h> for the official definition of this function.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/ptrace.c | 2 +-
 arch/x86/kernel/signal.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 87a4143aa7d7..4c208ea3bd9f 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -911,7 +911,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 		 * syscall with TS_COMPAT still set.
 		 */
 		regs->orig_ax = value;
-		if (syscall_get_nr(child, regs) >= 0)
+		if (syscall_get_nr(child, regs) != -1)
 			child->thread_info.status |= TS_I386_REGS_POKED;
 		break;
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..e12779a2714d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -713,7 +713,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
 
 	/* Are we from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* If so, check system call restarting.. */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTART_RESTARTBLOCK:
@@ -793,7 +793,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 	}
 
 	/* Did we come from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* Restart the system call - no handlers present */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTARTNOHAND:
-- 
2.31.1

