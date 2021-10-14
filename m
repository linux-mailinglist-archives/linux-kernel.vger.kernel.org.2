Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B766442E0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhJNSMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhJNSMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:12:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66EAA60EBB;
        Thu, 14 Oct 2021 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634235031;
        bh=GoTaq77Ra/lW0Ecx7yxYe7pPMdG+lFF4HE2gFnyEeMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMCpyWmHkicQylbP61RL8UffOSyiJx+u1WY0OQsLNl4mtBK7xUfVe2d7hcZ1vTotu
         Q6+g2U9MrRWO8lMmEk+ccDatRkJs2OkcAL2Wvjy3og5dDRD1xllaOwgYRcj5R3G7dI
         O6PFOSJJFbbj3hyURtXrWvSpsdZMJ/7ZU6StmcJeX9V3pkZ1rawH2wdz8nhkv2un7o
         863qScNdM47BZt+sykdxXT69Q/gHBljFJQquDx5tYg0q840AXRekI7v4RkH6AXrfX0
         ZMtg9V34FNgWHqvBoWXsyabAaPzikE4+pTnhntCFBfKID3yWDXDYzuhPJmsJsL5+GF
         gn2ilxm/nUB7g==
Date:   Thu, 14 Oct 2021 13:14:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:for-next/cast-function 1/3]
 kernel/trace/ftrace.c:7029:6: error: no previous prototype for function
 'arch_ftrace_ops_list_func'
Message-ID: <20211014181456.GA1146469@embeddedor>
References: <202110140709.ogqbzDcq-lkp@intel.com>
 <20211014135317.0755987f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014135317.0755987f@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 01:53:17PM -0400, Steven Rostedt wrote:
> This should fix this issue as well as some of the other ones reported on
> this commit.
> 
> [ I'll be adding this update to my own version in my tree ]

Great. I'll apply it to my tree. Thanks! :)

--
Gustavo

> 
> -- Steve
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b86f52683b6f..8771c435f34b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -178,7 +178,8 @@
>  			ftrace_ops_list_func = arch_ftrace_ops_list_func;
>  #else
>  # ifdef CONFIG_FUNCTION_TRACER
> -#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
> +#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;	\
> +			ftrace_ops_list_func = arch_ftrace_ops_list_func;
>  # else
>  #  define MCOUNT_REC()
>  # endif
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 832e65f06754..871b51bec170 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -30,16 +30,25 @@
>  #define ARCH_SUPPORTS_FTRACE_OPS 0
>  #endif
>  
> +#ifdef CONFIG_FUNCTION_TRACER
> +struct ftrace_ops;
>  /*
>   * If the arch's mcount caller does not support all of ftrace's
>   * features, then it must call an indirect function that
>   * does. Or at least does enough to prevent any unwelcome side effects.
> + *
> + * Also define the function prototype that these architectures use
> + * to call the ftrace_ops_list_func().
>   */
>  #if !ARCH_SUPPORTS_FTRACE_OPS
>  # define FTRACE_FORCE_LIST_FUNC 1
> +void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
>  #else
>  # define FTRACE_FORCE_LIST_FUNC 0
> +void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> +			       struct ftrace_ops *op, struct ftrace_regs *fregs);
>  #endif
> +#endif /* CONFIG_FUNCTION_TRACER */
>  
>  /* Main tracing buffer and events set up */
>  #ifdef CONFIG_TRACING
> @@ -88,8 +97,6 @@ extern int
>  ftrace_enable_sysctl(struct ctl_table *table, int write,
>  		     void *buffer, size_t *lenp, loff_t *ppos);
>  
> -struct ftrace_ops;
> -
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  
>  struct ftrace_regs {
