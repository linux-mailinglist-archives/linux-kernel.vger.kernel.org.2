Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4B3D0FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhGUM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhGUMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:55:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F11C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:35:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso998608wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THtvL95+Wdg5XKa0Q6wjHIENl0Y9TZHt3CwdcuBkgF8=;
        b=dYzzqSbTcHoAKX52adHhFah33UAvJMaxB1AIimYVp8/ShQNJyvzpQuyW4v9H9wQS7C
         9oUflpJc11rRJeujwNJ/0OaIN7oOBEwVF7hMZpgJorzEtN81xw7UznEeWpFXOCMU+9Yf
         vvlCvBwEaXtKD+Mit2oA1qgc2x2cQOCvdQD8ad6Jmyx3IV+U1K1ht0zp7+FRoLComa9z
         7nyg//dnCxl4r1LGd2OmqdUp+AIhctUAyBKbvsw/8+fgpsxlsGVuOTjFWbitTHU3+qua
         iXTTZxxsP4ssGpvdcORzQIsJquYp1mYs6zK7WvpK/a82z1I5x6mBKwGwDf4o5qiqrpRR
         CN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THtvL95+Wdg5XKa0Q6wjHIENl0Y9TZHt3CwdcuBkgF8=;
        b=JzKW+kpNgaZ4XGKuRNR7rH0Nt+z7NaI7MMZs8N0Zs4v1+2M/gRBX3LQZv7a98yZ72b
         gMJFH2nrcPeAmS4955mi0Uoi/cJTdxKTxrC+wzhj/bA5feCF6BgY1/AiLXgGRY+fISUW
         o6whZgLLXvq5iKixL++0qp0/nc+r2qJ7+r27fax65zXDZSI6NXYFnsQCb51CXI2jtnRj
         h5wKy0vq+MGTDk4/dgl8rmBEbpyO2xQkjN+Obo3GxWXNiuoDCKc2kTEQI9URgZl7uFOY
         wbtserPtIRFEpdYV1t8cW2Nux1+vZFcBIR27eymXzX9cZghk7QJbYG/qVV80z77Z202y
         WELA==
X-Gm-Message-State: AOAM530oceHcWFn2+7GiGJ3Iop3zXeuZDB3N+1TajA8qIgu67N5tBfap
        dvPHubvvxuW67IMaBUshLoRxwQ==
X-Google-Smtp-Source: ABdhPJyciOXfOFa9KQ+iYzD+QsJY74g96fGc86hUOZHCThYzhTYjYByChhSiI5DH0qDjIx7s8PRrdA==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr4197684wmb.27.1626874534544;
        Wed, 21 Jul 2021 06:35:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:efb1:2fcc:e84:52ad])
        by smtp.gmail.com with ESMTPSA id e11sm33189602wrt.0.2021.07.21.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:35:34 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:35:30 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 13/14] KVM: arm64: Restrict hyp stage-1 manipulation in
 protected mode
Message-ID: <YPgion9+okAtvkr4@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-14-qperret@google.com>
 <CA+EHjTzpoX+rLQHwUbR3BVY_XJEWERiG4AGk7SW6GDtDFC_cuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzpoX+rLQHwUbR3BVY_XJEWERiG4AGk7SW6GDtDFC_cuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuad,

