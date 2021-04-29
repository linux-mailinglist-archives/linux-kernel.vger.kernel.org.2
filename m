Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C436EA95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhD2MfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:35:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhD2MfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:35:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740AF1FB;
        Thu, 29 Apr 2021 05:34:18 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F08B23F70D;
        Thu, 29 Apr 2021 05:34:15 -0700 (PDT)
Subject: Re: [PATCH] sched: Fix out-of-bound access in uclamp
To:     Quentin Perret <qperret@google.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net
References: <20210428172722.3908735-1-qperret@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b30e5815-441c-b4d3-85ad-65a4020f6d93@arm.com>
Date:   Thu, 29 Apr 2021 14:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428172722.3908735-1-qperret@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2021 19:27, Quentin Perret wrote:
> Util-clamp places tasks in different buckets based on their clamp values
> for performance reasons. However, the size of buckets is currently
> computed using a rounding division, which can lead to an off-by-one
> error in some configurations.
> 
> For instance, with 20 buckets, the bucket size will be 1024/20=51.2,
> rounded to the closest value: 51. Now, a task with a clamp of 1024 (as
> is the default for the min clamp of RT tasks) will be mapped to bucket
> id 1024/51=20 as we're now using a standard integer division. Sadly,
> correct indexes are in range [0,19], hence leading to an out of bound
> memory access.
> 
> Fix this by using a rounding-up division when computing the bucket size.

But in case you use e.g. 16 buckets, wouldn't you still end up with this
task mapped into bucket_id=16?

1024/16=64

1024/64=16

> 
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Suggested-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> 
> ---
> 
> This was found thanks to the SCHED_WARN_ON() in uclamp_rq_dec_id() which
> indicated a broken state while running with 20 buckets on Android.
> 
> Big thanks to Qais for the help with this one.
> ---
>  kernel/sched/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 98191218d891..ec175909e8b0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -920,8 +920,7 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
>   */
>  DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>  
> -/* Integer rounded range for each bucket */
> -#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> +#define UCLAMP_BUCKET_DELTA DIV_ROUND_UP(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>  
>  #define for_each_clamp_id(clamp_id) \
>  	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
> 

