Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777FA45AA27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhKWRmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233491AbhKWRmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:42:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD5E604E9;
        Tue, 23 Nov 2021 17:38:53 +0000 (UTC)
Date:   Tue, 23 Nov 2021 12:38:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aili Yao <yaoaili126@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] sched/isolation: delete redundant
 housekeeping_overridden check
Message-ID: <20211123123852.11a84a9e@gandalf.local.home>
In-Reply-To: <20211123154535.48be4399@gmail.com>
References: <20211123154535.48be4399@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 15:45:35 +0800
Aili Yao <yaoaili126@gmail.com> wrote:

> From: Aili Yao <yaoaili@kingsoft.com>
> 
> housekeeping_test_cpu is only called by housekeeping_cpu(),
> and in housekeeping_cpu(), there is already one same check;
> 
> So delete the redundant check.
> 
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  kernel/sched/isolation.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7f06eaf..5c4d533 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -56,9 +56,8 @@ void housekeeping_affine(struct task_struct *t, enum
> hk_flags flags) 
>  bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping_flags & flags)
> -			return cpumask_test_cpu(cpu,
> housekeeping_mask);

Not only is your email client broken, you don't seem to understand what
static_branch_unlikely() is.

NACK.

-- Steve


> +	if (housekeeping_flags & flags)
> +		return cpumask_test_cpu(cpu, housekeeping_mask);
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);

