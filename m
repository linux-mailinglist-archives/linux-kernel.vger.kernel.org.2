Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B045392301
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhEZXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhEZXGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:06:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:04:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i13so3443831edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+lq37qKI+oQQ5eC5isuuDqSVssXilsmmXniH/3lcLs=;
        b=eaEJLD5bQsXCevDFBPPEnuiFou+49aKNsH0ZbRKcr2bR0NqvWfBHY1PjuLfxTSocS/
         gksxymAUiWfbiBFS488NwzQQSKHIwBI1RXQoe+adIhTR0L3IeSTdJhnsDhluqdE2inqs
         H+IfwOmNn2IhlxMr1orI99pwIsT2vJut7d8csja+RLENcRW5YTG7RSmnQVZAXo5j6YEF
         8F+0BhoFQDE4L+5vP26aUIXC62tn3I5TFj8xqvVttW4bqfFPBsOzhzb2ZpuxBWczjGSM
         inY3EvFLtT9aS4YDyRXljPPQ6NznoBITX+TTISpWj/Z/bAak/DSKptpnmctMsTdGkxlO
         SZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+lq37qKI+oQQ5eC5isuuDqSVssXilsmmXniH/3lcLs=;
        b=IcHktbqkPvj4XRBbTlHF8vIawZk+cQ4l4Xb1GXUGV7t/VI/ig6odwUiE6yEIA6a0Dq
         i1IEdXGpYUKeAQaxB/mJSfR53jE37+5I5KM1GFTX0HDCnrdeyrddVyTa6G+BPagi4XyD
         krCNs5w+wm1O4T5mv1KTi0EwrbaDuDL89sn1rpRmq4p+Ui9PLBvNfb0SgBIIP04FBKid
         wPVeVaX8Dv9gaoXKiefvltJ6WRJndp92gsAFbwYVU3s8qzqFzA1GSFjA3uLN+HEg9zqt
         0aB9pCSlEM78xGJuN7V4y4me2LJwyAnLd6a4RjtEFYMe0/eKxJ8418admO9sq30QH+KU
         JDqA==
X-Gm-Message-State: AOAM533+fEiU4mH60S27IKGoPIwlA/sKOijSc/xDi2S7nIDKDY/BHhe5
        +qcILk/mECFbe2GLou73Mug2LxmQAFdj7r54K14=
X-Google-Smtp-Source: ABdhPJwnRXvFEAhe5YRIU84nIhbncr+t37M/f5KMWgLCq4a6Vq1J0OaktVtCR4gfCWapDA9knvi/DqbG7UuTCY68XG8=
X-Received: by 2002:a05:6402:51ce:: with SMTP id r14mr629192edd.151.1622070287905;
 Wed, 26 May 2021 16:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com>
 <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
 <alpine.LSU.2.11.2105251643320.2804@eggly.anvils> <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com>
 <alpine.LSU.2.11.2105261523250.16407@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105261523250.16407@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 May 2021 16:04:35 -0700
Message-ID: <CAHbLzkoDW+f0PKprtyY=ipoi9F-1C0z5Bt80k2h7ppPvNhCc5A@mail.gmail.com>
Subject: Re: [v3 PATCH 2/2] mm: thp: check page_mapped instead of
 page_mapcount for split
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 3:48 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 26 May 2021, Yang Shi wrote:
> > On Tue, May 25, 2021 at 4:58 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Tue, 25 May 2021, Yang Shi wrote:
> > > >
> > > > We should be able to make dump_page() print total mapcount, right? The
> > > > dump_page() should be just called in some error paths so taking some
> > > > extra overhead to dump more information seems harmless, or am I
> > > > missing something? Of course, this can be done in a separate patch.
> > >
> > > I didn't want to ask that of you, but yes, if you're willing to add
> > > total_mapcount() into dump_page(), I think that would be ideal; and
> > > could be helpful for other cases too.
> > >
> > > Looking through total_mapcount(), I think it's safe to call from
> > > dump_page() - I always worry about extending crash info with
> > > something that depends on a maybe-corrupted pointer which would
> > > generate a further crash and either recurse or truncate the output -
> > > but please check that carefully.
> >
> > Yes, it is possible. If the THP is being split, some VM_BUG_* might be
> > triggered if total_mapcount() is called. But it is still feasible to
> > print total mapcount as long as we implement a more robust version for
> > dump_page().
>
> Oh dear. I think the very last thing the kernel needs is yet another
> subtly different variant of *mapcount*().
>
> Do you have a specific VM_BUG_* in mind there?  Of course there's
> the VM_BUG_ON_PAGE(PageTail) at the start of it, and you'd want to
> print total_mapcount(head) to avoid that one.

There are two more places in total_mapcount() other than the tail page
assertion.

#1. compound_mapcount() has !PageCompound assertion. The similar
problem has been met before, please refer to commit 6dc5ea16c86f ("mm,
dump_page: do not crash with bad compound_mapcount()").
#2. PageDoubleMap has !PageHead assertion.

>
> Looks like __dump_page() is already careful about "head", checking
> whether "page" is within the expected bounds.  Of course, once we're
> in serious VM_WARN territory, there might be races which could flip
> fields midway: PageTail set by the time it reaches total_mapcount()?

It seems possible, at least theoretically.

> Narrow the race (rather like it does with PageSlab) by testing
> PageTail immediately before calling total_mapcount(head)?

TBH I don't think of a simple testing to narrow all the races. We have
to add multiple testing in total_mapcount(), it seems too hacky.
Another variant like below might be neater?

+static inline int __total_mapcount(struct page *head)
+{
+       int i, compound, nr, ret;
+
+       compound = head_compound_mapcount(head);
+       nr = compound_nr(head);
+       if (PageHuge(head))
+               return compound;
+       ret = compound;
+       for (i = 0; i < nr; i++)
+               ret += atomic_read(&head[i]._mapcount) + 1;
+       /* File pages has compound_mapcount included in _mapcount */
+       if (!PageAnon(head))
+               return ret - compound * nr;
+       if (head[1].flags & PG_double_map)
+               ret -= nr;
+       return ret;
+}

>
> Hugh
