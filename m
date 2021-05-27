Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6693924E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhE0Ccm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhE0Cck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:32:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53970C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:31:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jt22so5571215ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwLkSsXhzF8/pdkFxICpjXFKRCe8Kdj+t5du899SDeI=;
        b=WCEb/HJFU5gBzRsJLThrK1+zglMHm5vE4e07q1buJR52oey32W3awhUPUklMNexccE
         xATX45ged89lS6fO07ReOK+wxYscjZGq8Cj3GORU4omWTtIEvcJrxwmmIcD2iBCJHbLb
         D+104yWIYsKp+PJxpxL+9/qfLfbrWlrDyxOwKzYROXXGCeLng60subrHYNAOOmoLkIX2
         3vxW/cKSIPo8YTQ+PdTNkN6coqSU7UnMU0JPTpjY6z/IgzUOBjD7Z7/Q6tVEp9ASPLkt
         Y31LTcNGbVcgyFmx6iDnv02GZ866PbIc8mKFG5nWdY4CdO0BlarqUmPW54nBeEgC36ts
         USoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwLkSsXhzF8/pdkFxICpjXFKRCe8Kdj+t5du899SDeI=;
        b=DpIYDNyS3hgoKnqo++5goOE/HSsI3CFEHhhQI7mQGlUThoeIYRS3vk/cevomDmo8qE
         MHpDXbCUi7WLMaqbQqLRZR0pi6aKPGQs+EelKS8jD6NmWF5W/wTfIdE7JuXgyPQa1sCu
         YGTC2GfHLxjkQEGI/DZXTVVe8keEhbzq1bRp8iSRLgJHnY+GCO4YAGOQejybg4P9Xj++
         HmtFAbA5AqW/cJ0H5GEOgGTYuRL5U2+n7mDvqyscadpbpYEbwJyudRwBpCZybAYFcv11
         RlpkKu8WB5Gg4LdrlclYYpihNRXofS3n5JOz/NWcEEmpbPZiU+MXA1rL4kx1heE3uJNh
         EQ3g==
X-Gm-Message-State: AOAM531vYH06UPnS9SAASrwUPA6KDJUO6+PBl8klp1bzD60tGve5tMXA
        eoRDVK5TGpugTjnYm0zgMAg435fGDfR97QlFriA=
X-Google-Smtp-Source: ABdhPJwv15xpxj2+mXmeTUDKS8K9ol3UD3d/7V2syBJpbOc2GJQIbGDKwDuh33/rNJkO5+9yQzzfYk1OgH64YLJkI7s=
X-Received: by 2002:a17:906:4751:: with SMTP id j17mr1378107ejs.25.1622082665943;
 Wed, 26 May 2021 19:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com>
 <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
 <alpine.LSU.2.11.2105251643320.2804@eggly.anvils> <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com>
 <alpine.LSU.2.11.2105261523250.16407@eggly.anvils> <CAHbLzkoDW+f0PKprtyY=ipoi9F-1C0z5Bt80k2h7ppPvNhCc5A@mail.gmail.com>
 <alpine.LSU.2.11.2105261733110.16920@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105261733110.16920@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 May 2021 19:30:54 -0700
Message-ID: <CAHbLzkpO-nZp+JnOOWmf5w-nXQj2QaErxFNq=VVfg_e6tk+z9w@mail.gmail.com>
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

