Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D15407886
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhIKOAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhIKOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:00:51 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE84E61209;
        Sat, 11 Sep 2021 13:59:38 +0000 (UTC)
Date:   Sat, 11 Sep 2021 09:59:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20210911095937.5a298619@rorschach.local.home>
In-Reply-To: <20210911135043.16014-2-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20210911135043.16014-2-yinan@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2021 21:50:42 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> When ftrace is enabled, ftrace_init will consume a period of
> time, usually around 15~20 ms. Approximately 40% of the time is
> consumed by sort-processing. Moving the sort-processing to the
> compile time can speed up the kernel boot process.
> 

Nice. I like the idea of sorting at compile time.

> performance test:
>         env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
>         method: before and after patching, compare the
>                 total time of ftrace_init(), and verify
>                 the functionality of ftrace.
> 
>         avg_time of ftrace_init:
>                 with patch: 8.352 ms
>                 without patch: 15.763 ms
> 
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c   |   5 ++-
>  scripts/link-vmlinux.sh |   6 +--
>  scripts/sorttable.c     |   2 +
>  scripts/sorttable.h     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7efbc8aaf7f6..c236da868990 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6189,8 +6189,9 @@ static int ftrace_process_locs(struct module *mod,
>  	if (!count)
>  		return 0;
>  
> -	sort(start, count, sizeof(*start),
> -	     ftrace_cmp_ips, NULL);
> +	if (mod)

Why can't we enforce modules to be sorted too?

> +		sort(start, count, sizeof(*start),
> +		     ftrace_cmp_ips, NULL);


-- Steve
