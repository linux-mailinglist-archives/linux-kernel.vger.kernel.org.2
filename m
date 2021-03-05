Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3832F36E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCETEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhCETD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:03:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F289965066;
        Fri,  5 Mar 2021 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614971037;
        bh=hGG9zCwfl02S8an8gLZvtH9jqKn5RF6pFf/w3LZ+zwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsWVFctl/HJV38I1lSfmtObYYDL6uszH3DnCnGmRGlWrPywDO6QV6B/Yg3HuApQTv
         L2szzwqFNsR+oFtzK5CQLNFIvGgMG1rvTwYW4tTPLr98pZFhUW/g+/DdElcQVubiwZ
         eFjeytiJC23BmyggvwyN6Avj02uDeeXRrjeWeJQa1qNHDKG+FICkL3KXPHolkbzhcw
         Bzk+9PmYMmwtTLSQRMQkcuiotpy8zOo/ZnJn+PGTLDSURox6Hm8PM6vBRGCQmRoyxC
         x+f+W9zphaUBYGla5Rg/NvWZ7yfduelYHxb37hh7vpkctMCgHPacbXzf9cd+N63emZ
         Ux6MiGhZavjBA==
Date:   Fri, 5 Mar 2021 19:03:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 26/32] KVM: arm64: Introduce PROT_NONE mappings for
 stage 2
Message-ID: <20210305190350.GB23633@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-27-qperret@google.com>
 <20210304200044.GF21950@willie-the-truck>
 <YEH/THAYbSjOuFrH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEH/THAYbSjOuFrH@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 09:52:12AM +0000, Quentin Perret wrote:
> On Thursday 04 Mar 2021 at 20:00:45 (+0000), Will Deacon wrote:
> > On Tue, Mar 02, 2021 at 02:59:56PM +0000, Quentin Perret wrote:
> > > Once we start unmapping portions of memory from the host stage 2 (such
> > > as e.g. the hypervisor memory sections, or pages that belong to
> > > protected guests), we will need a way to track page ownership. And
> > > given that all mappings in the host stage 2 will be identity-mapped, we
> > > can use the host stage 2 page-table itself as a simplistic rmap.
> > > 
> > > As a first step towards this, introduce a new protection attribute
> > > in the stage 2 page table code, called KVM_PGTABLE_PROT_NONE, which
> > > allows to annotate portions of the IPA space as inaccessible. For
> > > simplicity, PROT_NONE mappings are created as invalid mappings with a
> > > software bit set.
> > 
> > Just as an observation, but given that they're invalid we can use any bit
> > from [63:2] to indicate that it's a PROT_NONE mapping, and that way we
> > can keep the real "software bits" for live mappings.
> > 
> > But we can of course change that later when we need the bit for something
> > else.
> 
> Right, so I used this approach for consistency with the kernel's
> PROT_NONE mappings:
> 
> 	#define PTE_PROT_NONE	(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> 
> And in fact now that I think about it, it might be worth re-using the
> same bit in stage 2.
> 
> But yes it would be pretty neat to use the other bits of invalid
> mappings to add metadata about the pages. I could even drop the
> PROT_NONE stuff straight away in favor of a more extensive mechanism for
> tracking page ownership...
> 
> Thinking about it, it should be relatively straightforward to construct
> the host stage 2 with the following invariants:
> 
>   1. everything is identity-mapped in the host stage 2;
> 
>   2. all valid mappings imply the underlying PA range belongs to the
>      host;
> 
>   3. bits [63:32] (say) of all invalid mappings are used to store a
>      unique identifier for the owner of the underlying PA range;
> 
>   4. the host identifier is 0, such that it owns all of memory by
>      default at boot as its pgd is zeroed;
> 
> And then I could replace my PROT_NONE permission stuff by an ownership
> change. E.g. the hypervisor would have its own identifier, and I could
> use it to mark the .hyp memory sections as owned by the hyp (which
> implies inaccessible by the host). And that should scale quite easily
> when we start running protected guests as we'll assign them their own
> identifiers. Sharing pages between guests (or even worse, between host
> and guests) is a bit trickier, but maybe that is for later.
> 
> Thoughts?

I think this sounds like a worthwhile generalisation to me, although virtio
brings an immediate need for shared pages and so we'll still need a software
bit for those so that we e.g. prevent the host from donating such a shared
page to the hypervisor.

Will
