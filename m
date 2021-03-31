Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D173506D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhCaSwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhCaSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:51:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B00861057;
        Wed, 31 Mar 2021 18:51:47 +0000 (UTC)
Date:   Wed, 31 Mar 2021 14:51:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210331145145.0e3579fa@gandalf.local.home>
In-Reply-To: <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
References: <20210331092711.2b23fcff@gandalf.local.home>
        <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 10:45:01 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Mar 31, 2021 at 6:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >                 order = get_count_order(pg->size / ENTRIES_PER_PAGE);
> > -               free_pages((unsigned long)pg->records, order);
> > +               if (order >= 0)
> > +                       free_pages((unsigned long)pg->records, order);  
> 
> Honestly, looking at that code, every single use of
> "get_count_order()" seems really really confusing.
> 
> And really confused.
> 
> The comments are garbage, the code is odd, it's just all very very strange.
> 
> See here in ftrace_allocate_records():
> 
>         pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
>         order = get_count_order(pages);
> 
>         /*
>          * We want to fill as much as possible. No more than a page
>          * may be empty.
>          */
>         if (!is_power_of_2(pages))
>                 order--;
> 
> can you actually explain what the logic is here?
> 
> The 'get_count_order()' function will return the smallest order that
> the value fits in. But then if the value wasn't a power of two, you
> subtract 1. If I understand the code correctly, that's just the same
> as "what is the highest bit set", isn't it?
> 
> So afaik, what you *actually* want is just
> 
>         pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
>         order = fls(pages)-1;
> 
> isn't it?

I'll have to look at this a bit more, but this could be a new improvement
of the logic. The last one was: 

b40c6eabfcd40 ("ftrace: Simplify the calculation of page number for ftrace_page->records")

This happens once at boot up (and once for each module loaded) so I never
thought about making it efficient.

> 
> Did I misunderstand what the code wants to do? The "No more than a
> page may be empty" seems wrong - you really mean "no empty pages".

Yeah, that could be worded better.

> 
> I dunno. Maybe I'm wrong, but that code is really confusing (which is
> why I may be wrong). It doesn't seem to make any sense at all to use
> "get_count_order()" and then modify the end result.
> 

The basic idea is that we are allocating a group of pages for 10s
of thousands of records (one for every function being traced). The way the
records are stored is by "page group" (pg). It's a link list of pages
filled with records. The records are sorted by instruction pointer of the
functions they represent. There are times we need to quickly search for a
record and this is done by iterating the link list of page groups, and then
doing a binary search of the records in the pages that are there.

The more records you store in a single group, the faster this algorithm is
(more binary searches, less iterating a link list). But since these records
are permanently in the memory, we also do not want to allocate more than
needed to store the records. Now because pages are only allocated in powers
of two (1, 2, 4, 8, 16, ...) If it takes 5 pages to store all the records,
we don't want to allocate 8 pages for it. Instead we make a link list where
the first entry has 4 pages the second has 1.

In the dmesg on boot up, you'll see something like this:

 ftrace: allocating 42979 entries in 168 pages
 ftrace: allocated 168 pages with 3 groups


That shows that the link list is size of 3, and it used 168 pages to
store the 42,979 records.

What the logic above does is to figure out how many pages are needed to
store all the records. If the value is not a power of two (say 5 pages),
where the order would give use 8 pages. We subtract one from the order (to
give us 4 pages), and store what we can there. The next time around we only
allocate 1 page to store the rest of the records.

Your fls() trick might work too (have to gawk at it more). And I should fix
the comments. But any work on that would be for the next merge window, and
doesn't affect that this patch fixes a possible issue.

-- Steve
