Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113F633C331
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhCORBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234806AbhCORBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:01:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E790E64D9D;
        Mon, 15 Mar 2021 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615827699;
        bh=XZi122AEwWqMj9ZZvX8bMJnPSkj+5a7gkjWIRRfb/CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU/i5m3ktp2+u0LV2ng5ubQko8BQTNYwC8oH77rIUeWFethPfizyDHZJ7kg5J9JDH
         fefW0YFTxENH9St6Yw3CPnDMziw0oHa6O5pDbK9J1e2ska7lWn34WWnMixQzlFtv41
         FXhGQYpSEIouonp1bTdKF3BKCCScBXfbKRAE0D5LitzG9zJ2boQH50Yy5i5wPvtyB1
         l6gW/DcFs8YgsE/cbGjcc9LSUdOTLXNupoReYd5JPAb8xxWHGkmklvgyFP1I5KxHC7
         vbj6mbYmAQ4ljsuEwDzLmoC684rEn85CbNHBxQfX2BqpKyOgi7VeU83c2mW7nwniSs
         Y13WQwjtm1oLQ==
Date:   Mon, 15 Mar 2021 17:01:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 29/36] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <20210315170133.GH3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-30-qperret@google.com>
 <20210315163618.GF3430@willie-the-truck>
 <YE+Q/vFpSaAO5vZS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE+Q/vFpSaAO5vZS@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:53:18PM +0000, Quentin Perret wrote:
> On Monday 15 Mar 2021 at 16:36:19 (+0000), Will Deacon wrote:
> > On Mon, Mar 15, 2021 at 02:35:29PM +0000, Quentin Perret wrote:
> > > As the host stage 2 will be identity mapped, all the .hyp memory regions
> > > and/or memory pages donated to protected guestis will have to marked
> > > invalid in the host stage 2 page-table. At the same time, the hypervisor
> > > will need a way to track the ownership of each physical page to ensure
> > > memory sharing or donation between entities (host, guests, hypervisor) is
> > > legal.
> > > 
> > > In order to enable this tracking at EL2, let's use the host stage 2
> > > page-table itself. The idea is to use the top bits of invalid mappings
> > > to store the unique identifier of the page owner. The page-table owner
> > > (the host) gets identifier 0 such that, at boot time, it owns the entire
> > > IPA space as the pgd starts zeroed.
> > > 
> > > Provide kvm_pgtable_stage2_set_owner() which allows to modify the
> > > ownership of pages in the host stage 2. It re-uses most of the map()
> > > logic, but ends up creating invalid mappings instead. This impacts
> > > how we do refcount as we now need to count invalid mappings when they
> > > are used for ownership tracking.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_pgtable.h |  21 +++++
> > >  arch/arm64/kvm/hyp/pgtable.c         | 127 ++++++++++++++++++++++-----
> > >  2 files changed, 124 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > > index 4ae19247837b..683e96abdc24 100644
> > > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > > @@ -238,6 +238,27 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > >  			   u64 phys, enum kvm_pgtable_prot prot,
> > >  			   void *mc);
> > >  
> > > +/**
> > > + * kvm_pgtable_stage2_set_owner() - Annotate invalid mappings with metadata
> > > + *				    encoding the ownership of a page in the
> > > + *				    IPA space.
> > 
> > The function does more than this, though, as it will also go ahead and unmap
> > existing valid mappings which I think should be mentioned here, no?
> 
> Right, I see why you mean. How about:
> 
> 'Unmap and annotate pages in the IPA space to track ownership'

I think I'd go with:

'Unmap pages and annotate the invalid mappings with ownership metadata for
 the unmapped IPA range.'

as it's the page-table which is annotated, not the actual pages (which could
potentially be mapped by other page-tables).

Will
