Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B70390D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhEYX7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhEYX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:59:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43846C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:58:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so30317847otg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=96SWrhLmUCKQijao48QxB8kgaW2ggVLMSJIzzAAK82s=;
        b=JkbcbieZnBP98eCaMaDkGpBNne2U71qQhBMxkWGZmcfquJDvt0qyhK3d+7swAYlm9e
         diraHkDZjp3fJCUYEBZ/IONDfA9fe6O4Q1TkHyYhmI3cVrDbgcVlUiEm11EZzrWeyOUF
         acoql4FHCAz36VGkUzduCJNi89OqBsboKsVB1Q1DSqPrR4SqEldZTZoku3LDetlgz6Tc
         gtO5AJUvdl1TwdnW9nyIj9qYi3S8PAuIU7SxJJkNz6A7eizyqtLZWal1umQahwgv23gk
         3D/KvNXhYw4bjdcoAYUj6ObB9bmZb71upekftP5ZX+ihYcxfvmbrrXZtxx7+iqsKZM/K
         Xhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=96SWrhLmUCKQijao48QxB8kgaW2ggVLMSJIzzAAK82s=;
        b=H2+oDXYLEQuh04b5KMik6IKCpK3BfgOqgJvw3Wg7BEXldaPpnP0nKBX4FHaDy1pTH4
         bJbVb7au6KVXvC1o/61SBQzjWWezMmVJfvfOZCB7Bg19mQBFdHToSEUXa39BWVL0SMsQ
         2UV2OlluJLgC1tCQKRwsaQmLgW/weN14ZwBTdZyTBh7f3VuRoaW5ihItrziF4MWZ9QA7
         a/HB1Do3ZZCPjotH0vLHwK7tX/tacfgGxecURdiPoUdwEWmdKbi6lHyVnybIZh6ovIYj
         gf82NBMi3vcXn4f6WRr585D2Me7AjtKeF4OTxJPiWJYA36MFGCbIXSUos65tyvwG9GiX
         pHyA==
X-Gm-Message-State: AOAM533ixM+n1yk9F8IaYiafiu6p6sDVNNXduE5ZXhL1H2iPzOKhW3/K
        r8YGF7Ij6fa8ymUmXW7bUWeZuw==
X-Google-Smtp-Source: ABdhPJxYTgORel00p83Ig33bBNDTJPo4Kko+a5E/oDEYLjvCYkAWza0i04mqKo/jpxN4eiqAVjA+hQ==
X-Received: by 2002:a9d:4e88:: with SMTP id v8mr168567otk.110.1621987096235;
        Tue, 25 May 2021 16:58:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 129sm3773659ooq.34.2021.05.25.16.58.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 25 May 2021 16:58:15 -0700 (PDT)
Date:   Tue, 25 May 2021 16:58:03 -0700 (PDT)
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
In-Reply-To: <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2105251643320.2804@eggly.anvils>
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com> <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Yang Shi wrote:
> On Tue, May 25, 2021 at 3:06 PM Hugh Dickins <hughd@google.com> wrote:
> > On Tue, 25 May 2021, Yang Shi wrote:
> >
> > > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > > return false positive for PTE-mapped THP since page_mapcount() is used
> > > to check if the THP is unmapped, but it just checks compound mapount and
> > > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > > mapped, it may return false positive.
> >
> > But those false positives did not matter because there was a separate
> > DEBUG_VM check later.
> >
> > It's good to have the link to Wang Yugui's report, but that paragraph
> > is not really about this patch, as it has evolved now: this patch
> > consolidates the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE.
> >
> > >
> > > The try_to_unmap() has been changed to void function, so check
> > > page_mapped() after it.  And changed BUG_ON to WARN_ON since it is not a
> > > fatal issue.
> >
> > The change from DEBUG_VM BUG to VM_WARN_ON_ONCE is the most important
> > part of this, and the reason it's good for stable: and the patch title
> > ought to highlight that, not the page_mapcount business.
> 
> Will update the subject and the commit log accordingly.

Thanks!

> 
> >
> > >
> > > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> > >
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > This will be required Cc: stable@vger.kernel.org
> > (but we don't want to Cc them on this mail).
> >
> > As I said on the other, I think this should be 1/2 not 2/2.
> 
> Sure.

Great.

> 
> >
> > > ---
> > > v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
> > >     since there is no fundamental change against v2.
> > > v2: Removed dead code and updated the comment of try_to_unmap() per Zi
> > >     Yan.
> > >  mm/huge_memory.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 80fe642d742d..72d81d8e01b1 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2343,6 +2343,8 @@ static void unmap_page(struct page *page)
> > >               ttu_flags |= TTU_SPLIT_FREEZE;
> > >
> > >       try_to_unmap(page, ttu_flags);
> > > +
> > > +     VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
> >
> > There is one useful piece of information that dump_page() will not show:
> > total_mapcount(page).  Is there a way of crafting that into the output?
> >
> > Not with the macros available, I think.  Maybe we should be optimistic
> > and assume I already have the fixes, so not worth trying to refine the
> > message (but I'm not entirely convinced of that!).
> >
> > The trouble with
> >         if (VM_WARN_ON_ONCE_PAGE(page_mapped(page), page))
> >                 pr_warn("total_mapcount:%d\n", total_mapcount(page));
> > is that it's printed regardless of the ONCEness.  Another "trouble"
> > is that it's printed so long after the page_mapped(page) check that
> > it may be 0 by now - but one can see that as itself informative.
> 
> We should be able to make dump_page() print total mapcount, right? The
> dump_page() should be just called in some error paths so taking some
> extra overhead to dump more information seems harmless, or am I
> missing something? Of course, this can be done in a separate patch.

I didn't want to ask that of you, but yes, if you're willing to add
total_mapcount() into dump_page(), I think that would be ideal; and
could be helpful for other cases too.

Looking through total_mapcount(), I think it's safe to call from
dump_page() - I always worry about extending crash info with
something that depends on a maybe-corrupted pointer which would
generate a further crash and either recurse or truncate the output -
but please check that carefully.

Yes, a separate patch please: which can come later on, and no
need for stable for that one, but good to know it's coming.

Thanks,
Hugh
