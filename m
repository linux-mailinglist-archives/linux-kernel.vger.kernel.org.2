Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB0333CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhCJMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCJMkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:40:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D84C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YXLSNz/4WtUmU/lneglWll+uILsFH1Ed7/OVzx0cvHA=; b=Lz4WnUTw+n2jLhOUshnVqFNQYm
        5Ht8WsNNrizMH2TUjihR32IxK4gNWEZaD5i7M9FTEcsN/B6cHyjsG0W4hkUvmr3EFXtEO31n5TH9C
        7/NJ5Ipl3eEvG6JSMyCilLj672MJ4w+LsXGg29jwv84ygPn53z+ZXP4pHuKPNfqKvJvO/R/Mj0MgJ
        DDtuHsYShlafszsIjEMe00I4DVfbEwCAgqGzRPGM+00XUBXusVoSHiXQC3AI79XCDSvYLqAPEIEqV
        IYxtE9Wzu6nKwRhof35XLzWBPt5T1WkZos8g/O6ulpV8HbiAGzUe0sbx0DfbvpRPCF2mVy/BIpLvW
        v6Cw/rPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJy88-003P0t-8A; Wed, 10 Mar 2021 12:40:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E74F03011F0;
        Wed, 10 Mar 2021 13:39:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B016920D72075; Wed, 10 Mar 2021 13:39:49 +0100 (CET)
Date:   Wed, 10 Mar 2021 13:39:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YEi+FVH5ovbC5uDh@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110453.18899-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:04:50PM +0800, Huaixin Chang wrote:
> In this patch, we introduce the notion of CFS bandwidth burst. Unused
> "quota" from pervious "periods" might be accumulated and used in the
> following "periods". The maximum amount of accumulated bandwidth is
> bounded by "burst". And the maximun amount of CPU a group can consume in
> a given period is "buffer" which is equivalent to "quota" + "burst in
> case that this group has done enough accumulation.
> 
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>

Not a valid SoB chain.

> ---
>  kernel/sched/core.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/fair.c  |  2 ++
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 82 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e7e453492cff..48d3bad12be2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7895,10 +7895,12 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>  
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
> -static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
> +static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
> +							u64 burst)

Non standard indentation.

>  {
>  	int i, ret = 0, runtime_enabled, runtime_was_enabled;
>  	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> +	u64 buffer;
>  
>  	if (tg == &root_task_group)
>  		return -EINVAL;
> @@ -7925,6 +7927,16 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>  	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bound burst to defend burst against overflow during bandwidth shift.
> +	 */
> +	if (burst > max_cfs_runtime)
> +		return -EINVAL;
> +
> +	if (quota == RUNTIME_INF)
> +		buffer = RUNTIME_INF;
> +	else
> +		buffer = min(max_cfs_runtime, quota + burst);

Why do we care about buffer when RUNTIME_INF?
