Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E80338B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCLLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhCLLSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:18:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EB0864F09;
        Fri, 12 Mar 2021 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615547891;
        bh=4M8/d1QtvNV0W22nnWX2De2qfNZVr8K7C/taDssa2Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvgY2ixxwgnMDRs6DayZDJfXR1VG+agFl/c5ryWLihtPZrXyiAITc3Z3DhwjhWKSr
         QixZ+cIFSfVRHu4wj4bqnJGhgTgoxG5Q0jiA/zFwgGZIAd9kbttdxrXMz+h8rc8DLf
         MDeAFCrDlcWQpHH4KXEY+shjNwnrtMK00t5f1QibG3Md/5LlHoA1oaIwqvgMnuJWJq
         uqmgObMsd6Ue5uqdFkktT4ksgWSGaYa+dit8HiN9xOqjsbTRGwR40tCGNsgeSqNRyX
         XKYql/ytfOCaQm3wnG3kpztMyXHP3ok0WEpLpAMsOBbBGibTvIk9DztGVRjgRRV51L
         JBSXW6eZQ3BHg==
Date:   Fri, 12 Mar 2021 11:18:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 28/34] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <20210312111804.GB32208@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-29-qperret@google.com>
 <20210311183834.GC31378@willie-the-truck>
 <YEsIxA/fKaDlSaio@google.com>
 <20210312093205.GB32016@willie-the-truck>
 <YEs+xi6IDj3gwX10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEs+xi6IDj3gwX10@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 10:13:26AM +0000, Quentin Perret wrote:
> On Friday 12 Mar 2021 at 09:32:06 (+0000), Will Deacon wrote:
> > I'm not saying to use the VMID directly, just that allocating half of the
> > pte feels a bit OTT given that the state of things after this patch series
> > is that we're using exactly 1 bit.
> 
> Right, and that was the reason for the PROT_NONE approach in the
> previous version, but we agreed it'd be worth generalizing to allow for
> future use-cases :-)

Yeah, just generalising to 32 bits feels like going too far! I dunno,
make it a u8 for now, or define the hypervisor owner ID as 1 and reject
owners greater than that? We can easily extend it later.

> > > > > @@ -517,28 +543,36 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > > > >  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> > > > >  		return -E2BIG;
> > > > >  
> > > > > -	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > > > > -	if (kvm_pte_valid(old)) {
> > > > > +	if (kvm_pte_valid(data->attr))
> > > > 
> > > > This feels like a bit of a hack to me: the 'attr' field in stage2_map_data
> > > > is intended to correspond directly to the lower/upper attributes of the
> > > > descriptor as per the architecture, so tagging the valid bit in there is
> > > > pretty grotty. However, I can see the significant advantage in being able
> > > > to re-use the stage2_map_walker functionality, so about instead of nobbling
> > > > attr, you set phys to something invalid instead, e.g.:
> > > > 
> > > > 	#define KVM_PHYS_SET_OWNER	(-1ULL)
> > > 
> > > That'll confuse kvm_block_mapping_supported() and friends I think, at
> > > least in their current form. If you _really_ don't like this, maybe we
> > > could have an extra 'flags' field in stage2_map_data?
> > 
> > I was pondering this last night and I thought of two ways to do it:
> > 
> > 1. Add a 'bool valid' and then stick the owner and the phys in a union.
> >    (yes, you'll need to update the block mapping checks to look at the
> >     valid flag)
> 
> Right, though that is also used for the hyp s1 which doesn't use any of
> this ATM. That shouldn't be too bad to change, I'll have a look.

Oh, I meant stick the bool in the stage2_map_data so that should be limited
to the stage2 path.

Will