On Wednesday 21 Jul 2021 at 11:45:53 (+0100), Fuad Tabba wrote:
> > +static int hyp_range_is_shared_walker(u64 addr, u64 end, u32 level,
> > +                                     kvm_pte_t *ptep,
> > +                                     enum kvm_pgtable_walk_flags flag,
> > +                                     void * const arg)
> > +{
> > +       enum kvm_pgtable_prot prot;
> > +       kvm_pte_t pte = *ptep;
> > +
> > +       if (!kvm_pte_valid(pte))
> > +               return -EPERM;
> > +
> > +       prot = kvm_pgtable_hyp_pte_prot(pte);
> > +       if (!prot)
> > +               return -EPERM;
> nit: is this check necessary?

I guess not, the next one should do, I'll remove :)

> > +       /* Check that the page has been shared with the hypervisor before */
> > +       if (prot != (PAGE_HYP | KVM_PGTABLE_STATE_SHARED | KVM_PGTABLE_STATE_BORROWED))
> > +               return -EPERM;
> > +
> > +       return 0;
> > +}
> > +
> > +static int hyp_range_is_shared(phys_addr_t start, phys_addr_t end)
> > +{
> > +       struct kvm_pgtable_walker walker = {
> > +               .cb = hyp_range_is_shared_walker,
> > +               .flags = KVM_PGTABLE_WALK_LEAF,
> > +       };
> > +
> > +       return kvm_pgtable_walk(&pkvm_pgtable, (u64)__hyp_va(start),
> > +                               end - start, &walker);
> > +}
> > +
> > +static int check_host_share_hyp_walker(u64 addr, u64 end, u32 level,
> 
> nit: It seems the convention is usually addr,size or start,end. Here
> you're using addr,end.

Well for some reason all the walkers in pgtable.c follow the addr,end
convention, so I followed that. But in fact, as per [1] I might actually
get rid of this walker in v2, so hopefully that'll make the issue go
away.

[1] https://lore.kernel.org/kvmarm/YPbwmVk1YD9+y7tr@google.com/

> > +                                      kvm_pte_t *ptep,
> > +                                      enum kvm_pgtable_walk_flags flag,
> > +                                      void * const arg)
> > +{
> > +       enum kvm_pgtable_prot prot;
> > +       kvm_pte_t pte = *ptep;
> > +
> > +       /* If invalid, only allow to share pristine pages */
> > +       if (!kvm_pte_valid(pte))
> > +               return pte ? -EPERM : 0;
> > +
> > +       prot = kvm_pgtable_stage2_pte_prot(pte);
> > +       if (!prot)
> > +               return -EPERM;
> > +
> > +       /* Cannot share a page that is not owned */
> > +       if (prot & KVM_PGTABLE_STATE_BORROWED)
> > +               return -EPERM;
> > +
> > +       /* Cannot share a page with restricted access */
> > +       if ((prot & KVM_PGTABLE_PROT_RWX) ^ KVM_PGTABLE_PROT_RWX)
> nit: isn't this clearer as
> 
> if ((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RWX)

I guess it would be, I'll fix it up.

> > +               return -EPERM;
> > +
> > +       /* Allow double-sharing (requires cross-checking the hyp stage-1) */
> > +       if (prot & KVM_PGTABLE_STATE_SHARED)
> > +               return hyp_range_is_shared(addr, addr + 1);
> 
> Why addr+1, rather than end?

Because 'end' here is the 'end' that was passed to kvm_pgtable_walk()
IIRC. What I want to do here is check if the page I'm currently visiting
is already shared and if so, that it is shared with the hypervisor. But
it's possible that only one page in the range of pages passed to
__pkvm_host_share_hyp is already shared, so I need to check them one by
one.

Anyways, as per the discussion with Marc on [2], I'll probably switch to
only accept sharing one page at a time, so all these issues should just
go away as well!

[2] https://lore.kernel.org/kvmarm/YPa6BGuUFjw8do+o@google.com/

> > +
> > +       return 0;
> > +}
> > +
> > +static int check_host_share_hyp(phys_addr_t start, phys_addr_t end)
> > +{
> > +       struct kvm_pgtable_walker walker = {
> > +               .cb = check_host_share_hyp_walker,
> > +               .flags = KVM_PGTABLE_WALK_LEAF,
> > +       };
> > +
> > +       return kvm_pgtable_walk(&host_kvm.pgt, start, end - start, &walker);
> > +}
> > +
> > +int __pkvm_host_share_hyp(phys_addr_t start, phys_addr_t end)
> > +{
> > +       enum kvm_pgtable_prot prot;
> > +       int ret;
> > +
> > +       if (!range_is_memory(start, end))
> > +               return -EINVAL;
> > +
> > +       hyp_spin_lock(&host_kvm.lock);
> > +       hyp_spin_lock(&pkvm_pgd_lock);
> > +
> > +       ret = check_host_share_hyp(start, end);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       prot = KVM_PGTABLE_PROT_RWX | KVM_PGTABLE_STATE_SHARED;
> > +       ret = host_stage2_idmap_locked(start, end, prot);
> 
> Just for me to understand this better. The id mapping here, which
> wasn't taking place before this patch, is for tracking, right?

Yes, exactly, I want to make sure to mark the page as shared (and
borrowed) in the relevant page-tables to not forget about it :)

Cheers,
Quentin
