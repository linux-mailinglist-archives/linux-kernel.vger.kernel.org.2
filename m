Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFDD3068CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhA1Asx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhA1Asm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:48:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDB3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:48:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u7so3845413iol.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqhWuPJQWzxcYd51zOTBBe32ajnLh+ur9OS99sopons=;
        b=sFkN5dQvyK6yJYdEfBoJcRZzCVAr1MiZyViMHcaSUMRI6ow86O+L29R7KPwHQsi2QP
         St9izOKpm8nyZmLbh2W2ea1B2vNK0DmE7nmJPs6S9M3NxO4bA8U7IRoMws82A9IA+Xha
         J34F7FUNPaB3Xt0IFfCPc/JEsEm6j9C3wE6Uw3L8u6BZ4DVpGiOBSbRqLvQvYA5cRc+C
         Ce3O4auwngGU6jEJttPduHN9mvIb3fxpd+xfD+e59kb22sw2hvD/mQHEEjCVsI/jz4vQ
         4TnUucD4F/aBygGXgRMtKTPgBlSzya+Z/Wtp7x46ajWBm9twUjFNx13HFV6WiRNxFojL
         vyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqhWuPJQWzxcYd51zOTBBe32ajnLh+ur9OS99sopons=;
        b=kXhnw0GyCVH/LeDrB4xsF+68sxNZs3uxONgaw5q8f0d6wUuggpozXotCw3tAfnArps
         YK2EngX6rmKyfK9N+VgLOS0t5A7qkUrZmQqAkmkXNScMXOKU+apxkdVJNRnw3MXzUGwl
         Bbnl1WauhSYnNOalc83hljfq/2jWr+sWya/rNHZ6Fpftl+GFbBmFspXzNJIUsLPhjbAc
         7SSsm+BWu9FCXgj5ser5aqc/p1MzdIEp+XN1kpe28CRNV2c07ll5nYiRN2kUQrftp5Qh
         URyQq7LY8dTLRu8okQiijnZ2LJgBAcT09R4Ab/fpeXi5pj2XpgGw6+Wtcb1RNdvO/cTT
         3Ctw==
X-Gm-Message-State: AOAM530CnWVov6c+eo3wmKBE23q0tiW08x0yCrCHWIXe4yzc3aDr4KOt
        2AqchwvNdYBLpRQBaqbCt085PqrurnHXno2U1q8=
X-Google-Smtp-Source: ABdhPJxtZMc3G20lQKXkp9oNrQpfNPo285rwLEOWBEkrxL+XMTBOnCDrMr4P98gwhooUW9UVrxJMwd1qCarEDkLVq1Y=
X-Received: by 2002:a05:6602:122b:: with SMTP id z11mr9458563iot.210.1611794881571;
 Wed, 27 Jan 2021 16:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-4-paul.gortmaker@windriver.com> <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
 <20210127080206.GE23530@windriver.com>
In-Reply-To: <20210127080206.GE23530@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 27 Jan 2021 16:47:50 -0800
Message-ID: <CAAH8bW-tWRJ4m3pP37YBVrferOa9CwMZGdZkSDC+GXvBfC=Uhw@mail.gmail.com>
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:02 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> [Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct] On 26/01/2021 (Tue 23:16) Andy Shevchenko wrote:
>
> > On Tue, Jan 26, 2021 at 12:11:36PM -0500, Paul Gortmaker wrote:
> > > This will reduce parameter passing and enable using nbits as part
> > > of future dynamic region parameter parsing.
> >
> > One nit below, nevertheless
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > ---
> > >  lib/bitmap.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > > index 75006c4036e9..162e2850c622 100644
> > > --- a/lib/bitmap.c
> > > +++ b/lib/bitmap.c
> > > @@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
> > >
> > >  /*
> > >   * Region 9-38:4/10 describes the following bitmap structure:
> > > - * 0          9  12    18                  38
> > > - * .........****......****......****......
> > > - *     ^  ^     ^                   ^
> > > - *      start  off   group_len            end
> > > + * 0          9  12    18                  38           N
> > > + * .........****......****......****..................
> > > + *     ^  ^     ^                   ^           ^
> > > + *      start  off   group_len            end       nbits
> > >   */
> > >  struct region {
> > >     unsigned int start;
> > >     unsigned int off;
> > >     unsigned int group_len;
> > >     unsigned int end;
> > > +   unsigned int nbits;
> > >  };
> > >
> > > -static int bitmap_set_region(const struct region *r,
> > > -                           unsigned long *bitmap, int nbits)
> > > +static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
> > >  {
> > >     unsigned int start;
> > >
> > > -   if (r->end >= nbits)
> > > +   if (r->end >= r->nbits)
> > >             return -ERANGE;
> > >
> > >     for (start = r->start; start <= r->end; start += r->group_len)
> > > @@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> > >     struct region r;
> > >     long ret;
> > >
> > > -   bitmap_zero(maskp, nmaskbits);
> > > +   r.nbits = nmaskbits;
> >
> > > +   bitmap_zero(maskp, r.nbits);
> >
> > This sounds not right from style perspective.
> > You have completely uninitialized r on stack, then you assign only one value
> > for immediate use here and...
>
> So, this change was added because Yury suggested that I "..store
> nmaskbits in the struct region, and avoid passing nmaskbits as a
> parameter."
>
> To which I originally noted "I considered that and went with the param
> so as to not open the door to someone possibly using an uninitialized
> struct value later."

struct region is purely internal structure. It's declared on stack and filled
field-by-field using helpers. 'Someone' misusing the structure doesn't exist
because the structure doesn't exist out of the scope.

> https://lore.kernel.org/lkml/20210122044357.GS16838@windriver.com/
>
> Looking back, I had a similar thought as to yours, it seems...
>
> I am also thinking more and more that nbits doesn't belong in the
> region anyway - yes, a region gets validated against a specific nbits
> eventually, but it doesn't need an nbits field to be a complete
> specification.  The region "0-3" is a complete specification for "the
> 1st four cores" and is as valid on a 4 core machine as it is on a 64 core
> machine -- a validation we do when we deploy the region on that machine.
>
> I will set this change aside and get the nbits value to getnum() another
> way, and leave the region struct as it was -- without a nbits field.
>
> This will also resolve having the macro handling of region that you were
> not really liking.
>
> Paul.

Region is a convenient structure. Adding nbits into it helps to remove
validation
logic from bitmap_set_region(), so it's worth doing this.

Can you please have it unchanged?

Thanks,
Yury
