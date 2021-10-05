Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995E64229D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhJEOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235891AbhJEOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:00:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569E1614C8;
        Tue,  5 Oct 2021 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxe-0055fD-Cb; Tue, 05 Oct 2021 09:58:26 -0400
Message-ID: <20211005135826.221774895@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 04/27] csky: ftrace: Drop duplicate implementation of
 arch_check_ftrace_location()
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

The csky specific arch_check_ftrace_location() shadows a weak
implementation of the function in core code that offers the same
functionality but with additional error checking.

Drop the architecture specific function as a step towards further
cleanup in core code.

Link: https://lkml.kernel.org/r/163163034617.489837.7789033031868135258.stgit@devnote2

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/kernel/probes/ftrace.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index ef2bb9bd9605..b388228abbf2 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -2,13 +2,6 @@
 
 #include <linux/kprobes.h>
 
-int arch_check_ftrace_location(struct kprobe *p)
-{
-	if (ftrace_location((unsigned long)p->addr))
-		p->flags |= KPROBE_FLAG_FTRACE;
-	return 0;
-}
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
-- 
2.32.0
