Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA993426ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbhJHMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241357AbhJHMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:30:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE7E60F48;
        Fri,  8 Oct 2021 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696123;
        bh=GWqObyYz57gQD0h5e1G31uUpDZjmjLaxrlrmxBydL5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1NqNFoLXvsH3EDKidrpCSxq+y6IvMcALoGwjQcO0Irk+S5LKgAAZzTIROTAtgKqO
         DK7RI+b4X2rBUsNUFUbX28wn3ajC2YqPUpL1EPCTrQ2+6jtuKdg8lkv3AYBKs+e/Di
         dHwHhEaUUtdkwGj6MgggEewrNAn6s3wbBAEKkb2xPzRuEKlLX/T/bNi/2v+e4ru0/t
         P5p1WZuZ7CPBDh+RPkRRnCyHLT52L17svMK1yQxLL1oXOas7VH33EEXOn9T1TGOi0E
         GB7VzPKBnQFm4Hwiz0OvJ4FcbpAkktNKRO0g/vweonAByLYBnbxTfcUUPZR/S/N8Il
         m3YKzlYYGbQCA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/8] arm64: kprobes: Record frame pointer with kretprobe instance
Date:   Fri,  8 Oct 2021 21:28:39 +0900
Message-Id: <163369611948.636038.11552166777773804729.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163369609308.636038.15295764725220907794.stgit@devnote2>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the frame pointer instead of stack address with kretprobe
instance as the identifier on the instance list.
Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
actual frame pointer (x29).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index e7ad6da980e8..d9dfa82c1f18 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -401,14 +401,14 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
+	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
-	ri->fp = (void *)kernel_stack_pointer(regs);
+	ri->fp = (void *)regs->regs[29];
 
 	/* replace return addr (x30) with trampoline */
 	regs->regs[30] = (long)&__kretprobe_trampoline;

