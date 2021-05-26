Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD7392246
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhEZVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEZVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:48:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:46:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h16so3285980edr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVadEvLZpce8a7tGz4LRC6JJpJnbOhzGVc5VcId76RQ=;
        b=F6o4xrQad6efMACHqorToK30W9yh7Gf5y2FY3ZphmDLLWR1oRR+ukXzN+SBzCctnpg
         8PIU+XYUi8kMTij/+vo1hqtIjzjSg+MVC4qMobaMH50z/gL+Aamxq7VUqS2M/3RmDoUW
         FBM4mZJXA9Lw1hr6BMbSwexgGedX4fRFUG60qaHj8OSIJFCXx4KTRYbMJw8in5gSeg+F
         wXKsf09T1i1/zZ68WG5NEYezvhsHQFdVDnajcI2gZz8Qo9vZv8f3D+efFGw0wxhfs5k5
         56lQp+rpZAsi88fVFP+/s6380xa5tZhuzuJu+ppcYIWGjrvn3IShNRPTR7Z3o2n4gL8P
         c/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVadEvLZpce8a7tGz4LRC6JJpJnbOhzGVc5VcId76RQ=;
        b=ZZG8/DPjGo6xjKKW2SwtQ1sgjeyjfRgXsbEx5UHVMPlWtsnmxI9GBY0FgezlI2aGxb
         LFExoMP7I4lD7sBk7VEFGM9Qpy62IMqXew33AUNnuwlLdwsOh6hCJJ5ZYAKvLlNW7zNr
         Tr8S9PZeEkFg6f2KheuAIRIkyzK02XR+tidS3IQoVat+3H4q7zATzkLTh+LMvAy3RKa/
         TG13NlN6ntSYGmil6XaULrXrTwytgqOZDFbtKdNEBiOM4wkUx16Kv0UYdljk75bG6BSo
         3XtqzlNoXm13yCVLo72Vg1WfDoyNniN0eL2HW7SwjQePbSDc1+u0TYxREsBglZYliNOC
         yAcQ==
X-Gm-Message-State: AOAM533SwSJ0QCE4azdKoELVWNFWfBJpuHAvYLz7xgKnxn5VeonvuD9f
        /vyaM/Gcgr4jOSqjgRYEedU82auU39k42SmB7KM=
X-Google-Smtp-Source: ABdhPJwNv31/gORIrWNfhwq738PIQ709IiWGpudsg02wgTgLJy5kALrFpTNSNH/CXJIznBUzJY9JraVh+chdmt0bpao=
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr277738edd.313.1622065594992;
 Wed, 26 May 2021 14:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com>
 <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
 <alpine.LSU.2.11.2105251643320.2804@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105251643320.2804@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 May 2021 14:46:23 -0700
Message-ID: <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com>
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

On Tue, May 25, 2021 at 4:58 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 25 May 2021, Yang Shi wrote:
> > On Tue, May 25, 2021 at 3:06 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Tue, 25 May 2021, Yang Shi wrote:
> > >
> > > > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > > > return false positive for PTE-mapped THP since page_mapcount() is used
> > > > to check if the THP is unmapped, but it just checks compound mapount and
> > > > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > > > mapped, it may return false positive.
> > >
> > > But those false positives did not matter because there was a separate
> > > DEBUG_VM check later.
> > >
> > > It's good to have the link to Wang Yugui's report, but that paragraph
> > > is not really about this patch, as it has evolved now: this patch
> > > consolidates the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE.
> > >
> > > >
> > > > The try_to_unmap() has been changed to void function, so check
> > > > page_mapped() after it.  And changed BUG_ON to WARN_ON since it is not a
> > > > fatal issue.
> > >
> > > The change from DEBUG_VM BUG to VM_WARN_ON_ONCE is the most important
> > > part of this, and the reason it's good for stable: and the patch title
> > > ought to highlight that, not the page_mapcount business.
> >
> > Will update the subject and the commit log accordingly.
>
> Thanks!
>
> >
> > >
> > > >
> > > > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> > > >
> > > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >
> > > This will be required Cc: stable@vger.kernel.org
> > > (but we don't want to Cc them on this mail).
> > >
> > > As I said on the other, I think this should be 1/2 not 2/2.
> >
> > Sure.
>
> Great.
>
> >
> > >
> > > > ---
> > > > v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
> > > >     since there is no fundamental change against v2.
> > > > v2: Removed dead code and updated the comment of try_to_unmap() per Zi
> > > >     Yan.
> > > >  mm/huge_memory.c | 17 +++++------------
> > > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 80fe642d742d..72d81d8e01b1 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2343,6 +2343,8 @@ static void unmap_page(struct page *page)
> > > >               ttu_flags |= TTU_SPLIT_FREEZE;
> > > >
> > > >       try_to_unmap(page, ttu_flags);
> > > > +
> > > > +     VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
> > >
> > > There is one useful piece of information that dump_page() will not show:
> > > total_mapcount(page).  Is there a way of crafting that into the output?
> > >
> > > Not with the macros available, I think.  Maybe we should be optimistic
> > > and assume I already have the fixes, so not worth trying to refine the
> > > message (but I'm not entirely convinced of that!).
> > >
> > > The trouble with
> > >         if (VM_WARN_ON_ONCE_PAGE(page_mapped(page), page))
> > >                 pr_warn("total_mapcount:%d\n", total_mapcount(page));
> > > is that it's printed regardless of the ONCEness.  Another "trouble"
> > > is that it's printed so long after the page_mapped(page) check that
> > > it may be 0 by now - but one can see that as itself informative.
> >
> > We should be able to make dump_page() print total mapcount, right? The
> > dump_page() should be just called in some error paths so taking some
> > extra overhead to dump more information seems harmless, or am I
> > missing something? Of course, this can be done in a separate patch.
>
> I didn't want to ask that of you, but yes, if you're willing to add
> total_mapcount() into dump_page(), I think that would be ideal; and
> could be helpful for other cases too.
>
> Looking through total_mapcount(), I think it's safe to call from
> dump_page() - I always worry about extending crash info with
> something that depends on a maybe-corrupted pointer which would
> generate a further crash and either recurse or truncate the output -
> but please check that carefully.

Yes, it is possible. If the THP is being split, some VM_BUG_* might be
triggered if total_mapcount() is called. But it is still feasible to
print total mapcount as long as we implement a more robust version for
dump_page().

>
> Yes, a separate patch please: which can come later on, and no
> need for stable for that one, but good to know it's coming.
>
> Thanks,
> Hugh
