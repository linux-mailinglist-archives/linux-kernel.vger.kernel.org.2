Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19512330F88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCHNiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCHNiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:38:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64698C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:38:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w7so6067102wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PFBRtObdnApUzRvAuScTx2Kw0ULloMz5ElbqpQCVZ4E=;
        b=DlzGUTmvsB+sDC4hIi5gNvd6CbNk1Tz0/nBGg/8SbC9YimO5Z2Ao2m8EqeETEhTmXH
         gg+bIb953rzFbi0I9YjzrON8nRevQLzIIXHIY/U/AJqjF9kTvmKnuxwuYP8I3NECMxGR
         z6/82TezvDq1Q8Jl48hOqizM545OfysJc0nESM3s9mnWvUtMu1HITc9HAcFu9oiJAotR
         F/w3ueSVFouExv1E7EOGc9FkpX5HY0bZm2Thd14AVt36z4UwYHBYGV1QiJP1Dx3RUsx/
         1UVl+XdfNd9IiYbGp5p8mmvGj/ozNnOuee7lP3M9mD6k1Boi2AtckS0mhwbZ/0MmakvB
         1SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PFBRtObdnApUzRvAuScTx2Kw0ULloMz5ElbqpQCVZ4E=;
        b=HGqUAGxlmtURChEfcxFk4G1UQQJqwww5924OPQtRdeLXJ2Ku+ufTui6/JWJrNEx2wI
         A9mAKJL0kCbkMvPfrWKuZNl0unPpE0kk9m3934/WR6InZxpilNVCTO7TkRUWcZpL/+Vd
         Qv7Szp06dFHQXXY0Rn2uoQ1xJYXjLHefREq9VJZyKXMq5YEKvX9djj1u/xDf5DCGoYgE
         9AyHfnikFCZ2Mvx6bV3fOMRLjfkUbhKmuHU9zGiE6emw3tiDNJZgCyqkam15XXYjuWNA
         Tdg5ZgB0wJnnLziBmi9zqho4DsWGQEmk3fXt6XNDIBwBEYgfjs21nEYMjgKnV05awrfG
         IijA==
X-Gm-Message-State: AOAM531BMa/ShGIWt8AWoH6gMsYA0zzdXV1IuMq5bbWSUdlWoWEBPNIP
        yOoMAgfgRBnKuUiePh3k8akN1w==
X-Google-Smtp-Source: ABdhPJxdMgJt1UHBWtl36bgUKr2lFU/ztPx2Xm8qGG8vibyqeSTLpcrl/63fHe5uBl7JNr0lG8I+yg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr22576268wme.181.1615210690018;
        Mon, 08 Mar 2021 05:38:10 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id a5sm18572985wrs.35.2021.03.08.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:38:09 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:38:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 29/32] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YEYov+r6A3uil1aU@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-30-qperret@google.com>
 <20210305192905.GE23633@willie-the-truck>
 <YEXs1cOlmhHg4u8x@google.com>
 <20210308124606.GA25879@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308124606.GA25879@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2021 at 12:46:07 (+0000), Will Deacon wrote:
> __load_stage2() _only_ has the ISB if ARM64_WORKAROUND_SPECULATIVE_AT is
> present, whereas I think you need one unconditionall here so that the
> system register write has taken effect before the TLB invalidation.
> 
> It's similar to the comment at the end of __tlb_switch_to_guest().
> 
> Having said that, I do worry that ARM64_WORKAROUND_SPECULATIVE_AT probably
> needs a closer look in the world of pKVM, since it currently special-cases
> the host.

Yes, I see that now. I'll start looking into this.

> > > > +	__tlbi(vmalls12e1is);
> > > > +	dsb(ish);
> > > 
> > > Given that the TLB is invalidated on the boot path, please can you add
> > > a comment here about the stale entries which you need to invalidate?
> > 
> > Sure -- that is for HCR bits cached in TLBs for VMID 0. Thinking about
> > it I could probably reduce the tlbi scope as well.
> > 
> > > Also, does this need to be inner-shareable? I thought this function ran on
> > > each CPU.
> > 
> > Hmm, correct, nsh should do.
> 
> Cool, then you can do that for both the TLBI and the DSB instructions (and
> please add a comment that the invalidation is due to the HCR bits).

Sure.

> > > > +static void host_stage2_unmap_dev_all(void)
> > > > +{
> > > > +	struct kvm_pgtable *pgt = &host_kvm.pgt;
> > > > +	struct memblock_region *reg;
> > > > +	u64 addr = 0;
> > > > +	int i;
> > > > +
> > > > +	/* Unmap all non-memory regions to recycle the pages */
> > > > +	for (i = 0; i < hyp_memblock_nr; i++, addr = reg->base + reg->size) {
> > > > +		reg = &hyp_memory[i];
> > > > +		kvm_pgtable_stage2_unmap(pgt, addr, reg->base - addr);
> > > > +	}
> > > > +	kvm_pgtable_stage2_unmap(pgt, addr, ULONG_MAX);
> > > 
> > > Is this just going to return -ERANGE?
> > 
> > Hrmpf, yes, that wants BIT(pgt->ia_bits) I think. And that wants testing
> > as well, clearly.
> 
> Agreed, maybe it's worth checking the return value.

Ack, and hyp_panic if != 0, but that is probably preferable anyway.

> > > > +static int host_stage2_idmap(u64 addr)
> > > > +{
> > > > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> > > > +	struct kvm_mem_range range;
> > > > +	bool is_memory = find_mem_range(addr, &range);
> > > > +	struct hyp_pool *pool = is_memory ? &host_s2_mem : &host_s2_dev;
> > > > +	int ret;
> > > > +
> > > > +	if (is_memory)
> > > > +		prot |= KVM_PGTABLE_PROT_X;
> > > > +
> > > > +	hyp_spin_lock(&host_kvm.lock);
> > > > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > > > +					      &range, pool);
> > > > +	if (is_memory || ret != -ENOMEM)
> > > > +		goto unlock;
> > > > +	host_stage2_unmap_dev_all();
> > > > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > > > +					      &range, pool);
> > > 
> > > I find this _really_ hard to reason about, as range is passed by reference
> > > and we don't reset it after the first call returns -ENOMEM for an MMIO
> > > mapping. Maybe some commentary on why it's still valid here?
> > 
> > Sure, I'll add something. FWIW, that is intended -- -ENOMEM can only be
> > caused by the call to kvm_pgtable_stage2_map() which leaves the range
> > untouched. So, as long as we don't release the lock, the range returned
> > by the first call to kvm_pgtable_stage2_idmap_greedy() should still be
> > valid. I suppose I could call kvm_pgtable_stage2_map() directly the
> > second time to make it obvious but I thought this would expose the
> > internal of kvm_pgtable_stage2_idmap_greedy() a little bit too much.
> 
> I can see it both ways, but updating the kerneldoc for
> kvm_pgtable_stage2_idmap_greedy() to state in which cases the range is
> updated and how would be helpful. It just says "negative error code on
> failure" at the moment.

Alternatively I could expose the 'reduce' path (maybe with another name
e.g. stage2_find_compatible_range() or so) and remove the
kvm_pgtable_stage2_idmap_greedy() wrapper. So it'd be the caller's
responsibility to not release the lock in between
stage2_find_compatible_range() and kvm_pgtable_stage2_map() for
instance, but that sounds reasonable to me. And that would make it
explicit it's the _map() path that failed with -ENOMEM, and that the
range can be re-used the second time.

Thoughts?

Thanks,
Quentin
