Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D8392400
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhE0A7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhE0A7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:59:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4498C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:57:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c15so2353502qte.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VlAnyDw6pOEr4UrVszLcWbhU5bthiU7s1qIDq+xEOhg=;
        b=pCEe7RNPWnZ4rQBQ8SmjheElLpr1XVKjKcZt8DigpqtuH06dvNcxuWjLsT2XqVkraO
         soY1VcdN/ioF2VCB0b8mUg1CJcb+ssnQDXUY4tXAkOcl2wRu7CByql8gUxhH8PuaQnhx
         Q+l0GRyKQmnAjf9TAP1FaWKf09oRK0KCzaJE5O9hd6M8SugQidU20pJckcnUCEHekhm5
         nfq0Qveh8tjf4KydffPgoL8Hny8Dpxf5RF4eWpR9ORU52lnE00qEyCS2SK5HVe9cTwhQ
         Q6tD0+WF4ua0dUM5UufvsZfISHQwHPdVi3uKUq+9LqfsNvdPv69iKEaaALmN6NBjGtWv
         qG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VlAnyDw6pOEr4UrVszLcWbhU5bthiU7s1qIDq+xEOhg=;
        b=WV6sUQAQnJZbqEvxMwaQnmJmMf6c/BoM6VelwhqI+Dlf7HBB4NpUctGpdVV7vhpIk1
         Y5jnYahR7kgv2303yv5VrfaXqG7UHzSHAOEGI5MxuCy7HSEK+Veb+SQaX1zsjRePLfYu
         b0alWzrCKZI10xeEU+nnwvSFJgUARrbYgcmzIJbUux1opZlLPFrfenPgsgemZt8EdJkF
         apjygCFDaAq/V89kWfrs3M5EiAnPczn/KLBMH3eq7s4beShgNtbPLpg0CTM6yp47mTes
         Rx9Wta80LdQvQDSrQiJei88eTh0kLa9mMRDT21fW34LQR95msyxND2BXnqYL/XKXsqCg
         Q1DA==
X-Gm-Message-State: AOAM531s6Cc/Sl7AXPIYLFrwRExRTlQHBlculCeFxg5/Niq4VBTBYejk
        OrqwX3IZ7nyqdASauz8SD+NI9decK3/9hQ==
X-Google-Smtp-Source: ABdhPJyvTOWEKd3+R9wmG3haRULo6mVhKdxafqBgRIXxQTrugp+kKU1rsHASJdFs/a00tMWwsP5eDg==
X-Received: by 2002:a05:622a:40d:: with SMTP id n13mr885951qtx.59.1622077077752;
        Wed, 26 May 2021 17:57:57 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d28sm399733qkl.105.2021.05.26.17.57.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 26 May 2021 17:57:57 -0700 (PDT)
Date:   Wed, 26 May 2021 17:57:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3_=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/2] mm: thp: check page_mapped instead of page_mapcount
 for split
In-Reply-To: <CAHbLzkoDW+f0PKprtyY=ipoi9F-1C0z5Bt80k2h7ppPvNhCc5A@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2105261733110.16920@eggly.anvils>
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com> <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com> <alpine.LSU.2.11.2105251643320.2804@eggly.anvils>
 <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com> <alpine.LSU.2.11.2105261523250.16407@eggly.anvils> <CAHbLzkoDW+f0PKprtyY=ipoi9F-1C0z5Bt80k2h7ppPvNhCc5A@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Yang Shi wrote:
