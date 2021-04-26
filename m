Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0F36AF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhDZIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhDZIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:05:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7054C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y5t7GfabIQkYUOC7rXCJ5vSKsR16bmBoHXARMBq1Utg=; b=INtVdGN6z+FGh9cuwsOY+rpnsx
        J4ZLDRBP49XDRBSx3Eq4zivVV0r5IFmq6OMIyaphDsUsEJqDDAG5Wa6ZVIStsvEk2CyQODACGGEZ+
        PtrhV6WSqopTpw4X0YSz8k1VmPVxqbrC9uZVr8l8oGJzfnG76ukP9ZtBnHNRbSBTd/9lk2BZyYh3x
        SmNrcDJMghRyWw1DnD3b4+AVyrFXw26daiDLT/3rZqWLaveQcEokFiWRP1enka5bbXNOoIitCONpG
        Wml4DCb1B6XLNs5F40ZpgZzHQT9iZ4rXtHjZMoUcyhcbwaINZ+dp4idHU/KqsG76n5h+opWj3FP/I
        AcbHMfUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lawEZ-005Ldr-C8; Mon, 26 Apr 2021 08:04:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02695300212;
        Mon, 26 Apr 2021 10:04:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6AAE2C988F3B; Mon, 26 Apr 2021 10:04:45 +0200 (CEST)
Date:   Mon, 26 Apr 2021 10:04:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] locking/urgent for v5.12
Message-ID: <YIZ0HZGqLvU+VlYh@hirez.programming.kicks-ass.net>
References: <YIU4005K55S20FU1@zn.tnic>
 <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
 <CAHk-=wi2NEfJmgZbqHL43a2rsWuc7Oyb5kfiz9x8z+S-juL7-w@mail.gmail.com>
 <9017e7b9-cd6e-caa1-b8ba-8d85f4a5d87e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9017e7b9-cd6e-caa1-b8ba-8d85f4a5d87e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 01:06:52PM -0400, Waiman Long wrote:
> On 4/25/21 12:39 PM, Linus Torvalds wrote:

> > > I'm assuming it's because of the switch to try_cmpxchg by PeterZ?
> 
> Yes, try_cmpxchg() requires a variable to hold the new value as well as a
> place to return the actual value before the cmpxchg(). It is just the way
> try_cmpxchg() works.

Right; by virtue of it returning a boolean, the value return needs to be
through a pointer argument.


> > > New confusion:
> > >   - Why is the truly non-critical cmpxchg using "try_cmpxhg()", when
> > >     the _first_ cmpxchg - above the loop - is not?

> At least for x86, try_cmpxchg() seems to produce a slight better assembly
> code than the regular cmpxchg(). I guess that may be one of the reason Peter
> changed it to use try_cmpxchg(). Another reason that I can think of is to
> make the code fit in one line instead of splitting it up into two lines like
> the original version from Ali.

Right, x86 generates slightly better asm (and potentially so for any
architecture that has CAS state in condition codes) while it's a wash
for other architectures (specifically we checked at the time arm64
didn't generate worse code).

> > > 
> > > Pre-existing confusion:
> > >   - Why is the code using "atomic_add()" to set a bit?
> > > 
> > > Yeah, yeah, neither of these are *bugs*, but Christ is that code hard
> > > to read. The "use add to set a bit" is valid because of the spinlock
> > > serialization (ie only one add can ever happen), and the
> > > cmpxchg-vs-try_cmpxchg confusion isn't buggy, it's just really really
> > > confusing that that same function is using two different - but
> > > equivalent - cmpxchg things on the same variable literally a couple of
> > > lines apart.
> As you have said, the spinlock serialization makes sure that only 1 writer
> is allowed to do that. I agree that using atomic_or() looks better in this
> case. Both of them are equivalent in this particular case.

Agreed, I think the reason is that because of the read-side doing the
BIAS add/sub, some of that snuck into the write side. AFAIK no arch
lacks the atomic_or() intrinsic. The one that's often an issue is
atomic_fetch_or() (x86 for one doesn't have it :/).

> > > I've pulled this, but can we please
> > > 
> > >   - make *both* of the cmpxchg's use "try_cmpxchg()" (and thus that
> > >     "cnts" variable)?
> Yes, we can certainly change the other cmpxchg() to try_cmpxchg().
> > > 
> > >   - add a comment about _why_ it's doing "atomic_add()" instead of the
> > >     much more logical "atomic_or()", and about how the spinlock serializes
> > >     it
> > > 
> > > I'm assuming the "atomic_add()" is simply because many more
> > > architectures have that as an actual intrinsic atomic. I understand.
> > > But it's really really not obvious from the code.
> > > 
> I will post a patch to make the suggested change to qrwlock.c.

Thanks.
