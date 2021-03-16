Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1237733D13A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhCPJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhCPJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:55:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5UQSoM71v4EQpNU186kKhqhGR93agBCHr17FoeRyDYk=; b=FWUB18h8a/c0YzZ5Qb7r6r8n6m
        WSPqSkUmHM5Rdo0dYV6n2JkkcUnQAhnJ0zNqW4F2qfR8PucnGTTosOwv4redgItAGASq/+0kI5V7K
        IslG1irxYQJYeyLsRy5hEfVhrLcu+LifWlhGzY1rtb3Qbg23q2jjnZ8SzGGYLC4KQFrGqTPCluRkF
        Obnkk3inDyy8t+2uCWySVNotD3VapfJZg8FSIXRTp1R6Fb2z8ft8uf7HoKw+vfC4CLzZH+KmtXEAk
        KJIuTK9UDc+clumm16uaoxeOYcK61HqHKhK4WuNjQEl6hGrWSSB3Vh/76ZOkFgwejJXb9Bt3/AVkE
        BIzB8TEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM6PX-000KMR-Ss; Tue, 16 Mar 2021 09:54:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13567304D58;
        Tue, 16 Mar 2021 10:54:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D659A20435CF4; Tue, 16 Mar 2021 10:54:37 +0100 (CET)
Date:   Tue, 16 Mar 2021 10:54:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:49:28PM +0800, Huaixin Chang wrote:
> @@ -8982,6 +8983,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>  	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bound burst to defend burst against overflow during bandwidth shift.
> +	 */
> +	if (burst > max_cfs_runtime)
> +		return -EINVAL;

Why do you allow such a large burst? I would expect something like:

	if (burst > quote)
		return -EINVAL;

That limits the variance in the system. Allowing super long bursts seems
to defeat the entire purpose of bandwidth control.
