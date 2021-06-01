Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D762B397B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhFAU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFAU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:29:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89847C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=30+VAi/gUQPHVAYLWEtLXg5TLFDkyPVFmvnpsxX/JzQ=; b=dDV+5DnwINpdtZzOYTur+fuRym
        6MtJdGy6ECAbBGEyCNEj/Xp9QP6Gr3a4caJ1gRGcJTCa47cQ75v+htJjPQmDeihgQLBgcmBd+lltw
        6f6xIHGOIEjf46QQazj5V0blO7hBZ5KnyNRZrpd/4pD3JU6jaVKyjHv6PZjfzkVIOVOfCH8FtQAg7
        D2os4RmDWFpR4fUy4hzL5KLM59LeVW0vuPNMYAAPav+Q0BCtfy66KxcEFBFMZ38jN4jFbNHtOA9Bv
        FPbp9/75Y751ihJOHxs66kYurSPEu7SNwVXwgqg/lSCI4kpUe3NzoFnwXh8mAne6DN0e0YGThswwn
        dRo9Vmtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loAym-00APTG-DK; Tue, 01 Jun 2021 20:27:19 +0000
Date:   Tue, 1 Jun 2021 21:27:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.dg@linux.alibaba.com, Greg Thelen <gthelen@google.com>,
        Wei Xu <weixugc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
Message-ID: <YLaYIAeNUlitUy0z@casper.infradead.org>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
 <YLZqKJ4anEGpAZfp@casper.infradead.org>
 <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 12:10:48PM -0700, Hugh Dickins wrote:
> On Tue, 1 Jun 2021, Matthew Wilcox wrote:
> > On Tue, Jun 01, 2021 at 09:55:56AM -0700, Hugh Dickins wrote:
> > > 
> > > Well caught: you're absolutely right that there's a bug there.
> > > But isn't cond_resched() just papering over the real bug, and
> > > what it should do is a "page = compound_head(page);" before the
> > > get_page_unless_zero()? How does that work out in your testing?
> > 
> > You do realise you're strengthening my case for folios by suggesting
> > that, don't you?  ;-)
> 
> Hah! Well, I do realize that I'm offering you a marketing opportunity.
> And you won't believe how many patches I dread to post for fear of that ;-)
> 
> But I'm not so sure that it strengthens your case: apparently folios
> had not detected this?  Or do you have a hoard of folio-detected fixes
> waiting for the day, and a folio-kit for each of the stable releases?

Oh, I wish!  I haven't been working on converting the
migration code to use folios.  If I'd taken the step to convert
put_and_wait_on_page_locked() to folio_put_and_wait_locked(), I would
have fixed the bug, but I'm not sure I would have noticed that it was
fixing a bug.  I would have probably converted migration_entry_to_page()
to be migration_entry_to_folio() and just inadvertently fixed it.

> > I was going to suggest that it won't make any difference because the
> > page reference count is frozen, but the freezing happens after the call
> > to unmap_page(), so it may make a difference.
> 
> I think that's a good point: I may have just jumped on the missing
> compound_head(), without thinking it through as far as you have.
> 
> I'm having trouble remembering the dynamics now; but I think there
> are cond_resched()s in the unmap_page() part, so the splitter may
> get preempted even on a non-preempt kernel; whereas the frozen
> part is all done expeditiously, with interrupts disabled.

That would certainly make a difference.

