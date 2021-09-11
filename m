Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0B4078A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhIKOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235331AbhIKOOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:14:02 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC711611CC;
        Sat, 11 Sep 2021 14:12:48 +0000 (UTC)
Date:   Sat, 11 Sep 2021 10:12:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20210911101247.4a37ec51@rorschach.local.home>
In-Reply-To: <20210911135043.16014-3-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20210911135043.16014-3-yinan@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2021 21:50:43 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> When ftrace is enabled, ftrace_init will consume a period of
> time, usually around 15~20ms. Approximately 60% of the time is
> consumed by nop-processing. Moving the nop-processing to the
> compile time can speed up the kernel boot process.
> 
> performance test:
>         env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
>         method: before and after patching, compare the
>                 total time of ftrace_init(), and verify
>                 the functionality of ftrace.
> 
>         avg_time of ftrace_init:
>                 with patch: 7.114ms
>                 without patch: 15.763ms

What compiler are you using? Because by default, gcc should already do
this for you. In fact, recordmcount isn't even called with the latest
gcc, as gcc creates mcount_loc and inserts nops.

This was implemented before, but because we use to have "ideal nops"
that was determined at run time, because the different CPUs had
different efficiency on what nop was used, we had to do it at run time.
But that is no longer the case today, so we can revisit this.

> 
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c  |  4 ++++
>  scripts/recordmcount.h | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c236da868990..ae3fba331179 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6261,6 +6261,10 @@ static int ftrace_process_locs(struct module *mod,
>  	 * until we are finished with it, and there's no
>  	 * reason to cause large interrupt latencies while we do it.
>  	 */
> +#if defined CONFIG_X86 || defined CONFIG_X86_64 || defined CONFIG_ARM || defined CONFIG_ARM64

We don't list archs in generic files. The above needs to be something like:

#ifdef ARCH_HAS_MCOUNT_NOP

or some name like that, and then that macro gets defined by the arch
header (include/asm/ftrace.h)



> +	ret = 0;
> +	goto out;
> +#endif

space should be here.

>  	if (!mod)
>  		local_irq_save(flags);
>  	ftrace_update_code(mod, start_pg);

-- Steve
