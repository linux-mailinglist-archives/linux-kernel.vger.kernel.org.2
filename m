Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4836E3AB55D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhFQOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFQOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:08:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OM5P5xBbthYbL75jxvFs5uaCgdAcSHR4gEDRFZu/D28=; b=hNEIGS3JdsLyvgPzIYnV9sH1vb
        M1ICBIC5aSRoXC09K1dGYd9S6ApQ4/UMNBrxMe5qvmbMP65UYYDl5Y6xP8DddyiatT+Bx9JrqQYO2
        l3fqZsujFsFGECxy9h/XhbcrNJMOXax8QoJ0SfLEHFV+RgwV0Z971DBGHseQ39hfgc2MUief50Zoo
        Nb5aPExY0yfSAx/L5/+NH/AXwOeahwU4nFiiUzN4498GsT+gcwET1xzod0C1hXhPO+1UWtbvq2iE5
        xDr0GGOt03+HlUAWVAq5GiKUO9fF+EPW6cc3gX5qTzmHqGWETCDm9bbSlAL2KrwumlXWBFqkEaOq+
        QVT0tqaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltsdm-009CPL-JG; Thu, 17 Jun 2021 14:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 180873001DB;
        Thu, 17 Jun 2021 16:05:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D52342C072F49; Thu, 17 Jun 2021 16:05:03 +0200 (CEST)
Date:   Thu, 17 Jun 2021 16:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <YMtWj/y4Hc0CeCux@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:41:41AM -0700, Andy Lutomirski wrote:
> On Thu, Jun 17, 2021, at 4:33 AM, Mark Rutland wrote:

> > Sure, and I agree we should not change cacheflush().
> > 
> > The point of membarrier(SYNC_CORE) is that you can move the cost of that
> > ISB out of the fast-path in the executing thread(s) and into the
> > slow-path on the thread which generated the code.
> > 
> > So e.g. rather than an executing thread always having to do:
> > 
> > 	LDR	<reg>, [<funcptr>]
> > 	ISB	// in case funcptr was just updated
> > 	BLR	<reg>
> > 
> > ... you have the thread generating the code use membarrier(SYNC_CORE)
> > prior to plublishing the funcptr, and the fast-path on all the executing
> > threads can be:
> > 
> > 	LDR	<reg> [<funcptr>]
> > 	BLR	<reg>
> > 
> > ... and thus I think we still want membarrier(SYNC_CORE) so that people
> > can do this, even if there are other means to achieve the same
> > functionality.
> 
> I had the impression that sys_cacheflush() did that.  Am I wrong?

Yes, sys_cacheflush() only does what it says on the tin (and only
correctly for hardware broadcast -- everything except 11mpcore).

It only invalidates the caches, but not the per CPU derived state like
prefetch buffers and micro-op buffers, and certainly not instructions
already in flight.

So anything OoO needs at the very least a complete pipeline stall
injected, but probably something stronger to make it flush the buffers.

> In any event, I’m even more convinced that no new SYNC_CORE arches
> should be added. We need a new API that just does the right thing. 

I really don't understand why you hate the thing so much; SYNC_CORE is a
means of injecting whatever instruction is required to flush all uarch
state related to instructions on all theads (not all CPUs) of a process
as efficient as possible.

The alternative is sending signals to all threads (including the
non-running ones) which is known to scale very poorly indeed, or, as
Mark suggests above, have very expensive instructions unconditinoally in
the instruction stream, which is also undesired.

