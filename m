Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E666335EB84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbhDNDpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:45:02 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45954 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhDNDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:45:00 -0400
Received: by mail-il1-f169.google.com with SMTP id e14so4623223ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xfdm6SLikmekIdGUXOcQbfA+pIeWoCcb6+txvE9srgk=;
        b=i4gqi/c9/vZe2FeFPXgEdq8yN7brs2rEdWQOxxqMgkutXMhX7XnSNEEBCS0jyby1y/
         7ydafejhLIBDNMRjpzYEwcJU0EIMswaAfArxbYMTYQ4gC0O4RoCkujpIy/L9wUhxYwGy
         C1iYci/yDcL0+/ATVlJC44xGuOP/wB2l1RCZ8OKfWFAZCcgZK77NYRzwLYCxd1fEyW/F
         wpkelizj+N50GTm6nCIh8tkSFwl/fz41aVb5YX2oTs70uHVE3SB7xP2Q4CH/14VfuAef
         fVVQGQj8Yo69yYyHoa94PI4fNBd3iAb19silugif5mlggd/el6GfCgFozpY7btFwnQse
         d9dg==
X-Gm-Message-State: AOAM5323Z2kZQ/7U5blWCVZ2eFtwvSE4khQ70MicoC44ohQ6C3nOYO6M
        ULwZpUd9SZa2Tb9nxf7k1ig=
X-Google-Smtp-Source: ABdhPJxbx/s/NB+3pabeJ+q80RhKB1UHz5lvice0vYUHqlo6Ve8Rdq10JnZ4/30S11a2Wgu473FPBA==
X-Received: by 2002:a05:6e02:190a:: with SMTP id w10mr4095472ilu.1.1618371879644;
        Tue, 13 Apr 2021 20:44:39 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id j2sm7462310ilr.76.2021.04.13.20.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:44:39 -0700 (PDT)
Date:   Wed, 14 Apr 2021 03:44:37 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, alex.shi@linux.alibaba.com, willy@infradead.org,
        minchan@kernel.org, richard.weiyang@gmail.com, hughd@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm/swapfile: add percpu_ref support for swap
Message-ID: <YHZlJZh8T4ZhLhp6@google.com>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-2-linmiaohe@huawei.com>
 <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <87zgy4ufr3.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <46a51c49-2887-0c1a-bcf3-e1ebe9698ebf@huawei.com>
 <874kg9u0jo.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <75e27441-7744-7a10-e709-c8cd00830099@huawei.com>
 <87tuo9sjpj.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuo9sjpj.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 14, 2021 at 10:06:48AM +0800, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
