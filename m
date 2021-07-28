Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9A3D8F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhG1Nrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhG1NrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:47:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE2C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:46:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 184so2240841qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sVvCedOiHNNS2N2AbA3HaoukyGvi3rdukkeJ2dK8WDs=;
        b=ZD2RgalNzeDSCP5anWAv+Ja8eSd4YU9Fye9iLhxQTwo6S0CxnRkScjGEKPI8jqCuPC
         q/h08a3BHrnaTazhZC8wPWpza1FceWHC/cOXlfsSryYTNEq3fQDyOWRC21do7TTN++4J
         LKHy/THBvEc7ghkidc0SIIDbcEPBGQAOwEw97ML16cBPCeW8X7N61bCv0R6eZicNsd11
         A014HHm4rPZV1SA0Vg5EBOO64WusF85+N4P14K8G7056m0UuRvWgOPg636SYkzRkFzLR
         Q65bX5M3kfdUssTvDsKKH1I+N/0tFaUXh4skdG6mSBi6YZCBfqPLO8eH2dWrpxYCsXJW
         MVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVvCedOiHNNS2N2AbA3HaoukyGvi3rdukkeJ2dK8WDs=;
        b=qlHJhYBTACzsWLfwoI/zKPwrmiEDgElq78c+ovaCM+LlX2pYNMcF3k2OzsKJAdipCe
         hPXcoqulP27ZytsJh1VMKT0c3htGeabtE4Z/gfVm9uLDeZ2gLgFS1x6bF+Cr2OpOcF5Z
         X4ICXPZE1moj875T1JXWjUewsqz5etF4V7lIOyiF3h4VZi/Pp66XivCuLeaopji2JYvM
         6h7C2eEqX881d43iQLCfOpnCjqPeX3m7c+dMNbec+ez9o9ZDKup+2tDDL5cIFQMAlZcl
         tRDZOkQ5WPyTbYZ0TrioODsBej3eCUwQZjI1EIz2ZHY24JInzWY6ThvZTkm+A4XL487S
         7law==
X-Gm-Message-State: AOAM532xCBOu1JmjSEaowVyh4cL5h7CPw+zvDWLD/IeRpiRfqPnBULuy
        eV1ZVhvAVXl+XDKfAUCIXWA=
X-Google-Smtp-Source: ABdhPJzre1XpcM5E3Bio8JoYESCY9lNKyGrlBNMIsSOYxAdiFl2JS+BCFpk/wQRMaVdAIbRD2hirBg==
X-Received: by 2002:a05:620a:1319:: with SMTP id o25mr23942443qkj.396.1627480000758;
        Wed, 28 Jul 2021 06:46:40 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id c2sm2854609qtw.30.2021.07.28.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:46:40 -0700 (PDT)
Date:   Wed, 28 Jul 2021 06:46:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH v1 1/1] bitmap.h: add const modifier to
 bitmap_next_[set/clear]_region() argument
Message-ID: <YQFfvoZn/DlYRJkI@yury-ThinkPad>
References: <20210727094441.9815-1-andrea.merello@gmail.com>
 <YP/ymvrd1zV7z6rF@smile.fi.intel.com>
 <YQAlmBEGIaChYgeW@yury-ThinkPad>
 <CAN8YU5PD9i=qztMLyuFsMQFf80pz04dLOSQ0NJ9=uHb1bTh52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5PD9i=qztMLyuFsMQFf80pz04dLOSQ0NJ9=uHb1bTh52w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:39:15AM +0200, Andrea Merello wrote:
> Il giorno mar 27 lug 2021 alle ore 17:26 Yury Norov
> <yury.norov@gmail.com> ha scritto:
> >
> > On Tue, Jul 27, 2021 at 02:48:42PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 27, 2021 at 11:44:41AM +0200, Andrea Merello wrote:
> > > > Those two functions don't modify the bitmap, so their bitmap argument
> > > > should be const. This patch add this.
> >
> > Thanks Andrea.
> >
> > Acked-by: Yury Norov <yury.norov@gmail.com>
> >
> > > Constification is always a good thing. No objections from me,
> > > although Yuri is doing something with them in one of his patch series.
> >
> > I try to remove those two because in practice they bring more mess
> > than good. All real use-cases for bitmap_next_{set,clear}_region
> > relate to iterating the whole bitmap, ie nobody just wants to find a
> > next region. Untill recently there was only a single user of the API,
> > so I easily reworked the code to use find_first_bit/find_next bit and
> > by chance return faster.
> 
> Ah, that's interesting to know: I'm working on a new driver that used
> find_next_zero_bit() and find_next_bit() [0]; Andy told me that my
> algorithm could be rewritten exploiting some bitmap_* helpers, so I
> rewrote my code using bitmap_for_each_set_region(), which in turn uses
> bitmap_next_set_region().
> 
> Should I revert to my previous implementation that uses
> find_next_zero_bit() and find_next_bit() ?
> 
> [0] https://lore.kernel.org/linux-iio/20210715141742.15072-3-andrea.merello@gmail.com/

No, you're doing right. I just reimplemented and renamed
bitmap_for_each_set_region to unify with other similar functions. The
transition is very stragthforward, so you have nothing to worry on.

https://patchwork.kernel.org/project/linux-mmc/patch/20210719021755.883182-3-yury.norov@gmail.com/

> 
> > https://github.com/norov/linux/commit/1c870b5c3fcd2eea9b351a1e0af8d1e93be78e1e
> >
> > Recently in next-20210716, there appeared another user in fs/btrfs/extent_io.c:
> > find_next_dirty_byte(). The fun is that in that case the length of bitmap
> > is 16 bit, so it's probably simpler to return the bitmap by value,
> > instead of calling prologue code up to 8 times. Anyways, I'll contact
> > authors of the find_next_dirty_byte() and ask if it's possible to rework
> > their code.
> >
> > > Yuri, do you have a public repo / branch that people can base their changes to
> > > bitmap stuff against of?
> >
> > I collected not yet upstreamed bitmap patches here:
> >
> > https://github.com/norov/linux/commits/bitmap-20210716
> 
> Looks like also bitmap_for_each_set_region() went away indeed ?

Just replaced with for_each_{set,clear}_bitrange.

Thanks,
Yury
