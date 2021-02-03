Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481130D121
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBCB4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhBCB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:56:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82985C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:56:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so3839143wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 17:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqb0FQEG710LFOVTd7yEl7tin1eRbeirJikh0ogVzXs=;
        b=r4yYUo1RncgQIJ2OFCrbLrZmrY2T3kRRqBaZl+AROnou29V143R2jumKvvg19DLqCo
         F2V2aPSyfbh5iMz1kj+xBVJV5f3HQGt+xLXfaqUjvnBhUO3hfL/56qlxZDAIdOsWeEHT
         hgLIVPKdps71ba9B4KnrfwhUrjd8IWTghGyuq5RgmBTA4yN6F/I1hI7BqhdUhBiri6p5
         ti5ok3BitGiRKghlbB49tORC5hYAZPVoOOMlJELLKjTmtecV3vwGP9LPTSn9fwZ9iS2Z
         UEGUrjUGisH5nTtUYi/e4DuidkIQ991KCpyjJd8/CkA6Vn08ScJOtArwZ6K7oU0ZTpcH
         gASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqb0FQEG710LFOVTd7yEl7tin1eRbeirJikh0ogVzXs=;
        b=bzZdpAxT6YekA7ILNOpCa/SssOPqPDWf4k/grzgk5/+QiBgspj6sUafEcFfjZQC8kt
         8IXjBEpqPQMW2TnvfZVSzvwNdRVjNLuepIsGc02m1wvwKT5pxInc4d4FxdN7qed8nm7s
         L2Ej/Vrsuv3XD9kNpKujisE3ZosCa+6BlG811HXIpvUboW99JJdX9dOAqGPXj6EhsfET
         Hk8i5B63O3S2FMl9hBXJq+0kxSJeTvviK1baNKnOy3lPuWGlC6WmiFzigHJ7lcRXCDhx
         JFLYwZ5LwfgN8uDgsl+uYzz2w/ScaA7bojdp1Yn4CwcKrhyTowujom5TznEgodnzs1Hs
         4/ng==
X-Gm-Message-State: AOAM533GdeFmBRE1KQFoiny96iA5Y+daWSEEmyxuUviCLwRNwcVu8Wmo
        z/1IjsVyl6t8HApmBj+0gDGGGaFF54mIthjwd/IXGg==
X-Google-Smtp-Source: ABdhPJy8V/ouw2lofMtSb/Jdw++5KWj9ruCBYLUqtDkkx9ZA4byJWPoR5Az0VDn+L4rTDLhOT5LbVZqAi5I9Yc52fww=
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr665311wme.22.1612317361941;
 Tue, 02 Feb 2021 17:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20210203003134.2422308-1-surenb@google.com> <YBn81xAeCqHgudYb@google.com>
In-Reply-To: <YBn81xAeCqHgudYb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 Feb 2021 17:55:50 -0800
Message-ID: <CAJuCfpEirOiisM-xouZB7JRBDpERdvWb2gfaq003+rs0b4M83Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: replace BUG_ON in vm_insert_page with a return of
 an error
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>, labbott@redhat.com,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Jones <jajones@nvidia.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-media <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:31 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Feb 02, 2021 at 04:31:33PM -0800, Suren Baghdasaryan wrote:
> > Replace BUG_ON(vma->vm_flags & VM_PFNMAP) in vm_insert_page with
> > WARN_ON_ONCE and returning an error. This is to ensure users of the
> > vm_insert_page that set VM_PFNMAP are notified of the wrong flag usage
> > and get an indication of an error without panicing the kernel.
> > This will help identifying drivers that need to clear VM_PFNMAP before
> > using dmabuf system heap which is moving to use vm_insert_page.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/memory.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index feff48e1465a..e503c9801cd9 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1827,7 +1827,8 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >               return -EINVAL;
> >       if (!(vma->vm_flags & VM_MIXEDMAP)) {
> >               BUG_ON(mmap_read_trylock(vma->vm_mm));
>
> Better to replace above BUG_ON with WARN_ON_ONCE, too?

If nobody objects I'll do that in the next respin. Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
