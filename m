Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79DA40EADF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhIPTfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhIPTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:35:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:34:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c8so23044666lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6mmXR9sn4aUKnpE0M6FckZySxfxKRfWw9V/EDd6Fsl8=;
        b=YsQyQER7nuHEU7isBnZKHjKkICn3dyryD8wyfYAlxhwPW9JGr3YVDjrtdEiOp0xw5S
         zAg6iIO2LyCieLK9qaZ7F37RV1AybhKcyP2bBMVbUy/Cj0R+5NoQkBAUKzJ9qmdlLbq8
         aug/epVomSWRoHpw4J9xZSztxD72SnZxSl3TyEbJPiHFW7Pz257XZjbrO8QJrwRlDbwK
         Lwmq6m50GTIDTWIGbjFKVsze85YrF7s1DgdkQU7r7XSnwPScLXcyatEm3SNkc3YeI3aB
         A5at8eantcguGknphPv+cZBVvstcj7ITgPDDVMEQ87z5zSGW8YUhAtbAU44TwTI8B1ge
         2edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6mmXR9sn4aUKnpE0M6FckZySxfxKRfWw9V/EDd6Fsl8=;
        b=098kLSDzLfbFDMkF0SHXFeoopE+gkHn0WiPWJeCAEIVXM22IFKqFnt5mKa8wOaebwv
         MZ9tldDfYyDka7ANyW4y/03fbvykY2AhimjKdIGvTtoQFOFVR6MdAMGeaLzHqCDOB0p7
         4uXTKs3xR4LTPDQ1tbi9Sip+YVWZztcnkDkSc87N0e8UQMXi07vveaVF4WfA6N7rdmdY
         UpGblrKRTTEjmLs9eEGZPljh0AdsSLFWC7nhp4aMR4azpdrm4sORFxYaW/DJ1KJ2CkZc
         ziURfWejMCG2zcrEXoti+OUsGztEWTyjnPYsOA9x7Vvd3tX1zu3dTYDpYK/jb26uBtzF
         5x2w==
X-Gm-Message-State: AOAM533NCHZAS39irrddnVUq08WoODAeTqGWW5vyVN9jF30ukDK4QoW6
        DV64Wa4jYc5XDmxRrCJ8JNU=
X-Google-Smtp-Source: ABdhPJypR98XnlX8kN0hoql8VSq4EEt6tboLuos4ov00RhGlEjeSmoqQQjt03/aHzX7T/0Q7Vv8A5Q==
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr5215377lfu.105.1631820846591;
        Thu, 16 Sep 2021 12:34:06 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u12sm364490lff.280.2021.09.16.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:34:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 16 Sep 2021 21:34:03 +0200
To:     David Hildenbrand <david@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
Message-ID: <20210916193403.GA1940@pc638.lan>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 14.09.21 21:15, Uladzislau Rezki wrote:
> > > Let me have a look at it.
> > > 
> > > Vlad Rezki
> > > 
> > > On Wed, Sep 8, 2021 at 3:27 PM David Hildenbrand <david@redhat.com> wrote:
> > > > 
> > > > find_vmap_lowest_match() is imprecise such that it won't always
> > > > find "the first free block ... that will accomplish the request" if
> > > > an alignment > 1 was specified: especially also when the alignment is
> > > > PAGE_SIZE. Unfortuantely, the way the vmalloc data structures were
> > > > designed, propagating the max size without alignment information through
> > > > the tree, it's hard to make it precise again when an alignment > 1 is
> > > > specified.
> > > > 
> > > > The issue is that in order to be able to eventually align later,
> > > > find_vmap_lowest_match() has to search for a slightly bigger area and
> > > > might skip some applicable subtrees just by lookign at the result of
> > > > get_subtree_max_size(). While this usually doesn't matter, it matters for
> > > > exact allocations as performed by KASAN when onlining a memory block,
> > > > when the free block exactly matches the request.
> > > > (mm/kasn/shadow.c:kasan_mem_notifier()).
> > > > 
> > > > In case we online memory blocks out of order (not lowest to highest
> > > > address), find_vmap_lowest_match() with PAGE_SIZE alignment will reject
> > > > an exact allocation if it corresponds exactly to a free block. (there are
> > > > some corner cases where it would still work, if we're lucky and hit the
> > > > first is_within_this_va() inside the while loop)
> > > > 
> > > > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory82/state
> > > > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory83/state
> > > > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory85/state
> > > > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory84/state
> > > > [  223.858115] vmap allocation for size 16777216 failed: use vmalloc=<size> to increase size
> > > > [  223.859415] bash: vmalloc: allocation failure: 16777216 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > > > [  223.860992] CPU: 4 PID: 1644 Comm: bash Kdump: loaded Not tainted 4.18.0-339.el8.x86_64+debug #1
> > > > [  223.862149] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > > > [  223.863580] Call Trace:
> > > > [  223.863946]  dump_stack+0x8e/0xd0
> > > > [  223.864420]  warn_alloc.cold.90+0x8a/0x1b2
> > > > [  223.864990]  ? zone_watermark_ok_safe+0x300/0x300
> > > > [  223.865626]  ? slab_free_freelist_hook+0x85/0x1a0
> > > > [  223.866264]  ? __get_vm_area_node+0x240/0x2c0
> > > > [  223.866858]  ? kfree+0xdd/0x570
> > > > [  223.867309]  ? kmem_cache_alloc_node_trace+0x157/0x230
> > > > [  223.868028]  ? notifier_call_chain+0x90/0x160
> > > > [  223.868625]  __vmalloc_node_range+0x465/0x840
> > > > [  223.869230]  ? mark_held_locks+0xb7/0x120
> > > > 
> > > > While we could fix this in kasan_mem_notifier() by passing an alignment
> > > > of "1", this is actually an implementation detail of vmalloc and to be
> > > > handled internally.
> > > > 
> > > > So use an alignment of 1 when calling find_vmap_lowest_match() for exact
> > > > allocations that are expected to succeed -- if the given range can
> > > > satisfy the alignment requirements.
> > > > 
> > > > Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> > > > Reported-by: Ping Fang <pifang@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Cc: Roman Gushchin <guro@fb.com>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Oscar Salvador <osalvador@suse.de>
> > > > Cc: linux-mm@kvack.org
> > > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > ---
> > > >   mm/vmalloc.c | 13 +++++++++++--
> > > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index d5cd52805149..c6071f5f8de3 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1153,7 +1153,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> > > >   /*
> > > >    * Find the first free block(lowest start address) in the tree,
> > > >    * that will accomplish the request corresponding to passing
> > > > - * parameters.
> > > > + * parameters. Note that with an alignment > 1, this function
> > > > + * can be imprecise and skip applicable free blocks.
> > > >    */
> > > >   static __always_inline struct vmap_area *
> > > >   find_vmap_lowest_match(unsigned long size,
> > > > @@ -1396,7 +1397,15 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
> > > >          enum fit_type type;
> > > >          int ret;
> > > > 
> > > > -       va = find_vmap_lowest_match(size, align, vstart);
> > > > +       /*
> > > > +        * For exact allocations, ignore the alignment, such that
> > > > +        * find_vmap_lowest_match() won't search for a bigger free area just
> > > > +        * able to align later and consequently fail the search.
> > > > +        */
> > > > +       if (vend - vstart == size && IS_ALIGNED(vstart, align))
> > > > +               va = find_vmap_lowest_match(size, 1, vstart);
> > > > +       else
> > > > +               va = find_vmap_lowest_match(size, align, vstart);
> > > >          if (unlikely(!va))
> > > >                  return vend;
> > > > 
> > > > 
> > > > base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
> > > > --
> > > > 2.31.1
> > > > 
> > This patch looks like a KASAN specific to me. So i would like to avoid
> > such changes to
> > the vmalloc internals in order to simplify further maintenance and
> > keeping it generic
> > instead.
> 
> There is nothing KASAN specific in there :) It's specific to exact
> applications -- and KASAN may be one of the only users for now.
> 
Well, you can name it either way :) So it should not be specific by the
design, otherwise as i mentioned the allocator would be like a peace of
code that handles corner cases what is actually not acceptable.

