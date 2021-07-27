Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830343D79CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhG0P2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbhG0P1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:27:54 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31826C061796
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:26:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o61so4472505qvo.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NTgXzfWkyhtq+zizJ+5C4IeWyVCNim2DsO4Exn10eZ4=;
        b=RZquX77R97F8WPn8wsK/LwjqatshA+IACrSjuFTechlit8HSk8i3OlCsWM65AzTqky
         98VpTeESoFH+CaquMhXWI5OmSCZpRMVkkFHCaJeI2bVL1+IYy2y0F4sUBNnmmVNL+fUp
         IyVUNup26gEFGwMsVjSdtKPLKpvoUmo4IRIOCnm3Of2MygrJDmK3zqEUyIbbNalYtum5
         l5KIXosS+hmRiQG53VL6795qgbL4s8UQL67FL+Sbvxt2ldN6xYjkDUz1oT9NS0ACFjs1
         QoD3Ry7EodhejtmfF5hOuM9ddEnZhBdxm6JiOvP9uXeyApY2JIiUoI/KlMAmo/eQ7qeH
         8krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTgXzfWkyhtq+zizJ+5C4IeWyVCNim2DsO4Exn10eZ4=;
        b=i9Rk6BUE22dgPxpy9rp1jLpvln9PnhTbTrQ4MmzmvGoOa06+9jluJbreE03O29x43j
         1+4dD7j4C1P5IveqwHJFKpR58el91dAYeg37rBqeEmP4XsBHpNbUAczWQHk1NY1pPlHs
         9acSqhQ2kwegy/Olp4LEtdj/LVeq0fj6qpDZ0XLiU+uagdVbhCd/0/KKRqHObsFFo3SO
         T8QT94jIMzk7nn3t7poztztXLZ6fq4npg/7DEhSpRGG+/UR6h3akU3spvaGZYaaFY/T4
         Ao4cZp0LwFEMaT7xxXdeksk6sZChfrAgRCmiV4cClHYWOXkrA/RLGOcH6hnFrvnz3B5s
         OHfg==
X-Gm-Message-State: AOAM530PMqKz7cf83BrsIOXiUmR21xKqhs2hLE6xLrGojng3+mLgqUqv
        dbtPsx2ZRhM9Hhnh8TWsEUo=
X-Google-Smtp-Source: ABdhPJzdZJs3dURsJI5yvsNHjIbX5IGUE3uyFGtU6jwBwtFdq4Qe9lVJ5CAMuAPTU0wHUDq/j/sJTA==
X-Received: by 2002:ad4:46ed:: with SMTP id h13mr6960486qvw.56.1627399578245;
        Tue, 27 Jul 2021 08:26:18 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id f2sm1513767qth.11.2021.07.27.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:26:17 -0700 (PDT)
Date:   Tue, 27 Jul 2021 08:26:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH v1 1/1] bitmap.h: add const modifier to
 bitmap_next_[set/clear]_region() argument
Message-ID: <YQAlmBEGIaChYgeW@yury-ThinkPad>
References: <20210727094441.9815-1-andrea.merello@gmail.com>
 <YP/ymvrd1zV7z6rF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/ymvrd1zV7z6rF@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:48:42PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 27, 2021 at 11:44:41AM +0200, Andrea Merello wrote:
> > Those two functions don't modify the bitmap, so their bitmap argument
> > should be const. This patch add this.

Thanks Andrea.

Acked-by: Yury Norov <yury.norov@gmail.com>

> Constification is always a good thing. No objections from me,
> although Yuri is doing something with them in one of his patch series.

I try to remove those two because in practice they bring more mess
than good. All real use-cases for bitmap_next_{set,clear}_region 
relate to iterating the whole bitmap, ie nobody just wants to find a
next region. Untill recently there was only a single user of the API,
so I easily reworked the code to use find_first_bit/find_next bit and
by chance return faster.

https://github.com/norov/linux/commit/1c870b5c3fcd2eea9b351a1e0af8d1e93be78e1e

Recently in next-20210716, there appeared another user in fs/btrfs/extent_io.c:
find_next_dirty_byte(). The fun is that in that case the length of bitmap
is 16 bit, so it's probably simpler to return the bitmap by value,
instead of calling prologue code up to 8 times. Anyways, I'll contact
authors of the find_next_dirty_byte() and ask if it's possible to rework
their code. 
 
> Yuri, do you have a public repo / branch that people can base their changes to
> bitmap stuff against of?

I collected not yet upstreamed bitmap patches here:

https://github.com/norov/linux/commits/bitmap-20210716

Please let me know if you believe we need a more official branch for
bitmaps. I'd encourage people to review what we already have and
upstream it.

Thanks,
Yury

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > ---
> >  include/linux/bitmap.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index a36cfcec4e77..ea4a8f1a2545 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -458,7 +458,7 @@ static inline void bitmap_replace(unsigned long *dst,
> >  		__bitmap_replace(dst, old, new, mask, nbits);
> >  }
> >  
> > -static inline void bitmap_next_clear_region(unsigned long *bitmap,
> > +static inline void bitmap_next_clear_region(const unsigned long *bitmap,
> >  					    unsigned int *rs, unsigned int *re,
> >  					    unsigned int end)
> >  {
> > @@ -466,7 +466,7 @@ static inline void bitmap_next_clear_region(unsigned long *bitmap,
> >  	*re = find_next_bit(bitmap, end, *rs + 1);
> >  }
> >  
> > -static inline void bitmap_next_set_region(unsigned long *bitmap,
> > +static inline void bitmap_next_set_region(const unsigned long *bitmap,
> >  					  unsigned int *rs, unsigned int *re,
> >  					  unsigned int end)
> >  {
> > -- 
> > 2.17.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
