Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC34B40B7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhINTRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhINTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:17:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:15:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e21so606110ejz.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHstVMUN/G0pYs2uKRn5zA+XIUh1l56ApnQSUa8rs7Q=;
        b=X9BKcGWEQsJOCiBp1Ia5outl6HBqUsFiJyV+A27LeZnuVpZom5iTey2FEMlQG2aCLu
         D721MGvcH2zCSIJtQ5WVYv3ac6gexRNarfzsdjEfVggvRMWuygxSUNCsPEE4aerEbsId
         6KB+9doaXfKO2JmIoM86aTYAP81xYTL0GecNWwFKuiiaEtTmvmSEy0xqZY05IWg9O+Qa
         xMSVM50gB5yPAd0kj9hPh/SrESido7M8W5DzEd0ZFxp/Su1H/zy61RwdLq14lIrg8vbD
         R+zt+5iv7Y8fPimhyn6qiZXRixcVbNIoKruoPB/uk4I39oNH9bjlwhD2EXNeZe0gx9+E
         Yx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHstVMUN/G0pYs2uKRn5zA+XIUh1l56ApnQSUa8rs7Q=;
        b=Can4YqanVjkPZJIUPwOkegBzkBDy1PH3RCfIOgxrGyYHmPm7PiwsGz7554dqjFErUw
         qOj9Gkxbq4T3RDEz1cK3oMDSgbwdAUSK9QKVEUO3tk/1bSj4gQOv8aUwixjG7otNGY4N
         s563tFemd3Y49QuF38PkYZmhcXIDq6fwOxW8ZqZ7AfsMlOQw6oyolHZmzAJsqyscV3yA
         PLVbIf2EXzBTxW6APnrOIvIcnCTFnaqDnDGfNQc3T+0EP3sITKNxjynWsKC+LOCl5Axg
         iJ2Jg/HlZVTruENPBu/FchRZGbqjj857A2epRTef5RTygFM7uPTIsG1po75c8ELlV1Ik
         vLvA==
X-Gm-Message-State: AOAM530yevGi8Lw++b5P2Bprwk5MW2jHCu7RKIePqtZuNVHY4eLc1McP
        mKKUzCdB8/jeLVhFF4GzDZc2dM0iTVNMO3XlgQsYQY0vMg7nB66J
X-Google-Smtp-Source: ABdhPJxS8Orxy4055O/Xwy/Ud7P0uMfay8d4QTLnHeVOhO5HWQLVrjeeueVZRp+XAvOJMHTIKqCtnSNuVjdyG2nJ+ws=
X-Received: by 2002:a17:906:c055:: with SMTP id bm21mr20429680ejb.350.1631646941112;
 Tue, 14 Sep 2021 12:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210908132727.16165-1-david@redhat.com> <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
