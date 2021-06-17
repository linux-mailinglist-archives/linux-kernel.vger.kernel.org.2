Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91573AB6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhFQPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFQPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:05:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745EEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KX8gk6ZCpqOC9nSWaqvOCHcylVovoN9q1sfHRCr4AO4=; b=TQhZXMBCxo6OqEwuNBxuB4jzyQ
        ihW5/nuSgPzxb5nDabSP6Izlg1MYt/879HJH7Od4DGdiT7/dt/tf2BlesZpz21FgW+sPSZOffB0BG
        DtLaAe3nf1CNfSAX5qKf7LtqGxS2G6bRUz3+ERRJfdNXRgvF2Vr/2ZhG0zEsZy+HNlZhybvB2g2rl
        HL43muztl0ALPQgQcjj9VydyJlSSV7yJ4+cA/3BgZd0bVAZ1+yUtyDOFGkOIn0jhdn3vtOLbuL+MS
        VdhSFkkpR2uU/FRcwRFC25C7jCgsWw8uhiG1b6ZcE7pLHlgXrOBGCbLeuWRn3urxajOo1LfbYO6dQ
        oUHMcRWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lttWk-009FwM-7Q; Thu, 17 Jun 2021 15:02:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 648DD300252;
        Thu, 17 Jun 2021 17:01:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 473772BD52F30; Thu, 17 Jun 2021 17:01:53 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:01:53 +0200
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
Message-ID: <YMtj4Xoo5lh4fGSx@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
 <20210617135133.GA86101@C02TD0UTHF1T.local>
 <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:00:26AM -0700, Andy Lutomirski wrote:
> On Thu, Jun 17, 2021, at 6:51 AM, Mark Rutland wrote:

> > It's not clear to me what "the right thing" would mean specifically, and
> > on architectures with userspace cache maintenance JITs can usually do
> > the most optimal maintenance, and only need help for the context
> > synchronization.
> > 
> 
> This I simply don't believe -- I doubt that any sane architecture
> really works like this.  I wrote an email about it to Intel that
> apparently generated internal discussion but no results.  Consider:
> 
> mmap(some shared library, some previously unmapped address);
> 
> this does no heavyweight synchronization, at least on x86.  There is
> no "serializing" instruction in the fast path, and it *works* despite
> anything the SDM may or may not say.

I'm confused; why do you think that is relevant?

The only way to get into a memory address space is CR3 write, which is
serializing and will flush everything. Since there wasn't anything
mapped, nothing could be 'cached' from that location.

So that has to work...

> We can and, IMO, should develop a sane way for user programs to
> install instructions into VMAs, for security-conscious software to
> verify them (by splitting the read and write sides?), and for their
> consumers to execute them, without knowing any arch details.  And I
> think this can be done with no IPIs except for possible TLB flushing
> when needed, at least on most architectures.  It would require a
> nontrivial amount of design work, and it would not resemble
> sys_cacheflush() or SYNC_CORE.

The interesting use-case is where we modify code that is under active
execution in a multi-threaded process; where CPU0 runs code and doesn't
make any syscalls at all, while CPU1 modifies code that is visible to
CPU0.

In that case CPU0 can have various internal state still reflecting the
old instructions that no longer exist in memory -- presumably.

We also need to inject at least a full memory barrier and pipeline
flush, to create a proper before and after modified. To reason about
when the *other* threads will be able to observe the new code.

Now, the SDM documents that prefetch and trace buffers are not flushed
on i$ invalidate (actual implementations might of course differ) and
doing this requires the SERIALIZE instruction or one of the many
instructions that implies this, one of which is IRET.

For the cross-modifying case, I really don't see how you can not send an
IPI and expect behavour one can reason about, irrespective of any
non-coherent behaviour.

Now, the SDM documents non-coherent behaviour and requires SERIALIZE,
while at the same time any IPI already implies IRET which implies
SERIALIZE -- except some Luto guy was having plans to optimize the IRET
paths so we couldn't rely on that.
