Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807342F16D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhJOMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239281AbhJOMxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 863D161090;
        Fri, 15 Oct 2021 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302292;
        bh=0rk2OE9N625FCZQR+v+3LZ8V9a5HPzPHQNru9UNWLCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTzaLMqDCU1dZD4zb8xwT3cob7cIYib7RNENvAMHhlqU1Avjl02iXp893Ar23k1kb
         7HU/G+exNHot3r0UWLogKtbMsKwb6bTOGwMSIZJPq8+6UbU2ciemaAvkd1hCheFLQq
         NfBWlf2eIjLuAUlHP1rZ6muOPSlteyDFux7MvdeZnbUIo5G/d1t2ZEUeHaqgduMjd6
         ugiYtiRCumJUlBlkNv8L8qZbH7K7xwewrBS9500K9QtcV7BmQVW8J0GTZRLyxqgdmg
         ZbvzyvLdC9ucAsqAmHnpZCw2OgvwiDqmcTaAnDxT0BxuE8RIJmOxYNIFd2aG8FPIMp
         cyWtlUbnOEMQw==
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
Subject: [PATCH 05/10] arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
Date:   Fri, 15 Oct 2021 21:51:29 +0900
Message-Id: <163430228904.459050.16973178880543757481.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163430224341.459050.2369208860773018092.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a frame pointer (make the x29 register points the
address of pt_regs->regs[29]) on __kretprobe_trampoline.

This frame pointer will be used by the stacktracer when it is
called from the kretprobe handlers. In this case, the stack
tracer will unwind stack to trampoline_probe_handler() and
find the next frame pointer in the stack frame of the
__kretprobe_trampoline().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/probes/kprobes_trampoline.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
index 520ee8711db1..9a6499bed58b 100644
--- a/arch/arm64/kernel/probes/kprobes_trampoline.S
+++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
@@ -66,6 +66,9 @@ SYM_CODE_START(__kretprobe_trampoline)
 
 	save_all_base_regs
 
+	/* Setup a frame pointer. */
+	add x29, sp, #S_FP
+
 	mov x0, sp
 	bl trampoline_probe_handler
 	/*
@@ -74,6 +77,7 @@ SYM_CODE_START(__kretprobe_trampoline)
 	 */
 	mov lr, x0
 
+	/* The frame pointer (x29) is restored with other registers. */
 	restore_all_base_regs
 
 	add sp, sp, #PT_REGS_SIZE

