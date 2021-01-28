Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB430707E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhA1H7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhA1HFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:35 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97368C061794
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:04:28 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id s83so147957vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+5dcejhRaQpDCwiyEVn753oCGrTihEzoxoKOU9kwWA=;
        b=ZRaEUkWxALHTVzsipCFQj35joZ7/P6/xdlQtefyyRmxLlAGo8gHta0a7fC8kj3x5r+
         GxclBFXoUJx51nRjfo+V34nIRM63VqC/CQshNpy3h2dCgg8646a+2U4jrEa/dypNRyfO
         ZzJFbe98NYDv4NAT5C9qLzoTHoB78A3YTmV/7UZbnOQjoHOPMZ63eCQc9UurepxD2ksp
         Qhi0d9fpObvKbsfnqNPTho1MZsOnUbK5865rJz/INF/EsZplNtp0r68tFpIzxJ3TRz1a
         IsJZaR/mrnNzbZgwxEb+QCC6k/kAWhsb4OndU91f+iluj6lJFf8tpaglkzhUZHz7qT7g
         GD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+5dcejhRaQpDCwiyEVn753oCGrTihEzoxoKOU9kwWA=;
        b=owBIO0YPvcKd7YT4APa/wQwQ+bObVvtakfCsu5thpO1CZk/ltMYrmYAPjYh3kD3F9x
         SV+/O+DmDosJbwBIWCKmfJZyawHmmbxfxyw67XtNjLghIPGx+AXYheAxmOMTDAQhU6ZR
         kxgmPYO2HXuu4VkXy56LxXwv1ukpJ1D6db5/vPiGarUGdUJClgpryl4LsNV1dfmxMBsE
         YEBbM14w9+OssYy8HWuq2XRq7brwWr8QrOe7wRfSmwE+9OCHOVGqV/XbJWSpghUv3lOS
         9P1bWSdnbewUfN+ldqZOtT8L7vD/2aTovBRZvL0YeatmJabyskCzK6mnOM6VkffgamW2
         KlmQ==
X-Gm-Message-State: AOAM53111xHoWXQq3/Pf/MdKJNZqPzykeHEyWKPG2RIZgUM+baJnGefF
        tZybkTZ9A1WmQ5I8KxB81FBsAPFaqATKGU1h4yjmBg==
X-Google-Smtp-Source: ABdhPJwSIFhyRLM20J+i0UEgD++xaYJdmbeJOtujr1vKiolKVw9/Eda+jgrZU0PTyDT5E6na4d2MivXZJp3MV5R/2I0=
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr10592240vsq.56.1611817467057;
 Wed, 27 Jan 2021 23:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20210123034655.102813-1-john.stultz@linaro.org>
 <20210123034655.102813-2-john.stultz@linaro.org> <CAE2F3rA3a-MWBHPZhGP9dMhEUqMkkvm6wXYYh6LDZ1zF9CAyUg@mail.gmail.com>
 <CALAqxLWkTQwQ8Xqnc+PAMWUO_C84jaGzOLqKFqkuk3=AFNHD6g@mail.gmail.com>
In-Reply-To: <CALAqxLWkTQwQ8Xqnc+PAMWUO_C84jaGzOLqKFqkuk3=AFNHD6g@mail.gmail.com>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Wed, 27 Jan 2021 23:04:15 -0800
Message-ID: <CAE2F3rAvg1-jtpsJdgzmBkZ5CDnGG4S0-oVxw74LY3O+N=0JZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma-buf: system_heap: Add pagepool support to
 system heap
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 9:10 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jan 27, 2021 at 12:21 PM Daniel Mentz <danielmentz@google.com> wrote:
> >
> > On Fri, Jan 22, 2021 at 7:47 PM John Stultz <john.stultz@linaro.org> wrote:
> > > +static int system_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
> > > +{
> > > +       void *addr = vmap(pages, num, VM_MAP, pgprot);
> > > +
> > > +       if (!addr)
> > > +               return -ENOMEM;
> > > +       memset(addr, 0, PAGE_SIZE * num);
> > > +       vunmap(addr);
> > > +       return 0;
> > > +}
> >
> > I thought that vmap/vunmap are expensive, and I am wondering if
> > there's a faster way that avoids vmap.
> >
> > How about lifting this code from lib/iov_iter.c
> > static void memzero_page(struct page *page, size_t offset, size_t len)
> > {
> >         char *addr = kmap_atomic(page);
> >         memset(addr + offset, 0, len);
> >         kunmap_atomic(addr);
> > }
> >
> > Or what about lifting that code from the old ion_cma_heap.c
> >
> > if (PageHighMem(pages)) {
> >         unsigned long nr_clear_pages = nr_pages;
> >         struct page *page = pages;
> >
> >         while (nr_clear_pages > 0) {
> >                 void *vaddr = kmap_atomic(page);
> >
> >                 memset(vaddr, 0, PAGE_SIZE);
> >                 kunmap_atomic(vaddr);
> >                 page++;
> >                 nr_clear_pages--;
> >         }
> > } else {
> >         memset(page_address(pages), 0, size);
> > }
>
> Though, this last memset only works since CMA is contiguous, so it
> probably needs to always do the kmap_atomic for each page, right?

Yeah, but with the system heap page pool, some of these pages might be
64KB or 1MB large. kmap_atomic(page) just maps to page_address(page)
in most cases. I think iterating over all pages individually in this
manner might still be faster than using vmap.

>
> I'm still a little worried if this is right, as the current
> implementation with the vmap comes from the old ion_heap_sglist_zero
> logic, which similarly tries to batch the vmaps  32 pages at at time,
> but I'll give it a try.
