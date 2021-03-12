Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19513389CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhCLKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhCLKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:13:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F164C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:13:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso14815239wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOH5AK+PAfRAsg2dxAdQE8C774VeCltqpKz+okkVeFM=;
        b=OQyevQU51Wt1xnh2LbX/w1hCSfiwz6KAaijoqwJz0R8Wjxrl8Uep70/qnj/OCN76EJ
         zF1lDsjWFBn//WEW76/aHd88jg2/A3oLTLTdCoEH41VqrLnPwfka/vDfXzhgvKKz2hwh
         Bw5aWs/xlmjzVaxZfgDMnWoYGONap/ih6d6St4+g2PG9ckB2n1Sh7VojdF0bX3prNspp
         kOjtaPujuw5izKVEhe6VmVy5Ut/10+gwAMKKGLJsN52lPb6tkRsQFegz3mLkvdUqs7Gl
         69DP+TmO9mqm0hSj6w62fHZEarnptc9hBY8JXn2fANa1fWzKp4/xHqI1UndehrCgdbcv
         oJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOH5AK+PAfRAsg2dxAdQE8C774VeCltqpKz+okkVeFM=;
        b=AITbX4IZUwxuRjZo9bPiatfs8i+coP17peELE/pArlC5XwBXC+9hnxscHX6MbEH5xD
         a2orpiIhGlfUdnNWSPDwpj6cwh8NdGC3qa+bARWIObEHhN7r/pUHgwq7myJ/4eCrqk7u
         7W6lPTsSemQRUQR23jxMmA50lRhPUkUvp6z2ImcN6GJLhd8hCnRKqeymTNZ9uOqL1qm8
         JWZNBFzWsxQU3hEqvh1jl6SEYBRLTQWvNH+QDYKacanUOyHNU3SGWjsEdyTpz1zzzv3+
         T/E+mTEDPcapyhBd0gWVF9q2gcyS66gVpQYOm8fzooadGe3GeHGp2LOGFWhYK2u/E4Zu
         2KIA==
X-Gm-Message-State: AOAM531yArb9r02fDHBNxrYUsIVE8+W9iEeVTVcSErqbR1Adbu/b67D3
        J450MbDfudRTj7QXAVWXugY4nA==
X-Google-Smtp-Source: ABdhPJzs2CwFIhMIFHCtWhF0Kk8Mn96x94X3sQBAAfKwNZIrb+5CYxK9LtqpnTzDcLxhgVyEpFqTlw==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr12231304wmm.57.1615544012774;
        Fri, 12 Mar 2021 02:13:32 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id h25sm1933615wml.32.2021.03.12.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:13:32 -0800 (PST)
Date:   Fri, 12 Mar 2021 10:13:26 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 28/34] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <YEs+xi6IDj3gwX10@google.com>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-29-qperret@google.com>
 <20210311183834.GC31378@willie-the-truck>
 <YEsIxA/fKaDlSaio@google.com>
 <20210312093205.GB32016@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312093205.GB32016@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2021 at 09:32:06 (+0000), Will Deacon wrote:
> I'm not saying to use the VMID directly, just that allocating half of the
> pte feels a bit OTT given that the state of things after this patch series
> is that we're using exactly 1 bit.

Right, and that was the reason for the PROT_NONE approach in the
previous version, but we agreed it'd be worth generalizing to allow for
future use-cases :-)

> > > > @@ -517,28 +543,36 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > > >  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> > > >  		return -E2BIG;
> > > >  
> > > > -	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > > > -	if (kvm_pte_valid(old)) {
> > > > +	if (kvm_pte_valid(data->attr))
> > > 
> > > This feels like a bit of a hack to me: the 'attr' field in stage2_map_data
> > > is intended to correspond directly to the lower/upper attributes of the
> > > descriptor as per the architecture, so tagging the valid bit in there is
> > > pretty grotty. However, I can see the significant advantage in being able
> > > to re-use the stage2_map_walker functionality, so about instead of nobbling
> > > attr, you set phys to something invalid instead, e.g.:
> > > 
> > > 	#define KVM_PHYS_SET_OWNER	(-1ULL)
> > 
> > That'll confuse kvm_block_mapping_supported() and friends I think, at
> > least in their current form. If you _really_ don't like this, maybe we
> > could have an extra 'flags' field in stage2_map_data?
> 
> I was pondering this last night and I thought of two ways to do it:
> 
> 1. Add a 'bool valid' and then stick the owner and the phys in a union.
>    (yes, you'll need to update the block mapping checks to look at the
>     valid flag)

Right, though that is also used for the hyp s1 which doesn't use any of
this ATM. That shouldn't be too bad to change, I'll have a look.

> 2. Go with my latter suggestion:
> 
> > > Is there ever a reason to use kvm_pgtable_stage2_set_owner() to set an
> > > owner of 0, or should you just use the map/unmap APIs for that? If so,
> > > then maybe the key is simply if owner_id is non-zero, then an invalid
> > > entry is installed?
> > 
> > I couldn't find a good reason to restrict it, as that wouldn't change
> > the implementation much anyway. Also, if we added the right CMOs, we
> > could probably remove the unmap walker and re-express it in terms of
> > set_owner(0) ... But I suppose that is for later :-)
> 
> The idea being that if owner is 0, then we install a mapping for phys, but
> if owner is !0 then we set the invalid mapping.

And I could even special-case set_owner(0) by calling unmap under the
hood so the caller doesn't need to care, but it's a bit yuck.

> (1) is probably the less hacky option... what do you reckon?

Agreed, (1) is a bit nicer. I was also considering setting phys = BIT(63)
in the set_owner() path. That makes it obvious it is an invalid PA, and
it should retain the nice alignment properties I need. But I suppose an
explicit flag makes it easier to reason about, so I'll have a go at it.

Thanks,
Quentin
