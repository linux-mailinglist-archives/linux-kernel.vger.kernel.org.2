Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8553E3388D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCLJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhCLJkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:40:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3961E64FDD;
        Fri, 12 Mar 2021 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615542017;
        bh=IhMRNUcJYwCkDReHSF76lISid/6+vJxJRq5TrqpWgk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FttZZGnGm4GqH4u+TmUc57P5wbD6izysvvsuuknHB0t9tFFQ2cQUyxJP/LmMkMDPj
         pBaaPhflRrPTYmpAiwT0ngHHanDpHmZPoRs7X+JJnQ9lmsdsaUrapQE8/wHB66L3Hu
         aVesI5HypLmSPbqdaaWqDr25iEvI5DhjopJJ0hEA3yEeNosk9xaawcrEhTcWRKRiSJ
         byZmtWoB7mUSOf5wgOLjHY3cp9Q9veMVqbG3NIvjswUAA8acTGGr0x/S3V/DniQx4j
         0+d4EafNVWpjsvT9E+2S9Uv0D5JTLHwiVdzh+eQOaEL5QjPeEq0Xn9UUd3EPKbRAWz
         EWOc5VUiGsXxg==
Date:   Fri, 12 Mar 2021 09:40:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 30/34] KVM: arm64: Add kvm_pgtable_stage2_find_range()
Message-ID: <20210312094009.GC32016@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-31-qperret@google.com>
 <20210311190406.GB31586@willie-the-truck>
 <YEr83QKZnEd4a6Ba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEr83QKZnEd4a6Ba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 05:32:13AM +0000, Quentin Perret wrote:
> On Thursday 11 Mar 2021 at 19:04:07 (+0000), Will Deacon wrote:
> > On Wed, Mar 10, 2021 at 05:57:47PM +0000, Quentin Perret wrote:
> > > +	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
> > > +		granule = kvm_granule_size(level);
> > > +		start = ALIGN_DOWN(addr, granule);
> > > +		end = start + granule;
> > > +
> > > +		if (!kvm_level_support_block_mappings(level))
> > > +			continue;
> > > +
> > > +		if (start < range->start || range->end < end)
> > > +			continue;
> > > +
> > > +		/*
> > > +		 * Check the presence of existing mappings with incompatible
> > > +		 * permissions within the current block range, and try one level
> > > +		 * deeper if one is found.
> > > +		 */
> > > +		ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
> > > +		if (ret != -EEXIST)
> > > +			break;
> > > +	}
> > 
> > Can you write this as a:
> > 
> > 	do {
> > 		...
> > 	} while (level < KVM_PGTABLE_MAX_LEVELS && ret == -EEXIST);
> > 
> > loop?
> 
> I tried it but found it a little less pretty -- the pre-assignment of
> level and the increment at the end make it really feel like a for loop
> to me:
> 
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1098,26 +1098,23 @@ int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
>                 return ret;
>         attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
>  
> -       for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
> +       ret = -EEXIST;
> +       level = pgt->start_level;
> +       do {
>                 granule = kvm_granule_size(level);
>                 start = ALIGN_DOWN(addr, granule);
>                 end = start + granule;
>  
> -               if (!kvm_level_support_block_mappings(level))
> -                       continue;
> -
> -               if (start < range->start || range->end < end)
> -                       continue;

Urgh, yes, sorry, I hadn't appreciated what a mess it causes for these guys.

Stick with the 'for' loop.

Will
