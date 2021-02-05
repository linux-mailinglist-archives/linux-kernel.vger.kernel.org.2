Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D693117F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhBFAxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBEKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:03:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B58C061356
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VeyWycuGg4ZW+zeTPH9DJgzH6UhIGZUG1CK6P8oNHRI=; b=PAF90TL8TjDKJWkWpklNh81TT0
        qYkPnTO+Vsn8SO6+GZrvD4IpX7550n/3F+YbDaBzX6wUO19tDdS689QQfgAVxrATwVgOSc3vbtbPN
        xK3VOvFA2bXxmAtweqEhi8gZhriBjJZ8B8p9QhZa8h/yeQ4Snw/jekw4xdZNbcIAnNF9Te+XqGRMe
        8MIRccBQxOLh6DbygXJBCInPkWdpOrHJ3LCybMM3Tyg1LKbhM59YMG6+DivdI+09xPteh5J+jdjyY
        gxIeTNdCn1LULJIdfZAFDdw9U5i4g+uKngfJeWereY4DcwdoPEuGs8ZKnJRgASnEEbZrsKwdOJ00e
        IFs0y5/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7xwL-0028Hz-TB; Fri, 05 Feb 2021 10:02:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 793BB301CC4;
        Fri,  5 Feb 2021 11:02:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 673FD2BBE1CB3; Fri,  5 Feb 2021 11:02:10 +0100 (CET)
Date:   Fri, 5 Feb 2021 11:02:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 2/2] x86: add extra serialization for
 non-serializing MSRs
Message-ID: <YB0XonRIr1GcCy6M@hirez.programming.kicks-ass.net>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
 <20200305174708.F77040DD@viggo.jf.intel.com>
 <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
 <CALCETrXMhe3ULF9UDc1=8CKVfKqneCxJ2wYmCdKPpntkkMNGWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXMhe3ULF9UDc1=8CKVfKqneCxJ2wYmCdKPpntkkMNGWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:11:12PM -0800, Andy Lutomirski wrote:
> I'm wondering if a more mild violation is possible:
> 
> Initialize *addr = 0.
> 
> mov $1, (addr)
> wrmsr
> 
> remote cpu's IDT vector:
> 
> mov (addr), %rax
> %rax == 0!
> 
> There's no speculative-execution-becoming-visible-even-if-it-doesn't-retire
> here -- there's just an ordering violation.  For Linux, this would
> presumably only manifest as a potential deadlock or confusion if the
> IPI vector code looks at the list of pending work and doesn't find the
> expected work in it.
> 
> Dave?  hpa?  What is the SDM trying to tell us?

[ Big caveat, I've not spoken to any hardware people about this. The
below is purely my own understanding. ]

This is my interpretation as well. Without the MFENCE+LFENCE there is no
guarantee the store is out of the store-buffer and the remote load isn't
guaranteed to observe it.

What I think the SDM is trying to tell us, is that the IPI, even if it
goes on the same regular coherency fabric as memory transfers, is not
subject to the regular memory ordering rules.

Normal TSO rules tells us that when:

P1() {
	x = 1;
	y = 1;
}

P2() {
	r1 = y;
	r2 = x;
}

r2 must not be 0 when r1 is 1. Because if we see store to y, we must
also see store to x. But the IPI thing doesn't behave like a store. The
(fast) wrmsr isn't even considered a memop.

The thing is, the above ordering does not guarantee we have r2 != 0.
r2==0 is allowed when r1==0. And that's an entirely sane outcome even if
we run the instructions like:

		CPU1		CPU2

cycle-1		mov $1, ([x])
cycle-2		mov $1, ([y])
cycle-3				mov ([y]), rax
cycle-4				mov ([x]), rbx

There is no guarantee _any_ of the stores will have made it out. And
that's exactly the issue. The IPI might make it out of the core before
any of the stores will.

Furthermore, since there is no dependency between:

	mov	$1, ([x])
	wrmsr

The CPU is allowed to reorder the execution and retire the wrmsr before
the store. Very much like it would for normal non-dependent
instructions.

And presumably it is still allowed to do that when we write it like:

	mov	$1, ([x])
	mfence
	wrmsr

because, mfence only has dependencies to memops and (fast) wrmsr is not
a memop.

Which then brings us to:

	mov	$1, ([x])
	mfence
	lfence
	wrmsr

In this case, the lfence acts like the newly minted ifence (see
spectre), and will block execution of (any) later instructions until
completion of all prior instructions. This, and only this ensures the
wrmsr happens after the mfence, which in turn ensures the store to x is
globally visible.

