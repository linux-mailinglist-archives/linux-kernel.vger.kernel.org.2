Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58279422C27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhJEPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:17:31 -0400
Received: from casper.infradead.org ([90.155.50.34]:50894 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJEPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:17:30 -0400
X-Greylist: delayed 2364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 11:17:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DP4p9r8h1C8ORsFq/fmU8NTA1a+WhCICD8nBr3Eu4yM=; b=J1sZTQ4Iy7+8UFwOyqGi1PeCKm
        nRYEmJRyXn5PDSMjIz3yoH/jb03O4Oga99W0p1C32cHA4PP7OQepg9ic+eY5CRHTWBzhf2lsJZoKo
        oQ1LNyaNlpiiMzxb0yOUwr/6AVNFpv0TR6bPvlaEp0DFZqJEEyHeRe5YCelj4TwvZ2Dw35YaG9zNA
        PKkZR7kNJ/zwjpWe902pwLRg3bVpZQio/SC8nc5tnk9gpc0F9JUtY6Ibqfk0Vl7SZeZU2y9UAtX/r
        tHlbQe4QWKyav6lJk1g7KTNVAidM5h74YLyYRRWZ+PHiY7U+SnMz5CgAmnUQqxOLhTPWpjovsqyny
        SLNp7R1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXlUb-0000LR-1n; Tue, 05 Oct 2021 14:32:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A65530026F;
        Tue,  5 Oct 2021 16:32:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22FA921339B6E; Tue,  5 Oct 2021 16:32:28 +0200 (CEST)
Date:   Tue, 5 Oct 2021 16:32:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVxh/NE2me6ueCNP@hirez.programming.kicks-ass.net>
References: <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <YUxx42W3K2Ur7W84@lorien.usersys.redhat.com>
 <YVwqphxxNSDL828Y@hirez.programming.kicks-ass.net>
 <YVxdPGj92+FcVrgt@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxdPGj92+FcVrgt@lorien.usersys.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:12:12AM -0400, Phil Auld wrote:
> On Tue, Oct 05, 2021 at 12:36:22PM +0200 Peter Zijlstra wrote:
> > On Thu, Sep 23, 2021 at 08:24:03AM -0400, Phil Auld wrote:
> > 
> > > It's capped at 8 cpus, which is pretty easy to reach these days, so the
> > > values don't get too large.  That scaling is almost a no-op these days.
> > 
> >   https://lkml.kernel.org/r/YVwdrh5pg0zSv2/b@hirez.programming.kicks-ass.net
> > 
> > Ooh, hey, we already fixed that :-)
> >
> 
> Thanks Peter.
> 
> I'm always a little behind upstream (nature of the job :)
> 
> That link leads to a message Id not found.

https://lore.kernel.org/all/YVwblBZ9JBn9vvVr@hirez.programming.kicks-ass.net/T/#u

Seems to work, I must've messed up the copy/paste or something.

> But from what I can see the code that takes the min of online cpus and
> 8 is still present. 

Yes, and it should be. I was the confused one. I forgot we added it and
suggested we should add it again :-)

> > So the reasoning there is that if the values get too big, interactiviy
> > get *really* bad, but if you go from say 1 to 4 CPUs, interactivity can
> > improve due to being able to run on other CPUs.
> > 
> > At 8 CPUs we end up at 6ms*4=24ms, which is already pretty terrible.
> > 
> 
> And actually you mention the same thing later on.  Most systems, even
> desktops, have 8+ cpus these days so the scaling is mostly not doing
> anything except multiplying by 4, right? So no-op was not the right
> way to describe it maybe. But it's not getting bigger with larger
> numbers of cpus beyond a pretty commonly reached limit.

Yeah, the whole scaling thing is of dubious value these days, the whole
1-8 range is for embedded stuff these days, I mean, only low-end phones
are maybe even still in that range -- oh and my laptop.. :/


