Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5725942E08D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhJNRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhJNRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:55:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E5661130;
        Thu, 14 Oct 2021 17:53:19 +0000 (UTC)
Date:   Thu, 14 Oct 2021 13:53:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:for-next/cast-function 1/3]
 kernel/trace/ftrace.c:7029:6: error: no previous prototype for function
 'arch_ftrace_ops_list_func'
Message-ID: <20211014135317.0755987f@gandalf.local.home>
In-Reply-To: <202110140709.ogqbzDcq-lkp@intel.com>
References: <202110140709.ogqbzDcq-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 07:33:21 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/cast-function
> head:   eed09ebd6f47aeb92b3fe3b8d338b2a55e534928
> commit: f9d45e65ef7f67bdb39c15d09bc6021f197d893e [1/3] ftrace: Fix -Wcast-function-type warnings on powerpc64
> config: i386-buildonly-randconfig-r002-20211013 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a8c695542b2987eb9a203d5663a0740cb4725f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=f9d45e65ef7f67bdb39c15d09bc6021f197d893e
>         git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
>         git fetch --no-tags gustavoars for-next/cast-function
>         git checkout f9d45e65ef7f67bdb39c15d09bc6021f197d893e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/ftrace.c:297:5: error: no previous prototype for function '__register_ftrace_function' [-Werror,-Wmissing-prototypes]
>    int __register_ftrace_function(struct ftrace_ops *ops)
>        ^
>    kernel/trace/ftrace.c:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __register_ftrace_function(struct ftrace_ops *ops)
>    ^
>    static 
>    kernel/trace/ftrace.c:340:5: error: no previous prototype for function '__unregister_ftrace_function' [-Werror,-Wmissing-prototypes]
>    int __unregister_ftrace_function(struct ftrace_ops *ops)
>        ^
>    kernel/trace/ftrace.c:340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __unregister_ftrace_function(struct ftrace_ops *ops)
>    ^
>    static 
>    kernel/trace/ftrace.c:579:5: error: no previous prototype for function 'ftrace_profile_pages_init' [-Werror,-Wmissing-prototypes]
>    int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
>        ^
>    kernel/trace/ftrace.c:579:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
>    ^
>    static 
>    kernel/trace/ftrace.c:3871:15: error: no previous prototype for function 'arch_ftrace_match_adjust' [-Werror,-Wmissing-prototypes]
>    char * __weak arch_ftrace_match_adjust(char *str, const char *search)
>                  ^
>    kernel/trace/ftrace.c:3871:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    char * __weak arch_ftrace_match_adjust(char *str, const char *search)
>    ^
>    static 
> >> kernel/trace/ftrace.c:7029:6: error: no previous prototype for function 'arch_ftrace_ops_list_func' [-Werror,-Wmissing-prototypes]  
>    void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>         ^
>    kernel/trace/ftrace.c:7029:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>    ^
>    static 
>    5 errors generated.
> 
> 
> vim +/arch_ftrace_ops_list_func +7029 kernel/trace/ftrace.c
> 
>   7011	
>   7012	/*
>   7013	 * Some archs only support passing ip and parent_ip. Even though
>   7014	 * the list function ignores the op parameter, we do not want any
>   7015	 * C side effects, where a function is called without the caller
>   7016	 * sending a third parameter.
>   7017	 * Archs are to support both the regs and ftrace_ops at the same time.
>   7018	 * If they support ftrace_ops, it is assumed they support regs.
>   7019	 * If call backs want to use regs, they must either check for regs
>   7020	 * being NULL, or CONFIG_DYNAMIC_FTRACE_WITH_REGS.
>   7021	 * Note, CONFIG_DYNAMIC_FTRACE_WITH_REGS expects a full regs to be saved.
>   7022	 * An architecture can pass partial regs with ftrace_ops and still
>   7023	 * set the ARCH_SUPPORTS_FTRACE_OPS.
>   7024	 *
>   7025	 * In vmlinux.lds.h, ftrace_ops_list_func() is defined to be
>   7026	 * arch_ftrace_ops_list_func.
>   7027	 */
>   7028	#if ARCH_SUPPORTS_FTRACE_OPS
> > 7029	void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,  
>   7030				       struct ftrace_ops *op, struct ftrace_regs *fregs)
>   7031	{
>   7032		__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
>   7033	}
>   7034	#else
>   7035	void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
>   7036	{
>   7037		__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
>   7038	}
>   7039	#endif
>   7040	NOKPROBE_SYMBOL(arch_ftrace_ops_list_func);
>   7041	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

This should fix this issue as well as some of the other ones reported on
this commit.

[ I'll be adding this update to my own version in my tree ]

-- Steve

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b86f52683b6f..8771c435f34b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -178,7 +178,8 @@
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 #else
 # ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
+#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;	\
+			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 # else
 #  define MCOUNT_REC()
 # endif
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..871b51bec170 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -30,16 +30,25 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 0
 #endif
 
+#ifdef CONFIG_FUNCTION_TRACER
+struct ftrace_ops;
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
@@ -88,8 +97,6 @@ extern int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos);
 
-struct ftrace_ops;
-
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 struct ftrace_regs {
