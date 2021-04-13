Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6435DA30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbhDMIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:36:32 -0400
Received: from foss.arm.com ([217.140.110.172]:38464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhDMIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:36:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF5431B;
        Tue, 13 Apr 2021 01:36:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8949F3F73B;
        Tue, 13 Apr 2021 01:36:09 -0700 (PDT)
Subject: Re: [PATCH] sched: remove the redundant comments
To:     Hui Su <suhui@zeku.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20210412073928.1120823-1-suhui@zeku.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d9c447fd-d3f5-cb66-b3a9-7f7002594ccc@arm.com>
Date:   Tue, 13 Apr 2021 10:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412073928.1120823-1-suhui@zeku.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 09:39, Hui Su wrote:
> Since the commit 55627e3cd22c ("sched/core: Remove rq->cpu_load[]"),
> we don't need this any more.
> 
> Signed-off-by: Hui Su <suhui@zeku.com>
> ---
>  kernel/sched/sched.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 10a1522b1e30..2232022d8561 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -897,11 +897,6 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>  struct rq {
>  	/* runqueue lock: */
>  	raw_spinlock_t		lock;
> -
> -	/*
> -	 * nr_running and cpu_load should be in the same cacheline because
> -	 * remote CPUs use both these fields when doing load calculation.
> -	 */
>  	unsigned int		nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int		nr_numa_running;

I forgot to remove this snippet back then. LGTM.

Add a

  Fixes: 55627e3cd22c ("sched/core: Remove rq->cpu_load[]")

line.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
