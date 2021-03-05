Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6058D32E54E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCEJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:52:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61027C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:52:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i9so875273wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQ4ayVmpQ2yz1MNTdvkvVI7Y2HpF8m5uabtW6s1crek=;
        b=pa92rFxaaU+b6gJewmAwGkjarcluL9ua1pgfkM90CsQm9VBf4UM9KxIuSSi1bFkPzG
         xbFEPSCQx2NT6SyI7Cl6CgkSXuTO3SUkoTSzb5i5MYS1nYuXd/RELM+hK3itxajc2Ifu
         gU6jwDtqB12ZdNMlpKtx1BPuKGH5qLiBYxflmhqbmEX1/jWiPunqooGvdzXTkcwg1MXB
         sr3vwe52KUjRsf6lY4diBlT4UmV10ENCnTPFS3eqnp2WQDPlQ5QC4sIA5kiO24lwEdqO
         1wKbfeKKPEyZbtIaE+ranbai7g3Q4WTRE/ddsBgLokobZ5LbPSI79L3GDfNlu9J4o8Ur
         7AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQ4ayVmpQ2yz1MNTdvkvVI7Y2HpF8m5uabtW6s1crek=;
        b=kzbKMg+2ID75ZEGuJqW78bsh7DoX/sfm3Wqdz5XDGnA2ON7YkVeimTYFySz6EgsR5w
         2i08vi9AchnPHD5brtQs0HNNx3V0Vn/OUJ7hQzSgeZnwaZBHFdEh63OFLY7hTR8618Tx
         +2P0iWU9siv3Oux0Yh8OFcoP8XsMxvN7YzhCJB2gOUv/tyoZ2Heo43O3CyzOCybQFgad
         l8FN9DLURMWQP5WczO2XjgDq7yJL6NFDKCtrT7IGDVibXk6Ynqg9qFyftMiTexSzKGX6
         1IUZJZWh4ovHCFEDWz9QoIqi3o663dKJFLydVVBrfAoOR1gM9gB3aHlAh30/c0kRNwnC
         4dmg==
X-Gm-Message-State: AOAM5328lqDybC+bkr0bqyTHJ0ZLsUNbCgeUzPTnBs5oWg3YXvPYBKX/
        shl0HRZzRAJaqnxW7xs7iC63Ew==
X-Google-Smtp-Source: ABdhPJzUCdNZnXwdgKLQPy9vMWodT8+aKJFzhw1JHW0+mwV55+XAdoh7ZW8AFTDEKwM6rIrOOMtHmA==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr8133708wmg.170.1614937934941;
        Fri, 05 Mar 2021 01:52:14 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id s23sm3509793wmc.29.2021.03.05.01.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:52:14 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:52:12 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 26/32] KVM: arm64: Introduce PROT_NONE mappings for
 stage 2
Message-ID: <YEH/THAYbSjOuFrH@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-27-qperret@google.com>
 <20210304200044.GF21950@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304200044.GF21950@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2021 at 20:00:45 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:56PM +0000, Quentin Perret wrote:
> > Once we start unmapping portions of memory from the host stage 2 (such
> > as e.g. the hypervisor memory sections, or pages that belong to
> > protected guests), we will need a way to track page ownership. And
> > given that all mappings in the host stage 2 will be identity-mapped, we
> > can use the host stage 2 page-table itself as a simplistic rmap.
> > 
> > As a first step towards this, introduce a new protection attribute
> > in the stage 2 page table code, called KVM_PGTABLE_PROT_NONE, which
> > allows to annotate portions of the IPA space as inaccessible. For
> > simplicity, PROT_NONE mappings are created as invalid mappings with a
> > software bit set.
> 
> Just as an observation, but given that they're invalid we can use any bit
> from [63:2] to indicate that it's a PROT_NONE mapping, and that way we
> can keep the real "software bits" for live mappings.
> 
> But we can of course change that later when we need the bit for something
> else.

Right, so I used this approach for consistency with the kernel's
PROT_NONE mappings:

	#define PTE_PROT_NONE	(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */

And in fact now that I think about it, it might be worth re-using the
same bit in stage 2.

But yes it would be pretty neat to use the other bits of invalid
mappings to add metadata about the pages. I could even drop the
PROT_NONE stuff straight away in favor of a more extensive mechanism for
tracking page ownership...

Thinking about it, it should be relatively straightforward to construct
the host stage 2 with the following invariants:

  1. everything is identity-mapped in the host stage 2;

  2. all valid mappings imply the underlying PA range belongs to the
     host;

  3. bits [63:32] (say) of all invalid mappings are used to store a
     unique identifier for the owner of the underlying PA range;

  4. the host identifier is 0, such that it owns all of memory by
     default at boot as its pgd is zeroed;

And then I could replace my PROT_NONE permission stuff by an ownership
change. E.g. the hypervisor would have its own identifier, and I could
use it to mark the .hyp memory sections as owned by the hyp (which
implies inaccessible by the host). And that should scale quite easily
when we start running protected guests as we'll assign them their own
identifiers. Sharing pages between guests (or even worse, between host
and guests) is a bit trickier, but maybe that is for later.

Thoughts?

> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h |  2 ++
> >  arch/arm64/kvm/hyp/pgtable.c         | 26 ++++++++++++++++++++++++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 9935dbae2cc1..c9f6ed76e0ad 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -80,6 +80,7 @@ struct kvm_pgtable {
> >   * @KVM_PGTABLE_PROT_W:		Write permission.
> >   * @KVM_PGTABLE_PROT_R:		Read permission.
> >   * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
> > + * @KVM_PGTABLE_PROT_NONE:	No permission.
> >   */
> >  enum kvm_pgtable_prot {
> >  	KVM_PGTABLE_PROT_X			= BIT(0),
> > @@ -87,6 +88,7 @@ enum kvm_pgtable_prot {
> >  	KVM_PGTABLE_PROT_R			= BIT(2),
> >  
> >  	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
> > +	KVM_PGTABLE_PROT_NONE			= BIT(4),
> 
> Why do we need an extra entry here? Couldn't we just create PROT_NONE
> entries when none of R,W or X are set?

The kernel has an explicit PAGE_NONE permission, so I followed the same
idea, but that could work as well. Now, as per the above discussion that
may not be relevant if we implement the page ownership thing.

> >  };
> >  
> >  #define PAGE_HYP		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index bdd6e3d4eeb6..8e7059fcfd40 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -48,6 +48,8 @@
> >  					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
> >  					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
> >  
> > +#define KVM_PTE_LEAF_SW_BIT_PROT_NONE	BIT(55)
> > +
> >  struct kvm_pgtable_walk_data {
> >  	struct kvm_pgtable		*pgt;
> >  	struct kvm_pgtable_walker	*walker;
> > @@ -120,6 +122,16 @@ static bool kvm_pte_valid(kvm_pte_t pte)
> >  	return pte & KVM_PTE_VALID;
> >  }
> >  
> > +static bool kvm_pte_prot_none(kvm_pte_t pte)
> > +{
> > +	return pte & KVM_PTE_LEAF_SW_BIT_PROT_NONE;
> > +}
> 
> I think it would be a good idea to check !kvm_pte_valid() in here too,
> since it doesn't make sense to report true for valid (or table) entries.

Ack.

Thanks,
Quentin
