Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF0391735
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhEZMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhEZMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:17:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3xmH7qSYyi3hV73rc2x1wNehlEhuf3efAfgA0/Hbw8=; b=BGNJ1Qwazv6vVbt4FmD6tNlfNC
        6pTn5N/oqp17QPS2Ix8oduopj1QpX/8aR3NgvWPjKuPm+6nJFIVrf9+b2lBv/JnXqOIx00L9ho4Tl
        UDHR7SJDPaFE+QLbxUM6d7tsBT9ApohrCfGWkNkdgmeRMytguHMYlszRlk3Aai52lQS+OMjc1smV9
        b7n/vyJfTot7TZlSKUw874QJLxR/waqr7H1iT3QjcZ0Q/HzHn30g1BZIOxZZtgyaslwSoCk3i1TD1
        L+mv1XHyq2jPzmU4pgKKmxdsHy6JVu1SR64f9XK8ey5l7yqQLhSxsTicWzLRPjGKoROWkKIYejglC
        pERWbfqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llsRb-000dfV-7b; Wed, 26 May 2021 12:15:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F070830022C;
        Wed, 26 May 2021 14:15:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A872C20567627; Wed, 26 May 2021 14:15:31 +0200 (CEST)
Date:   Wed, 26 May 2021 14:15:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, valentin.schneider@arm.com, juri.lelli@redhat.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        tangchengchang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Message-ID: <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


$subject is weird; sched/fair: is the right tag, and then start with a
capital letter.

On Wed, May 26, 2021 at 09:10:57PM +1200, Barry Song wrote:
> when waker and wakee are already in the same LLC, it is pointless to worry
> about the competition caused by pulling wakee to waker's LLC domain.

But there's more than LLC.

> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  kernel/sched/fair.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..cfb1bd47acc3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6795,7 +6795,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  			new_cpu = prev_cpu;
>  		}
>  
> -		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> +		/*
> +		 * we use wake_wide to make smarter pull and avoid cruel
> +		 * competition because of jam-packed tasks in waker's LLC
> +		 * domain. But if waker and wakee have been already in
> +		 * same LLC domain, it seems it is pointless to depend
> +		 * on wake_wide
> +		 */
> +		want_affine = (cpus_share_cache(cpu, prev_cpu) || !wake_wide(p)) &&
> +				cpumask_test_cpu(cpu, p->cpus_ptr);
>  	}

And no supportive numbers...
