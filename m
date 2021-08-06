Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4EC3E2C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhHFOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234605AbhHFOBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DB8361165;
        Fri,  6 Aug 2021 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258446;
        bh=YnMXMdf7qUuY86hHh42fpSjvgfW/QTSHWKpqLCBqcFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkJisRfavINrcJpGpWNtUf4hcKsNAR1jeJtiR2Aovp2FBcO9BT04EGf/BTo+P9+MA
         iVNJhwZ0q18WaAm1UD8r/v9xZ9n34N1T6TslTErg4Kiw3mhpKe+jeD5L6NIsa2rEgs
         LKJoF1Twbum6kzqFyoUhkNByL+G+LBICJBmJbYK/eRRJH4ol5SUWKJXsraI9SvE1B5
         G1jP11hRsmWuMM9Gye9NppC0GNqQhXchVsSw5h+tLgLDBg67yjYlMqRBw58BNV5zsK
         P3he4oHOKiLhTBxUp5HwQx3Ova5V38/tGR/XrKZt41h3OE78FcvyEKf3grXwEdBmNw
         +JCyPKU9sKVvg==
Date:   Fri, 6 Aug 2021 23:00:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 5/9] tracing/boot: Show correct histogram error
 command
Message-Id: <20210806230043.cc3700ca5518651c3efe5748@kernel.org>
In-Reply-To: <202108061028.Wme82Hlq-lkp@intel.com>
References: <162818075888.226227.14156763636028793396.stgit@devnote2>
        <202108061028.Wme82Hlq-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 10:58:30 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/perf/core]
> [also build test WARNING on trace/for-next linux/master linus/master v5.14-rc4 next-20210805]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-boot-Add-histogram-syntax-support-in-boot-time-tracing/20210806-002938
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 79551ec0782895af27d6aa9b3abb6d547b7260d3

This seems that the base tree is not correct. I worked on Steve's 
linux-trace tree for this series, including 

commit e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")

which introduced "xbc_node_for_each_subkey()" macro.

Thank you,


> config: x86_64-randconfig-r025-20210805 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 42b9c2a17a0b63cccf3ac197a82f91b28e53e643)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/b07ebb734f4e2b68934de501715c1cd98e34ae17
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Masami-Hiramatsu/tracing-boot-Add-histogram-syntax-support-in-boot-time-tracing/20210806-002938
>         git checkout b07ebb734f4e2b68934de501715c1cd98e34ae17
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace_boot.c:287:2: error: implicit declaration of function 'xbc_node_for_each_subkey' [-Werror,-Wimplicit-function-declaration]
>            xbc_node_for_each_subkey(hnode, node) {
>            ^
>    kernel/trace/trace_boot.c:287:39: error: expected ';' after expression
>            xbc_node_for_each_subkey(hnode, node) {
>                                                 ^
>                                                 ;
>    kernel/trace/trace_boot.c:290:4: error: 'continue' statement not in loop statement
>                            continue;
>                            ^
>    kernel/trace/trace_boot.c:294:4: error: 'break' statement not in loop or switch statement
>                            break;
>                            ^
>    kernel/trace/trace_boot.c:404:2: error: implicit declaration of function 'xbc_node_for_each_subkey' [-Werror,-Wimplicit-function-declaration]
>            xbc_node_for_each_subkey(hnode, node) {
>            ^
>    kernel/trace/trace_boot.c:404:39: error: expected ';' after expression
>            xbc_node_for_each_subkey(hnode, node) {
>                                                 ^
>                                                 ;
>    kernel/trace/trace_boot.c:407:4: error: 'continue' statement not in loop statement
>                            continue;
>                            ^
> >> kernel/trace/trace_boot.c:420:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
>                            if (trigger_process_regex(file, buf) < 0)
>                            ^
>    kernel/trace/trace_boot.c:418:3: note: previous statement is here
>                    if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
>                    ^
>    1 warning and 7 errors generated.
> 
> 
> vim +/if +420 kernel/trace/trace_boot.c
> 
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  395  
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  396  static void __init
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  397  trace_boot_init_histograms(struct trace_event_file *file,
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  398  			   struct xbc_node *hnode, char *buf, size_t size)
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  399  {
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  400  	struct xbc_node *node;
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  401  	const char *p;
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  402  	char *tmp;
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  403  
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06 @404  	xbc_node_for_each_subkey(hnode, node) {
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  405  		p = xbc_node_get_data(node);
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  406  		if (!isdigit(p[0]))
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  407  			continue;
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  408  		/* All digit started node should be instances. */
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  409  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  410  			tmp = kstrdup(buf, GFP_KERNEL);
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  411  			if (trigger_process_regex(file, buf) < 0)
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  412  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  413  			kfree(tmp);
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  414  		}
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  415  	}
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  416  
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  417  	if (xbc_node_find_child(hnode, "keys")) {
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  418  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  419  			tmp = kstrdup(buf, GFP_KERNEL);
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06 @420  			if (trigger_process_regex(file, buf) < 0)
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  421  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> b07ebb734f4e2b Masami Hiramatsu 2021-08-06  422  			kfree(tmp);
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  423  	}
> 8885ed81dfd529 Masami Hiramatsu 2021-08-06  424  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Masami Hiramatsu <mhiramat@kernel.org>