In-Reply-To: <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 14 Sep 2021 21:15:30 +0200
Message-ID: <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment > 1
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me have a look at it.
>
> Vlad Rezki
>
> On Wed, Sep 8, 2021 at 3:27 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > find_vmap_lowest_match() is imprecise such that it won't always
> > find "the first free block ... that will accomplish the request" if
> > an alignment > 1 was specified: especially also when the alignment is
> > PAGE_SIZE. Unfortuantely, the way the vmalloc data structures were
> > designed, propagating the max size without alignment information through
> > the tree, it's hard to make it precise again when an alignment > 1 is
> > specified.
> >
> > The issue is that in order to be able to eventually align later,
> > find_vmap_lowest_match() has to search for a slightly bigger area and
> > might skip some applicable subtrees just by lookign at the result of
> > get_subtree_max_size(). While this usually doesn't matter, it matters for
> > exact allocations as performed by KASAN when onlining a memory block,
> > when the free block exactly matches the request.
> > (mm/kasn/shadow.c:kasan_mem_notifier()).
> >
> > In case we online memory blocks out of order (not lowest to highest
> > address), find_vmap_lowest_match() with PAGE_SIZE alignment will reject
> > an exact allocation if it corresponds exactly to a free block. (there are
> > some corner cases where it would still work, if we're lucky and hit the
> > first is_within_this_va() inside the while loop)
> >
> > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory82/state
> > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory83/state
> > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory85/state
> > [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory84/state
> > [  223.858115] vmap allocation for size 16777216 failed: use vmalloc=<size> to increase size
> > [  223.859415] bash: vmalloc: allocation failure: 16777216 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > [  223.860992] CPU: 4 PID: 1644 Comm: bash Kdump: loaded Not tainted 4.18.0-339.el8.x86_64+debug #1
> > [  223.862149] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [  223.863580] Call Trace:
> > [  223.863946]  dump_stack+0x8e/0xd0
> > [  223.864420]  warn_alloc.cold.90+0x8a/0x1b2
> > [  223.864990]  ? zone_watermark_ok_safe+0x300/0x300
> > [  223.865626]  ? slab_free_freelist_hook+0x85/0x1a0
> > [  223.866264]  ? __get_vm_area_node+0x240/0x2c0
> > [  223.866858]  ? kfree+0xdd/0x570
> > [  223.867309]  ? kmem_cache_alloc_node_trace+0x157/0x230
> > [  223.868028]  ? notifier_call_chain+0x90/0x160
> > [  223.868625]  __vmalloc_node_range+0x465/0x840
> > [  223.869230]  ? mark_held_locks+0xb7/0x120
> >
> > While we could fix this in kasan_mem_notifier() by passing an alignment
> > of "1", this is actually an implementation detail of vmalloc and to be
> > handled internally.
> >
> > So use an alignment of 1 when calling find_vmap_lowest_match() for exact
> > allocations that are expected to succeed -- if the given range can
> > satisfy the alignment requirements.
> >
> > Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> > Reported-by: Ping Fang <pifang@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/vmalloc.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d5cd52805149..c6071f5f8de3 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1153,7 +1153,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> >  /*
> >   * Find the first free block(lowest start address) in the tree,
> >   * that will accomplish the request corresponding to passing
> > - * parameters.
> > + * parameters. Note that with an alignment > 1, this function
> > + * can be imprecise and skip applicable free blocks.
> >   */
> >  static __always_inline struct vmap_area *
> >  find_vmap_lowest_match(unsigned long size,
> > @@ -1396,7 +1397,15 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
> >         enum fit_type type;
> >         int ret;
> >
> > -       va = find_vmap_lowest_match(size, align, vstart);
> > +       /*
> > +        * For exact allocations, ignore the alignment, such that
> > +        * find_vmap_lowest_match() won't search for a bigger free area just
> > +        * able to align later and consequently fail the search.
> > +        */
> > +       if (vend - vstart == size && IS_ALIGNED(vstart, align))
> > +               va = find_vmap_lowest_match(size, 1, vstart);
> > +       else
> > +               va = find_vmap_lowest_match(size, align, vstart);
> >         if (unlikely(!va))
> >                 return vend;
> >
> >
> > base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
> > --
> > 2.31.1
> >
This patch looks like a KASAN specific to me. So i would like to avoid
such changes to
the vmalloc internals in order to simplify further maintenance and
keeping it generic
instead.

Currently the find_vmap_lowest_match() adjusts the search size
criteria for any alignment
values even for PAGE_SIZE alignment. That is not optimal. Because a
PAGE_SIZE or one
page is a minimum granularity we operate on vmalloc allocations thus
all free blocks are
page aligned.

All that means that we should adjust the search length only if an
alignment request is bigger than
one page, in case of one page, that corresponds to PAGE_SIZE value,
there is no reason in such
extra adjustment because all free->va_start have a page boundary anyway.

Could you please test below patch that is a generic improvement?

<snip>
urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 24a3955d5a36..9d219ab5ae57 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1153,7 +1153,9 @@ is_within_this_va(struct vmap_area *va, unsigned
long size,
 /*
  * Find the first free block(lowest start address) in the tree,
  * that will accomplish the request corresponding to passing
- * parameters.
+ * parameters. Note that with an alignment > PAGE_SIZE, this
+ * function can skip applicable free blocks with lower start
+ * addresses which may fit for an alignment request.
  */
 static __always_inline struct vmap_area *
 find_vmap_lowest_match(unsigned long size,
@@ -1167,7 +1169,7 @@ find_vmap_lowest_match(unsigned long size,
        node = free_vmap_area_root.rb_node;

        /* Adjust the search size for alignment overhead. */
-       length = size + align - 1;
+       length = (align > PAGE_SIZE) ? size + align:size;

        while (node) {
                va = rb_entry(node, struct vmap_area, rb_node);
@@ -2251,7 +2253,7 @@ void __init vm_area_register_early(struct
vm_struct *vm, size_t align)

 static void vmap_init_free_space(void)
 {
-       unsigned long vmap_start = 1;
+       unsigned long vmap_start = PAGE_ALIGN(1);
        const unsigned long vmap_end = ULONG_MAX;
        struct vmap_area *busy, *free;

urezki@pc638:~/data/raid0/coding/linux-next.git$
<snip>

Thanks!

--
Vlad Rezki
