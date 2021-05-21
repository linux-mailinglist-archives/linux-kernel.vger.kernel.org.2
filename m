Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8038CBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhEURSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhEURST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:18:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B75C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:16:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l1so31559224ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4/CwNk0FN5qvx+50wn7PTfWmi1N+v6lF6hq8B8Z0+M=;
        b=KXVt6s5DY0WD87o/HNLXBpqqo1MqEcSRjiohfszAFUncp7HQiMkeAvjtkvqR3OPYN7
         03qdYY4RnBnbrnovcyyrHXQ3a5LNSHilQlcKHkiuQsts7ajUohjhkw4RDTnnY2kljWb8
         RA4aeTRK0BDFOHTeMQwLTWTDUOWNC2CZHxxrbJH9S1zkPgAzAhwRoCHLS2I5vCwl4mXz
         OwnHAe1FOodgKpySSIxzWO02VxfKMc2W/Ho7if4QQ7gUrmOnKg3g5HcUeHeJ7crN6l4J
         SaJ9kZO6ckVk96R5JK5c4gBI1y/WeZLLXJlTrzYqbxbQjUnUaDtoEjkZddYfKH6+6vY+
         7RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4/CwNk0FN5qvx+50wn7PTfWmi1N+v6lF6hq8B8Z0+M=;
        b=lhY2X8kOUiTiIu4fLnDuJXZmY3altquF5AU668V3+7uuhbnUGte27GU4s27br+kVRM
         wahEcpI+2iRs2U3QBUK14DFaApXHRJ/OoLr/ksPeQdfXB5sZCVtX016+XMkmyBAYbsS5
         0hqeapSDaQfQCE5nxf5MnnHlbSWcSarKro9YWIEhZ4HaGSl5JTCCxSWOzm/81/yQ5hyA
         6PasjX8w/f8NHVQnTDKhThbBIUaQiGopEUoctailWpKKEwTQiMQYBdERgssJirmrp6Jy
         n8cUPtBYBvThzCflLpXgN8YNLDfIbY7bqDmGzL+qKrm1aq/W1Tu9M+EnoHLVkjz0DCQ2
         9CLA==
X-Gm-Message-State: AOAM5323zMODkNXAwAXe/HE8wXqJrf9TVUuiFEm+9A5eVutYZSNI1c5a
        lqx/ldfn5h20pcV1oT6CnYxN+2hY3wNbsEsYBPA=
X-Google-Smtp-Source: ABdhPJwYPFLbDho6OUZa5Gd2kS+qNLXtO1L5UeCv1ZEkEBjMF2CDlJBrEwLVl/d5F2SQc/WNJuJFGpb79qnY8g+xCZg=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr11482393ejf.25.1621617414570;
 Fri, 21 May 2021 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210513212334.217424-1-shy828301@gmail.com> <alpine.LSU.2.11.2105202120220.6466@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105202120220.6466@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 May 2021 10:16:41 -0700
Message-ID: <CAHbLzkpipqwZQfmJe0t3MxfPW-RvG8wXerffBqrUxZb3OHccGg@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: thp: check total_mapcount instead of page_mapcount
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:06 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 13 May 2021, Yang Shi wrote:
>
> > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > return false positive for PTE-mapped THP since page_mapcount() is used
> > to check if the THP is unmapped, but it just checks compound mapount and
> > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > mapped, it may return false positive.
> >
> > Use total_mapcount() instead of page_mapcount() for try_to_unmap() and
> > do so for the VM_BUG_ON_PAGE in split_huge_page_to_list as well.
> >
> > This changed the semantic of try_to_unmap(), but I don't see there is
> > any usecase that expects try_to_unmap() just unmap one subpage of a huge
> > page.  So using page_mapcount() seems like a bug.
> >
> > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> I don't object to this patch, I've no reason to NAK it; but I'll
> point out a few deficiencies which might make you want to revisit it.
>
> > ---
> > v2: Removed dead code and updated the comment of try_to_unmap() per Zi
> >     Yan.
> >
> >  mm/huge_memory.c | 11 +----------
> >  mm/rmap.c        | 10 ++++++----
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 63ed6b25deaa..3b08b9ba1578 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2348,7 +2348,6 @@ static void unmap_page(struct page *page)
> >               ttu_flags |= TTU_SPLIT_FREEZE;
> >
> >       unmap_success = try_to_unmap(page, ttu_flags);
> > -     VM_BUG_ON_PAGE(!unmap_success, page);
>
> The unused variable unmap_success has already been reported and
> dealt with.  But I couldn't tell what you intended: why change
> try_to_unmap()'s output, if you then ignore it?

Because some other callers of try_to_unmap() check the output.

