Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08C326E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhB0SDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 13:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhB0R4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 12:56:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45AD464E83;
        Sat, 27 Feb 2021 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614447858;
        bh=wl0bPRid1P3GRcDi+IxVTiaUvww8jAAXvf5pQd1H/qA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TPtbvqIMvJPOtmGFc4Ywvyn3+Kvy4GhegH6h2ezEuDbehF+wBjsO8fJcN5v4t4DMS
         kk18unpgvHQWkMafbF5YV46oNOmJjKly5PVI2/0tC/O0gilKyb9DWA2j4PphLV470y
         VnzwjNatJ5paj+Og2BsLFT8zTcWREGhtgl46G1NBUWccPdAkJNYiWx+DV1hjUaKj+r
         +VOkPkQ7aWAFVpWG7ei4ks29PhcLBaP3SKjA+hYgMuOVtegX69o9icYxjIlPVSOIPJ
         XH3AsTGT2jvAvtEPHyCBCHLn39baxHo+Gug3DzW66+foOmvNzEcFefZBqUoB/AIyJI
         KX1XxeMB3KL0A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A14C35239CC; Sat, 27 Feb 2021 09:44:18 -0800 (PST)
Date:   Sat, 27 Feb 2021 09:44:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Javier Contreras <contreras.javi.0@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: init_task.c: fixed two spaces coding style issue
Message-ID: <20210227174417.GA18947@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210227170118.24056-1-contreras.javi.0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227170118.24056-1-contreras.javi.0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 06:01:18PM +0100, Javier Contreras wrote:
> Fixed two spaces coding style issue.
> 
> Signed-off-by: Javier Contreras <contreras.javi.0@gmail.com>

I am not maintainer for this code, and also wangjingyu beat you to this
one.  But one question:  Given that this patch would cause "git blame"
to list you as the immediate point of contact for each line changed,
are you ready to answer all questions about each of those lines of code?
For example, given C's default initialization to zero, why is the "mm"
field explicitly set to NULL?

						Thanx, Paul

> ---
>  init/init_task.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 3711cdaafed2..85d6b045ef7a 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -71,24 +71,24 @@ struct task_struct init_task
>  	.thread_info	= INIT_THREAD_INFO(init_task),
>  	.stack_refcount	= REFCOUNT_INIT(1),
>  #endif
> -	.state		= 0,
> -	.stack		= init_stack,
> -	.usage		= REFCOUNT_INIT(2),
> -	.flags		= PF_KTHREAD,
> -	.prio		= MAX_PRIO - 20,
> -	.static_prio	= MAX_PRIO - 20,
> -	.normal_prio	= MAX_PRIO - 20,
> -	.policy		= SCHED_NORMAL,
> -	.cpus_ptr	= &init_task.cpus_mask,
> -	.cpus_mask	= CPU_MASK_ALL,
> -	.nr_cpus_allowed= NR_CPUS,
> -	.mm		= NULL,
> -	.active_mm	= &init_mm,
> -	.restart_block	= {
> +	.state		 = 0,
> +	.stack		 = init_stack,
> +	.usage		 = REFCOUNT_INIT(2),
> +	.flags		 = PF_KTHREAD,
> +	.prio		 = MAX_PRIO - 20,
> +	.static_prio	 = MAX_PRIO - 20,
> +	.normal_prio	 = MAX_PRIO - 20,
> +	.policy		 = SCHED_NORMAL,
> +	.cpus_ptr	 = &init_task.cpus_mask,
> +	.cpus_mask	 = CPU_MASK_ALL,
> +	.nr_cpus_allowed = NR_CPUS,
> +	.mm		 = NULL,
> +	.active_mm	 = &init_mm,
> +	.restart_block	 = {
>  		.fn = do_no_restart_syscall,
>  	},
>  	.se		= {
> -		.group_node 	= LIST_HEAD_INIT(init_task.se.group_node),
> +		.group_node	= LIST_HEAD_INIT(init_task.se.group_node),
>  	},
>  	.rt		= {
>  		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
> -- 
> 2.30.1
> 
