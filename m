Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3B3802A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhENED2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:03:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:41909 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhENED1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:03:27 -0400
IronPort-SDR: Qob3a8ec7K+g/Jez5b/LuKXc9/oRgPl3wVMFEejRDrJUzPLtkEvwFkq2x43DqovF2DVaeLxXQb
 KOLWDPLoDU8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187229286"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="187229286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 21:02:11 -0700
IronPort-SDR: REnY5NxPqWGBgUgGZtPbviKac19RGqISF8goZdoXvPbgGmqRV2+CFWmN2zcmCZEyaC8+yK7F1j
 YJvmBZnEndBA==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="626649475"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 21:02:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
        <20210514015946.nivgnoobef4nqwmw@oracle.com>
Date:   Fri, 14 May 2021 12:02:05 +0800
In-Reply-To: <20210514015946.nivgnoobef4nqwmw@oracle.com> (Daniel Jordan's
        message of "Thu, 13 May 2021 21:59:46 -0400")
Message-ID: <878s4iezeq.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Thu, May 13, 2021 at 02:46:10PM +0200, Peter Zijlstra wrote:
>> Ah, I think I see what you meant to say, it would perhaps help if you
>> write it like so:
>> 
>> 
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 149e77454e3c..94735248dcd2 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -99,11 +99,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>  
>>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>>  {
>> -	if (type >= READ_ONCE(nr_swapfiles))
>> +	if (type >= MAX_SWAPFILES)
>>  		return NULL;
>>  
>> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
>> -	return READ_ONCE(swap_info[type]);
>> +	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>>  }
>>  
>>  static inline unsigned char swap_count(unsigned char ent)
>> @@ -2869,14 +2868,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>>  	}
>>  	if (type >= nr_swapfiles) {
>>  		p->type = type;
>> -		WRITE_ONCE(swap_info[type], p);
>>  		/*
>> -		 * Write swap_info[type] before nr_swapfiles, in case a
>> -		 * racing procfs swap_start() or swap_next() is reading them.
>> -		 * (We never shrink nr_swapfiles, we never free this entry.)
>> +		 * Publish the swap_info_struct.
>>  		 */
>> -		smp_wmb();
>> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
>> +		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
>> +		nr_swapfiles++;
>
> Yes, this does help, I didn't understand why smp_wmb stayed around in
> the original post.
>
> I think the only access smp_store_release() orders is p->type.  Wouldn't
> it be kinda inconsistent to only initialize that one field before
> publishing when many others would be done at the end of
> alloc_swap_info() after the fact?

In addition to p->type, *p is zeroed via kvzalloc().

> p->type doesn't seem special.  For
> instance, get_swap_page_of_type() touches si->lock soon after it calls
> swap_type_to_swap_info(), so there could be a small window where there's
> a non-NULL si with an uninitialized lock.

We usually check the state of swap_info_struct before other operations.
For example, we check si->swap_map in swap_start().

> It's not as if this is likely to be a problem in practice, it would just
> make it harder to understand why smp_store_release is there.  Maybe all
> we need is a WRITE_ONCE, or if it's really necessary for certain fields
> to be set before publication then move them up and explain?

I think we have initialized all fields before publication :-).

Best Regards,
Huang, Ying
