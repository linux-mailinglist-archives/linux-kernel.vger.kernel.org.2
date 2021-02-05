Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB33103C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBEDkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBEDkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:40:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2512C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:39:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j11so4836476wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EdjLgTFEfuQJGZBK+nXnyy4MdoUmVzeK7aTpj4p2cVs=;
        b=G0PEitJ+usd81lX6EDaRByi5sRj40yJPc5uhcY6QEK2X9Wq/MFm/0TXDN4RVz4ZQ6A
         ul/qH0mY8Lsr3XrIXuQOWFAtdI0BS6f2CpejnwFRIr29LWuWTbar+iE+BI3jzBNT/8pz
         bN4/D1zo8nWzktWb4bINMtYivhqcbzqgdnInQZ/8/0sEewECFyCYy640waGWJY0G1pqw
         Cm3UCGiNdKrJ6Z6enQVnga+JRIGdwAuAA2hDqGOY/AMehsv5k1ZgBGklnwlaTS/3abdO
         m/3btPqZdflTc78uLwP6rbg6URCpuKVpD+NEZtDZBBCapZrQXXYqV4CSKeCEy6/4DkV2
         uZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EdjLgTFEfuQJGZBK+nXnyy4MdoUmVzeK7aTpj4p2cVs=;
        b=b5NqiSL2Yxs7SY4KXQpWDSD9bdEQtEok/4PwJFp3eeKVgvmGqhYfCkUuW+D2RP4ulh
         n5FysMS2/oPTbkaA/S5j9oB7m4BFcNiNSlrCdfTr5hdKd6J4xPwc+30kD/Jpxk9lxW3g
         15WiH40X9SSEF/mIXRoqIpCALQFhWSesveX6Th8AjCHZMMeLFCYkxn62MxesLreSxsfu
         QDRRFOXpQoxev7MVhdlIFUWY4kACCwbi6bBF4H4WEXt1vj4Od6VLlqll+cn6uJgkmaE3
         Tr8k2F5zEa8scrMBdyzDCq1dcllvNxq7RGE16/lN6fq2yK3bA/XDwY5eKGBeARFMI40y
         jTpw==
X-Gm-Message-State: AOAM532EanPcD7ekKtzt/WZfjdvGVMEVuMUOy6USvptkUptx2LNHFRcV
        LrgmeMxmV61WJfWhKz+/FijTu8rSnPS6OUReIbtkdQ==
X-Google-Smtp-Source: ABdhPJwQJDGTRMEZ//zE5/HAppxy72r/wRamcStzdUixQgW9nAir2xq28+kgXZDBfrH14dhfKQY0nMy71MkA5Gx9FJg=
X-Received: by 2002:a05:600c:4fcb:: with SMTP id o11mr1704797wmq.88.1612496371382;
 Thu, 04 Feb 2021 19:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20210203003134.2422308-1-surenb@google.com> <20210203015553.GX308988@casper.infradead.org>
 <CAKMK7uHnNdjOYX5Rhj=uGMz7hSz12JhgkZJCfiqgkpjXnMfL4A@mail.gmail.com>
 <CAJuCfpG4GkVbeW=bB+Qrm5GPrZAwg0_rmyG05iwQmL7GrWAYHw@mail.gmail.com>
 <CAKMK7uHi+mG0z0HUmNt13QCCvutuRVjpcR0NjRL12k-WbWzkRg@mail.gmail.com>
 <CAKMK7uETu_m+=MHyPmqBbEP__qjMF_wmr4c2BiVTPcwE8c+5Mg@mail.gmail.com>
 <CAJuCfpHC6P5cJh-1hv=vjGHCCkM6mA_p19H6tCZmCDxhTuASkQ@mail.gmail.com>
 <ced1c1be-e731-946e-e9ce-919520fe935a@amd.com> <CADnq5_Oi_To=9rpet=Q73FY2_-abV47XtXYVVz5TBnRyzwffng@mail.gmail.com>
In-Reply-To: <CADnq5_Oi_To=9rpet=Q73FY2_-abV47XtXYVVz5TBnRyzwffng@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Feb 2021 19:39:20 -0800
Message-ID: <CAJuCfpFjW-QcbZbspOCJ-pLFv01htN3Vp5hkvbkBJxonnV8_Hw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] mm: replace BUG_ON in vm_insert_page
 with a return of an error
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christoph Hellwig <hch@infradead.org>,
        Sandeep Patil <sspatil@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        Robin Murphy <robin.murphy@arm.com>,
        James Jones <jajones@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Minchan Kim <minchan@kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 7:55 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 4, 2021 at 3:16 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> > Am 03.02.21 um 22:41 schrieb Suren Baghdasaryan:
> > > [SNIP]
> > >>> How many semi-unrelated buffer accounting schemes does google come =
up with?
> > >>>
> > >>> We're at three with this one.
> > >>>
> > >>> And also we _cannot_ required that all dma-bufs are backed by struc=
t
> > >>> page, so requiring struct page to make this work is a no-go.
> > >>>
> > >>> Second, we do not want to all get_user_pages and friends to work on
> > >>> dma-buf, it causes all kinds of pain. Yes on SoC where dma-buf are
> > >>> exclusively in system memory you can maybe get away with this, but
> > >>> dma-buf is supposed to work in more places than just Android SoCs.
> > >> I just realized that vm_inser_page doesn't even work for CMA, it wou=
ld
> > >> upset get_user_pages pretty badly - you're trying to pin a page in
> > >> ZONE_MOVEABLE but you can't move it because it's rather special.
> > >> VM_SPECIAL is exactly meant to catch this stuff.
> > > Thanks for the input, Daniel! Let me think about the cases you pointe=
d out.
> > >
> > > IMHO, the issue with PSS is the difficulty of calculating this metric
> > > without struct page usage. I don't think that problem becomes easier
> > > if we use cgroups or any other API. I wanted to enable existing PSS
> > > calculation mechanisms for the dmabufs known to be backed by struct
> > > pages (since we know how the heap allocated that memory), but sounds
> > > like this would lead to problems that I did not consider.
> >
> > Yeah, using struct page indeed won't work. We discussed that multiple
> > times now and Daniel even has a patch to mangle the struct page pointer=
s
> > inside the sg_table object to prevent abuse in that direction.
> >
> > On the other hand I totally agree that we need to do something on this
> > side which goes beyong what cgroups provide.
> >
> > A few years ago I came up with patches to improve the OOM killer to
> > include resources bound to the processes through file descriptors. I
> > unfortunately can't find them of hand any more and I'm currently to bus=
y
> > to dig them up.
>
> https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.ht=
ml
> I think there was a more recent discussion, but I can't seem to find it.

Thanks for the pointer!
Appreciate the time everyone took to explain the issues.
Thanks,
Suren.

>
> Alex
>
> >
> > In general I think we need to make it possible that both the in kernel
> > OOM killer as well as userspace processes and handlers have access to
> > that kind of data.
> >
> > The fdinfo approach as suggested in the other thread sounds like the
> > easiest solution to me.
> >
> > Regards,
> > Christian.
> >
> > > Thanks,
> > > Suren.
> > >
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