> On Wed, May 26, 2021 at 3:48 PM Hugh Dickins <hughd@google.com> wrote:
> > On Wed, 26 May 2021, Yang Shi wrote:
> > > On Tue, May 25, 2021 at 4:58 PM Hugh Dickins <hughd@google.com> wrote:
> > > > On Tue, 25 May 2021, Yang Shi wrote:
> > > > >
> > > > > We should be able to make dump_page() print total mapcount, right? The
> > > > > dump_page() should be just called in some error paths so taking some
> > > > > extra overhead to dump more information seems harmless, or am I
> > > > > missing something? Of course, this can be done in a separate patch.
> > > >
> > > > I didn't want to ask that of you, but yes, if you're willing to add
> > > > total_mapcount() into dump_page(), I think that would be ideal; and
> > > > could be helpful for other cases too.
> > > >
> > > > Looking through total_mapcount(), I think it's safe to call from
> > > > dump_page() - I always worry about extending crash info with
> > > > something that depends on a maybe-corrupted pointer which would
> > > > generate a further crash and either recurse or truncate the output -
> > > > but please check that carefully.
> > >
> > > Yes, it is possible. If the THP is being split, some VM_BUG_* might be
> > > triggered if total_mapcount() is called. But it is still feasible to
> > > print total mapcount as long as we implement a more robust version for
> > > dump_page().
> >
> > Oh dear. I think the very last thing the kernel needs is yet another
> > subtly different variant of *mapcount*().
> >
> > Do you have a specific VM_BUG_* in mind there?  Of course there's
> > the VM_BUG_ON_PAGE(PageTail) at the start of it, and you'd want to
> > print total_mapcount(head) to avoid that one.
> 
> There are two more places in total_mapcount() other than the tail page
> assertion.
> 
> #1. compound_mapcount() has !PageCompound assertion. The similar
> problem has been met before, please refer to commit 6dc5ea16c86f ("mm,
> dump_page: do not crash with bad compound_mapcount()").

Thanks for the useful reference.

> #2. PageDoubleMap has !PageHead assertion.
> 
> >
> > Looks like __dump_page() is already careful about "head", checking
> > whether "page" is within the expected bounds.  Of course, once we're
> > in serious VM_WARN territory, there might be races which could flip
> > fields midway: PageTail set by the time it reaches total_mapcount()?
> 
> It seems possible, at least theoretically.
> 
> > Narrow the race (rather like it does with PageSlab) by testing
> > PageTail immediately before calling total_mapcount(head)?
> 
> TBH I don't think of a simple testing to narrow all the races. We have
> to add multiple testing in total_mapcount(), it seems too hacky.
> Another variant like below might be neater?
> 
> +static inline int __total_mapcount(struct page *head)
> +{
> +       int i, compound, nr, ret;
> +
> +       compound = head_compound_mapcount(head);
> +       nr = compound_nr(head);
> +       if (PageHuge(head))
> +               return compound;
> +       ret = compound;
> +       for (i = 0; i < nr; i++)
> +               ret += atomic_read(&head[i]._mapcount) + 1;
> +       /* File pages has compound_mapcount included in _mapcount */
> +       if (!PageAnon(head))
> +               return ret - compound * nr;
> +       if (head[1].flags & PG_double_map)
> +               ret -= nr;
> +       return ret;
> +}

I still don't want any more of those lovely functions.

My current preference is just to drop the idea of trying
to show total_mapcount from __dump_page().

I might end up compromising on printing the result of
	for (i = 0; i < nr; i++)
		ret += atomic_read(&head[i]._mapcount) + 1;
(if we can safely decide nr), and leave all the convoluted
flags logic to the poor reader of the page dump.

But that in itself shows the limitation of printing total_mapcount(),
when individual corrupt _mapcounts might be -1, +2, -3, +4, ...

To some extent (modulo racing references to the THP), a good
total_mapcount can be inferred from the page reference count.
(But that probably describes better the situation when everything
is going correctly: maybe problems tend to come precisely when there
are multiple racing references.)

Dunno. My mind is not on it at the moment. I'm more concerned that
Wang Yugui's crash turns out not to be solved by any of the fixes
I have lined up: we certainly did not promise that it would be,
and it shouldn't stop advancing the fixes we already know, but I do
want to give it a little more thought before resuming on my patches.

Hugh
