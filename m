Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68653336F57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhCKJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhCKJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:53:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSqh2AE8rvBwoDNCIlwIFAxfELtqU/iPz0j7NKjcDuI=; b=XOKBHtSlebtELpG/48aZcF7Y0/
        jzcIp+dC0dtJo7fvJVrXpKoOYnrZz41SgG493jDpqTkhJ3MsZgrYDx75a2W1zfM5hye93CtVQJrh8
        P5+uCNSbQlUA58raX9tuWvtsiJeqJN+hlS3gIsGtMT++uzsaV1+2duBxrmq2rIAch5WCyl580tEwB
        elYANyjZWH/4EcNE9fYlL87RrGTim09Fpn534SyK4tF7VGPN9tBecC8d6gmIpKFWIMxEkYoe7LJFJ
        X6f43+8pUdpW3ebE4129s58ePYDlaiVo1G3eAfui3G7RuZ555Eh1Mztjh54yPnbpD8Axl6x3YJnnP
        1I5H6+4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKHzv-0075gj-AN; Thu, 11 Mar 2021 09:52:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28C85300455;
        Thu, 11 Mar 2021 10:52:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1270D299EE417; Thu, 11 Mar 2021 10:52:50 +0100 (CET)
Date:   Thu, 11 Mar 2021 10:52:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:44:56AM +0100, Michal Hocko wrote:
> On Thu 11-03-21 10:32:24, Peter Zijlstra wrote:
> > The whole changelog reads like a trainwreck, but akpm already commented
> > on that. I picked out a small factual incorrectness, simply because if
> > you can't get that right, the whole argument looses weight.
> 
> Is there any reason why in_atomic || irq_disabled wouldn't work
> universally?

I just explained to you how you really wanted:

  in_atomic() && !irq_disabled()

> > That said, I don't think you actually need it, if as you write the lock
> > should be IRQ-safe, then you're worried about the IRQ recursion
> > deadlock:
> 
> making hugetlb_lock irqsafe is a long way as explained by Mike
> elsewhere. Not only that. The upcoming hugeltb feature to have sparse
> vmemmap for hugetlb pages will need to allocate vmemmap when hugetlb
> page is to be freed back to the allocator. That cannot happen in any
> atomic context so there will be a need to tell those contexts for
> special casing.

Then scrap the vmemmap code *NOW*. Do not merge more shit before fixing
existing problems. Especially not if that's known to make it harder to
fix the problems.

