Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E98413D60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhIUWPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhIUWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:15:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF270C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:13:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u18so3294044lfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pCZE/KATfVul7zh4Istxf2mLH4yD9uQZLzU/uqsm3SY=;
        b=MTDamyLducVf/fexpFbF74KsLN0AjIGWkypxrsjC2pB4V5VdW2adz1qfQv6xdz6Bx2
         t5OHe/cSfQyo76F3W/r9jU9+ul+s6w71n5usmCuus1vqi6mJEJCeHKwYuYpe0LV5krPg
         6X+ie3WOEEIJh7/7roZn0lHOds0F0Rp0LgIE4vzbiHo/krH7zLLeOyHVhdCIQIG7qQXz
         3cUJaZAcNWdJHNhoaXc2zOPG7UtqCIHl+sWUTPru8Gge180ZUXuN/rgN0Yf+5y+k/Hnc
         ekSEL2HwnshlHf0B05ltS3o23ZNjvDvaWt1Z5LKB+AfXfjQwgJC5XJtz0tDPhucr4SiD
         t4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pCZE/KATfVul7zh4Istxf2mLH4yD9uQZLzU/uqsm3SY=;
        b=nfbMsiCk3EXv64HPTozW4svJk4zQ29tA6TIdwQmyTuO3Uf4N3PVLDPjnLMh9cEuS+u
         7NKGgJfk4mVp6PDClzxyzDziMuEcmUdUcKz+MSEDGgXY+CMnfJxMKhJUclOOD0FpA5B3
         H7uuiXSXF+L/GtoECxKRkOiFVdZ0pl4JBiq5KLFW0ODi0KP6w1KwOt7j3v2mO+mUFmcT
         AcmL3v//Hh2evfCV0dlJ3E2QqOEW1+tIPpeQR+OGvRcdLN4IVLPX+vYqJH3Ia3K8SB3a
         N2SHLH5u0ERNsoXdWUVrU1hXRBv4TaahfnkH5apGm58bfdR1PSaEEijmXbYUHG1aiB/J
         G8EQ==
X-Gm-Message-State: AOAM530WchGXqct5pkz+fDNUn+VrfgOaVrU8ADp35ExiHaYqeM7qBx2K
        1MUQBxpPNzalIF7ZbCdQ0b0=
