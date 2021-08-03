Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0155F3DEB2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHCKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhHCKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:43:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:43:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso1443344wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yf8CYtfpcYFP2kmmB7d8YySkiG5qMULsKJdwwdNKGdo=;
        b=Xkiwr86aB2b2IXXyQ3phMRfh8j3QEJwOW7FaShfOp1omNRlMQWdhDJdftT6kLOdoXj
         OF27SQRuNeKZ6jACRqI28pFLd2PjfeCpMs/uH20SdNEERHpOcMNe9l6tPazr2405LMNF
         66NnQjUg7OmdHTKYTMai1NebDBdvZCPsScPC4lz5MsjMpUOek1wUIHGerM9NWqdK5YpN
         1BSoe4cffaRhlstFm5B7iu/oWRtTkTMJd6J9I2cy+30cL9nDA5jFHY4XGKJYgjyv0pLW
         NBX7by79WZj5GrWezI0pd1FNLQGRdnKzTmBMfeWBn6nysNzSfixSF/oWcKHaIviptQyy
         ysxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yf8CYtfpcYFP2kmmB7d8YySkiG5qMULsKJdwwdNKGdo=;
        b=taA+tQEgK/OyJZz3exnixHCv6QBpTl1dRZQYfj7/2BNiUQ/mCTmqBhGgYBHAfDvnpR
         A/wsvtIIp+tHnYLQi4pHNgq7jhuq+sjAqm7Tg+z5bAwS+SdQ0XhkLREIzHvznFUsNFrB
         h5LsRloHj9YjJP8wXWsO14EQrtO0mC1DXeuj/z7+2rywkRSrQf+tzUU1nbiv6xgzRAl3
         j+QMsBgj26C6FqX1scQsqMVYL5hITT1xwVyS/Uv3IiLClTQESrMMACo/TBAZ8SHw9THM
         5SQyRWevdbHaxtqrdl8S8rhO3iAtupD+gol/oljwT5XVU6rQ77mUIFNSEqqI4JCUpvPi
         QZHg==
X-Gm-Message-State: AOAM533r+ipa4/AUyRU/WQk+yLnAutCPuo2yUMSM1rkm+B3AV5f348QM
        Vsf54JeBM1xGdNtAm8IZn2I0DA==
X-Google-Smtp-Source: ABdhPJyIy4ipDSmV4jxH9j18cKuik8k9waAqFprPdKpKXfO5PYVYNRiwJnu2X48LUmk/Ifz3OBSMeA==
X-Received: by 2002:a7b:c930:: with SMTP id h16mr21943168wml.2.1627987409823;
        Tue, 03 Aug 2021 03:43:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id x9sm2162756wmj.41.2021.08.03.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:43:29 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:43:26 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 20/21] KVM: arm64: Restrict EL2 stage-1 changes in
 protected mode
Message-ID: <YQkdztIHwXfj7Sbc@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-21-qperret@google.com>
 <CA+EHjTw7W=5JqH+oZAqLPrf_6222eazDnSk24h4EuGE1VLwKYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw7W=5JqH+oZAqLPrf_6222eazDnSk24h4EuGE1VLwKYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 Aug 2021 at 10:22:03 (+0200), Fuad Tabba wrote:
> Hi Quentin,
> 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 0ccea58df7e0..1b67f562b6fc 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -338,6 +338,95 @@ static int host_stage2_idmap(u64 addr)
> >         return ret;
> >  }
> >
> > +static inline bool check_prot(enum kvm_pgtable_prot prot,
> > +                             enum kvm_pgtable_prot required,
> > +                             enum kvm_pgtable_prot denied)
> > +{
> > +       return (prot & (required | denied)) == required;
> > +}
> > +
> > +int __pkvm_host_share_hyp(u64 pfn)
> > +{
> > +       phys_addr_t addr = hyp_pfn_to_phys(pfn);
> > +       enum kvm_pgtable_prot prot, cur;
> > +       void *virt = __hyp_va(addr);
> > +       enum pkvm_page_state state;
> > +       kvm_pte_t pte;
> > +       u32 level;
> > +       int ret;
> > +
> > +       if (!range_is_memory(addr, addr + PAGE_SIZE))
> > +               return -EINVAL;
> > +
> > +       hyp_spin_lock(&host_kvm.lock);
> > +       hyp_spin_lock(&pkvm_pgd_lock);
> > +
> > +       ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
> > +       if (ret)
> > +               goto unlock;
> > +       if (!pte)
> > +               goto map_shared;
> 
> Should this check whether kvm_pte_valid as well, is that guaranteed to
> always be the case, or implicitly handled later?

Yep, this is implicitly handled by kvm_pgtable_stage2_pte_prot() which
is guaranteed not to return KVM_PGTABLE_PROT_RWX for an invalid mapping.

> > +
> > +       /*
> > +        * Check attributes in the host stage-2 PTE. We need the page to be:
> > +        *  - mapped RWX as we're sharing memory;
> > +        *  - not borrowed, as that implies absence of ownership.
> > +        * Otherwise, we can't let it got through
> > +        */
> > +       cur = kvm_pgtable_stage2_pte_prot(pte);
> > +       prot = pkvm_mkstate(0, PKVM_PAGE_SHARED_BORROWED);
> > +       if (!check_prot(cur, KVM_PGTABLE_PROT_RWX, prot)) {
> > +               ret = -EPERM;
> > +               goto unlock;
> > +       }
> > +
> > +       state = pkvm_getstate(cur);
> > +       if (state == PKVM_PAGE_OWNED)
> > +               goto map_shared;
> > +
> > +       /*
> > +        * Tolerate double-sharing the same page, but this requires
> > +        * cross-checking the hypervisor stage-1.
> > +        */
> > +       if (state != PKVM_PAGE_SHARED_OWNED) {
> > +               ret = -EPERM;
> > +               goto unlock;
> > +       }
> > +
> > +       ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, &level);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       /*
> > +        * If the page has been shared with the hypervisor, it must be
> > +        * SHARED_BORROWED already.
> > +        */
> 
> This comment confused me at first, but then I realized it's referring
> to the page from the hyp's point of view. Could you add something to
> the comment to that effect?

