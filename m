Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9B37F454
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhEMIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhEMIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:47:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:46:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so23033702otp.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ7+l3rExZBaA7bKHIfKIm7ib+Q7MPRwk+IxJLrlxRI=;
        b=NVpeqkHCo7sdSPaJsGy55+xo6UtH7Oz5wOh9TFFPGF3bdF3P7GiRbOZwntYrFCQaf2
         GRAO4IyYs4J2sitduGBT8U2FznF6Ens0SJs5Xwa9lVpceHUUql/sQH0xd4EVOW3jhA6r
         RPPYKufWZBjpYzlHulyt2DuV5K5An/Y5b8KusPfxembUl3JDvHcvGP/jZjNPGFXwVcSp
         NYPa810kNbKRRGqBDt3f76ThiwcwPralaFa86t3N3GodWvhrLvo1qyW6CNvinHcHg4Jm
         Zo00+v+R6w1D9d5NrS6hKSHgmb2n3poR+lcvsDQBUciX2O8dXCSajTyz4dxxZlxSaSDf
         tRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ7+l3rExZBaA7bKHIfKIm7ib+Q7MPRwk+IxJLrlxRI=;
        b=b1z4Ys27KCrEQ6qwlJ3H/LGMoT1K1mIe+7gNa/fHPZTZWYYBWfnENaWV5NnewfGoT5
         8JXqsRut2f1rBY/GfPlOxJMoPGiqrM0tuLcyrObgUjAfUXhxZgohLqWJvdV3PcnD4fi6
         IqC84+DvaqHsrHM78P+ow55ImceL5qbcmphmQdV3lnJGmP/r8lM2kPHmfNjTs21ihYnb
         Rja3nenV39vKDN0mLzloHcdwMeFy5sCMtW6aO02yFiVtXGoTV0lD+R7RrIEjwbsS4Pki
         SmkUqvB1rOolssXsyKA+gcvVD6ZBfY2rPQ/OtIKiT3kPVZlT9KhOLXWajLJ/gPHoT39W
         GMTw==
X-Gm-Message-State: AOAM533cPpvziEE1IFjVzw/WDeqfDKqx4ns6XrFbiLKSTTcbzKKyjoV3
        /4OO4fWRkosV7OIRzSzx6abfnV6O3WXg3JnlbNjxCg==
X-Google-Smtp-Source: ABdhPJwlLnaMBd7WNopJUrcQQPRR0y7LTeUIzmkBIyfK5vz7zDyBOdwFUcAJ4gPPevmqcspKsAeu/hwbH7kZ4XmVOeM=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr35506426otn.233.1620895574247;
 Thu, 13 May 2021 01:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210511173448.GA54466@hyeyoo> <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo> <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
In-Reply-To: <20210513062809.GA319973@hyeyoo>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 May 2021 10:46:03 +0200
Message-ID: <CANpmjNPYtWsYv5tcH4wGrTBQx4vU4+LvjX9fG=nC9icDjJXy5g@mail.gmail.com>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index()
 to compile-time
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 08:28, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> On Wed, May 12, 2021 at 08:40:24PM -0700, Andrew Morton wrote:
> > On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > > On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
> > > > This explodes in mysterious ways.  The patch as I have it is appended,
> > > > for reference.
> > > >
> > > > gcc-10.3.0 allmodconfig.
> > > >
> > > > This patch suppresses the error:
> >
> > Ah, yes, of course, your patch changes kmalloc_index() to require that
> > it always is called with a constant `size'.  kfence_test doesn't do
> > that.
> >
> > kfence is being a bit naughty here - the other kmalloc_index() callers
> > only comple up the call after verifying that `size' is a compile-time
> > constant.
> >
> > Would something like this work?
> >  include/linux/slab.h    |   12 ++++++++----
> >  mm/kfence/kfence_test.c |    4 ++--
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> >
> > --- a/include/linux/slab.h~b
> > +++ a/include/linux/slab.h
> > @@ -374,7 +374,8 @@ static __always_inline enum kmalloc_cach
> >   * Note: there's no need to optimize kmalloc_index because it's evaluated
> >   * in compile-time.
> >   */
> > -static __always_inline unsigned int kmalloc_index(size_t size)
> > +static __always_inline unsigned int kmalloc_index(size_t size,
> > +                                               bool size_is_constant)
> >  {
> >       if (!size)
> >               return 0;
> > @@ -410,7 +411,10 @@ static __always_inline unsigned int kmal
> >       if (size <=  16 * 1024 * 1024) return 24;
> >       if (size <=  32 * 1024 * 1024) return 25;
> >
> > -     BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> > +     if (size_is_constant)
> > +             BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> > +     else
> > +             BUG();
>
>
> kfence is randomly generating size. because kfence is using non-constant
> size, we should do run-time assertion or compile-time assertion depending
> on situation.
>
> I think we can use __builtin_constant_p here. we don't need to modify
> kmalloc_index's prototype.
>
> so what about this?
> if you think it makes sense, I'll send patch v4.
>
> I used KMALLOC_MAX_CACHE_SIZE to assure it's safe size.
> it's safer than putting BUILD_BUG_ON_MSG(1, ...) to below if statements
> because KMALLOC_MAX_CACHE_SIZE can be less than 32MB.

I'm actually inclined to say that Andrew's patch with
'size_is_constant' is the better option, because we want to be
explicit about where it's using constant size and where it isn't. I
think in tests like kfence_test, it should be permitted to use
non-constant size, it's a test after all and performance is no
concern. For non-test code, however, we want to ensure size is
constant, and therefore having the distinguishing argument makes
sense. That way non-test code will not compile if our intent does not
match reality.

Thanks,
-- Marco