> > 
> > Currently the find_vmap_lowest_match() adjusts the search size
> > criteria for any alignment
> > values even for PAGE_SIZE alignment. That is not optimal. Because a
> > PAGE_SIZE or one
> > page is a minimum granularity we operate on vmalloc allocations thus
> > all free blocks are
> > page aligned.
> > 
> > All that means that we should adjust the search length only if an
> > alignment request is bigger than
> > one page, in case of one page, that corresponds to PAGE_SIZE value,
> > there is no reason in such
> > extra adjustment because all free->va_start have a page boundary anyway.
> > 
> > Could you please test below patch that is a generic improvement?
> 
> I played with the exact approach below (almost exactly the same code in
> find_vmap_lowest_match()), and it might make sense as a general improvement
> -- if we can guarantee that start+end of ranges are always PAGE-aligned; I
> was not able to come to that conclusion...
All free blocks are PAGE aligned that is how it has to be. A vstart also
should be aligned otherwise the __vunmap() will complain about freeing
a bad address: 

<snip>
    if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad address (%p)\n",
            addr))
        return;
<snip>

BTW, we should add an extra check to the alloc_vmap_area(), something like
below:

<snip>
    if (!PAGE_ALIGNED(ALIGN(vstart, align))) {
        WARN_ONCE(1, "vmalloc: vstart or align are not page aligned (0x%lx, 0x%lx)\n",
            vstart, align);
        return ERR_PTR(-EBUSY);
	}
<snip>

to check that passed pair of vstart and align are correct.

>
> vmap_init_free_space() shows me that our existing alignment code/checks
> might be quite fragile.
>
It is not important to page align a first address. As i mentioned before
vstart and align have to be correct and we should add such check.

> 
> But I mainly decided to go with my patch instead because it will also work
> for exact allocations with align > PAGE_SIZE: most notably, when we try
> population of hugepages instead of base pages in __vmalloc_node_range(), by
> increasing the alignment. If the exact range allows for using huge pages,
> placing huge pages will work just fine with my modifications, while it won't
> with your approach.
> 
> Long story short: my approach handles exact allocations also for bigger
> alignment, Your optimization makes sense as a general improvement for any
> vmalloc allocations.
> 
> Thanks for having a look!
>
The problem is that there are no users(seems only KASAN) who set the range
that corresponds to exact size. If you add an aligment overhead on top of
it means that search size should include it because we may end up with exact
free block and after applying aligment it will not fit. This is how allocators
handle aligment.

Another approach is(you mentioned it in your commit message):

urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff mm/kasan/shadow.c
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 082ee5b6d9a1..01d3bd76c851 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -200,7 +200,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
                if (shadow_mapped(shadow_start))
                        return NOTIFY_OK;
 
-               ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
+               ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
                                        shadow_end, GFP_KERNEL,
                                        PAGE_KERNEL, VM_NO_GUARD,
                                        pfn_to_nid(mem_data->start_pfn),
urezki@pc638:~/data/raid0/coding/linux-next.git$

why not? Also you can increase the range in KASAN code.

--
Vlad Rezki
