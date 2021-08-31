Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251C3FC7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhHaNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHaNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 170CC6103D;
        Tue, 31 Aug 2021 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630415702;
        bh=0zkMautvKaCRy49XjpJW4DX7iRRfLMhdAybHI0e16lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Anus8dDaJ3K0vwh84BE/MHE0LAawH4FsqJjSwRbpIeDVPR2jp3lCTxxAdn2hdcOSg
         I5AxzC0NxnI2w59aJzxWgU+W36pvXR+QIWRUJNQWWMyzKal2GZjfAWD60P9xsZAINy
         medmWxBrtj+dqVG9Ya1hxpBZeoQ4ctjy7ZHdPHTYB2Nk+dojrkP8nPpJ0n2CUPEvNo
         KHse1fwIhYVsOyis/Ls+0hln4IjaRUp0tN0REnOo0Xs/EOnfY7gVXNuMS6SLSzNsxB
         dLMzHtjn/JuJAZkkvl76fUlKXUDayve+olZDbRygH8hTLbM/LUiP2SqH0DCqsqJDD4
         QFGHEs49+oqug==
Date:   Tue, 31 Aug 2021 22:15:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [trace:ftrace/core 35/39] kernel/trace/trace_boot.c:418:17:
 warning: this 'if' clause does not guard...
Message-Id: <20210831221500.8c4e179571bffcfdbd0da91c@kernel.org>
In-Reply-To: <202108312050.5qqqDz5V-lkp@intel.com>
References: <202108312050.5qqqDz5V-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, thanks for the great test bot!
Let me send a fix asap.

Thank you,

On Tue, 31 Aug 2021 20:57:56 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/core
> head:   3dc65994e3c1c999be3d991cdc96705e167cb3b1
> commit: 5d4648a0415efc239ffb377bce1d389723eda25d [35/39] tracing/boot: Show correct histogram error command
> config: s390-allyesconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?id=5d4648a0415efc239ffb377bce1d389723eda25d
>         git remote add trace https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>         git fetch --no-tags trace ftrace/core
>         git checkout 5d4648a0415efc239ffb377bce1d389723eda25d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace_boot.c: In function 'trace_boot_init_histograms':
> >> kernel/trace/trace_boot.c:418:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      418 |                 if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
>          |                 ^~
>    kernel/trace/trace_boot.c:420:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
>      420 |                         if (trigger_process_regex(file, buf) < 0)
>          |                         ^~
> 
> 
> vim +/if +418 kernel/trace/trace_boot.c
> 
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  395  
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  396  static void __init
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  397  trace_boot_init_histograms(struct trace_event_file *file,
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  398  			   struct xbc_node *hnode, char *buf, size_t size)
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  399  {
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  400  	struct xbc_node *node;
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  401  	const char *p;
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  402  	char *tmp;
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  403  
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  404  	xbc_node_for_each_subkey(hnode, node) {
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  405  		p = xbc_node_get_data(node);
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  406  		if (!isdigit(p[0]))
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  407  			continue;
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  408  		/* All digit started node should be instances. */
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  409  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  410  			tmp = kstrdup(buf, GFP_KERNEL);
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  411  			if (trigger_process_regex(file, buf) < 0)
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  412  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  413  			kfree(tmp);
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  414  		}
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  415  	}
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  416  
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  417  	if (xbc_node_find_child(hnode, "keys")) {
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06 @418  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  419  			tmp = kstrdup(buf, GFP_KERNEL);
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  420  			if (trigger_process_regex(file, buf) < 0)
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  421  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> 5d4648a0415efc Masami Hiramatsu 2021-08-06  422  			kfree(tmp);
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  423  	}
> 30cb856e3067e5 Masami Hiramatsu 2021-08-06  424  
> 
> :::::: The code at line 418 was first introduced by commit
> :::::: 30cb856e3067e5d6ae7b2144e1659145ab7686fd tracing/boot: Support multiple histograms for each event
> 
> :::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
> :::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Masami Hiramatsu <mhiramat@kernel.org>
