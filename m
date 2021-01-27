Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8A305059
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhA0ECO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhA0DAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:00:37 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48265C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:58:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y19so450684iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=traqaTrIhXYiC2RHUp0xIGU3PGSCNk68NWm3RfowTXE=;
        b=qOgY8SA+JE+9SXXmRulFMCreP+sFqUB7QBj4pkk+r2Oquj07PLcnimwOOhbMBnbAIX
         NwOswNPTNEXpmd7fAb4pA9WIjvjlUMiwJE9ePF7Wxd28ib8X9AR5TLycVwNZJjmsPDTe
         5bofCnqOfRjq8mlo7z8FLrh0apnUA+fQ8pZ2VMwfQBwm055ycbFrN9DMrFgqsWCeE++2
         itzc6r+xCbt48wI18OVCHYVt3mX8PPeGdA6+jn8rNPLJnXh8ifYuPAW5sMMQNcd0Yn7s
         vRPPrYs4uX94nSLiDL2gaHsRxrKnoaFE3GEux0Q3qXQ7sOhGrlUJ6CGIXJvSalvQq71a
         +o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=traqaTrIhXYiC2RHUp0xIGU3PGSCNk68NWm3RfowTXE=;
        b=XiBVztOYm4N/b/jmJ2CgoAV8Swqnr54cb5ftiSgJgkdnVNf+uxHFOGcgsOCSuQGidh
         p/8I5PeDkPhY8hy6dKrhl3k+OrqKNLx9G97L2ifbK+xqJOYSDhmWpuKn2oBb8bo7yNiS
         1ZOHk9QnMD/ZOE7XvSQ9Ekb1zKIvl0uqppFDr+NfSYW7xAd0MezYgbuvFnxz+ap2Tx1X
         JDlWKGGZcUzkduwPuIQ4E/EtwMr9zk9HdQI5UnGmMlRg0TXIKbgAkWfYjSKkvWmlSGi8
         LLklXalWNaWyvE0t0qcZ+Z4H/VWigfVQR4+UnxTmvWmz2o361j0E0DDx7pcK6gmxcorU
         AvcQ==
X-Gm-Message-State: AOAM5322oxqziNMR6+l4UQbItI/68GSyD/umcLvs9UKhsoLoWAWL1fhX
        gvA9fqNh5aYLvZIKfR3px/1fOyqgKLEI09/VPcvcPWa+Fts=
X-Google-Smtp-Source: ABdhPJyeWLbj+8/qPOeTqIn13W84bik53apyXFmVkVCApxi45Ddd+rtpYtU0gDArJJiiuYHRDC7uUa8TgiMk9km3YPA=
X-Received: by 2002:a05:6638:84:: with SMTP id v4mr7186833jao.30.1611716337509;
 Tue, 26 Jan 2021 18:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-6-paul.gortmaker@windriver.com> <YBCIXzUkgjcCTprv@smile.fi.intel.com>
In-Reply-To: <YBCIXzUkgjcCTprv@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 18:58:46 -0800
Message-ID: <CAAH8bW9pQ_==uF3_Zo6K-ijqHXDVcW_-9gx0fvFWXe=fEvsg9A@mail.gmail.com>
Subject: Re: [PATCH 5/8] lib: bitmap_getnum: separate arg into region and field
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
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

On Tue, Jan 26, 2021 at 1:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 26, 2021 at 12:11:38PM -0500, Paul Gortmaker wrote:
> > The bitmap_getnum is only used on a region's start/end/off/group_len
> > field.  Trivially decouple the region from the field so that the region
> > pointer is available for a pending change.
>
> Honestly, I don't like this macro trick. It's bad in couple of ways:
>  - it hides what actually is done with the fields of r structure
>    (after you get that they are fields!)
>  - it breaks possibility to compile time (type) checks
>
> I will listen what others say, but I'm in favour not to proceed like this.

Agree. Would be better to drop the patch. Paul, what kind of pending
change do you mean here? All the following patches are not related to
parsing machinery.

> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  lib/bitmap.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 833f152a2c43..f65be2f148fd 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -533,6 +533,7 @@ static const char *bitmap_getnum(const char *str, unsigned int *num)
> >       *num = n;
> >       return str + len;
> >  }
> > +#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))
> >
> >  static inline bool end_of_str(char c)
> >  {
> > @@ -571,7 +572,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
> >
> >  static const char *bitmap_parse_region(const char *str, struct region *r)
> >  {
> > -     str = bitmap_getnum(str, &r->start);
> > +     str = bitmap_getrnum(str, r, start);
> >       if (IS_ERR(str))
> >               return str;
> >
> > @@ -581,7 +582,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> >       if (*str != '-')
> >               return ERR_PTR(-EINVAL);
> >
> > -     str = bitmap_getnum(str + 1, &r->end);
> > +     str = bitmap_getrnum(str + 1, r, end);
> >       if (IS_ERR(str))
> >               return str;
> >
> > @@ -591,14 +592,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> >       if (*str != ':')
> >               return ERR_PTR(-EINVAL);
> >
> > -     str = bitmap_getnum(str + 1, &r->off);
> > +     str = bitmap_getrnum(str + 1, r, off);
> >       if (IS_ERR(str))
> >               return str;
> >
> >       if (*str != '/')
> >               return ERR_PTR(-EINVAL);
> >
> > -     return bitmap_getnum(str + 1, &r->group_len);
> > +     return bitmap_getrnum(str + 1, r, group_len);
> >
> >  no_end:
> >       r->end = r->start;
> > --
> > 2.17.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
