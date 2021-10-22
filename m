Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559FC437F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhJVUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234442AbhJVUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F7A613B5;
        Fri, 22 Oct 2021 20:48:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T2-000QVp-Vq;
        Fri, 22 Oct 2021 16:48:44 -0400
Message-ID: <20211022204844.821961287@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 36/40] arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Make a frame pointer (make the x29 register points the
address of pt_regs->regs[29]) on __kretprobe_trampoline.

This frame pointer will be used by the stacktracer when it is
called from the kretprobe handlers. In this case, the stack
tracer will unwind stack to trampoline_probe_handler() and
find the next frame pointer in the stack frame of the
__kretprobe_trampoline().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/probes/kprobes_trampoline.S | 4 ++++
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
-- 
2.33.0
