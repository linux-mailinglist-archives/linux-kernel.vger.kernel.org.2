Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9579645B8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhKXLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhKXLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:17:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s2E5adjpzqmax/IU8j88qhpbYauvLkBEfTf0Oh2+RTs=; b=Yb9hajgzOxCixoBNJgh5Lk5WDa
        sXJU1GSLTbRwd1IC9ABf3YNczObzqcbJ9RonyA8WTowRsx61rtn+d0wHuO7BoovaqHvtJFQDYO3Hq
        2Fj+wsXPoRhdYbCZJzNvWALG9j7AHP+Yi+xQ3NGQoMOMapeS5GcgPa/gRnX8DItrmyoTjpr/YH3t5
        IVCr41oEkVxsYE3XDFVGX8S5Z9lzuNDs1AfwLrTezQVAh0cqZcLhw4zTDWRwJEem0VtJwy9pF9Gx3
        j9lernAn/w5A5f9skSJn02y55HEYlf+bHjMihAOUsTGBlIohgTd77EajA6bVhh43Pi1ALflQs5yBA
        fPVlj3Dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpqDS-000FcJ-U0; Wed, 24 Nov 2021 11:13:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF034300230;
        Wed, 24 Nov 2021 12:13:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD7912DAA8BF2; Wed, 24 Nov 2021 12:13:28 +0100 (CET)
Date:   Wed, 24 Nov 2021 12:13:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
Message-ID: <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
References: <20211124091546.5072-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124091546.5072-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 05:15:46PM +0800, Barry Song wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6..8cd23f1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6278,6 +6278,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> +	--nr;
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -6285,11 +6286,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> -				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;
> +			if (!--nr)
> +				return -1;
>  		}
>  	}

This way nr can never be 1 for a single iteration -- it current isn't,
but that's besides the point.