Sure thing.

> It might also make it easier to follow if the variables could be
> annotated to specify whether cur, state, and prot are the host's or
> hyps (and not reuse the same one for both).
> 
> > +       cur = kvm_pgtable_hyp_pte_prot(pte);
> > +       prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
> > +       if (!check_prot(cur, prot, ~prot))
> > +               ret = EPERM;
> > +       goto unlock;
> > +
> > +map_shared:
> > +       /*
> > +        * If the page is not yet shared, adjust mappings in both page-tables
> > +        * while both locks are held.
> > +        */
> > +       prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
> > +       ret = pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, prot);
> > +       BUG_ON(ret);
> > +
> > +       prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_OWNED);
> > +       ret = host_stage2_idmap_locked(addr, addr + PAGE_SIZE, prot);
> > +       BUG_ON(ret);
> > +
> > +unlock:
> > +       hyp_spin_unlock(&pkvm_pgd_lock);
> > +       hyp_spin_unlock(&host_kvm.lock);
> > +
> > +       return ret;
> > +}
> > +
> >  void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
> >  {
> >         struct kvm_vcpu_fault_info fault;
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 0625bf2353c2..cbab146cda6a 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -259,10 +259,8 @@ static int __create_hyp_mappings(unsigned long start, unsigned long size,
> >  {
> >         int err;
> >
> > -       if (!kvm_host_owns_hyp_mappings()) {
> > -               return kvm_call_hyp_nvhe(__pkvm_create_mappings,
> > -                                        start, size, phys, prot);
> > -       }
> > +       if (WARN_ON(!kvm_host_owns_hyp_mappings()))
> > +               return -EINVAL;
> >
> >         mutex_lock(&kvm_hyp_pgd_mutex);
> >         err = kvm_pgtable_hyp_map(hyp_pgtable, start, size, phys, prot);
> > @@ -282,6 +280,21 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
> >         }
> >  }
> >
> > +static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
> > +{
> > +       phys_addr_t addr;
> > +       int ret;
> > +
> > +       for (addr = ALIGN_DOWN(start, PAGE_SIZE); addr < end; addr += PAGE_SIZE) {
> > +               ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
> > +                                       __phys_to_pfn(addr));
> 
> I guess we don't expect this to happen often, but I wonder if it would
> be better to have the looping in the hyp call rather than here, to
> reduce the number of hyp calls when sharing.

Yes, I was wondering the same thing, but ended up doing the looping here
to avoid spending long periods of time in a non-preemptible state at
EL2. Probably doesn't make a big difference for now, but it might if we
ever need to share large memory regions.

Cheers,
Quentin

> 
> Thanks,
> /fuad
> 
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
> >   * @from:      The virtual kernel start address of the range
> > @@ -302,6 +315,13 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >         if (is_kernel_in_hyp_mode())
> >                 return 0;
> >
> > +       if (!kvm_host_owns_hyp_mappings()) {
> > +               if (WARN_ON(prot != PAGE_HYP))
> > +                       return -EPERM;
> > +               return pkvm_share_hyp(kvm_kaddr_to_phys(from),
> > +                                     kvm_kaddr_to_phys(to));
> > +       }
> > +
> >         start = start & PAGE_MASK;
> >         end = PAGE_ALIGN(end);
> >
> > --
> > 2.32.0.432.gabb21c7263-goog
> >
