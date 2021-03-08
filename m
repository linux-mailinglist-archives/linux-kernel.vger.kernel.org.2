Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5C331011
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCHNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhCHNwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:52:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096A5651C2;
        Mon,  8 Mar 2021 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615211560;
        bh=DvWcVEv2Vrw8pMLTCVc0UcvS+o5tJf6N3Zi7lsDgBtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0SmlzBCUl9vwUrnk3vCdFm9Ed2nFSvhEw7I1IbWCJJoc5cL/37GnXspwt50WvvS7
         afmBNhOO9O9J7al1g+H/XvELL8IE8nj95MvOIwvspwkz3LhRBsXBpgp7bXnZzvU7OU
         HK5KQO1YCil3BaiJzcSVOOhc9xvLROz2SXhjo5mxlFesByhc3vGnVgwRlQgzpvbLWP
         xQpNMhZ7asJwO4eAcs3W0DnephAAMEW/uLkI9G9bZNr0N74JWbnCGJ/MrDwXpHy6cC
         z4xcns0XTko0wLEsBI+P+Q8EqXY35MknsD51UKfcJ7GWXRgPoKWJshn1klQ+6EWf4C
         7DMF6cUcpbcdg==
Date:   Mon, 8 Mar 2021 13:52:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 29/32] KVM: arm64: Wrap the host with a stage 2
Message-ID: <20210308135234.GB26128@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-30-qperret@google.com>
 <20210305192905.GE23633@willie-the-truck>
 <YEXs1cOlmhHg4u8x@google.com>
 <20210308124606.GA25879@willie-the-truck>
 <YEYov+r6A3uil1aU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEYov+r6A3uil1aU@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 01:38:07PM +0000, Quentin Perret wrote:
> On Monday 08 Mar 2021 at 12:46:07 (+0000), Will Deacon wrote:
> > > > > +static int host_stage2_idmap(u64 addr)
> > > > > +{
> > > > > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> > > > > +	struct kvm_mem_range range;
> > > > > +	bool is_memory = find_mem_range(addr, &range);
> > > > > +	struct hyp_pool *pool = is_memory ? &host_s2_mem : &host_s2_dev;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (is_memory)
> > > > > +		prot |= KVM_PGTABLE_PROT_X;
> > > > > +
> > > > > +	hyp_spin_lock(&host_kvm.lock);
> > > > > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > > > > +					      &range, pool);
> > > > > +	if (is_memory || ret != -ENOMEM)
> > > > > +		goto unlock;
> > > > > +	host_stage2_unmap_dev_all();
> > > > > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > > > > +					      &range, pool);
> > > > 
> > > > I find this _really_ hard to reason about, as range is passed by reference
> > > > and we don't reset it after the first call returns -ENOMEM for an MMIO
> > > > mapping. Maybe some commentary on why it's still valid here?
> > > 
> > > Sure, I'll add something. FWIW, that is intended -- -ENOMEM can only be
> > > caused by the call to kvm_pgtable_stage2_map() which leaves the range
> > > untouched. So, as long as we don't release the lock, the range returned
> > > by the first call to kvm_pgtable_stage2_idmap_greedy() should still be
> > > valid. I suppose I could call kvm_pgtable_stage2_map() directly the
> > > second time to make it obvious but I thought this would expose the
> > > internal of kvm_pgtable_stage2_idmap_greedy() a little bit too much.
> > 
> > I can see it both ways, but updating the kerneldoc for
> > kvm_pgtable_stage2_idmap_greedy() to state in which cases the range is
> > updated and how would be helpful. It just says "negative error code on
> > failure" at the moment.
> 
> Alternatively I could expose the 'reduce' path (maybe with another name
> e.g. stage2_find_compatible_range() or so) and remove the
> kvm_pgtable_stage2_idmap_greedy() wrapper. So it'd be the caller's
> responsibility to not release the lock in between
> stage2_find_compatible_range() and kvm_pgtable_stage2_map() for
> instance, but that sounds reasonable to me. And that would make it
> explicit it's the _map() path that failed with -ENOMEM, and that the
> range can be re-used the second time.
> 
> Thoughts?

I suppose it depends on whether or not you reckon this could be optimised
into a single-pass of the page-table. If not, then splitting it up makes
sense to me (and actually, it's not like this has tonnes of callers so
even if we changed things in future it wouldn't be too hard to fix them up).

Will
