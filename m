Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40738D1E0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhEUXTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEUXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:19:01 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:17:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id m13so16495145qtk.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=agt0Suc2aHA8tAAlCd1Y+aPc288Wv9k1YGDz6WZK9U0=;
        b=X6gFIbrkt5aY2TtZF1JquoJxZIMSApOGRb9MX4LR36hKSCXr5hLVC9qYaalIB6yTY3
         KOnINQ01B6WDcTZFi2FWuxsRHkINuJ2XLoDZWgokrXp+bmrL/Fo0vi6V3RFMw9TO/rb9
         rB1IlkU+202VDrxc/Tu/DrjCMYYmynXy/cQTUT9MvexpQRNJb7M5vCRW8z2PA5Q/BN4m
         kGFPmZ9VtHjv8GgVkXOIVyYt1Q7tZsgQdRE5Kx9fpMZ6wtX6ZuKsgiswRFR0jJkQOjLR
         4iEguUo7cdFpo4zrI5TOT77HfYXBPlAou3ezJoP96Ivev4c4wkpDlG0jxAvSQ9iafb2H
         SiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=agt0Suc2aHA8tAAlCd1Y+aPc288Wv9k1YGDz6WZK9U0=;
        b=QhERdAWIQex/rcUx5QcwqbfC8Wh0k5QDn2qzGUMhLcVbzXaJbgLjMI+wMOaQDBF6wj
         UgIYDLyXS9aqGtmr3N54XQWafjEC+/YuafD+iI7QGxdMvXi/qhKXMg4U8ZbIDuWi0U4A
         47AA5khwDgL3zcCgCGaz2seQfONzl9sUkDImAKZ3Z4OD9XjAC5p81cl5XGNHPsXChzYh
         nHkYrpXBTEBi+DFzqYctDpA0HxRrI0KSWCEeSziIxJU1mOscyfWap5cbE6229x7RoSDd
         NyCDdIGVouzq+Zs+FjADs7mdmXgNIeJSCoRN9ORzjpTpvP/pTGerY/27QhmCNGjA2uQ3
         a/HA==
X-Gm-Message-State: AOAM533qajaWOM+nwP5TV86l+CD+T0KRLRNnEDyt4DMm7wCjfbL5C0JT
        oq+jaBZZEbzAiWRaxnpixs+iAQ==
X-Google-Smtp-Source: ABdhPJzksLBufW+6f3XAO1nlAA1+9buSI0lF1XxC1TSwW56FNInjrfJTk88ecMHtlM1Dz/4G0GReKA==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr14255350qtx.145.1621639055227;
        Fri, 21 May 2021 16:17:35 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k9sm6268735qkh.11.2021.05.21.16.17.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 21 May 2021 16:17:34 -0700 (PDT)
Date:   Fri, 21 May 2021 16:17:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: thp: check total_mapcount instead of
 page_mapcount
In-Reply-To: <CAHbLzkpWzs-ym2wS3r9g8gw+wTRoKQD_4rNmdCRjWQjJ981awA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2105211521170.8734@eggly.anvils>
References: <20210513212334.217424-1-shy828301@gmail.com> <alpine.LSU.2.11.2105202120220.6466@eggly.anvils> <CAHbLzkpipqwZQfmJe0t3MxfPW-RvG8wXerffBqrUxZb3OHccGg@mail.gmail.com> <CAHbLzkpWzs-ym2wS3r9g8gw+wTRoKQD_4rNmdCRjWQjJ981awA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Yang Shi wrote:
> On Fri, May 21, 2021 at 10:16 AM Yang Shi <shy828301@gmail.com> wrote:
> > On Thu, May 20, 2021 at 10:06 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Thu, 13 May 2021, Yang Shi wrote:
> > >
> > > > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > > > return false positive for PTE-mapped THP since page_mapcount() is used
> > > > to check if the THP is unmapped, but it just checks compound mapount and
> > > > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > > > mapped, it may return false positive.
> > > >
> > > > Use total_mapcount() instead of page_mapcount() for try_to_unmap() and
> > > > do so for the VM_BUG_ON_PAGE in split_huge_page_to_list as well.
> > > >
> > > > This changed the semantic of try_to_unmap(), but I don't see there is
> > > > any usecase that expects try_to_unmap() just unmap one subpage of a huge
> > > > page.  So using page_mapcount() seems like a bug.
> > > >
> > > > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >
> > > I don't object to this patch, I've no reason to NAK it; but I'll
> > > point out a few deficiencies which might make you want to revisit it.
> > >
> > > > ---
> > > > v2: Removed dead code and updated the comment of try_to_unmap() per Zi
> > > >     Yan.
> > > >
> > > >  mm/huge_memory.c | 11 +----------
> > > >  mm/rmap.c        | 10 ++++++----
> > > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 63ed6b25deaa..3b08b9ba1578 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2348,7 +2348,6 @@ static void unmap_page(struct page *page)
> > > >               ttu_flags |= TTU_SPLIT_FREEZE;
> > > >
> > > >       unmap_success = try_to_unmap(page, ttu_flags);
> > > > -     VM_BUG_ON_PAGE(!unmap_success, page);
> > >
> > > The unused variable unmap_success has already been reported and
> > > dealt with.  But I couldn't tell what you intended: why change
> > > try_to_unmap()'s output, if you then ignore it?
> >
> > Because some other callers of try_to_unmap() check the output.

