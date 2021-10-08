Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B58426ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhJHMat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241493AbhJHMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A36360FC2;
        Fri,  8 Oct 2021 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696133;
        bh=DDWSnIkSXXxhQSQVm1lvRkcHmdLh5M6ojrT3AbCWFpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IS/u79LiqdIkNAN7MNKV0e/+ErXFmTq71qnLSzWDZoREx+dUFZoPTQYY0nxfmRuYQ
         yUUETSZs40NozRwPVpyzHMN1Aapbx9rv2Qo8e58ksM1KMRfixQ87w1ZaWCXCcUPtrD
         t4AUoVZMkUtiB/WwA5pgxKmf9lUPB6lcaDeUJH20GnSKeX5FvKE2eouWBTMN3xAuDM
         owncWUN/FSmJNBbFA0/rQEjoKU4oZapEXN+KL/J4P4n9iKNtn8E/JNad4mrpm5VvOv
         ISXvIiCT4aoPiJyS9rfhiXPXqG0zhDQVKG9B3RFL6QmvMV7ANAkPvSS5EvDbSzCWtA
         tpRa+x0ijMUaw==
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
Subject: [PATCH 4/8] arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
Date:   Fri,  8 Oct 2021 21:28:49 +0900
Message-Id: <163369612899.636038.6691283708565501775.stgit@devnote2>
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

Make a frame pointer (make the x29 register points the
address of pt_regs->regs[29]) on __kretprobe_trampoline.

This frame pointer will be used by the stacktracer when it is
called from the kretprobe handlers. In this case, the stack
tracer will unwind stack to trampoline_probe_handler() and
find the next frame pointer in the stack frame of the
__kretprobe_trampoline().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

