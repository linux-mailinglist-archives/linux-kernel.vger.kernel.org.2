Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8448334866F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCYBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCYBeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:34:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E3C619FB;
        Thu, 25 Mar 2021 01:34:18 +0000 (UTC)
Date:   Wed, 24 Mar 2021 21:34:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     menglong8.dong@gmail.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: Re: [PATCH] kernel/sched: remove duplicate include in sched.h
 sched.h
Message-ID: <20210324213416.63d2a1d4@oasis.local.home>
In-Reply-To: <20210304120926.194628-1-xiong.zhenwu@zte.com.cn>
References: <20210304120926.194628-1-xiong.zhenwu@zte.com.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Mar 2021 04:09:26 -0800
menglong8.dong@gmail.com wrote:

> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> 
> 'linux/psi.h' included in 'kernel/sched/sched.h' is duplicated. it also
> include in 59th line.
> 

Yep, #include <linux/psi.h> is at the top of the file, no need to have
it again in the the CGROUP_SCHED conditional.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  kernel/sched/sched.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 10a1522b1e30..235d8381f142 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -344,7 +344,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
>  #ifdef CONFIG_CGROUP_SCHED
>  
>  #include <linux/cgroup.h>
> -#include <linux/psi.h>
>  
>  struct cfs_rq;
>  struct rt_rq;

