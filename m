Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062DA43C912
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhJ0MCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhJ0MCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:02:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D2560F70;
        Wed, 27 Oct 2021 11:59:38 +0000 (UTC)
Date:   Wed, 27 Oct 2021 07:59:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH] nds32: ftrace: fix pointer comparison warning
Message-ID: <20211027075936.7fd3e7a5@gandalf.local.home>
In-Reply-To: <20211027055554.19372-1-rdunlap@infradead.org>
References: <20211027055554.19372-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 22:55:54 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> GCC 11.1.0 for nds32 (nds32le if it matters) complains:
> 
> ../arch/nds32/kernel/ftrace.c: In function '_mcount':
> ../arch/nds32/kernel/ftrace.c:24:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>    24 |         if (ftrace_trace_function != ftrace_stub)
>       |                                   ^~
> 
> Cast the second function (pointer) to (void *) to avoid the warning.
> 
> Fixes: a18082575c66 ("nds32/ftrace: Support static function tracer")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> To: Greentime Hu <green.hu@gmail.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Zong Li <zong@andestech.com>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> ---
>  arch/nds32/kernel/ftrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211026.orig/arch/nds32/kernel/ftrace.c
> +++ linux-next-20211026/arch/nds32/kernel/ftrace.c
> @@ -21,7 +21,7 @@ noinline void _mcount(unsigned long pare
>  
>  	unsigned long ip = (unsigned long)__builtin_return_address(0);
>  
> -	if (ftrace_trace_function != ftrace_stub)
> +	if (ftrace_trace_function != (void *)ftrace_stub)
>  		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
>  				      NULL, NULL);
>  

Or update ftrace_trace_function prototype that was missed when ftrace_stub
prototype was updated.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index f0ef4842d191..711bc8cd186d 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -6,7 +6,7 @@
 
 #ifndef CONFIG_DYNAMIC_FTRACE
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
-				     struct ftrace_ops*, struct pt_regs*);
+				     struct ftrace_ops*, struct ftrace_regs*);
 extern void ftrace_graph_caller(void);
 
 noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
