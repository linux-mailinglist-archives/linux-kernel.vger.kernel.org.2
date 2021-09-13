Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20040874C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhIMIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhIMIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:45:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A16C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:44:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h17so3056614edj.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJVLAgjPqP4xIJS9umrFtQA2JuduxsSgfZlrPIy+kDk=;
        b=VY3Zmvkj8mVPfQA/REWw0z8U6rmZ//lToHAyUr6eaOw76YsrXwFzNE4K0CZBDI9T1x
         gcBMDsEPgxkSMzqboJTdXnQTN9t13gTb+IyqX9W4gnjDFTCn+YZIl6KUnuyYjOGkwjGd
         YHRVbz65fQoy9m6b41cHBVMvyh47YLLQGiatQZpKs0Fb8vq7uUXyCy77GL4Dd4TNVjrE
         zpuNqS43xM12rm2dj53VUPuycaRHm4fqCRAxwnW3CfubUf0CckiLPmGI6QeiNbkc6m6h
         TtX61ECTdlytDlYEdxlsnxGya+EkhNrSSdocl6ej8yQ9uZkgvZDzndEw+O+C3xhK/qc9
         iIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJVLAgjPqP4xIJS9umrFtQA2JuduxsSgfZlrPIy+kDk=;
        b=QpOdeyEtSkLWcv7QZLH9OfO2fEDksZz6zBI/ZTNPfKxJp2aB9GCbKJzDVz30dEcMyV
         HN4boStHBS4jsYPn9iFL9NtzPFwR0Fgp5Za8coFZetOeTpKJ/GomwKhSdzA/ejFhvXMw
         kvU8e/rQOmPXOqGUM478ALrjZPIrTUtv6xCUw80cnxMP97LZCHXnhTRXwgS58xPrVKPC
         nBkmhsClI9O76k6PxRPDNX9w0vFATy9ssH0BxJtfi5RbaQWhP2tJmJL77UT3324Hs7n3
         71tzQ4rcp4iV4ztGL0PwIjvNgm2JtHJaLM0zmKxMRY6p2aIFrsYxyoevviR4Jk1yn90k
         bYNg==
X-Gm-Message-State: AOAM530BExlQbpkhgjJrlT+yDpJ9AMiRdUy/TQC3KPOz66jatY8ExMNG
        DuurnTTxyj7+1A+1LbPOsBVxvZYg2XBUv724pkPPSjs8Rsc=
X-Google-Smtp-Source: ABdhPJyXvc35ThSM56k2hv5/iCu97D4QsqZsoCkrHXWLBUmMQjxbuKufpiRubRI4zNvpkOX4bZI3M750SQcjDwvQgmc=
X-Received: by 2002:aa7:da41:: with SMTP id w1mr10093692eds.344.1631522669397;
 Mon, 13 Sep 2021 01:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210908132727.16165-1-david@redhat.com>
In-Reply-To: <20210908132727.16165-1-david@redhat.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 13 Sep 2021 10:44:18 +0200
Message-ID: <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
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

Hello.

Let me have a look at it.

Vlad Rezki

On Wed, Sep 8, 2021 at 3:27 PM David Hildenbrand <david@redhat.com> wrote:
>
> find_vmap_lowest_match() is imprecise such that it won't always
> find "the first free block ... that will accomplish the request" if
> an alignment > 1 was specified: especially also when the alignment is
> PAGE_SIZE. Unfortuantely, the way the vmalloc data structures were
> designed, propagating the max size without alignment information through
> the tree, it's hard to make it precise again when an alignment > 1 is
> specified.
>
> The issue is that in order to be able to eventually align later,
> find_vmap_lowest_match() has to search for a slightly bigger area and
> might skip some applicable subtrees just by lookign at the result of
> get_subtree_max_size(). While this usually doesn't matter, it matters for
> exact allocations as performed by KASAN when onlining a memory block,
> when the free block exactly matches the request.
> (mm/kasn/shadow.c:kasan_mem_notifier()).
>
> In case we online memory blocks out of order (not lowest to highest
> address), find_vmap_lowest_match() with PAGE_SIZE alignment will reject
> an exact allocation if it corresponds exactly to a free block. (there are
> some corner cases where it would still work, if we're lucky and hit the
> first is_within_this_va() inside the while loop)
>
> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory82/state
> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory83/state
> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory85/state
> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory84/state
> [  223.858115] vmap allocation for size 16777216 failed: use vmalloc=<size> to increase size
> [  223.859415] bash: vmalloc: allocation failure: 16777216 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> [  223.860992] CPU: 4 PID: 1644 Comm: bash Kdump: loaded Not tainted 4.18.0-339.el8.x86_64+debug #1
> [  223.862149] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  223.863580] Call Trace:
> [  223.863946]  dump_stack+0x8e/0xd0
> [  223.864420]  warn_alloc.cold.90+0x8a/0x1b2
> [  223.864990]  ? zone_watermark_ok_safe+0x300/0x300
> [  223.865626]  ? slab_free_freelist_hook+0x85/0x1a0
> [  223.866264]  ? __get_vm_area_node+0x240/0x2c0
> [  223.866858]  ? kfree+0xdd/0x570
> [  223.867309]  ? kmem_cache_alloc_node_trace+0x157/0x230
> [  223.868028]  ? notifier_call_chain+0x90/0x160
> [  223.868625]  __vmalloc_node_range+0x465/0x840
> [  223.869230]  ? mark_held_locks+0xb7/0x120
>
> While we could fix this in kasan_mem_notifier() by passing an alignment
> of "1", this is actually an implementation detail of vmalloc and to be
> handled internally.
>
> So use an alignment of 1 when calling find_vmap_lowest_match() for exact
> allocations that are expected to succeed -- if the given range can
> satisfy the alignment requirements.
>
> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> Reported-by: Ping Fang <pifang@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/vmalloc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d5cd52805149..c6071f5f8de3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1153,7 +1153,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>  /*
>   * Find the first free block(lowest start address) in the tree,
>   * that will accomplish the request corresponding to passing
> - * parameters.
> + * parameters. Note that with an alignment > 1, this function
> + * can be imprecise and skip applicable free blocks.
>   */
>  static __always_inline struct vmap_area *
>  find_vmap_lowest_match(unsigned long size,
> @@ -1396,7 +1397,15 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>         enum fit_type type;
>         int ret;
>
> -       va = find_vmap_lowest_match(size, align, vstart);
> +       /*
> +        * For exact allocations, ignore the alignment, such that
> +        * find_vmap_lowest_match() won't search for a bigger free area just
> +        * able to align later and consequently fail the search.
> +        */
> +       if (vend - vstart == size && IS_ALIGNED(vstart, align))
> +               va = find_vmap_lowest_match(size, 1, vstart);
> +       else
> +               va = find_vmap_lowest_match(size, align, vstart);
>         if (unlikely(!va))
>                 return vend;
>
>
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
> --
> 2.31.1
>