>
> >  }
> >
> >  static void remap_page(struct page *page, unsigned int nr)
> > @@ -2718,7 +2717,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >       }
> >
> >       unmap_page(head);
> > -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
> > +     VM_BUG_ON_PAGE(total_mapcount(head), head);
>
> And having forced try_to_unmap() to do the expensive-on-a-THP
> total_mapcount() calculation, you now repeat it here.  Better
> to stick with the previous VM_BUG_ON_PAGE(!unmap_success).
>
> Or better a VM_WARN_ONCE(), accompanied by dump_page()s as before,
> to get some perhaps useful info out, which this patch has deleted.
> Probably better inside unmap_page() than cluttering up here.

Moving the BUG or WARN into unmap_page() looks fine to me. IIUC,
VM_BUG_ON_PAGE or VM_WARN_ON_PAGE does call dump_page(), so dumping
something useful is not deleted.

>
> VM_WARN_ONCE() because nothing in this patch fixes whatever Wang
> Yugui is suffering from; and (aside from the BUG()) it's harmless,
> because there are other ways in which the page_ref_freeze() can fail,
> and that is allowed for.  We would like to know when this problem
> occurs: there is something wrong, but no reason to crash.

Yes, it fixes nothing. I didn't figure out why try_to_unmap() failed.
I agree BUG_ON could be relaxed.

>
> >
> >       /* block interrupt reentry in xa_lock and spinlock */
> >       local_irq_disable();
> > @@ -2758,14 +2757,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >               __split_huge_page(page, list, end);
> >               ret = 0;
> >       } else {
> > -             if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> > -                     pr_alert("total_mapcount: %u, page_count(): %u\n",
> > -                                     mapcount, count);
> > -                     if (PageTail(page))
> > -                             dump_page(head, NULL);
> > -                     dump_page(page, "total_mapcount(head) > 0");
> > -                     BUG();
> > -             }
>
> This has always looked ugly (as if Kirill had hit an unsolved case),
> so it is nice to remove it; but you're losing the dump_page() info,
> and not really gaining anything more than a cosmetic cleanup.

As I mentioned above, IIUC VM_BUG_ON_PAGE and VM_WARN_ON_PAGE do call
dump_page().

>
> >               spin_unlock(&ds_queue->split_queue_lock);
> >  fail:                if (mapping)
> >                       xa_unlock(&mapping->i_pages);
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 693a610e181d..f52825b1330d 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1742,12 +1742,14 @@ static int page_not_mapped(struct page *page)
> >  }
> >
> >  /**
> > - * try_to_unmap - try to remove all page table mappings to a page
> > - * @page: the page to get unmapped
> > + * try_to_unmap - try to remove all page table mappings to a page and the
> > + *                compound page it belongs to
> > + * @page: the page or the subpages of compound page to get unmapped
> >   * @flags: action and flags
> >   *
> >   * Tries to remove all the page table entries which are mapping this
> > - * page, used in the pageout path.  Caller must hold the page lock.
> > + * page and the compound page it belongs to, used in the pageout path.
> > + * Caller must hold the page lock.
> >   *
> >   * If unmap is successful, return true. Otherwise, false.
> >   */
> > @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> >       else
> >               rmap_walk(page, &rwc);
> >
> > -     return !page_mapcount(page) ? true : false;
> > +     return !total_mapcount(page) ? true : false;
>
> That always made me wince: "return !total_mapcount(page);" surely.

But page_mapcount() seems not correct, it may return false positive,
right? Or it is harmless?

And I actually spotted a few other places which should use
total_mapcount() but using page_mapcount() instead, for example, some
madvise code check if the page is shared by using page_mapcount(),
however it may return false negative (double mapped THP, but head page
is not PTE-mapped, just like what Wang Yugui reported). It is not
fatal, but not expected behavior. I understand total_mapcount() is
expensive, so is it a trade-off between cost and correctness or just
overlooked the false negative case in the first place? I can't tell.

>
> Or slightly better, "return !page_mapped(page);", since at least that
> one breaks out as soon as it sees a mapcount.  Though I guess I'm
> being silly there, since that case should never occur, so both
> total_mapcount() and page_mapped() scan through all pages.
>
> Or better, change try_to_unmap() to void: most callers ignore its
> return value anyway, and make their own decisions; the remaining
> few could be changed to do the same.  Though again, I may be
> being silly, since the expensive THP case is not the common case.

I'd say half callers ignore its return value. But I think it should be
worth doing. At least we could remove half unnecessary
total_mapcount() or page_mapped() call.

Thanks a lot for all the suggestions, will incorporate them in the new version.

>
> >  }
> >
> >  /**
> > --
> > 2.26.2
