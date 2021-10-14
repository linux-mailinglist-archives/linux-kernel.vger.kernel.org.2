Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD542E0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhJNSB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhJNSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:01:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758ED61037;
        Thu, 14 Oct 2021 17:59:52 +0000 (UTC)
Date:   Thu, 14 Oct 2021 13:59:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:for-next/cast-function 1/3] ftrace.c:undefined
 reference to `ftrace_ops_list_func'
Message-ID: <20211014135950.2f9b37a1@gandalf.local.home>
In-Reply-To: <202110141048.EPutaubE-lkp@intel.com>
References: <202110141048.EPutaubE-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 10:58:55 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/cast-function
> head:   eed09ebd6f47aeb92b3fe3b8d338b2a55e534928
> commit: f9d45e65ef7f67bdb39c15d09bc6021f197d893e [1/3] ftrace: Fix -Wcast-function-type warnings on powerpc64
> config: sh-randconfig-r026-20211013 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=f9d45e65ef7f67bdb39c15d09bc6021f197d893e
>         git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
>         git fetch --no-tags gustavoars for-next/cast-function
>         git checkout f9d45e65ef7f67bdb39c15d09bc6021f197d893e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    sh4-linux-ld: kernel/trace/ftrace.o: in function `update_ftrace_function':
> >> ftrace.c:(.text+0x158): undefined reference to `ftrace_ops_list_func'  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

This update should fix this patch (sent for the other issues as well).

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
