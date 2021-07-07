Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9F3BE851
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhGGMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhGGMws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 887AC61CBA;
        Wed,  7 Jul 2021 12:50:06 +0000 (UTC)
Date:   Wed, 7 Jul 2021 13:50:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210707125003.GA24397@arm.com>
References: <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
 <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
 <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
 <20210706175052.GD15218@arm.com>
 <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 08:15:47PM +0100, Robin Murphy wrote:
> On 2021-07-06 18:50, Catalin Marinas wrote:
> > On Mon, Jun 28, 2021 at 05:22:30PM +0100, Robin Murphy wrote:
> > > @@ -62,6 +64,12 @@ EXPORT_SYMBOL(__arch_copy_to_user)
> > >   	.section .fixup,"ax"
> > >   	.align	2
> > > +9997:	cmp	dst, dstin
> > > +	b.ne	9998f
> > > +	// Before being absolutely sure we couldn't copy anything, try harder
> > > +	ldrb	tmp1w, [srcin]
> > > +USER(9998f, sttrb tmp1w, [dstin])
> > > +	add	dst, dstin, #1
> > >   9998:	sub	x0, end, dst			// bytes not copied
> > >   	ret
> > >   	.previous
> > 
> > I think it's worth doing the copy_to_user() fallback in a loop until it
> > faults or hits the end of the buffer. This would solve the problem we
> > currently have with writing more bytes than actually reported. The
> > copy_from_user() is not necessary, a byte would suffice.
> 
> The thing is, we don't really have that problem since the set_fs cleanup
> removed IMP-DEF STP behaviour from the picture - even with the current mess
> we could perfectly well know which of the two STTRs faulted if we just put a
> little more effort in.

I think there are some corner cases: STTR across a page boundary,
faulting on the second page. The architecture allows some data to be
written (or not) in the first page, so we'd under-report if we use the
destination update. If we use the fault address it's even worse as we
may over-report in case the instruction did not write anything.

> But yuck... If you think the potential under-reporting is worth fixing right
> now, rather than just letting it disappear in a future rewrite, then I'd
> still rather do it by passing the actual fault address to the current
> copy_to_user fixup.

After some more digging in the ARM ARM, I don't think that's fixable by
using the actual fault address. B2.2.1 and D1.13.5 in version G.a
(thanks to Will for digging them out) mean that for an interrupted store
(exception, interrupt), any bytes stored by the instruction become
UNKNOWN. In practice, this means left unchanged or written.

So I think a byte-wise write loop is the only chance we have at a
more precise reporting, unless we change the loops to align the writes.

> A retry loop could still technically under-report if the
> page disappears (or tag changes) between faulting on the second word of a
> pair and retrying from the first, so we'd want to pin the initial fault down
> to a single access anyway. All the loop would achieve after that is
> potentially fill in an extra 1-7 bytes right up to the offending page/tag
> boundary for the sake of being nice, which I remain unconvinced is worth the
> bother :)

There is indeed the risk of a race but we can blame the user for
concurrently changing the permissions or tag. The kernel wouldn't
normally do this.

-- 
Catalin
