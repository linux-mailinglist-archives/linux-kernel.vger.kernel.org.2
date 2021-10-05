Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AE422E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhJEQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhJEQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:37:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F0761381;
        Tue,  5 Oct 2021 16:35:24 +0000 (UTC)
Date:   Tue, 5 Oct 2021 12:35:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005123522.244281e6@gandalf.local.home>
In-Reply-To: <20211005161812.GA768055@embeddedor>
References: <20211005053922.GA702049@embeddedor>
        <20211005111714.18ebea2b@gandalf.local.home>
        <20211005161812.GA768055@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 11:18:12 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> On Tue, Oct 05, 2021 at 11:17:14AM -0400, Steven Rostedt wrote:
> > On Tue, 5 Oct 2021 00:39:22 -0500
> > "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> >   
> > > In order to make sure new function cast mismatches are not introduced
> > > in the kernel (to avoid tripping CFI checking), the kernel should be
> > > globally built with -Wcast-function-type.
> > > 
> > > So, fix the following -Wcast-function-type warnings on powerpc64
> > > (ppc64_defconfig):  
> > 
> > I think I'll go back and add my linker magic.
> > 
> >   https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/
> > 
> > I'll clean it up a bit too. I'll have a patch in a bit.  
> 
> Awesome. :)
> 
> Thanks
> --

Does this fix it for you?

Subject: [PATCH] tracing: Use linker magic instead of recasting ftrace_ops_list_func()
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, all function casts need to be
removed.

This means that ftrace_ops_list_func() can no longer be defined as
ftrace_ops_no_ops(). The reason for ftrace_ops_no_ops() is to use that when
an architecture calls ftrace_ops_list_func() with only two parameters
(called from assembly). And to make sure there's no C side-effects, those
archs call ftrace_ops_no_ops() which only has two parameters, as
ftrace_ops_list_func() has four parameters.

Instead of a typecast, use vmlinux.lds.h to define ftrace_ops_list_func() to
arch_ftrace_ops_list_func() that will define the proper set of parameters.

Link: https://lore.kernel.org/r/20200614070154.6039-1-oscar.carter@gmx.com

Requested-by: Oscar Carter <oscar.carter@gmx.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h |  7 ++++++-
 kernel/trace/ftrace.c             | 23 ++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

Index: linux-trace.git/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-trace.git.orig/include/asm-generic/vmlinux.lds.h
+++ linux-trace.git/include/asm-generic/vmlinux.lds.h
@@ -164,13 +164,18 @@
  * Need to also make ftrace_stub_graph point to ftrace_stub
  * so that the same stub location may have different protocols
  * and not mess up with C verifiers.
+ *
+ * ftrace_ops_list_func will be defined as arch_ftrace_ops_list_func
+ * as some archs will have a different prototype for that function
+ * but ftrace_ops_list_func() will have a single prototype.
  */
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
 			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;			\
-			ftrace_stub_graph = ftrace_stub;
+			ftrace_stub_graph = ftrace_stub;	\
+			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 #else
 # ifdef CONFIG_FUNCTION_TRACER
 #  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
Index: linux-trace.git/kernel/trace/ftrace.c
===================================================================
--- linux-trace.git.orig/kernel/trace/ftrace.c
+++ linux-trace.git/kernel/trace/ftrace.c
@@ -119,14 +119,9 @@ struct ftrace_ops __rcu *ftrace_ops_list
 ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 struct ftrace_ops global_ops;
 
-#if ARCH_SUPPORTS_FTRACE_OPS
-static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct ftrace_regs *fregs);
-#else
-/* See comment below, where ftrace_ops_list_func is defined */
-static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
-#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
-#endif
+/* Defined by vmlinux.lds.h see the commment above arch_ftrace_ops_list_func for details */
+void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
+			  struct ftrace_ops *op, struct ftrace_regs *fregs);
 
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
@@ -7026,21 +7021,23 @@ out:
  * Note, CONFIG_DYNAMIC_FTRACE_WITH_REGS expects a full regs to be saved.
  * An architecture can pass partial regs with ftrace_ops and still
  * set the ARCH_SUPPORTS_FTRACE_OPS.
+ *
+ * In vmlinux.lds.h, ftrace_ops_list_func() is defined to be
+ * arch_ftrace_ops_list_func.
  */
 #if ARCH_SUPPORTS_FTRACE_OPS
-static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct ftrace_regs *fregs)
+void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
 }
-NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
-static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
+void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
 }
-NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 #endif
+NOKPROBE_SYMBOL(arch_ftrace_ops_list_func);
 
 /*
  * If there's only one function registered but it does not support
