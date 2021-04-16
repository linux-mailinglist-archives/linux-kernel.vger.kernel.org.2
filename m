Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004323619D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhDPG0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:26:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:30582 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233959AbhDPG0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:26:06 -0400
IronPort-SDR: K4CAWUB0Uyh3vuSxkrxkL2KFO0xjDCxfQxML6rkUUqbJl1uaeHVBZdPRl+rjYb2MSeuQb4jc1q
 a4b86AqkaKoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280314645"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280314645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 23:25:39 -0700
IronPort-SDR: ULdwpRpE9UwAH7Qs82NdWV6+tIVkhtATkij5XDwwkGSmu9LyOD6d9mo/XeCr/VeHjMUD3F3ohO
 UiJxns4KEZEQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="399822383"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 23:25:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Dennis Zhou <dennis@kernel.org>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <hughd@google.com>,
        <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 1/5] mm/swapfile: add percpu_ref support for swap
References: <46a51c49-2887-0c1a-bcf3-e1ebe9698ebf@huawei.com>
        <874kg9u0jo.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <75e27441-7744-7a10-e709-c8cd00830099@huawei.com>
        <87tuo9sjpj.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YHZlJZh8T4ZhLhp6@google.com>
        <877dl5seig.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YHZqCy/y2YLCOcbD@google.com>
        <87zgy1qv1h.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YHcB36r5gOyXnozT@google.com>
        <87o8egp1bk.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YHhOLuIAR3QJ1jx4@google.com>
        <32f4c6f4-c969-c434-82d6-66a0e76ac4c6@huawei.com>
Date:   Fri, 16 Apr 2021 14:25:31 +0800
In-Reply-To: <32f4c6f4-c969-c434-82d6-66a0e76ac4c6@huawei.com> (Miaohe Lin's
        message of "Fri, 16 Apr 2021 10:27:11 +0800")
