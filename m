Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5373AC26C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhFREqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhFREqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:46:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:44:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u24so6717970edy.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xClIV3g2rAFuoyZHyCnYEVOzgSyn0J/b3rPgod6lQRo=;
        b=IysTrToP+mR4ZL3tTCrr87Yg6G1IcGhuMnYEyffxAEn8bzy3GdmpYfYIJkqF8PHMgb
         u0ISALkuGhVi0o1uZg1zyw72CX83FQ3ECFQLnGPzuz7YSmcogSZRpf1dTmtrB7dJsEzM
         BjrOup6I0s9ICwQ8TCbuwdbwrh5NA/ongy16w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xClIV3g2rAFuoyZHyCnYEVOzgSyn0J/b3rPgod6lQRo=;
        b=E4BJCfbBVle6H9dreD8BONbvMHqEiUm80Ae5vcCQ75+C6MjqLoLmLbW52xeXhUR/ZT
         isgaOZpzMB1qlYEl1NjYZpc28c4mH0VCgjDpZcWWi7/FW9WBzy74K439mkjZl1qyhnVH
         Ced0m9lGWLZ265Vwuj9CG3aQifsuq2/1YzwhweWc3HZ+KKxg2ILaUhle8VLLSeoGYHPw
         MlBFtGqdFX0IZAYo9doyo0O6KZHCzKNynSE9rJbbiVUSZSOSXACotCxNB31jrRUuMttp
         1qKIUOVoNomjiZbGuejdcHh3XDGagWb/s/ZlQLjbSUrBxXkSCVedHpbQWN6Rjd3yrkGj
         BgzQ==
X-Gm-Message-State: AOAM5318EeIvSN85BPZYdn9wtm9xTa64QzBTpWMij7vAPk2KFlQC/PDf
        flal3UIWP/ycyafutwmXRMk/b7KqfVimrA==
X-Google-Smtp-Source: ABdhPJz1ytgym09BUz2Ti3Kp0hm1FY7znA+hhw726UBFqCL5gOyyV7PX0MMHJ0tc3lN6s1wp/pLDJA==
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr2298457edd.263.1623991462086;
        Thu, 17 Jun 2021 21:44:22 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m11sm512899ejl.102.2021.06.17.21.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 21:44:21 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id f2so9139480wri.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:44:20 -0700 (PDT)
X-Received: by 2002:adf:e804:: with SMTP id o4mr8875519wrm.103.1623991460457;
 Thu, 17 Jun 2021 21:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210427131344.139443-1-senozhatsky@chromium.org>
 <20210427131344.139443-9-senozhatsky@chromium.org> <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
 <YMsAIVs7G2hUDR2F@google.com> <20210617080107.GA1422@lst.de>
 <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
 <20210617085233.GA4702@lst.de> <CAAFQd5DqK2gSTGjfo-vahXwMzzO9gv26cY=vV6urn3viDLPE7g@mail.gmail.com>
 <20210617100656.GA11107@lst.de> <CAAFQd5CgLDkJ3t1aU2PRcGu6cGFjLXOnvMqDg62Z7Zuc8ABVHg@mail.gmail.com>
 <20210618042526.GA17794@lst.de>
In-Reply-To: <20210618042526.GA17794@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 18 Jun 2021 13:44:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bt9TJ87Yk5ZpqTqrX9rmP0Uq8VNwx_rwFHakWP850Axw@mail.gmail.com>
Message-ID: <CAAFQd5Bt9TJ87Yk5ZpqTqrX9rmP0Uq8VNwx_rwFHakWP850Axw@mail.gmail.com>
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 1:25 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 18, 2021 at 12:21:33PM +0900, Tomasz Figa wrote:
> > > On Thu, Jun 17, 2021 at 06:40:58PM +0900, Tomasz Figa wrote:
> > > > Sorry, I meant dma_alloc_attrs() and yes, it's indeed a misnomer. Our
> > > > use case basically has no need for the additional coherent mapping, so
> > > > creation of it can be skipped to save some vmalloc space. (Yes, it
> > > > probably only matters for 32-bit architectures.)
> > >
> > > Yes, that is the normal use case, and it is solved by using
> > > dma_alloc_noncoherent or dma_alloc_noncontigous without the vmap
> > > step.
> >
> > True, silly me. Probably not enough coffee at the time I was looking at it.
> >
> > With that, wouldn't it be possible to completely get rid of
> > dma_alloc_{coherent,attrs}() and use dma_alloc_noncontiguous() +
> > optional kernel and/or userspace mapping helper everywhere? (Possibly
> > renaming it to something as simple as dma_alloc().
>
> Well, dma_alloc_coherent users want a non-cached mapping.  And while
> some architectures provide that using a vmap with "uncached" bits in the
> PTE to provide that, this:
>
>  a) is not possibly everywhere
>  b) even where possible is not always the best idea as it creates mappings
>     with differnet cachability bets

I think this could be addressed by having a dma_vmap() helper that
does the right thing, whether it's vmap() or dma_common_pages_remap()
as appropriate. Or would be this still insufficient for some
architectures?

>
> And even without that dma_alloc_noncoherent causes less overhead than
> dma_alloc_noncontigious if you only need a single contiguous range.
>

Given that behind the scenes dma_alloc_noncontiguous() would also just
call __dma_alloc_pages() for devices that need contiguous pages, would
the overhead be basically the creation of a single-entry sgtable?

> So while I'm happy we have something useful for more complex drivers like
> v4l I think the simple dma_alloc_coherent API, including some of the less
> crazy flags for dma_alloc_attrs is the right thing to use for more than
> 90% of the use cases.

One thing to take into account here is that many drivers use the
existing "simple" way, just because there wasn't a viable alternative
to do something better. Agreed, though, that we shouldn't optimize for
the rare cases.

Best regards,
Tomasz
