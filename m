Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6B3D8816
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhG1Gja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhG1Gj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:39:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:39:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e21so1487150pla.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=y2w6EBV4fG3BDfOK0nFJk2tiKaooNFoqR03RG+cqxs0=;
        b=lhZtvPeU9FiQMkOHK38uw8Rmt1/wmBFbQbG8uE/CUEvlZlGnQO02m+npfWbiLgeeCi
         gcD14MR9fFyBRFDbhrNuez1dDkiRaI3hlQ0s3r8ixgGWituLsVGtjoR9bAYLdGWaZ6eR
         biLRKSocXPMjERKG5S1HWs+rXx8/mxaV1n12/IUlqqjzyc1w/az96+pqG0V9mAVnL2G4
         p8LYeRbzQUH2rYmJB495Bwx8mirM4m0IKpH4twNWrCq5270Z3s/8TkDPTabFUmnLFkQ1
         6YgHuptqk6oz44ub293XbKf3wD1teHaZelhBON98UsY+xLxqgrBkHIsbZvaIsCXjKL/m
         FaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=y2w6EBV4fG3BDfOK0nFJk2tiKaooNFoqR03RG+cqxs0=;
        b=nlNGFEZoAbYVOjfqIVdPtCFSr30Ap4+y3X9UUF7mTOmbyi+6Bvwqb0g6SurspRxT7C
         1AOZv/OCm2ggozwhKW7Mhcmq6DOs5ROaJXyF6Wjt6lAPDQy0eqtJbe8PI8N1MPB/bFth
         ITVd6VAJNddfFSel15zFqh3knPTSz+1WaOQjrWMMVscUqNf5GWUbDbbWya9HjEkv5UW8
         N9qn3pJ+nqmcHohwSyi3aG/EGEPSJd60RW8A5XG9IzyqfZyH23GW9c/x6+XyqkTSngA1
         kczYw0x9JGPWhmkzwMeFPBam9P8TUMQ4pL+3U3ib7h4bUEaYXzcDzouC0wge0Tm437v8
         Wm1g==
X-Gm-Message-State: AOAM5326Kh3J7B25iZqoCd4rD77HYygN9dEiQ8r4bDUabWIX7FVL9Nhf
        oV7Mkm248sN2AHWJ9E0rljZK1BcD/3togHpnCTU=
X-Google-Smtp-Source: ABdhPJx8ttlWKJQBaIfuzVZnxDDOCda0py9IAvmInvgGnaKdLblsVs53yRT9EKCKorZhF1PR2gSTu9LvUNZDB1XXuJ8=
X-Received: by 2002:a17:902:c115:b029:12c:50d1:ebde with SMTP id
 21-20020a170902c115b029012c50d1ebdemr3971813pli.67.1627454366632; Tue, 27 Jul
 2021 23:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210727094441.9815-1-andrea.merello@gmail.com>
 <YP/ymvrd1zV7z6rF@smile.fi.intel.com> <YQAlmBEGIaChYgeW@yury-ThinkPad>
In-Reply-To: <YQAlmBEGIaChYgeW@yury-ThinkPad>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 28 Jul 2021 08:39:15 +0200
Message-ID: <CAN8YU5PD9i=qztMLyuFsMQFf80pz04dLOSQ0NJ9=uHb1bTh52w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bitmap.h: add const modifier to
 bitmap_next_[set/clear]_region() argument
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mar 27 lug 2021 alle ore 17:26 Yury Norov
<yury.norov@gmail.com> ha scritto:
>
> On Tue, Jul 27, 2021 at 02:48:42PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 27, 2021 at 11:44:41AM +0200, Andrea Merello wrote:
> > > Those two functions don't modify the bitmap, so their bitmap argument
> > > should be const. This patch add this.
>
> Thanks Andrea.
>
> Acked-by: Yury Norov <yury.norov@gmail.com>
>
> > Constification is always a good thing. No objections from me,
> > although Yuri is doing something with them in one of his patch series.
>
> I try to remove those two because in practice they bring more mess
> than good. All real use-cases for bitmap_next_{set,clear}_region
> relate to iterating the whole bitmap, ie nobody just wants to find a
> next region. Untill recently there was only a single user of the API,
> so I easily reworked the code to use find_first_bit/find_next bit and
> by chance return faster.

Ah, that's interesting to know: I'm working on a new driver that used
find_next_zero_bit() and find_next_bit() [0]; Andy told me that my
algorithm could be rewritten exploiting some bitmap_* helpers, so I
rewrote my code using bitmap_for_each_set_region(), which in turn uses
bitmap_next_set_region().

Should I revert to my previous implementation that uses
find_next_zero_bit() and find_next_bit() ?

[0] https://lore.kernel.org/linux-iio/20210715141742.15072-3-andrea.merello@gmail.com/

> https://github.com/norov/linux/commit/1c870b5c3fcd2eea9b351a1e0af8d1e93be78e1e
>
> Recently in next-20210716, there appeared another user in fs/btrfs/extent_io.c:
> find_next_dirty_byte(). The fun is that in that case the length of bitmap
> is 16 bit, so it's probably simpler to return the bitmap by value,
> instead of calling prologue code up to 8 times. Anyways, I'll contact
> authors of the find_next_dirty_byte() and ask if it's possible to rework
> their code.
>
> > Yuri, do you have a public repo / branch that people can base their changes to
> > bitmap stuff against of?
>
> I collected not yet upstreamed bitmap patches here:
>
> https://github.com/norov/linux/commits/bitmap-20210716

Looks like also bitmap_for_each_set_region() went away indeed ?

> Please let me know if you believe we need a more official branch for
> bitmaps. I'd encourage people to review what we already have and
> upstream it.
>
> Thanks,
> Yury
>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > > ---
> > >  include/linux/bitmap.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > > index a36cfcec4e77..ea4a8f1a2545 100644
> > > --- a/include/linux/bitmap.h
> > > +++ b/include/linux/bitmap.h
> > > @@ -458,7 +458,7 @@ static inline void bitmap_replace(unsigned long *dst,
> > >             __bitmap_replace(dst, old, new, mask, nbits);
> > >  }
> > >
> > > -static inline void bitmap_next_clear_region(unsigned long *bitmap,
> > > +static inline void bitmap_next_clear_region(const unsigned long *bitmap,
> > >                                         unsigned int *rs, unsigned int *re,
> > >                                         unsigned int end)
> > >  {
> > > @@ -466,7 +466,7 @@ static inline void bitmap_next_clear_region(unsigned long *bitmap,
> > >     *re = find_next_bit(bitmap, end, *rs + 1);
> > >  }
> > >
> > > -static inline void bitmap_next_set_region(unsigned long *bitmap,
> > > +static inline void bitmap_next_set_region(const unsigned long *bitmap,
> > >                                       unsigned int *rs, unsigned int *re,
> > >                                       unsigned int end)
> > >  {
> > > --
> > > 2.17.1
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
