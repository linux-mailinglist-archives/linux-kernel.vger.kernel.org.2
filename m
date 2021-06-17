Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B203AB5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhFQOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:23:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhFQOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF6E12FC;
        Thu, 17 Jun 2021 07:21:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83CBC3F719;
        Thu, 17 Jun 2021 07:21:16 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:20:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617142046.GA87858@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
 <20210617135133.GA86101@C02TD0UTHF1T.local>
 <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:00:26AM -0700, Andy Lutomirski wrote:
> 
> 
> On Thu, Jun 17, 2021, at 6:51 AM, Mark Rutland wrote:
> > On Thu, Jun 17, 2021 at 06:41:41AM -0700, Andy Lutomirski wrote:
> 
> > > In any event, I’m even more convinced that no new SYNC_CORE arches
> > > should be added. We need a new API that just does the right thing. 
> > 
> > My intuition is the other way around, and that this is a gnereally
> > useful thing for architectures that require context synchronization.
> 
> Except that you can't use it in a generic way.  You have to know the
> specific rules for your arch.

That's generally true for modifying instruction streams though? The man
page for cacheflush(2) calls out that it is not portable.

I think what's necessary here is some mandatory per-arch documentation?

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

Sure, and I called this case out specifically when I said:

|   * Where we can guarantee that a CPU cannot possibly have an
|     instruction in-flight (e.g. due to a lack of a mapping to fetch
|     instructions from), nothing is necessary. This is what we rely on
|     when faulting in code pages. In these cases, the CPU is liable to
|     take fault on the missing translation anyway.

.. what really matters is whether the CPU had the oppoprtunity to fetch
something stale; the context synchronization is necessary to discard
that.

Bear in mind that in many cases where this could occur in theory, we
don't hit in practice because CPUs don't happen to predict/speculate as
aggressively as they are permitted to. On arm/arm64 it's obvious that
this is a problem because the documentation clearly defines the
boundaries of what a CPU is permitted to do, whereas on other
architectures docuentation is not necessarily as clear whether this is
permited or whether the architecture mandates additional guarantees.

> We can and, IMO, should develop a sane way for user programs to
> install instructions into VMAs, for security-conscious software to
> verify them (by splitting the read and write sides?), and for their
> consumers to execute them, without knowing any arch details.  And I
> think this can be done with no IPIs except for possible TLB flushing
> when needed, at least on most architectures.  It would require a
> nontrivial amount of design work, and it would not resemble
> sys_cacheflush() or SYNC_CORE.

I'm not opposed to adding new interfaces for stuff like that, but I
don't think that membarrier(SYNC_CORE) or cacheflush(2) are necessarily
wrong as-is.

Thanks,
Mark.
