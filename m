Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952CD3DEB0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhHCKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhHCKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:37:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E5C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:37:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h13so11308232wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OfCoiih4+kjHguXqFPDXzH6cgIOlyrxD4TS+l5ysvFk=;
        b=oK1JvaEldDcXbbl7XIpC2KQbuUB307XsvhZpKIw98fEC9HM3SeC2pQ3JMF0HUSBICg
         9R/Uc4FraONJ/tY44FUQcM4ppaXjUZ2Dwth2OZi/Lblhoe/T/Y5IZ3oR36WW7xqIMmc+
         vTKjnl6ElslWknLnGL9Nr4Of+7PNlOzZ6SSJU2GiCfw6Gp35Ul7EyZiTi+5uoKIM5pGs
         V3+Y/4Po+Odcy3c7s5D3G+nOrmVDjkqAcUuM+ofq7D9NTaRJQzxBEwip3+hlRMlUVTbn
         4x+TtKjws6Vpe6vw43bShnCMM7pTkw2Xsx7OkdIeGptyb/YT/1jXxJpnISXK77hONqn0
         eaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OfCoiih4+kjHguXqFPDXzH6cgIOlyrxD4TS+l5ysvFk=;
        b=l5B8Fk2qvjEoU/2yXmMu46r2BJFx9qeRPIWI++NGliOQANqqhy0WLNOn/OwKLhF1hf
         gZtRWx/6JTzwDYwl89dHdv0OpDIUbq82uthOb7WknJDjWrbKcrdYjl1/PlXfQ5d32pOv
         0NTKFvsUUXjDRcPoQDPR5SQy9K8bGaEmGCjDl2JjPluVpUbZXbzB8l9xToX/qBCAYV1r
         b0Fifbw+grY2OHl90xAioY1w49GszB/rDXmtw3E+OLDAiTR3OrvRh9t80LyHJhdDyB04
         tqgVxTkXYwc705ArN7im3CfJSjVirA9hkCQEsc8Fd9bq91ir9Z3Ak7FhVvpv4JcCBrDm
         7QEg==
X-Gm-Message-State: AOAM530aIdONam1PjJLm7m25biYCZp47o39/4CSF6IUe1cHzhMDjSxZe
        MVt1bzdNKCZRi4M23xUaLwc05g==
X-Google-Smtp-Source: ABdhPJyuLJL7/6FQ1Dy0s9kzytBeGbU4gur4MVpvOZPD2oYaeKYjAL+sZll6yArFzRDkovagShzTCg==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr21756760wru.85.1627987028707;
        Tue, 03 Aug 2021 03:37:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id i7sm14652599wre.64.2021.08.03.03.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:37:08 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:37:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 19/21] KVM: arm64: Refactor protected nVHE stage-1
 locking
Message-ID: <YQkcUXnrqp7hsZZT@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-20-qperret@google.com>
 <CA+EHjTwWt+jvRZsk5KEhQWzn+XqdV2gZSq7oCuOCVXRa1=JiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwWt+jvRZsk5KEhQWzn+XqdV2gZSq7oCuOCVXRa1=JiWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Fuad,

On Tuesday 03 Aug 2021 at 07:31:03 (+0200), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Thu, Jul 29, 2021 at 3:29 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
> > a new pkvm_create_mappings_locked() function. This will be used in later
> > patches to allow walking and changing the hypervisor stage-1 without
> > releasing the lock.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
> >  arch/arm64/kvm/hyp/nvhe/mm.c         | 18 ++++++++++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > index 8ec3a5a7744b..c76d7136ed9b 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > @@ -23,6 +23,7 @@ int hyp_map_vectors(void);
> >  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
> >  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
> >  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
> >  int __pkvm_create_mappings(unsigned long start, unsigned long size,
> >                            unsigned long phys, enum kvm_pgtable_prot prot);
> >  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> > index a8efdf0f9003..6fbe8e8030f6 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> > @@ -67,13 +67,15 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> >         return addr;
> >  }
> >
> > -int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> > +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
> >  {
> >         unsigned long start = (unsigned long)from;
> >         unsigned long end = (unsigned long)to;
> >         unsigned long virt_addr;
> >         phys_addr_t phys;
> >
> > +       hyp_assert_lock_held(&pkvm_pgd_lock);
> > +
> >         start = start & PAGE_MASK;
> >         end = PAGE_ALIGN(end);
> >
> > @@ -81,7 +83,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >                 int err;
> >
> >                 phys = hyp_virt_to_phys((void *)virt_addr);
> > -               err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
> > +               err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
> > +                                         phys, prot);
> >                 if (err)
> >                         return err;
> >         }
> > @@ -89,6 +92,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >         return 0;
> >  }
> >
> > +int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> > +{
> > +       int ret;
> > +
> > +       hyp_spin_lock(&pkvm_pgd_lock);
> > +       ret = pkvm_create_mappings_locked(from, to, prot);
> > +       hyp_spin_unlock(&pkvm_pgd_lock);
> > +
> > +       return ret;
> > +}
> > +
> 
> I'm wondering whether this patch should also refactor
> __pkvm_create_mappings. It doesn't quite do the exact same thing and
> has different parameters.

Sorry, not sure I'm understanding your suggestion here. What do you
think should be done to __pkvm_create_mappings?

Cheers,
Quentin