On Wed, May 26, 2021 at 5:57 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 26 May 2021, Yang Shi wrote:
> > On Wed, May 26, 2021 at 3:48 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Wed, 26 May 2021, Yang Shi wrote:
> > > > On Tue, May 25, 2021 at 4:58 PM Hugh Dickins <hughd@google.com> wrote:
> > > > > On Tue, 25 May 2021, Yang Shi wrote:
> > > > > >
> > > > > > We should be able to make dump_page() print total mapcount, right? The
> > > > > > dump_page() should be just called in some error paths so taking some
> > > > > > extra overhead to dump more information seems harmless, or am I
> > > > > > missing something? Of course, this can be done in a separate patch.
> > > > >
> > > > > I didn't want to ask that of you, but yes, if you're willing to add
> > > > > total_mapcount() into dump_page(), I think that would be ideal; and
> > > > > could be helpful for other cases too.
> > > > >
> > > > > Looking through total_mapcount(), I think it's safe to call from
> > > > > dump_page() - I always worry about extending crash info with
> > > > > something that depends on a maybe-corrupted pointer which would
> > > > > generate a further crash and either recurse or truncate the output -
> > > > > but please check that carefully.
> > > >
> > > > Yes, it is possible. If the THP is being split, some VM_BUG_* might be
> > > > triggered if total_mapcount() is called. But it is still feasible to
> > > > print total mapcount as long as we implement a more robust version for
> > > > dump_page().
> > >
> > > Oh dear. I think the very last thing the kernel needs is yet another
> > > subtly different variant of *mapcount*().
> > >
> > > Do you have a specific VM_BUG_* in mind there?  Of course there's
> > > the VM_BUG_ON_PAGE(PageTail) at the start of it, and you'd want to
> > > print total_mapcount(head) to avoid that one.
> >
> > There are two more places in total_mapcount() other than the tail page
> > assertion.
> >
> > #1. compound_mapcount() has !PageCompound assertion. The similar
> > problem has been met before, please refer to commit 6dc5ea16c86f ("mm,
> > dump_page: do not crash with bad compound_mapcount()").
>
> Thanks for the useful reference.
>
> > #2. PageDoubleMap has !PageHead assertion.
> >
> > >
> > > Looks like __dump_page() is already careful about "head", checking
> > > whether "page" is within the expected bounds.  Of course, once we're
> > > in serious VM_WARN territory, there might be races which could flip
> > > fields midway: PageTail set by the time it reaches total_mapcount()?
> >
> > It seems possible, at least theoretically.
> >
> > > Narrow the race (rather like it does with PageSlab) by testing
> > > PageTail immediately before calling total_mapcount(head)?
> >
> > TBH I don't think of a simple testing to narrow all the races. We have
> > to add multiple testing in total_mapcount(), it seems too hacky.
> > Another variant like below might be neater?
> >
> > +static inline int __total_mapcount(struct page *head)
> > +{
> > +       int i, compound, nr, ret;
> > +
> > +       compound = head_compound_mapcount(head);
> > +       nr = compound_nr(head);
> > +       if (PageHuge(head))
> > +               return compound;
> > +       ret = compound;
> > +       for (i = 0; i < nr; i++)
> > +               ret += atomic_read(&head[i]._mapcount) + 1;
> > +       /* File pages has compound_mapcount included in _mapcount */
> > +       if (!PageAnon(head))
> > +               return ret - compound * nr;
> > +       if (head[1].flags & PG_double_map)
> > +               ret -= nr;
> > +       return ret;
> > +}
>
> I still don't want any more of those lovely functions.
>
> My current preference is just to drop the idea of trying
> to show total_mapcount from __dump_page().
>
> I might end up compromising on printing the result of
>         for (i = 0; i < nr; i++)
>                 ret += atomic_read(&head[i]._mapcount) + 1;
> (if we can safely decide nr), and leave all the convoluted
> flags logic to the poor reader of the page dump.
>
> But that in itself shows the limitation of printing total_mapcount(),
> when individual corrupt _mapcounts might be -1, +2, -3, +4, ...
>
> To some extent (modulo racing references to the THP), a good
> total_mapcount can be inferred from the page reference count.
> (But that probably describes better the situation when everything
> is going correctly: maybe problems tend to come precisely when there
> are multiple racing references.)

Yes, the total_mapcount could be decoded (not very precisely for some
cases as you said) from refcount, pincount, page type (anon or page
cache), etc.

We could do the calculation and print the number in dump_page(), or
just leave it to the reader of page dump.

>
> Dunno. My mind is not on it at the moment. I'm more concerned that
> Wang Yugui's crash turns out not to be solved by any of the fixes
> I have lined up: we certainly did not promise that it would be,
> and it shouldn't stop advancing the fixes we already know, but I do
> want to give it a little more thought before resuming on my patches.
>
> Hugh
