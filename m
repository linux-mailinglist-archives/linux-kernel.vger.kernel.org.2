Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B90437F89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhJVUvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhJVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1420161284;
        Fri, 22 Oct 2021 20:48:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sz-000QKX-6r;
        Fri, 22 Oct 2021 16:48:41 -0400
Message-ID: <20211022204841.027696836@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 16/40] tracing: Use linker magic instead of recasting ftrace_ops_list_func()
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Link: https://lkml.kernel.org/r/20200617165616.52241bde@oasis.local.home
Link: https://lore.kernel.org/all/20211005053922.GA702049@embeddedor/

Requested-by: Oscar Carter <oscar.carter@gmx.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 include/linux/ftrace.h            | 12 ++++++++++--
 kernel/trace/ftrace.c             | 23 ++++++++++-------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af2b85b..8771c435f34b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -164,16 +164,22 @@
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
-#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
+#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;	\
+			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 # else
 #  define MCOUNT_REC()
 # endif
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..12fcfa2d23ea 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -30,16 +30,26 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 0
 #endif
 
+#ifdef CONFIG_FUNCTION_TRACER
+struct ftrace_ops;
+struct ftrace_regs;
 /*
  * If the arch's mcount caller does not support all of ftrace's
  * features, then it must call an indirect function that
  * does. Or at least does enough to prevent any unwelcome side effects.
+ *
+ * Also define the function prototype that these architectures use
+ * to call the ftrace_ops_list_func().
  */
 #if !ARCH_SUPPORTS_FTRACE_OPS
 # define FTRACE_FORCE_LIST_FUNC 1
+void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
 #else
 # define FTRACE_FORCE_LIST_FUNC 0
+void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #endif
+#endif /* CONFIG_FUNCTION_TRACER */
 
 /* Main tracing buffer and events set up */
 #ifdef CONFIG_TRACING
@@ -88,8 +98,6 @@ extern int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos);
 
-struct ftrace_ops;
-
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 struct ftrace_regs {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2c3e9760df7f..8b5801881271 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -119,14 +119,9 @@ struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
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
@@ -7032,21 +7027,23 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
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
-- 
2.33.0