memory-failure.c and one in vmscan.c: most callers are not interested,
so replacing a quick atomic_read by a scan of 512 struct pages is not
necessarily a good idea. But I am exaggerating, it's not usually that
bad: probably most of those callers will rarely encounter a THP.

> >
> > >
> > > >  }
> > > >
> > > >  static void remap_page(struct page *page, unsigned int nr)
> > > > @@ -2718,7 +2717,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> > > >       }
> > > >
> > > >       unmap_page(head);
> > > > -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
> > > > +     VM_BUG_ON_PAGE(total_mapcount(head), head);
> > >
> > > And having forced try_to_unmap() to do the expensive-on-a-THP
> > > total_mapcount() calculation, you now repeat it here.  Better
> > > to stick with the previous VM_BUG_ON_PAGE(!unmap_success).
> > >
> > > Or better a VM_WARN_ONCE(), accompanied by dump_page()s as before,
> > > to get some perhaps useful info out, which this patch has deleted.
> > > Probably better inside unmap_page() than cluttering up here.
> >
> > Moving the BUG or WARN into unmap_page() looks fine to me. IIUC,
> > VM_BUG_ON_PAGE or VM_WARN_ON_PAGE does call dump_page(), so dumping
> > something useful is not deleted.

Yes, you're right, I was forgetting that. The original DEBUG_VM block
does do a separate dump_page() for head and tail (if different), but
I don't think you need to replicate that now: (a) it was more a mark
of frustration at not getting enough info to solve the problem (and
if we really want more info, it's a dump of 512 struct pages needed);
and (b) I think Matthew and others have enhanced dump_page() meanwhile,
to issue some head info when dumping a tail; and (c) most splitters
pass the head anyway, IIRC there's only one or two who pass a tail.

> 
> I misspelled the function name. There is *NOT* VM_WARN_ON_PAGE(), the
> name is VM_WARN_ON_ONCE_PAGE(). We may need to add VM_WARN_ON_PAGE()
> since I'd like this warning to be printed every time when it is met.

I get very confused by all those variants too; and then indeed very
often the one variant you think you want turns out not to exist yet.

But I'm not sure that printing it every time will be good: isn't it
quite likely that the situation is long-lasting, and that the page
is on the anon deferred or shmem unused list, and will keep coming
back to report the same unhelpful info, just cluttering up the logs?
I'd be more comfortable with _ONCE myself.

But I'd also suggest dropping the VM_ part of it: we have no idea
how often this happens on non-DEBUG_VM machines in production,
and a pattern might be revealed there which would help to solve it.

> 
> >
> > >
> > > VM_WARN_ONCE() because nothing in this patch fixes whatever Wang
> > > Yugui is suffering from; and (aside from the BUG()) it's harmless,
> > > because there are other ways in which the page_ref_freeze() can fail,
> > > and that is allowed for.  We would like to know when this problem
> > > occurs: there is something wrong, but no reason to crash.
> >
> > Yes, it fixes nothing. I didn't figure out why try_to_unmap() failed.
> > I agree BUG_ON could be relaxed.

I have to confess, I have known of several reasons why one or other
of those BUG()s can be hit. Sigh. I'll rearrange priorities, research
back through what work I've done and not had time to upstream, filter
out the patches relevant to this "mysterious failure to unmap a THP".

I did not speak up earlier because I did not notice any obvious
connection between Wang Yugui's occurrence, and anything we have
fixed; and (as usual) there's other work I should be doing.  But
it's getting to feel dishonest, having this conversation without
showing our fixes: I'd better sort those out and post (but that
will take me more than a week I expect).

Not saying that you should stop with this patch at all:
no, I can easily rebase on top of what you end up with here.

