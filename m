Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E176143C569
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhJ0Iq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhJ0Iq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:46:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A+zmKdPo93Lq9OnWGjUdHfAZF2hxhxCY/Mux3Z85l+M=; b=DFwgecAr0lYfidnkySqNXUHF2S
        Os6vT0yYT0mVwTddp9nWduKSFf34bW2/Z3EguLbP8ht/xT0odTArGNbqIXsXWRKkKDDvMsP742NLk
        oZx242HNAZir7zdLQOA9vPd+etvg7DSC1pgcWJHrSYXq0wVcBhi6JnSKxqbHxXUkbRN/nbW0IANKH
        WjPO51z8f0dDaNjkNkwrcOvZnMlJLzvHM1+SbA9FPtsJTMn0cFVkmySKM8zj+W3DDosTcZlHVssFb
        ZOstHBeA5zelbfFfbfdeR76ymD8JyESIV4q+YS6jAe8NMnPpLTYuBiDY1tWHFY5V2rgcJ9OAMlqP2
        NzPB/Nkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfeWp-00HVw6-6I; Wed, 27 Oct 2021 08:43:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E783F3001BF;
        Wed, 27 Oct 2021 10:43:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7013236E43E5; Wed, 27 Oct 2021 10:43:21 +0200 (CEST)
Date:   Wed, 27 Oct 2021 10:43:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     valentin.schneider@arm.com, mingo@kernel.org, namit@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: Fix implicit type conversion
Message-ID: <YXkRKe7ovUFVvzqd@hirez.programming.kicks-ass.net>
References: <1635317123-2716894-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635317123-2716894-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 06:45:23AM +0000, Jiasheng Jiang wrote:
> Since the 'nr_cpu_ids' is unsigned int, then we can assume its
> value is (2^32 - 1).
> Also, the 'cpu' is unsigned int.
> As the number of cycles increases, the value of 'cpu' can be
> (2^31 - 1).
> Although in the cpumask_next() 'cpu' is implicitly casted to int,
> its actual value is also (2^31 - 1).
> However, the return value of cpumask_next(), the updated value of
> 'cpu', is (2^31).
> That means the restriction 'cpu < nr_cpu_ids' is still statisfied
> and in cpumask_next() when 'cpu' is implicitly casted to int, its
> actual value is (-2^31).
> Obviously, it is illegal and dangerous for cpumask_next(), as well

It is not illegal, police will not come for you.

> as others.
> Therefore, we should fix the macro description of 'cpu' that remove
> the '(optionally unsigned)' and restrict the value of 'cpu' to be
> non-negative integer.
> Moreover, all the existing issues should be dealed with.
> 
> Fixes: c743f0a ("sched/fair, cpumask: Export for_each_cpu_wrap()")
> Fixes: 8bd93a2 ("rcu: Accelerate grace period if last non-dynticked CPU")
> Fixes: 984f2f3 ("cpumask: introduce new API, without changing anything, v3")

There is no actual bug, Fixes tag is unwarranted.

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  include/linux/cpumask.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index bfc4690..8a8e59f 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -232,7 +232,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
>  
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
> - * @cpu: the (optionally unsigned) integer iterator
> + * @cpu: the integer iterator
>   * @mask: the cpumask pointer
>   *
>   * After the loop, cpu is >= nr_cpu_ids.
> @@ -240,11 +240,11 @@ int cpumask_any_distribute(const struct cpumask *srcp);
>  #define for_each_cpu(cpu, mask)				\
>  	for ((cpu) = -1;				\
>  		(cpu) = cpumask_next((cpu), (mask)),	\
> -		(cpu) < nr_cpu_ids;)
> +		(cpu) < nr_cpu_ids && (cpu) >= 0;)

So now you're generating worse code for no actual gain?
