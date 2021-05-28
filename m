Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059B0394756
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhE1S6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1S6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:58:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1864C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:57:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb17so6808721ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVbbn9Tllju3ajh8WBDFibkdk2WLCqQZwjz4DxeixVg=;
        b=o8MAWiiP+EedC79OfXmHH++BL0hoE4dXtHp72RwzksF3nBUatbYbHyZW9+Y6vfu1XF
         ogG7yxFsG7Lq64QEFHUot8HXaLKln7z13Vp8yI8pvsm1FnxSDkWIvej4VXkbb+2mzMLY
         lkXs98fhm8PIe10qY7zx/aKHBdn+LUxgEra9/oDEpMYIsIBE2mnt1Wc6NutHJuPDTUv2
         XQF1QFGkEJsA+qyzv7aporio0YCQP7sNREElMjnWhHaAKeNfIBciBklxpaMybEe0sHNp
         Mn191Xm3XXRW2UU3Y+tjjg5VjLl6MVPoXZmB4JKBzy7e/myhVyyQCdfparN7YyZg/oZD
         S2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVbbn9Tllju3ajh8WBDFibkdk2WLCqQZwjz4DxeixVg=;
        b=AoMWxoGfM3t3AD43RkYp2XrPoyG1BrYou9ziGlAB8j7b/WOgJPa5Yt3yRA+7b9XgiC
         ZJuXOrFXuxBntTi/A4fxiau50ZdkWdWiT777wSU4GEx0oJRhUwIpYScppV/eleAas0Ro
         eVoZHA06jw8lAgS0cyVfYuHh6vAcdR+vFRkwRm5k0mH6JtMnkKRwAtq6TZJhCUOkfjHL
         uaI56dnb+SUtBq53pIhlgp3y5pDcSYSWR3pMcbdbwlXmFIksxaGPJOpXJvxO0vtjRu2j
         y94HENJ/ccc2qk7Vc8kH3mSySp9BH3H+97T9bjTzwZUAaOngHhcfBG0fXMqwPN0Ia7En
         2GVg==
X-Gm-Message-State: AOAM532wcLqGMeMQO48lOSVAcyE3gsfiwNkm6et3T+y+6fkMGAFXUIPY
        j2ouByBMcc/CdWLkw4zwPSt/FcgJC8fW5UOLDOQ=
X-Google-Smtp-Source: ABdhPJzcUtLuBBKkDmUt7ki04LQtzvWlnRvb0cqO/bJ0/ldbrdUJfKjgTVdlz3Nmu5W1bQjljxkBLOODwJyqBiV1q3s=
X-Received: by 2002:a17:906:da1b:: with SMTP id fi27mr10497141ejb.161.1622228230486;
 Fri, 28 May 2021 11:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210528175403.4506-1-shy828301@gmail.com> <YLE00rVi6O3DF3XA@casper.infradead.org>
In-Reply-To: <YLE00rVi6O3DF3XA@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 May 2021 11:56:59 -0700
Message-ID: <CAHbLzkoRiMcsNXCO78AQWR+NADg09GcyQHfHwoPcA-aSEPr0+w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, May 28, 2021 at 10:54:03AM -0700, Yang Shi wrote:
> > So I prepared this patch to show a possible approach to get some
> > feedback.  The same thing could be decoded by the reader of page dump
> > as well by using the same formula used by this patch.  However it sounds
> > more convenient to have kernel do the math.
>
> You haven't taken enough things into consideration ...
>
> > +     bool is_slab = PageSlab(head);
>
> We should probably have a separate dump_slab_page().  Almost nothing
> in __dump_page() is really useful for slab pages (eg, mapping, index,
> mapcount, compound_mapcount, compound_pincount, aops), and the flags
> (such as are used) have different meanings.

Yes, slab page dump is missed for a long time.

>
> > +             nr = compound_nr(head);
> > +             if (is_slab)
> > +                     total_mapcount = 0;
> > +             else if (PageHuge(head))
> > +                     total_mapcount = comp_mapcnt;
> > +             else {
> > +                     if (mapping) {
> > +                             if (!PageAnon(head))
> > +                                     nr = nr * (comp_mapcnt + 1) - comp_mapcnt;
> > +                     } else
> > +                             nr = 0;
> > +                     total_mapcount = refcount - pincount - nr;
>
> I see what you're trying to do here, but there are so many other things
> which take a refcount on a page.  The LRU, the page cache, private fs
> data, random temporary "gets" (eg, buffered reads, buffered writes,
> get_user_pages(), readahead, truncate, migration).  I think this is
> likely to be so inaccurate as to be confusing.

Yes, it is inaccurate in some cases. There is not a simple way to rule
out those random transient references. The page cache has been taken
into account by this patch, but I overlooked private page and LRU
cache cases, they seem simple to filter out by page flags.

>
> I had to think hard about it though.  I like what you're trying to do,
> I just don't think it works ;-(

The random transient references are annoying and could make the number
be far away from accuracy. That would be too confusing to be worth
printing the number. But I'm not sure how often or bad it could be.
