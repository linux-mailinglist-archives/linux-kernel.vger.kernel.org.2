Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64CC33C28B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhCOQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhCOQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:53:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD41C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:53:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so19880398wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8jtK4LvHkQIstlrA5wZLxNvqJwLdyrOtIEuLebCwaq4=;
        b=gzyooPr/RXjEiOoZImRlh/c4wGsriorODrbvY7BTIMjGIhjq4kfsyJ2yVtFCBuzuAn
         j5bh7TXHhr736yFDkanUNL0+cANtSiwUSsO2SeJDXlOSqPzqDUY+C680a4s9L/10R6av
         xC7ngG6hErYLUCNHi7rRrY+6hi2OZR8jKUNd+He5swRuREZ1qpz5Hy7w94k6C1k8CGc0
         JPFP6RNl7DHjOYhI0NxQ9TxXSHvNYjzSaKZN8y1shjslUL+rrzWFUrePgvUtmrmxZELP
         RfwHJFHGqZx9d4V2qG+XFuAMTHPdbmIvepOCSlZEkTCyKSgguFqeAUv3/s0Cq9lmlxp/
         bOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jtK4LvHkQIstlrA5wZLxNvqJwLdyrOtIEuLebCwaq4=;
        b=V5abrHNoNqxwn+6Atw1Gb1a6+9Mww367Whl64wPtIhNeUKT5SBsXE1ZQDldGXH6yQd
         /ie2goYbK0GjpZzyZnCwN4Zhv1RmH3WVMPQA/geOa6xxuVTxhVMDZsTcuPfWymQhmR2H
         CZKEehJAbAaq8PwCf9irgDN3p0JO9Tnp2IN6BXBukzGNfvEO8KjRoZ+zT+T5w2k8eQax
         8jfh7A8gxP50ctDic37kBWwiH8+cMMRqCFfg+eKgRVq57Ta81iPMwP4HN0zerOONhbD9
         wWWKKjo1IGJ03BjFRMoghk8c+sZp2u6fE+OLUgAxN8gOn8ByEbsD1WE1B89OOcSNhLMn
         WobA==
X-Gm-Message-State: AOAM530y1ntBU5c6u4Sg2j6Kik+B0Rxk5WtE1HOgXk8rnbti69a7viOf
        SkNOqIM3122YkpO1CAh0FVFwLA==
X-Google-Smtp-Source: ABdhPJzyCUjEeIdn7MkxvV/Kzfaapb7kOKbdOTz0f/wFjhROoS2sYscMCclWPUTXv0qdQaa+Htk3kQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr563679wmc.185.1615827201290;
        Mon, 15 Mar 2021 09:53:21 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id j6sm218657wmq.16.2021.03.15.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:53:20 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:53:18 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 29/36] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <YE+Q/vFpSaAO5vZS@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-30-qperret@google.com>
 <20210315163618.GF3430@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315163618.GF3430@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 Mar 2021 at 16:36:19 (+0000), Will Deacon wrote:
> On Mon, Mar 15, 2021 at 02:35:29PM +0000, Quentin Perret wrote:
> > As the host stage 2 will be identity mapped, all the .hyp memory regions
> > and/or memory pages donated to protected guestis will have to marked
> > invalid in the host stage 2 page-table. At the same time, the hypervisor
> > will need a way to track the ownership of each physical page to ensure
> > memory sharing or donation between entities (host, guests, hypervisor) is
> > legal.
> > 
> > In order to enable this tracking at EL2, let's use the host stage 2
> > page-table itself. The idea is to use the top bits of invalid mappings
> > to store the unique identifier of the page owner. The page-table owner
> > (the host) gets identifier 0 such that, at boot time, it owns the entire
> > IPA space as the pgd starts zeroed.
> > 
> > Provide kvm_pgtable_stage2_set_owner() which allows to modify the
> > ownership of pages in the host stage 2. It re-uses most of the map()
> > logic, but ends up creating invalid mappings instead. This impacts
> > how we do refcount as we now need to count invalid mappings when they
> > are used for ownership tracking.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h |  21 +++++
> >  arch/arm64/kvm/hyp/pgtable.c         | 127 ++++++++++++++++++++++-----
> >  2 files changed, 124 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 4ae19247837b..683e96abdc24 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -238,6 +238,27 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  			   u64 phys, enum kvm_pgtable_prot prot,
> >  			   void *mc);
> >  
> > +/**
> > + * kvm_pgtable_stage2_set_owner() - Annotate invalid mappings with metadata
> > + *				    encoding the ownership of a page in the
> > + *				    IPA space.
> 
> The function does more than this, though, as it will also go ahead and unmap
> existing valid mappings which I think should be mentioned here, no?

Right, I see why you mean. How about:

'Unmap and annotate pages in the IPA space to track ownership'

> > +int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > +				 void *mc, u8 owner_id)
> > +{
> > +	int ret;
> > +	struct stage2_map_data map_data = {
> > +		.phys		= KVM_PHYS_INVALID,
> > +		.mmu		= pgt->mmu,
> > +		.memcache	= mc,
> > +		.mm_ops		= pgt->mm_ops,
> > +		.owner_id	= owner_id,
> > +	};
> > +	struct kvm_pgtable_walker walker = {
> > +		.cb		= stage2_map_walker,
> > +		.flags		= KVM_PGTABLE_WALK_TABLE_PRE |
> > +				  KVM_PGTABLE_WALK_LEAF |
> > +				  KVM_PGTABLE_WALK_TABLE_POST,
> > +		.arg		= &map_data,
> > +	};
> > +
> > +	if (owner_id > KVM_MAX_OWNER_ID)
> > +		return -EINVAL;
> > +
> > +	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
> > +	dsb(ishst);
> 
> Why is the DSB needed here? afaict, we only ever unmap a valid entry (which
> will have a DSB as part of the TLBI sequence) or we update the owner for an
> existing invalid entry, in which case the walker doesn't care.

Indeed, that is now unnecessary. I'll remove it.

Thanks,
Quentin
