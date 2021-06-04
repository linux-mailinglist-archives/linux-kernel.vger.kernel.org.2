Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4839C193
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFDUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFDUu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:50:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2BE613FF;
        Fri,  4 Jun 2021 20:48:39 +0000 (UTC)
Date:   Fri, 4 Jun 2021 16:48:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace.c:3634:2: warning: function might be
 possible candidate for 'gnu_printf' format attribute
Message-ID: <20210604164838.2da06df3@oasis.local.home>
In-Reply-To: <202106041958.XB0yCLBn-lkp@intel.com>
References: <202106041958.XB0yCLBn-lkp@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 19:12:03 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f88cd3fb9df228e5ce4e13ec3dbad671ddb2146e
> commit: 9a6944fee68e25084130386c608c5ac8db487581 tracing: Add a verifier to check string pointers for trace events
> date:   3 months ago
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Ubuntu 6.4.0-17ubuntu1) 6.4.0 20180424
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a6944fee68e25084130386c608c5ac8db487581
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9a6944fee68e25084130386c608c5ac8db487581
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'test_can_verify_check':
> >> kernel/trace/trace.c:3634:2: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]  
>      vsnprintf(buf, 16, "%d", ap);
>      ^~~~~~~~~

"test_can_verify_check" is not a generic function that needs a printf
format check. This is a bogus warning. Please remove it as being an issue.

-- Steve



>    kernel/trace/trace.c: In function 'trace_check_vprintf':
>    kernel/trace/trace.c:3717:3: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>       trace_seq_vprintf(&iter->seq, iter->fmt, ap);
>       ^~~~~~~~~~~~~~~~~
>    kernel/trace/trace.c:3756:3: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>       trace_seq_vprintf(&iter->seq, p, ap);
>       ^~~~~~~~~~~~~~~~~
> 
> 
> vim +/gnu_printf +3634 kernel/trace/trace.c
> 
>   3617	
>   3618	static int test_can_verify_check(const char *fmt, ...)
>   3619	{
>   3620		char buf[16];
>   3621		va_list ap;
>   3622		int ret;
>   3623	
>   3624		/*
>   3625		 * The verifier is dependent on vsnprintf() modifies the va_list
>   3626		 * passed to it, where it is sent as a reference. Some architectures
>   3627		 * (like x86_32) passes it by value, which means that vsnprintf()
>   3628		 * does not modify the va_list passed to it, and the verifier
>   3629		 * would then need to be able to understand all the values that
>   3630		 * vsnprintf can use. If it is passed by value, then the verifier
>   3631		 * is disabled.
>   3632		 */
>   3633		va_start(ap, fmt);
> > 3634		vsnprintf(buf, 16, "%d", ap);  
>   3635		ret = va_arg(ap, int);
>   3636		va_end(ap);
>   3637	
>   3638		return ret;
>   3639	}
>   3640	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

