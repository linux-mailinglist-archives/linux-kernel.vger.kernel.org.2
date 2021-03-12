Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F274A338BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhCLLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhCLLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:45:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1292C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:45:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w11so4610234wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ds53V4cY3JN7oKXrFWCOBzvFttSgaekliXgO0438ZQk=;
        b=NaNqBxCg7RA8yrBFVfqbNfzzF4xqk2O2uZcCen2sIu+xVWsrfoqqK18rK40AkQAXYv
         4xPNke/FcZ8lN6k6CupjvgTlklHJDKVIZ/1phZihJOD2NGUrg+afORGarmTUzdDSGXgB
         ioHwnQhNVHMbtnCl8nYqLFzaH8Kv1NEpm4PXXNoXMQZ79S6upOSplsRV+7o6DUtDjH4w
         BZxP37/DIL9/FYr1oQpOE2zPswaNRenFpjhOIST/MeCMBL/SOLmOgprjYNl5r6PSe8df
         /l0eiEQRPtMRcVfImTQfKvgekrhZm4ARlnX5P6+5KCKTvn4LCkNzPfa3I21C/sUNS9ZR
         v61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ds53V4cY3JN7oKXrFWCOBzvFttSgaekliXgO0438ZQk=;
        b=fEK8wsKyIylUBmflvkMp0YPi5LusqicUKhHIthOowHlCZX7n/ZC4kjvRkY4La18RYR
         TvxwPxEEcyB/eU3yqc4Gc1O7BeA//K+P0lAmjPscOI9MmnkZ4HFf43CxAuZO+lZTnUrc
         LXAzvZTDOqcTLvL96kr72JQ6SEgSZQ0QufDktpmEWUEuQdRuvS8LJJD8RHPU6h9E7F6h
         Nj9yaTrb3/wrQj6O2uqOWq9mqMjbCiYVczZ9+UUpNE68TbU4ZC42RSM7EA7NZD9SJlVU
         LeBLdLrhxh7iCSE8oN/W0Q+lrC0tXwjmahMBx9SBeRN5pvlZGgBP4HIBDplTdjurv+G9
         XJjA==
X-Gm-Message-State: AOAM531R033l77Gs6cBe9m5fJTnnbCxYns+9f5A5K0gk/3DhuxDM0iR0
        9JbfOjbqymmiG004lOdhkt4nNw==
X-Google-Smtp-Source: ABdhPJzAmI4E7/mrpYDo8qpBbI6XmHQnBQTiRQcL/26LsC9ALUUI0VO1SMvgcMoSDR1OehuPJKbnaw==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr13234945wrw.422.1615549529236;
        Fri, 12 Mar 2021 03:45:29 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id 1sm1933768wmj.2.2021.03.12.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:45:28 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:45:26 +0000
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
Message-ID: <YEtUVriUSi/MFGit@google.com>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-29-qperret@google.com>
 <20210311183834.GC31378@willie-the-truck>
 <YEsIxA/fKaDlSaio@google.com>
 <20210312093205.GB32016@willie-the-truck>
 <YEs+xi6IDj3gwX10@google.com>
 <20210312111804.GB32208@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312111804.GB32208@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2021 at 11:18:05 (+0000), Will Deacon wrote:
> On Fri, Mar 12, 2021 at 10:13:26AM +0000, Quentin Perret wrote:
> > On Friday 12 Mar 2021 at 09:32:06 (+0000), Will Deacon wrote:
> > > I'm not saying to use the VMID directly, just that allocating half of the
> > > pte feels a bit OTT given that the state of things after this patch series
> > > is that we're using exactly 1 bit.
> > 
> > Right, and that was the reason for the PROT_NONE approach in the
> > previous version, but we agreed it'd be worth generalizing to allow for
> > future use-cases :-)
> 
> Yeah, just generalising to 32 bits feels like going too far! I dunno,
> make it a u8 for now, or define the hypervisor owner ID as 1 and reject
> owners greater than that? We can easily extend it later.

Alrighty I'll do _both_

