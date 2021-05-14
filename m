Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37326380282
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEND2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:28:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:64991 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhEND2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:28:42 -0400
IronPort-SDR: VhTd6lhDdrBgq7s47a9b0KaYUbK6lJ1pX5MFyCgCSg8X6wn9tUHrQHJ/+08hpv7PHwZISZiUt6
 Nknc20e9v3xw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="197019769"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="197019769"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 20:27:31 -0700
IronPort-SDR: qYb2Cd2KQ3lTadR1ao0Y7/v/ZTDBmJXywCSIXhnLMMMmC3hqPzHkUSzT1FZrPiBOI0i1Os7DbL
 va5iY3oN6ydg==
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="401429050"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 20:27:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
References: <20210513064837.3949064-1-ying.huang@intel.com>
        <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
Date:   Fri, 14 May 2021 11:27:26 +0800
In-Reply-To: <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 13 May 2021 14:46:10 +0200")
Message-ID: <87cztuf10h.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, May 13, 2021 at 02:48:37PM +0800, Huang Ying wrote:
>>  mm/swapfile.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 2aad85751991..4c1fb28bbe0e 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>  
>>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>>  {
>> -	if (type >= READ_ONCE(nr_swapfiles))
>> +	if (type >= MAX_SWAPFILES)
>>  		return NULL;
>>  
>> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
>> +	/*
>> +	 * The data dependency ordering from the READ_ONCE() pairs
>> +	 * with smp_wmb() in alloc_swap_info() to guarantee the
>> +	 * swap_info_struct fields are read after swap_info[type].
>> +	 */
>>  	return READ_ONCE(swap_info[type]);
>>  }
>>  
>> @@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
>>  	}
>>  	if (type >= nr_swapfiles) {
>>  		p->type = type;
>> -		WRITE_ONCE(swap_info[type], p);
>> -		/*
>> -		 * Write swap_info[type] before nr_swapfiles, in case a
>> -		 * racing procfs swap_start() or swap_next() is reading them.
>> -		 * (We never shrink nr_swapfiles, we never free this entry.)
>> -		 */
>> +		/* Paired with READ_ONCE() in swap_type_to_swap_info() */
>>  		smp_wmb();
>> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
>> +		WRITE_ONCE(swap_info[type], p);
>> +		nr_swapfiles++;
>
> Ah, I think I see what you meant to say, it would perhaps help if you
> write it like so:
>
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 149e77454e3c..94735248dcd2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -99,11 +99,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>  
>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>  {
> -	if (type >= READ_ONCE(nr_swapfiles))
> +	if (type >= MAX_SWAPFILES)
>  		return NULL;
>  
> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
> -	return READ_ONCE(swap_info[type]);
> +	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>  
>  static inline unsigned char swap_count(unsigned char ent)
> @@ -2869,14 +2868,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= nr_swapfiles) {
>  		p->type = type;
> -		WRITE_ONCE(swap_info[type], p);
>  		/*
> -		 * Write swap_info[type] before nr_swapfiles, in case a
> -		 * racing procfs swap_start() or swap_next() is reading them.
> -		 * (We never shrink nr_swapfiles, we never free this entry.)
> +		 * Publish the swap_info_struct.
>  		 */
> -		smp_wmb();
> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> +		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
> +		nr_swapfiles++;
>  	} else {
>  		defer = p;
>  		p = swap_info[type];

OK.  It seems that this helps people to understand.  I will use this in
the next version.

Best Regards,
Huang, Ying
