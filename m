Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFF336EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhCKJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCKJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:32:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E33C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9I8ygaaFUwUSiRg1sGOHfSuV4vrE4sCR9d4qE3JUt9Q=; b=NoTljWZI3JTNqBz09M904YeWwh
        nOf5h2+ddkImXms7dWtlDbA6oyfUqzHOQilfR4zMn4roVJDYBConJDogzde4dqqSjFeLmtQYOg1Zr
        ik+aBbpTyC+qld+wDVNkPD834hXBFwAZqTZu4o4aEfmS9XUJtZc7yKHPGy1IJYzgPanqhZMu5YVe7
        PTHoHvA3Hp5Cil8lyrKVLcSpYSc2B5MqoIZySmWi4sM+BIzQBm76/21zbu0B7Fk3dMDTc1moHKn5I
        7YE5oPeh8huT5Jn1RsDb8IEk7x1sK0obejn/B/u64XrKw7+f4igQ2OtX7vdlIem3ZjMjkaGOA+wPH
        rOYw3ifA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKHg9-008lJj-IL; Thu, 11 Mar 2021 09:32:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB4B03013E5;
        Thu, 11 Mar 2021 10:32:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABF6E299E3D28; Thu, 11 Mar 2021 10:32:24 +0100 (CET)
Date:   Thu, 11 Mar 2021 10:32:24 +0100
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
Message-ID: <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEncYrWCVn2/20/C@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:01:22AM +0100, Michal Hocko wrote:
> On Thu 11-03-21 09:46:30, Peter Zijlstra wrote:
> > On Wed, Mar 10, 2021 at 06:13:21PM -0800, Mike Kravetz wrote:
> > > from irq context.  Changing the check in the code from !in_task to
> > > in_atomic would handle the situations when called with irqs disabled.
> > 
> > It does not. local_irq_disable() does not change preempt_count().
> 
> You are right. Earlier I was suggesting to check of irq_disabled() as
> well http://lkml.kernel.org/r/YD4I+VPr3UNt063H@dhcp22.suse.cz
> 
> back then it was not really clear to me that in fact we do care about
> spin locks more than irq disabled code. I am not even sure whether we
> need to care about irq disabled regions without any locks held that
> wouldn't be covered by in_atomic. But it would be safer to add
> irq_disabled check as well.

Safer still is always doing it, replace it with if (true).

What's the purpose, doing the minimal 'correct', of the maximal safe
solution?

The whole changelog reads like a trainwreck, but akpm already commented
on that. I picked out a small factual incorrectness, simply because if
you can't get that right, the whole argument looses weight.

That said, I don't think you actually need it, if as you write the lock
should be IRQ-safe, then you're worried about the IRQ recursion
deadlock:


  spin_lock(&A);
  <IRQ>
	spin_lock(&A);


And that obviously cannot happen when IRQs are disabled, even if you
were holding a lock.


Anyway, I think I support Andrew here, this needs proper fixing, not
bandaids.