> > > > > > @@ -517,28 +543,36 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > > > > >  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> > > > > >  		return -E2BIG;
> > > > > >  
> > > > > > -	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > > > > > -	if (kvm_pte_valid(old)) {
> > > > > > +	if (kvm_pte_valid(data->attr))
> > > > > 
> > > > > This feels like a bit of a hack to me: the 'attr' field in stage2_map_data
> > > > > is intended to correspond directly to the lower/upper attributes of the
> > > > > descriptor as per the architecture, so tagging the valid bit in there is
> > > > > pretty grotty. However, I can see the significant advantage in being able
> > > > > to re-use the stage2_map_walker functionality, so about instead of nobbling
> > > > > attr, you set phys to something invalid instead, e.g.:
> > > > > 
> > > > > 	#define KVM_PHYS_SET_OWNER	(-1ULL)
> > > > 
> > > > That'll confuse kvm_block_mapping_supported() and friends I think, at
> > > > least in their current form. If you _really_ don't like this, maybe we
> > > > could have an extra 'flags' field in stage2_map_data?
> > > 
> > > I was pondering this last night and I thought of two ways to do it:
> > > 
> > > 1. Add a 'bool valid' and then stick the owner and the phys in a union.
> > >    (yes, you'll need to update the block mapping checks to look at the
> > >     valid flag)
> > 
> > Right, though that is also used for the hyp s1 which doesn't use any of
> > this ATM. That shouldn't be too bad to change, I'll have a look.
> 
> Oh, I meant stick the bool in the stage2_map_data so that should be limited
> to the stage2 path.

I mean I still want to use kvm_block_mapping_supported() but ignore the
phys check when it's not valid. I find it ugly to add a 'valid'
parameter to the function itself, so maybe we're better off with just
special casing phys == -1ULL as you first suggested. How much do you hate
the below (totally untested)?

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8e4599256969..9ec937462fd6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -71,6 +71,13 @@ static u64 kvm_granule_size(u32 level)
        return BIT(kvm_granule_shift(level));
 }

+#define KVM_PHYS_INVALID (-1ULL)
+
+static bool kvm_phys_is_valid(u64 phys)
+{
+       return phys != KVM_PHYS_INVALID;
+}
+
 static bool kvm_level_support_block_mappings(u32 level)
 {
        /*
@@ -90,7 +97,10 @@ static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
        if (granule > (end - addr))
                return false;

-       return IS_ALIGNED(addr, granule) && IS_ALIGNED(phys, granule);
+       if (kvm_phys_is_valid(phys) && !IS_ALIGNED(phys, granule))
+               return false;
+
+       return IS_ALIGNED(addr, granule);
 }

 static u32 kvm_pgtable_idx(struct kvm_pgtable_walk_data *data, u32 level)
@@ -550,7 +560,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
        if (!kvm_block_mapping_supported(addr, end, phys, level))
                return -E2BIG;

-       if (kvm_pte_valid(data->attr))
+       if (kvm_phys_is_valid(phys))
                new = kvm_init_valid_leaf_pte(phys, data->attr, level);
        else
                new = kvm_init_invalid_leaf_owner(data->owner_id);
@@ -580,7 +590,8 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
        smp_store_release(ptep, new);
        if (stage2_pte_is_counted(new))
                mm_ops->get_page(ptep);
-       data->phys += granule;
+       if (kvm_phys_is_valid(phys))
+               data->phys += granule;
        return 0;
 }

@@ -739,9 +750,6 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
        if (ret)
                return ret;

-       /* Set the valid flag to distinguish with the set_owner() path. */
-       map_data.attr |= KVM_PTE_VALID;
-
        ret = kvm_pgtable_walk(pgt, addr, size, &walker);
        dsb(ishst);
        return ret;
@@ -752,6 +760,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 {
        int ret;
        struct stage2_map_data map_data = {
+               .phys           = KVM_PHYS_INVALID,
                .mmu            = pgt->mmu,
                .memcache       = mc,
                .mm_ops         = pgt->mm_ops,