X-Google-Smtp-Source: ABdhPJxHZ98JNyN/RVo5CFQyNkvyu8J+eSut3oEfn9GUlznngSgBTQP0BgP9fFFKD7NzQpBexmWJUQ==
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr25724700lfs.24.1632262419992;
        Tue, 21 Sep 2021 15:13:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id r206sm23234lff.100.2021.09.21.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:13:39 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 22 Sep 2021 00:13:37 +0200
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
Message-ID: <20210921221337.GA60191@pc638.lan>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:47:54AM +0200, David Hildenbrand wrote:
> > > > This patch looks like a KASAN specific to me. So i would like to avoid
> > > > such changes to
> > > > the vmalloc internals in order to simplify further maintenance and
> > > > keeping it generic
> > > > instead.
> > > 
> > > There is nothing KASAN specific in there :) It's specific to exact
> > > applications -- and KASAN may be one of the only users for now.
> > > 
> > Well, you can name it either way :) So it should not be specific by the
> > design, otherwise as i mentioned the allocator would be like a peace of
> > code that handles corner cases what is actually not acceptable.
> 
> Let's not overstress the situation of adding essentially 3 LOC in order to
> fix a sane use case of the vmalloc allocator that was not considered
> properly by internal changes due to 68ad4a330433 ("mm/vmalloc.c: keep track
> of free blocks for vmap allocation").
> 
> > 
> > > > 
> > > > Currently the find_vmap_lowest_match() adjusts the search size
> > > > criteria for any alignment
> > > > values even for PAGE_SIZE alignment. That is not optimal. Because a
> > > > PAGE_SIZE or one
> > > > page is a minimum granularity we operate on vmalloc allocations thus
> > > > all free blocks are
> > > > page aligned.
> > > > 
> > > > All that means that we should adjust the search length only if an
> > > > alignment request is bigger than
> > > > one page, in case of one page, that corresponds to PAGE_SIZE value,
> > > > there is no reason in such
> > > > extra adjustment because all free->va_start have a page boundary anyway.
> > > > 
> > > > Could you please test below patch that is a generic improvement?
> > > 
> > > I played with the exact approach below (almost exactly the same code in
> > > find_vmap_lowest_match()), and it might make sense as a general improvement
> > > -- if we can guarantee that start+end of ranges are always PAGE-aligned; I
> > > was not able to come to that conclusion...
> > All free blocks are PAGE aligned that is how it has to be. A vstart also
> > should be aligned otherwise the __vunmap() will complain about freeing
> > a bad address:
> > 
> > <snip>
> >      if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad address (%p)\n",
> >              addr))
> >          return;
> > <snip>
> > 
> > BTW, we should add an extra check to the alloc_vmap_area(), something like
> > below:
> > 
> > <snip>
> >      if (!PAGE_ALIGNED(ALIGN(vstart, align))) {
> >          WARN_ONCE(1, "vmalloc: vstart or align are not page aligned (0x%lx, 0x%lx)\n",
> >              vstart, align);
> >          return ERR_PTR(-EBUSY);
> > 	}
> > <snip>
> > 
> > to check that passed pair of vstart and align are correct.
> > 
> 
> Yes we better should.
> 
> > > 
> > > vmap_init_free_space() shows me that our existing alignment code/checks
> > > might be quite fragile.
> > > 
> > It is not important to page align a first address. As i mentioned before
> > vstart and align have to be correct and we should add such check.
> > 
> > > 
> > > But I mainly decided to go with my patch instead because it will also work
> > > for exact allocations with align > PAGE_SIZE: most notably, when we try
> > > population of hugepages instead of base pages in __vmalloc_node_range(), by
> > > increasing the alignment. If the exact range allows for using huge pages,
> > > placing huge pages will work just fine with my modifications, while it won't
> > > with your approach.
> > > 
> > > Long story short: my approach handles exact allocations also for bigger
> > > alignment, Your optimization makes sense as a general improvement for any
> > > vmalloc allocations.
> > > 
> > > Thanks for having a look!
> > > 
> > The problem is that there are no users(seems only KASAN) who set the range
> > that corresponds to exact size. If you add an aligment overhead on top of
> 
> So there is one user and it was broken by 68ad4a330433 ("mm/vmalloc.c: keep
> track of free blocks for vmap allocation").
> 
> > it means that search size should include it because we may end up with exact
> > free block and after applying aligment it will not fit. This is how allocators
> > handle aligment.
> 
> This is an implementation detail of the vmalloc allocator ever since
> 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap
> allocation").
> 
> If callers pass an exact range, and the alignment they specify applies, why
> should we reject such an allocation? It's leaking an implementation detail
> fixed easily internally into callers.
> 
> > 
> > Another approach is(you mentioned it in your commit message):
> > 
> > urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff mm/kasan/shadow.c
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index 082ee5b6d9a1..01d3bd76c851 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -200,7 +200,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
> >                  if (shadow_mapped(shadow_start))
> >                          return NOTIFY_OK;
> > -               ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
> > +               ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
> >                                          shadow_end, GFP_KERNEL,
> >                                          PAGE_KERNEL, VM_NO_GUARD,
> >                                          pfn_to_nid(mem_data->start_pfn),
> > urezki@pc638:~/data/raid0/coding/linux-next.git$
> > 
> > why not? Also you can increase the range in KASAN code.
> 
> No, that's leaking implementation details to the caller. And no, increasing
> the range and eventually allocating something bigger (e.g., placing a huge
> page where it might not have been possible) is not acceptable for KASAN.
> 
> If you're terribly unhappy with this patch,
Sorry to say but it simple does not make sense.

>
> please suggest something reasonable to fix exact allocations:
> a) Fixes the KASAN use case.
> b) Allows for automatic placement of huge pages for exact allocations.
> c) Doesn't leak implementation details into the caller.
>
I am looking at it.

--
Vlad Rezki