> >
> > >
> > > >
> > > >       /* block interrupt reentry in xa_lock and spinlock */
> > > >       local_irq_disable();
> > > > @@ -2758,14 +2757,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> > > >               __split_huge_page(page, list, end);
> > > >               ret = 0;
> > > >       } else {
> > > > -             if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> > > > -                     pr_alert("total_mapcount: %u, page_count(): %u\n",
> > > > -                                     mapcount, count);
> > > > -                     if (PageTail(page))
> > > > -                             dump_page(head, NULL);
> > > > -                     dump_page(page, "total_mapcount(head) > 0");
> > > > -                     BUG();
> > > > -             }
> > >
> > > This has always looked ugly (as if Kirill had hit an unsolved case),
> > > so it is nice to remove it; but you're losing the dump_page() info,
> > > and not really gaining anything more than a cosmetic cleanup.
> >
> > As I mentioned above, IIUC VM_BUG_ON_PAGE and VM_WARN_ON_PAGE do call
> > dump_page().
> >
> > >
> > > >               spin_unlock(&ds_queue->split_queue_lock);
> > > >  fail:                if (mapping)
> > > >                       xa_unlock(&mapping->i_pages);
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index 693a610e181d..f52825b1330d 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -1742,12 +1742,14 @@ static int page_not_mapped(struct page *page)
> > > >  }
> > > >
> > > >  /**
> > > > - * try_to_unmap - try to remove all page table mappings to a page
> > > > - * @page: the page to get unmapped
> > > > + * try_to_unmap - try to remove all page table mappings to a page and the
> > > > + *                compound page it belongs to
> > > > + * @page: the page or the subpages of compound page to get unmapped
> > > >   * @flags: action and flags
> > > >   *
> > > >   * Tries to remove all the page table entries which are mapping this
> > > > - * page, used in the pageout path.  Caller must hold the page lock.
> > > > + * page and the compound page it belongs to, used in the pageout path.
> > > > + * Caller must hold the page lock.
> > > >   *
> > > >   * If unmap is successful, return true. Otherwise, false.
> > > >   */
> > > > @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > > >       else
> > > >               rmap_walk(page, &rwc);
> > > >
> > > > -     return !page_mapcount(page) ? true : false;
> > > > +     return !total_mapcount(page) ? true : false;
> > >
> > > That always made me wince: "return !total_mapcount(page);" surely.
> >
> > But page_mapcount() seems not correct, it may return false positive,
> > right? Or it is harmless?

I wasn't disagreeing with your use of total_mapcount() in that comment,
just with your propagating the "return boolean() ? true : false" style.

> >
> > And I actually spotted a few other places which should use
> > total_mapcount() but using page_mapcount() instead, for example, some
> > madvise code check if the page is shared by using page_mapcount(),
> > however it may return false negative (double mapped THP, but head page
> > is not PTE-mapped, just like what Wang Yugui reported). It is not
> > fatal, but not expected behavior. I understand total_mapcount() is
> > expensive, so is it a trade-off between cost and correctness or just
> > overlooked the false negative case in the first place? I can't tell.

I haven't looked through those other places. I do agree with you that
total_mapcount() or page_mapped() is likely to be more correct in most
instances, but it's often more costly than it's worth (on THPs).

And you've reminded me that some months back, Andrea pointed out how
total_mapcount() can race with something, and give the wrong answer:
he was arguing against relying on it (but has patches with additional
locking to make it more reliable - though that gets more complicated).

In Google prod actually, we have mostly avoided using total_mapcount(),
merely because I feared the cost and couldn't convince myself of its
safety - I'm not saying I ever saw it go wrong, I just didn't feel
comfortable relying on it. Maybe that's part of what I need to post
after sifting through.

Hugh

> >
> > >
> > > Or slightly better, "return !page_mapped(page);", since at least that
> > > one breaks out as soon as it sees a mapcount.  Though I guess I'm
> > > being silly there, since that case should never occur, so both
> > > total_mapcount() and page_mapped() scan through all pages.
> > >
> > > Or better, change try_to_unmap() to void: most callers ignore its
> > > return value anyway, and make their own decisions; the remaining
> > > few could be changed to do the same.  Though again, I may be
> > > being silly, since the expensive THP case is not the common case.
> >
> > I'd say half callers ignore its return value. But I think it should be
> > worth doing. At least we could remove half unnecessary
> > total_mapcount() or page_mapped() call.
> >
> > Thanks a lot for all the suggestions, will incorporate them in the new version.
> >
> > >
> > > >  }
> > > >
> > > >  /**
> > > > --
> > > > 2.26.2
