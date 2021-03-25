Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBAF348D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCYJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhCYJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:41:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350CCC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:41:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k25so1506264oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ytpgGJ+GtYvC05QBQ0nA79g5rjGcUQUWfto8MGT8T5A=;
        b=hW77Ci8f+U/tmbEmXL8ihJtLZwDMcW8v0ECQY1tqoOjKzhYO2e2BocQHeYO9UZXfKY
         59sqIoLcgr+1t2YNCZ4buVs4UrMdexYoh/cHwYTwYDc7GjNlICuuoObPtE7fwovvCv2z
         7VxapeeBtYVHShmbzgcHfuY1yDFFIL4nqKov0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ytpgGJ+GtYvC05QBQ0nA79g5rjGcUQUWfto8MGT8T5A=;
        b=CxAY4jBJudT5KwEEVOOz2OVQCvESC3NMQblA46BioPZs3oU1zkXRxK47Hn8E9kh2a8
         mClpuLfEqTWfemypVq9scEX/BM+EMH+gNpOh4JfiAh7K1a34REeDyGEk3TZKkgVMk6Uc
         mudRTm+EWYyMrANBMHTpGUYklu1Op0BYAYuEShBklURI1eRGp/HvCmWSacJN1rG2v6vY
         GqlyO/cW/OLi7HWDi+QDYMpcuNN6Nb9YgpF7A8RVOkE6DXWL3S4xRzNVNITp+jlC3VS3
         wdoi00Zgz8Jd/kguAemSdpXdUXgYqEKK4g4OB383TAYf8TkBRb8O8iLLsnyhEC15HmHZ
         vG2Q==
X-Gm-Message-State: AOAM532AM6LD1zg5053BobHWXCpCij+ao4UNaCS3vRnmkYfkVh4Zf/R6
        H7difyrQkGXRDjBjLt0YD0m+EYTumyJ/oD3Msgudxg==
X-Google-Smtp-Source: ABdhPJxxDxu5h9yCJVcP15IRalhi2k05sHNvrUu9jeEPSUjkUiUhVdJspa93B2N9/pa4ZgGWb1DRGRP5BClMeSyEVBk=
X-Received: by 2002:aca:4188:: with SMTP id o130mr5362730oia.101.1616665314626;
 Thu, 25 Mar 2021 02:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <YFsM23t2niJwhpM/@phenom.ffwll.local> <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org> <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org> <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org> <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com> <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com> <d7aaf556-2f0c-f5b5-659f-f99496cede1e@amd.com>
In-Reply-To: <d7aaf556-2f0c-f5b5-659f-f99496cede1e@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 25 Mar 2021 10:41:43 +0100
Message-ID: <CAKMK7uHPwT2zuTywb7O2gVbPcb0wsh=VCWdQmgQd_NaJwTTpFA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:50 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.03.21 um 00:14 schrieb Jason Gunthorpe:
> > On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellstr=C3=B6m (Intel)=
 wrote:
> >> On 3/24/21 7:31 PM, Christian K=C3=B6nig wrote:
> >>>
> >>> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
> >>>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellstr=C3=B6m (Int=
el)
> >>>> wrote:
> >>>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
> >>>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellstr=C3=B6m
> >>>>>> (Intel) wrote:
> >>>>>>
> >>>>>>>> In an ideal world the creation/destruction of page
> >>>>>>>> table levels would
> >>>>>>>> by dynamic at this point, like THP.
> >>>>>>> Hmm, but I'm not sure what problem we're trying to solve
> >>>>>>> by changing the
> >>>>>>> interface in this way?
> >>>>>> We are trying to make a sensible driver API to deal with huge page=
s.
> >>>>>>> Currently if the core vm requests a huge pud, we give it
> >>>>>>> one, and if we
> >>>>>>> can't or don't want to (because of dirty-tracking, for
> >>>>>>> example, which is
> >>>>>>> always done on 4K page-level) we just return
> >>>>>>> VM_FAULT_FALLBACK, and the
> >>>>>>> fault is retried at a lower level.
> >>>>>> Well, my thought would be to move the pte related stuff into
> >>>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
> >>>>>>
> >>>>>> I don't know if the locking works out, but it feels cleaner that t=
he
> >>>>>> driver tells the vmf how big a page it can stuff in, not the vm
> >>>>>> telling the driver to stuff in a certain size page which it might =
not
> >>>>>> want to do.
> >>>>>>
> >>>>>> Some devices want to work on a in-between page size like 64k so th=
ey
> >>>>>> can't form 2M pages but they can stuff 64k of 4K pages in a batch =
on
> >>>>>> every fault.
> >>>>> Hmm, yes, but we would in that case be limited anyway to insert ran=
ges
> >>>>> smaller than and equal to the fault size to avoid extensive and
> >>>>> possibly
> >>>>> unnecessary checks for contigous memory.
> >>>> Why? The insert function is walking the page tables, it just updates
> >>>> things as they are. It learns the arragement for free while doing th=
e
> >>>> walk.
> >>>>
> >>>> The device has to always provide consistent data, if it overlaps int=
o
> >>>> pages that are already populated that is fine so long as it isn't
> >>>> changing their addresses.
> >>>>
> >>>>> And then if we can't support the full fault size, we'd need to
> >>>>> either presume a size and alignment of the next level or search for
> >>>>> contigous memory in both directions around the fault address,
> >>>>> perhaps unnecessarily as well.
> >>>> You don't really need to care about levels, the device should be
> >>>> faulting in the largest memory regions it can within its efficiency.
> >>>>
> >>>> If it works on 4M pages then it should be faulting 4M pages. The pag=
e
> >>>> size of the underlying CPU doesn't really matter much other than som=
e
> >>>> tuning to impact how the device's allocator works.
> >> Yes, but then we'd be adding a lot of complexity into this function th=
at is
> >> already provided by the current interface for DAX, for little or no ga=
in, at
> >> least in the drm/ttm setting. Please think of the following situation:=
 You
> >> get a fault, you do an extensive time-consuming scan of your VRAM buff=
er
> >> object into which the fault goes and determine you can fault 1GB. Now =
you
> >> hand it to vmf_insert_range() and because the user-space address is
> >> misaligned, or already partly populated because of a previous eviction=
, you
> >> can only fault single pages, and you end up faulting a full GB of sing=
le
> >> pages perhaps for a one-time small update.
> > Why would "you can only fault single pages" ever be true? If you have
> > 1GB of pages then the vmf_insert_range should allocate enough page
> > table entries to consume it, regardless of alignment.
>
> Completely agree with Jason. Filling in the CPU page tables is
> relatively cheap if you fill in a large continuous range.
>
> In other words filling in 1GiB of a linear range is *much* less overhead
> than filling in 1<<18 4KiB faults.
>
> I would say that this is always preferable even if the CPU only wants to
> update a single byte.
>
> > And why shouldn't DAX switch to this kind of interface anyhow? It is
> > basically exactly the same problem. The underlying filesystem block
> > size is *not* necessarily aligned to the CPU page table sizes and DAX
> > would benefit from better handling of this mismatch.
> >
> >> On top of this, unless we want to do the walk trying increasingly smal=
ler
> >> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() and =
teach
> >> it about transhuge page table entries, because pagewalk.c can't be use=
d (It
> >> can't populate page tables). That also means apply_to_page_range() nee=
ds to
> >> be complicated with page table locks since transhuge pages aren't stab=
le and
> >> can be zapped and refaulted under us while we do the walk.
> > I didn't say it would be simple :) But we also need to stop hacking
> > around the sides of all this huge page stuff and come up with sensible
> > APIs that drivers can actually implement correctly. Exposing drivers
> > to specific kinds of page levels really feels like the wrong level of
> > abstraction.
> >
> > Once we start doing this we should do it everywhere, the io_remap_pfn
> > stuff should be able to create huge special IO pages as well, for
> > instance.
>
> Oh, yes please!
>
> We easily have 16GiB of VRAM which is linear mapped into the kernel
> space for each GPU instance.
>
> Doing that with 1GiB mapping instead of 4KiB would be quite a win.

io_remap_pfn is for userspace mmaps. Kernel mappings should be as big
as possible already I think for everything.
-Daniel


> Regards,
> Christian.
>
> >
> >> On top of this, the user-space address allocator needs to know how lar=
ge gpu
> >> pages are aligned in buffer objects to have a reasonable chance of ali=
gning
> >> with CPU huge page boundaries which is a requirement to be able to ins=
ert a
> >> huge CPU page table entry, so the driver would basically need the drm =
helper
> >> that can do this alignment anyway.
> > Don't you have this problem anyhow?
> >
> > Jason
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