> > On 2021/4/14 9:17, Huang, Ying wrote:
> >> Miaohe Lin <linmiaohe@huawei.com> writes:
> >> 
> >>> On 2021/4/12 15:24, Huang, Ying wrote:
> >>>> "Huang, Ying" <ying.huang@intel.com> writes:
> >>>>
> >>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
> >>>>>
> >>>>>> We will use percpu-refcount to serialize against concurrent swapoff. This
> >>>>>> patch adds the percpu_ref support for later fixup.
> >>>>>>
> >>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>>> ---
> >>>>>>  include/linux/swap.h |  2 ++
> >>>>>>  mm/swapfile.c        | 25 ++++++++++++++++++++++---
> >>>>>>  2 files changed, 24 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>>>>> index 144727041e78..849ba5265c11 100644
> >>>>>> --- a/include/linux/swap.h
> >>>>>> +++ b/include/linux/swap.h
> >>>>>> @@ -240,6 +240,7 @@ struct swap_cluster_list {
> >>>>>>   * The in-memory structure used to track swap areas.
> >>>>>>   */
> >>>>>>  struct swap_info_struct {
> >>>>>> +	struct percpu_ref users;	/* serialization against concurrent swapoff */
> >>>>>>  	unsigned long	flags;		/* SWP_USED etc: see above */
> >>>>>>  	signed short	prio;		/* swap priority of this type */
> >>>>>>  	struct plist_node list;		/* entry in swap_active_head */
> >>>>>> @@ -260,6 +261,7 @@ struct swap_info_struct {
> >>>>>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
> >>>>>>  	struct file *swap_file;		/* seldom referenced */
> >>>>>>  	unsigned int old_block_size;	/* seldom referenced */
> >>>>>> +	struct completion comp;		/* seldom referenced */
> >>>>>>  #ifdef CONFIG_FRONTSWAP
> >>>>>>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
> >>>>>>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
> >>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>>>>> index 149e77454e3c..724173cd7d0c 100644
> >>>>>> --- a/mm/swapfile.c
> >>>>>> +++ b/mm/swapfile.c
> >>>>>> @@ -39,6 +39,7 @@
> >>>>>>  #include <linux/export.h>
> >>>>>>  #include <linux/swap_slots.h>
> >>>>>>  #include <linux/sort.h>
> >>>>>> +#include <linux/completion.h>
> >>>>>>  
> >>>>>>  #include <asm/tlbflush.h>
> >>>>>>  #include <linux/swapops.h>
> >>>>>> @@ -511,6 +512,15 @@ static void swap_discard_work(struct work_struct *work)
> >>>>>>  	spin_unlock(&si->lock);
> >>>>>>  }
> >>>>>>  
> >>>>>> +static void swap_users_ref_free(struct percpu_ref *ref)
> >>>>>> +{
> >>>>>> +	struct swap_info_struct *si;
> >>>>>> +
> >>>>>> +	si = container_of(ref, struct swap_info_struct, users);
> >>>>>> +	complete(&si->comp);
> >>>>>> +	percpu_ref_exit(&si->users);
> >>>>>
> >>>>> Because percpu_ref_exit() is used, we cannot use percpu_ref_tryget() in
> >>>>> get_swap_device(), better to add comments there.
> >>>>
> >>>> I just noticed that the comments of percpu_ref_tryget_live() says,
> >>>>
> >>>>  * This function is safe to call as long as @ref is between init and exit.
> >>>>
> >>>> While we need to call get_swap_device() almost at any time, so it's
> >>>> better to avoid to call percpu_ref_exit() at all.  This will waste some
> >>>> memory, but we need to follow the API definition to avoid potential
> >>>> issues in the long term.
> >>>
> >>> I have to admit that I'am not really familiar with percpu_ref. So I read the
> >>> implementation code of the percpu_ref and found percpu_ref_tryget_live() could
> >>> be called after exit now. But you're right we need to follow the API definition
> >>> to avoid potential issues in the long term.
> >>>
> >>>>
> >>>> And we need to call percpu_ref_init() before insert the swap_info_struct
> >>>> into the swap_info[].
> >>>
> >>> If we remove the call to percpu_ref_exit(), we should not use percpu_ref_init()
> >>> here because *percpu_ref->data is assumed to be NULL* in percpu_ref_init() while
> >>> this is not the case as we do not call percpu_ref_exit(). Maybe percpu_ref_reinit()
> >>> or percpu_ref_resurrect() will do the work.
> >>>
> >>> One more thing, how could I distinguish the killed percpu_ref from newly allocated one?
> >>> It seems percpu_ref_is_dying is only safe to call when @ref is between init and exit.
> >>> Maybe I could do this in alloc_swap_info()?
> >> 
> >> Yes.  In alloc_swap_info(), you can distinguish newly allocated and
> >> reused swap_info_struct.
> >> 
> >>>>
> >>>>>> +}
> >>>>>> +
> >>>>>>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
> >>>>>>  {
> >>>>>>  	struct swap_cluster_info *ci = si->cluster_info;
> >>>>>> @@ -2500,7 +2510,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
> >>>>>>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
> >>>>>>  	 * between get/put_swap_device() if SWP_VALID bit is set
> >>>>>>  	 */
> >>>>>> -	synchronize_rcu();
> >>>>>> +	percpu_ref_reinit(&p->users);
> >>>>>
> >>>>> Although the effect is same, I think it's better to use
> >>>>> percpu_ref_resurrect() here to improve code readability.
> >>>>
> >>>> Check the original commit description for commit eb085574a752 "mm, swap:
> >>>> fix race between swapoff and some swap operations" and discussion email
> >>>> thread as follows again,
> >>>>
> >>>> https://lore.kernel.org/linux-mm/20171219053650.GB7829@linux.vnet.ibm.com/
> >>>>
> >>>> I found that the synchronize_rcu() here is to avoid to call smp_rmb() or
> >>>> smp_load_acquire() in get_swap_device().  Now we will use
> >>>> percpu_ref_tryget_live() in get_swap_device(), so we will need to add
> >>>> the necessary memory barrier, or make sure percpu_ref_tryget_live() has
> >>>> ACQUIRE semantics.  Per my understanding, we need to change
> >>>> percpu_ref_tryget_live() for that.
> >>>>
> >>>
> >>> Do you mean the below scene is possible?
> >>>
> >>> cpu1
> >>> swapon()
> >>>   ...
> >>>   percpu_ref_init
> >>>   ...
> >>>   setup_swap_info
> >>>   /* smp_store_release() is inside percpu_ref_reinit */
> >>>   percpu_ref_reinit
> >> 
> >> spin_unlock() has RELEASE semantics already.
> >> 
> >>>   ...
> >>>
> >>> cpu2
> >>> get_swap_device()
> >>>   /* ignored  smp_rmb() */
> >>>   percpu_ref_tryget_live
> >> 
> >> Some kind of ACQUIRE is required here to guarantee the refcount is
> >> checked before fetching the other fields of swap_info_struct.  I have
> >> sent out a RFC patch to mailing list to discuss this.

I'm just catching up and following along a little bit. I apologize I
haven't read the swap code, but my understanding is you are trying to
narrow a race condition with swapoff. That makes sense to me. I'm not
sure I follow the need to race with reinitializing the ref though? Is it
not possible to wait out the dying swap info and then create a new one
rather than push acquire semantics?

> >
> > Many thanks.
> > But We may still need to add a smp_rmb() in get_swap_device() in case
> > we can't add ACQUIRE for refcount.
> 
> Yes.
> 
> Best Regards,
> Huang, Ying
> 

Thanks,
Dennis
