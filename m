Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF733D48E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhCPNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234502AbhCPNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0805A6505D;
        Tue, 16 Mar 2021 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615899917;
        bh=kor5HI4uVqpM15xlGlMQ3Vb/ab3YDAFb7vluRdukJEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEfHV44CdBP9Wq/ZcwBuFrlMhC8E88KuYYgwc+gWTmic4oiu/zFhQFfmWENNcPx1n
         wCod6XSv6D0MCq1SfWyMCj26ZFqQsIrr4XXeH6NFLxpymFS2+cJx9qsrIHBpKwyaHa
         C1pKYok//XXWRIZNRZT6NZ/6XJXhe7ZwnMRVEYYqjyGy9zbWsFlNyu3C5Wv+Jc0R+u
         /r8FCGLZIY8rzRPRpQ0uWtfkpEPAZWFS68Ri+eh0jhDsIEkrr9L0S1ih/oh6PDTJ2R
         k41D5fxz3adrRoKq1Tbf3yY1Be+WRR61U9+vMrSFDJYZRzDqoohzAdgy8QvPbJYR5Y
         sXOFFQE1yd8iw==
Date:   Tue, 16 Mar 2021 14:05:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] tick/nohz: Add tick_nohz_full_this_cpu()
Message-ID: <20210316130514.GB639918@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-3-frederic@kernel.org>
 <YFCkUUCYchYpB/0W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCkUUCYchYpB/0W@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:28:01PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 01:37:00PM +0100, Frederic Weisbecker wrote:
> > Optimize further the check for local full dynticks CPU. Testing directly
> > tick_nohz_full_cpu(smp_processor_id()) is suboptimal because the
> > compiler first fetches the CPU number and only then processes the
> > static key.
> > 
> > It's best to evaluate the static branch before anything.
> 
> Or you do tricky things like this ;-)

Good point!

I'll check the asm diff to see if that really does what we want.
I expect it will.

Thanks.

> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 7340613c7eff..bd4a6b055b80 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -185,13 +185,12 @@ static inline bool tick_nohz_full_enabled(void)
>  	return tick_nohz_full_running;
>  }
>  
> -static inline bool tick_nohz_full_cpu(int cpu)
> -{
> -	if (!tick_nohz_full_enabled())
> -		return false;
> -
> -	return cpumask_test_cpu(cpu, tick_nohz_full_mask);
> -}
> +#define tick_nohz_full_cpu(_cpu) ({					\
> +	bool __ret = false;						\
> +	if (tick_nohz_full_enabled())					\
> +		__ret = cpumask_test_cpu((_cpu), tick_nohz_full_mask);	\
> +	__ret;								\
> +})
>  
>  static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
>  {
> 
> 
