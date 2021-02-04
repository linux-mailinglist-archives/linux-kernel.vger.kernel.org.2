Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321C30FB13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhBDSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239010AbhBDSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:14:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842EB64F44;
        Thu,  4 Feb 2021 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612462404;
        bh=zbLV6tzEcrYE6Zr1vCAoOlEuk2uUe3OTj1GoEj/vbsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd/0Jes6vV9yhhSHANL1rZUNuB/fQhP/iQfuTS2kgxeRItC0waSOIU/ltYfOmsQM0
         ZOh5bzruLkhY7RB7lxLFOiSL9Kjd69Q+qgJS3+fMStjqDUqEZaHW3SgnJ+U6Uxmbtf
         JuHL4djLRKjhNdUibBNSXtkiMpM2SaAoKfcd6dJCeStsbY+3lqJfvoSwZc+0p+nhdk
         IrxtdsVlS5TwIZIajddo+hofOfxWHdUjicQRnmuHEJYEm6P8vftmPm9YU+O9eGrpPH
         sqZYPYp+4xXVacbgRM8c7kQu0NeNmolcwTczxstovtLGDGbp+hlTPjBeVn9wd2gz+N
         FsPz5jPY6jH+Q==
Date:   Thu, 4 Feb 2021 18:13:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 12/26] KVM: arm64: Introduce a Hyp buddy page
 allocator
Message-ID: <20210204181317.GE21303@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
 <20210204143106.GA20792@willie-the-truck>
 <YBwKRM3uHDMC9S0U@google.com>
 <20210204174849.GA21303@willie-the-truck>
 <YBw2aIr/Ktx1dsOT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBw2aIr/Ktx1dsOT@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 06:01:12PM +0000, Quentin Perret wrote:
> On Thursday 04 Feb 2021 at 17:48:49 (+0000), Will Deacon wrote:
> > On Thu, Feb 04, 2021 at 02:52:52PM +0000, Quentin Perret wrote:
> > > On Thursday 04 Feb 2021 at 14:31:08 (+0000), Will Deacon wrote:
> > > > On Wed, Feb 03, 2021 at 06:33:30PM +0000, Quentin Perret wrote:
> > > > > On Tuesday 02 Feb 2021 at 18:13:08 (+0000), Will Deacon wrote:
> > > > > > On Fri, Jan 08, 2021 at 12:15:10PM +0000, Quentin Perret wrote:
> > > > > > > + *   __find_buddy(pool, page 0, order 0) => page 1
> > > > > > > + *   __find_buddy(pool, page 0, order 1) => page 2
> > > > > > > + *   __find_buddy(pool, page 1, order 0) => page 0
> > > > > > > + *   __find_buddy(pool, page 2, order 0) => page 3
> > > > > > > + */
> > > > > > > +static struct hyp_page *__find_buddy(struct hyp_pool *pool, struct hyp_page *p,
> > > > > > > +				     unsigned int order)
> > > > > > > +{
> > > > > > > +	phys_addr_t addr = hyp_page_to_phys(p);
> > > > > > > +
> > > > > > > +	addr ^= (PAGE_SIZE << order);
> > > > > > > +	if (addr < pool->range_start || addr >= pool->range_end)
> > > > > > > +		return NULL;
> > > > > > 
> > > > > > Are these range checks only needed because the pool isn't required to be
> > > > > > an exact power-of-2 pages in size? If so, maybe it would be more
> > > > > > straightforward to limit the max order on a per-pool basis depending upon
> > > > > > its size?
> > > > > 
> > > > > More importantly, it is because pages outside of the pool are not
> > > > > guaranteed to be covered by the hyp_vmemmap, so I really need to make
> > > > > sure I don't dereference them.
> > > > 
> > > > Wouldn't having a per-pool max order help with that?
> > > 
> > > The issue is, I have no alignment guarantees for the pools, so I may end
> > > up with max_order = 0 ...
> > 
> > Yeah, so you would still need the range tracking,
> 
> Hmm actually I don't think I would, but that would essentially mean the
> 'buddy' allocator is now turned into a free list of single pages
> (because we cannot create pages of order 1).

Right, I'm not suggesting we do that.

> > but it would at least help
> > to reduce HYP_MAX_ORDER failed searches each time. Still, we can always do
> > that later.
> 
> Sorry but I am not following. In which case do we have HYP_MAX_ORDER
> failed searches?

I was going from memory, but the loop in __hyp_alloc_pages() searches up to
HYP_MAX_ORDER, whereas this is _never_ going to succeed beyond some per-pool
order determined by the size of the pool. But I doubt it matters -- I
thought we did more than just check a list.

Will
