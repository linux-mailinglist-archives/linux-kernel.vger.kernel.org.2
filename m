Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC97310F50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBEQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233599AbhBEQO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:14:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FCEA64DE8;
        Fri,  5 Feb 2021 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612547769;
        bh=tIx6Mq/q5bP075IBZ2ir3cjgV11ktDBdIgJkvpvVC3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTlgNtQ+Yw6PFVByGmHUzsyUYEpwKsJzsW+GNjtotiY8po0ywRgaiSjr1GuAsoMeR
         x+IR75GE7rrnakWiqzHBh0pNtil4DAStD/4cngKoM8MO8fypTdchG7tV9bDrEbIa7w
         f+b2Dm1Os9T7y+9ksGSx1SvohGbjRLeJxGbwH/96VBf/O8XGlMhJBW1NOYn1/w3SKb
         K83RbvvvM+XTwui5PkYnwUF+bft7iDfOSasn/J2V40uzD7vOP11AIQO3w8HrcHl7Yl
         QibMDqZEl9DdxiYCusF7CLgyazJvBPi+SAVwgsOQPH9kauUz65mCbKNapKpxju4iyo
         JNCM2nQUL+HXw==
Date:   Fri, 5 Feb 2021 17:56:02 +0000
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
Subject: Re: [RFC PATCH v2 16/26] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20210205175602.GG22665@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-17-qperret@google.com>
 <20210203143709.GA18907@willie-the-truck>
 <YBvQrHdbiNTSLQq6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBvQrHdbiNTSLQq6@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:47:08AM +0000, Quentin Perret wrote:
> On Wednesday 03 Feb 2021 at 14:37:10 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:14PM +0000, Quentin Perret wrote:
> > > +static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
> > > +{
> > > +	unsigned long total = 0, i;
> > > +
> > > +	/* Provision the worst case scenario with 4 levels of page-table */
> > > +	for (i = 0; i < 4; i++) {
> > 
> > Looks like you want KVM_PGTABLE_MAX_LEVELS, so maybe move that into a
> > header?
> 
> Will do.
> 
> > 
> > > +		nr_pages = DIV_ROUND_UP(nr_pages, PTRS_PER_PTE);
> > > +		total += nr_pages;
> > > +	}
> > 
> > ... that said, I'm not sure this needs to iterate at all. What exactly are
> > you trying to compute?
> 
> I'm trying to figure out how many pages I will need to construct a
> page-table covering nr_pages contiguous pages. The first iteration tells
> me how many level 0 pages I need to cover nr_pages, the second iteration
> how many level 1 pages I need to cover the level 0 pages, and so on...

Ah, you iterate from leaves back to the root. Got it, thanks.

> I might be doing this naively though. Got a better idea?

I thought I did, but I ended up with something based on a geometric series
and it looks terrible to code-up in C without, err, iterating like you do.

So yeah, ignore me :)

> > > +
> > > +	return total;
> > > +}
> > > +
> > > +static inline unsigned long hyp_s1_pgtable_size(void)
> > > +{
> > > +	struct hyp_memblock_region *reg;
> > > +	unsigned long nr_pages, res = 0;
> > > +	int i;
> > > +
> > > +	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
> > > +		return 0;
> > 
> > It's a bit grotty having this be signed. Why do we need to encode the error
> > case differently from the 0 case?
> 
> Here specifically we don't, but it is needed in early_init_dt_add_memory_hyp()
> to distinguish the overflow case from the first memblock being added.

Fair enough, but if you figure out a way for hyp_memblock_nr to be unsigned,
I think that would be preferable.

Will