Message-ID: <8735vqoiec.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/4/15 22:31, Dennis Zhou wrote:
>> On Thu, Apr 15, 2021 at 01:24:31PM +0800, Huang, Ying wrote:
>>> Dennis Zhou <dennis@kernel.org> writes:
>>>
>>>> On Wed, Apr 14, 2021 at 01:44:58PM +0800, Huang, Ying wrote:
>>>>> Dennis Zhou <dennis@kernel.org> writes:
>>>>>
>>>>>> On Wed, Apr 14, 2021 at 11:59:03AM +0800, Huang, Ying wrote:
>>>>>>> Dennis Zhou <dennis@kernel.org> writes:
>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On Wed, Apr 14, 2021 at 10:06:48AM +0800, Huang, Ying wrote:
>>>>>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>>>>>
>>>>>>>>>> On 2021/4/14 9:17, Huang, Ying wrote:
>>>>>>>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> On 2021/4/12 15:24, Huang, Ying wrote:
>>>>>>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> We will use percpu-refcount to serialize against concurrent swapoff. This
>>>>>>>>>>>>>>> patch adds the percpu_ref support for later fixup.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>  include/linux/swap.h |  2 ++
>>>>>>>>>>>>>>>  mm/swapfile.c        | 25 ++++++++++++++++++++++---
>>>>>>>>>>>>>>>  2 files changed, 24 insertions(+), 3 deletions(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>>>>>>>>>>>> index 144727041e78..849ba5265c11 100644
>>>>>>>>>>>>>>> --- a/include/linux/swap.h
>>>>>>>>>>>>>>> +++ b/include/linux/swap.h
>>>>>>>>>>>>>>> @@ -240,6 +240,7 @@ struct swap_cluster_list {
>>>>>>>>>>>>>>>   * The in-memory structure used to track swap areas.
>>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>>  struct swap_info_struct {
>>>>>>>>>>>>>>> +	struct percpu_ref users;	/* serialization against concurrent swapoff */
>>>>>>>>>>>>>>>  	unsigned long	flags;		/* SWP_USED etc: see above */
>>>>>>>>>>>>>>>  	signed short	prio;		/* swap priority of this type */
>>>>>>>>>>>>>>>  	struct plist_node list;		/* entry in swap_active_head */
>>>>>>>>>>>>>>> @@ -260,6 +261,7 @@ struct swap_info_struct {
>>>>>>>>>>>>>>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>>>>>>>>>>>>>>>  	struct file *swap_file;		/* seldom referenced */
>>>>>>>>>>>>>>>  	unsigned int old_block_size;	/* seldom referenced */
>>>>>>>>>>>>>>> +	struct completion comp;		/* seldom referenced */
>>>>>>>>>>>>>>>  #ifdef CONFIG_FRONTSWAP
>>>>>>>>>>>>>>>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
>>>>>>>>>>>>>>>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
>>>>>>>>>>>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>>>>>>>>>>>> index 149e77454e3c..724173cd7d0c 100644
>>>>>>>>>>>>>>> --- a/mm/swapfile.c
>>>>>>>>>>>>>>> +++ b/mm/swapfile.c
>>>>>>>>>>>>>>> @@ -39,6 +39,7 @@
>>>>>>>>>>>>>>>  #include <linux/export.h>
>>>>>>>>>>>>>>>  #include <linux/swap_slots.h>
>>>>>>>>>>>>>>>  #include <linux/sort.h>
>>>>>>>>>>>>>>> +#include <linux/completion.h>
>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>  #include <asm/tlbflush.h>
>>>>>>>>>>>>>>>  #include <linux/swapops.h>
>>>>>>>>>>>>>>> @@ -511,6 +512,15 @@ static void swap_discard_work(struct work_struct *work)
>>>>>>>>>>>>>>>  	spin_unlock(&si->lock);
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>> +static void swap_users_ref_free(struct percpu_ref *ref)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +	struct swap_info_struct *si;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +	si = container_of(ref, struct swap_info_struct, users);
>>>>>>>>>>>>>>> +	complete(&si->comp);
>>>>>>>>>>>>>>> +	percpu_ref_exit(&si->users);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Because percpu_ref_exit() is used, we cannot use percpu_ref_tryget() in
>>>>>>>>>>>>>> get_swap_device(), better to add comments there.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I just noticed that the comments of percpu_ref_tryget_live() says,
>>>>>>>>>>>>>
>>>>>>>>>>>>>  * This function is safe to call as long as @ref is between init and exit.
>>>>>>>>>>>>>
>>>>>>>>>>>>> While we need to call get_swap_device() almost at any time, so it's
>>>>>>>>>>>>> better to avoid to call percpu_ref_exit() at all.  This will waste some
>>>>>>>>>>>>> memory, but we need to follow the API definition to avoid potential
>>>>>>>>>>>>> issues in the long term.
>>>>>>>>>>>>
>>>>>>>>>>>> I have to admit that I'am not really familiar with percpu_ref. So I read the
>>>>>>>>>>>> implementation code of the percpu_ref and found percpu_ref_tryget_live() could
>>>>>>>>>>>> be called after exit now. But you're right we need to follow the API definition
>>>>>>>>>>>> to avoid potential issues in the long term.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> And we need to call percpu_ref_init() before insert the swap_info_struct
>>>>>>>>>>>>> into the swap_info[].
>>>>>>>>>>>>
>>>>>>>>>>>> If we remove the call to percpu_ref_exit(), we should not use percpu_ref_init()
>>>>>>>>>>>> here because *percpu_ref->data is assumed to be NULL* in percpu_ref_init() while
>>>>>>>>>>>> this is not the case as we do not call percpu_ref_exit(). Maybe percpu_ref_reinit()
>>>>>>>>>>>> or percpu_ref_resurrect() will do the work.
>>>>>>>>>>>>
>>>>>>>>>>>> One more thing, how could I distinguish the killed percpu_ref from newly allocated one?
>>>>>>>>>>>> It seems percpu_ref_is_dying is only safe to call when @ref is between init and exit.
>>>>>>>>>>>> Maybe I could do this in alloc_swap_info()?
>>>>>>>>>>>
>>>>>>>>>>> Yes.  In alloc_swap_info(), you can distinguish newly allocated and
>>>>>>>>>>> reused swap_info_struct.
>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>  	struct swap_cluster_info *ci = si->cluster_info;
>>>>>>>>>>>>>>> @@ -2500,7 +2510,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>>>>>>>>>>>>>>>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
>>>>>>>>>>>>>>>  	 * between get/put_swap_device() if SWP_VALID bit is set
>>>>>>>>>>>>>>>  	 */
>>>>>>>>>>>>>>> -	synchronize_rcu();
>>>>>>>>>>>>>>> +	percpu_ref_reinit(&p->users);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Although the effect is same, I think it's better to use
>>>>>>>>>>>>>> percpu_ref_resurrect() here to improve code readability.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Check the original commit description for commit eb085574a752 "mm, swap:
>>>>>>>>>>>>> fix race between swapoff and some swap operations" and discussion email
>>>>>>>>>>>>> thread as follows again,
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/20171219053650.GB7829@linux.vnet.ibm.com/
>>>>>>>>>>>>>
>>>>>>>>>>>>> I found that the synchronize_rcu() here is to avoid to call smp_rmb() or
>>>>>>>>>>>>> smp_load_acquire() in get_swap_device().  Now we will use
>>>>>>>>>>>>> percpu_ref_tryget_live() in get_swap_device(), so we will need to add
>>>>>>>>>>>>> the necessary memory barrier, or make sure percpu_ref_tryget_live() has
>>>>>>>>>>>>> ACQUIRE semantics.  Per my understanding, we need to change
>>>>>>>>>>>>> percpu_ref_tryget_live() for that.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Do you mean the below scene is possible?
>>>>>>>>>>>>
>>>>>>>>>>>> cpu1
>>>>>>>>>>>> swapon()
>>>>>>>>>>>>   ...
>>>>>>>>>>>>   percpu_ref_init
>>>>>>>>>>>>   ...
>>>>>>>>>>>>   setup_swap_info
>>>>>>>>>>>>   /* smp_store_release() is inside percpu_ref_reinit */
>>>>>>>>>>>>   percpu_ref_reinit
>>>>>>>>>>>
>>>>>>>>>>> spin_unlock() has RELEASE semantics already.
>>>>>>>>>>>
>>>>>>>>>>>>   ...
>>>>>>>>>>>>
>>>>>>>>>>>> cpu2
>>>>>>>>>>>> get_swap_device()
>>>>>>>>>>>>   /* ignored  smp_rmb() */
>>>>>>>>>>>>   percpu_ref_tryget_live
>>>>>>>>>>>
>>>>>>>>>>> Some kind of ACQUIRE is required here to guarantee the refcount is
>>>>>>>>>>> checked before fetching the other fields of swap_info_struct.  I have
>>>>>>>>>>> sent out a RFC patch to mailing list to discuss this.
>>>>>>>>
>>>>>>>> I'm just catching up and following along a little bit. I apologize I
>>>>>>>> haven't read the swap code, but my understanding is you are trying to
>>>>>>>> narrow a race condition with swapoff. That makes sense to me. I'm not
>>>>>>>> sure I follow the need to race with reinitializing the ref though? Is it
>>>>>>>> not possible to wait out the dying swap info and then create a new one
>>>>>>>> rather than push acquire semantics?
>>>>>>>
>>>>>>> We want to check whether the swap entry is valid (that is, the swap
>>>>>>> device isn't swapped off now), prevent it from swapping off, then access
>>>>>>> the swap_info_struct data structure.  When accessing swap_info_struct,
>>>>>>> we want to guarantee the ordering, so that we will not reference
>>>>>>> uninitialized fields of swap_info_struct.
>>>>>>>
>>>>>>
>>>>>> So in the normal context of percpu_ref, once someone can access it, the
>>>>>> elements that it is protecting are expected to be initialized.
>>>>>
>>>>> If we can make sure that all elements being initialized fully, why not
>>>>> just use percpu_ref_get() instead of percpu_ref_tryget*()?
>>>>>
>>>>
>>>> Generally, the lookup is protected with rcu and then
>>>> percpu_ref_tryget*() is used to obtain a reference. percpu_ref_get() is
>>>> only good if you already have a ref as it increments regardless of being
>>>> 0.
>>>>
>>>> What I mean is if you can get a ref, that means the object hasn't been
>>>> destroyed. This differs from the semantics you are looking for which I
>>>> understand to be: I have long lived pointers to objects. The object may
>>>> die, but I may resurrect it and I want the old pointers to still be
>>>> valid.
>>>>
>>>> When is it possible for someone to have a pointer to the swap device and
>>>> the refcount goes to 0? It might be better to avoid this situation than
>>>> add acquire semantics.
>>>>
>>>>>> In the basic case for swap off, I'm seeing the goal as to prevent
>>>>>> destruction until anyone currently accessing swap is done. In this
>>>>>> case wouldn't we always be protecting a live struct?
>>>>>>
>>>>>> I'm maybe not understanding what conditions you're trying to revive the
>>>>>> percpu_ref?
>>>>>
>>>>> A swap entry likes an indirect pointer to a swap device.  We may hold a
>>>>> swap entry for long time, so that the swap device is swapoff/swapon.
>>>>> Then we need to make sure the swap device are fully initialized before
>>>>> accessing the swap device via the swap entry.
>>>>>
>>>>
>>>> So if I have some number of outstanding references, and then
>>>> percpu_ref_kill() is called, then only those that have the pointer will
>>>> be able to use the swap device as those references are still good. Prior
>>>> to calling percpu_ref_kill(), call_rcu() needs to be called on lookup
>>>> data structure.
>>>>
>>>> My personal understanding of tryget() vs tryget_live() is that it
>>>> provides a 2 phase clean up and bounds the ability for new users to come
>>>> in (cgroup destruction is a primary user). As tryget() might inevitably
>>>> let a cgroup live long past its removal, tryget_live() will say oh
>>>> you're in the process of dying do something else.
>>>
>>> OK.  I think that I understand your typical use case now.  The resource
>>> producer code may look like,
>>>
>>>   obj = kmalloc();
>>>   /* Initialize obj fields */
>>>   percpu_ref_init(&obj->ref);
>>>   rcu_assign_pointer(global_p, obj);
>>>
>>> The resource reclaimer looks like,
>>>
>>>   p = global_p;
>>>   global_p = NULL;
>>>   percpu_ref_kill(&p->ref);
>>>   /* wait until percpu_ref_is_zero(&p->ref) */
>>>   /* free resources pointed by obj fields */
>>>   kfree(p);
>>>
>>> The resource producer looks like,
>>>
>>>   rcu_read_lock();
>>>   p = rcu_dereference(global_p);
>>>   if (!p || !percpu_ref_tryget_live(&p->ref)) {
>>>           /* Invalid pointer, go out */
>>>   }
>>>   rcu_read_unlock();
>>>   /* use p */
>>>   percpu_ref_put(&p->ref);
>>>
>>> For this use case, it's not necessary to make percpu_ref_tryget_live()
>>> ACQUIRE operation.  Because refcount doesn't act as a flag to indicate
>>> whether the object has been fully initialized, global_p does.  And
>>> the data dependency guaranteed the required ordering.
>>>
>> 
>> Yes this is spot on.
>> 
>>> The use case of swap is different.  Where global_p always points to
>>> the obj (never freed) even if the resources pointed by obj fields has
>>> been freed.  And we want to use refcount as a flag to indicate whether
>>> the object is fully initialized.  This is hard to be changed, because
>>> the global_p is used to identify the stalled pointer from the totally
>>> invalid pointer.
>>>
>> 
>> Apologies ahead of time for this possibly dumb question. Is it possible
>> to have swapon swap out the global_p with
>> old_obj = rcu_access_pointer(global_p);
>> rcu_assign_pointer(global_p, obj);
>> kfree_rcu(remove_old_obj) or call_rcu();
>> 
>> Then the obj pointed to by global_p would always be valid, but only
>> would be alive again if it got the new pointer?
>
> Many thanks for both of you! Looks like a nice solution! Will try to do it in v2.
> Thanks again! :)

Think about this again.  This means that we need to free the old
swap_info_struct at some time.  So something like RCU is needed to
enclose the accessor.  But some accessor doesn't follow this, and it
appears overkill to change all these accessors.  So I think at least as
the first step, smp_rmb() appears more appropriate.

Best Regards,
Huang, Ying

>> 
>>> If all other users follow the typical use case above, we may find some
>>> other way to resolve the problem inside swap code, such as adding
>>> smp_rmb() after percpu_ref_tryget_live().
>>>
>> 
>> I would prefer it.
>> 
>>> Best Regards,
>>> Huang, Ying
>> 
>> Thanks,
>> Dennis
>> 
>> .
>> 
