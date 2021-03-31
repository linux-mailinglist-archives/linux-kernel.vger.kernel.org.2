Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70822350722
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhCaTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235869AbhCaTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:03:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3B761073;
        Wed, 31 Mar 2021 19:03:16 +0000 (UTC)
Date:   Wed, 31 Mar 2021 15:03:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210331150315.6c38f333@gandalf.local.home>
In-Reply-To: <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
References: <20210331092711.2b23fcff@gandalf.local.home>
        <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
        <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 11:03:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I found another bug in there, for example:
> 
>                 ftrace_number_of_pages -= 1 << order;
> 
> is also wrong if order is negative.

True, but ftrace_number_of_pages is only used for accounting (used to
display the number of pages at boot up and the number in
/sys/kernel/tracing/dyn_ftrace_total_info). If order is negative, this
value could be used to debug what went wrong ;-)


> Doesn't this make the code now make SENSE? Instead of that
> incomprehensible mess it was before?

I'll look into it. This code has been there since pretty much the beginning
and slowly "grew". It suffered the thousand cuts, instead of going in and
doing surgery on making it clean. It hasn't changed in a long time, so it's
due for a clean up as I believe it's in a stable state now.

> 
> I dunno. Maybe it's just my "pee in the snow" thing, but honestly, the
> fact that I seem to have found another bug wrt the whole
> 'ftrace_number_of_pages' handling really says that the code was
> garbage.

Again, that variable was just used to see what the page count was. It was
never used for any logic.

> 
> And maybe it's just me who doesn't understand the subtle perfection of
> the old code, and I'm being stupid. Feel free to educate me about it.
> 
> Final note: note the "TOTALLY UNTESTED" part of the patch. The patch
> CompilesForMe(tm), but please consider it a "how about something like
> this" rather than anything finished.
> 
> Also note that I did *not* change the initial "order" calculation
> itself in ftrace_allocate_records() in this patch. I left that
> particular oddity alone. Again, I *think* the math just ends up being
> 
>         pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
>         order = fls(pages)-1;
> 
> but the attached patch is not about that, it's about the crazy "pg->size" games.
> 
>             Linus
> 
> PS. TOTALLY UNTESTED!!

Thanks, I'll look at it and see if it doesn't break anything, or if it can
be easily modified to not break anything.

-- Steve
