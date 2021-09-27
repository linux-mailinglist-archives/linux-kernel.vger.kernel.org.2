Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8A419135
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhI0JAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:00:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233594AbhI0JAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:00:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D531D6E;
        Mon, 27 Sep 2021 01:59:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B903F70D;
        Mon, 27 Sep 2021 01:59:10 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:58:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <20210927085837.GA1131@C02TD0UTHF1T.local>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
 <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
 <20210921153352.GC35846@C02TD0UTHF1T.local>
 <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
 <20210921162804.GD35846@C02TD0UTHF1T.local>
 <944ef479f1104c4a97d0e3f629a9b765@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944ef479f1104c4a97d0e3f629a9b765@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 05:46:23PM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 21 September 2021 17:28
> > 
> > On Tue, Sep 21, 2021 at 05:55:11PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 21 Sept 2021 at 17:33, Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
> > > ...
> ...
> > > >
> > > > I think so, yes. We can do sligntly better with an inline literal pool
> > > > and a PC-relative LDR to fold the ADRP+LDR, e.g.
> > > >
> > > >         .align 3
> > > > tramp:
> > > >         BTI     C
> > > >         {B <func> | RET | NOP}
> > > >         LDR     X16, 1f
> > > >         BR      X16
> > > > 1:      .quad   <literal>
> > > >
> > > > Since that's in the .text, it's RO for regular accesses anyway.
> > > >
> > >
> > > I tried to keep the literal in .rodata to avoid inadvertent gadgets
> > > and/or anticipate exec-only mappings of .text, but that may be a bit
> > > overzealous.
> > 
> > I think that in practice the risk of gadgetisation is minimal, and
> > having it inline means we only need to record a single address per
> > trampoline, so there's less risk that we get the patching wrong.
> 
> But doesn't that mean that it is almost certainly a data cache miss?
> You really want an instruction that reads the constant from the I-cache.
> Or at least be able to 'bunch together' the constants so they
> stand a chance of sharing a D-cache line.

The idea is that in the common case we don't even use the literal, and
the `B <func>` goes to the target.

The literal is there as a fallback for when the target is a sufficiently
long distance away (more than +/-128MiB from the `BR X16`). By default
we try to keep modules within 128MiB of the kernel image, and this
should only happen in uncommon configs (e.g. my debug kernel configs
when the kernel can be 100s of MiBs).

With that in mind, I'd strongly prefer to optimize for simplicity rather
than making the uncommon case faster.

Thanks,
Mark.
