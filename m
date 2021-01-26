Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67985304FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhA0Diu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbhAZV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:58:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD23C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:57:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d13so36874575ioy.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzIIbucA4bC6xAjzO2jcPxCgJ/XeeTQ4qXoBAmEcaOk=;
        b=g6CgGnRpd+qLDrILoQ7nOEPH/CE1ETMeTy3S64nip4FzcZSb8oA+QPHUt5VDb05MVr
         +sz8aE/6e8dA2dV/5GW2KmbA17jVx8Nmfvl5hZ3Or7r+cLusIeHoBI5tswBbxy0stxYx
         KOcDwxjLeDlotaR0+/Q3Z5RQCtY5Iz6MqCw3+Gz3AkckgQImOcVIvi9g1w21ItQOdCiu
         GXlnZ6ItkiHna/5rFXB4iLR04Qp8rEuxVVMuKTtvOONUjdPRuyuqHF0UDl2ZD1jOIDZI
         1iEs6EgXhQaOI5THL/i1VRvouJQ/BNO9UtzQFybhTAwifLZedoiXwKTjqCNbQuKfMiXw
         1XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzIIbucA4bC6xAjzO2jcPxCgJ/XeeTQ4qXoBAmEcaOk=;
        b=POi184fOq6YJhxTT8sbUvTiRcvcN7C0dBfXq5FWjjegUqQznJ/pBBD6imzXuUM3s+O
         ZfYSWsg/18Pq9BQZxPJv1HcmMqesVowOMzFEH5vUt7zwiPQCMfD7/1Wb/QfY+3Pe9Y8D
         A4RmkNAf0+qf04i7oEsCuGfmIOadYjhyIuQwTJiBVSeLl5U9bRjm9DcNQKQBPB+7cQp+
         Y8Mu9C3DreuABjls+USqLiEiOT7ZVChAwB7lYv2vJp9B1f9TceGyYwrTDY3JoFDUgG5N
         j5MSUpQvkVdI4/Y5DuyeFVosb8A38SWqFXYQ3wMjErmDcceM3KP9V5gnI7Cgx6HqE2kD
         gv4Q==
X-Gm-Message-State: AOAM530roM4BD1p6UoU57eg/iZISMUOpAMo6h0GQEBgYofTW8gHUZaCw
        gVUmFMruv2hKo/G2QTEQ0jB2pp7stboZpVxEp7cIXy/UR8Y=
X-Google-Smtp-Source: ABdhPJxqw2qcccBRAqNzGfQXEgTuriBNf/YTsOm5i+pyKUht1H9HnSkCEGDyjzIvh73pIGntxSycMx/Bd7zwrTPgXFk=
X-Received: by 2002:a92:60f:: with SMTP id x15mr3828071ilg.203.1611698264748;
 Tue, 26 Jan 2021 13:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-25-bgardon@google.com>
 <YAjRGBu5tAEt9xpv@google.com>
In-Reply-To: <YAjRGBu5tAEt9xpv@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 26 Jan 2021 13:57:33 -0800
Message-ID: <CANgfPd_dCNQHWMtWDJiC5prVC9R4gtNO6v5L3=QioNZLDDXVMw@mail.gmail.com>
Subject: Re: [PATCH 24/24] kvm: x86/mmu: Allow parallel page faults for the
 TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:56 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 12, 2021, Ben Gardon wrote:
> > Make the last few changes necessary to enable the TDP MMU to handle page
> > faults in parallel while holding the mmu_lock in read mode.
> >
> > Reviewed-by: Peter Feiner <pfeiner@google.com>
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 280d7cd6f94b..fa111ceb67d4 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3724,7 +3724,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> >               return r;
> >
> >       r = RET_PF_RETRY;
> > -     kvm_mmu_lock(vcpu->kvm);
> > +
> > +     if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
>
> Off topic, what do you think about rewriting is_tdp_mmu_root() to be both more
> performant and self-documenting as to when is_tdp_mmu_root() !=
> kvm->arch.tdp_mmu_enabled?  E.g. key off is_guest_mode() and then do a thorough
> audit/check when CONFIG_KVM_MMU_AUDIT=y?
>
> #ifdef CONFIG_KVM_MMU_AUDIT
> bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
> {
>         struct kvm_mmu_page *sp;
>
>         if (!kvm->arch.tdp_mmu_enabled)
>                 return false;
>         if (WARN_ON(!VALID_PAGE(hpa)))
>                 return false;
>
>         sp = to_shadow_page(hpa);
>         if (WARN_ON(!sp))
>                 return false;
>
>         return sp->tdp_mmu_page && sp->root_count;
> }
> #endif
>
> bool is_tdp_mmu(struct kvm_vcpu *vcpu)
> {
>         bool is_tdp_mmu = kvm->arch.tdp_mmu_enabled && !is_guest_mode(vcpu);
>
> #ifdef CONFIG_KVM_MMU_AUDIT
>         WARN_ON(is_tdp_mmu != is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa));
> #endif
>         return is_tdp_mmu;
> }

Great suggestions. In the interest of keeping this (already enormous)
series small, I'm inclined to make those changes in a future series if
that's alright with you.

>
> > +             kvm_mmu_lock_shared(vcpu->kvm);
> > +     else
> > +             kvm_mmu_lock(vcpu->kvm);
> > +
> >       if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
> >               goto out_unlock;
> >       r = make_mmu_pages_available(vcpu);
> > @@ -3739,7 +3744,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> >                                prefault, is_tdp);
> >
> >  out_unlock:
> > -     kvm_mmu_unlock(vcpu->kvm);
> > +     if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> > +             kvm_mmu_unlock_shared(vcpu->kvm);
> > +     else
> > +             kvm_mmu_unlock(vcpu->kvm);
> >       kvm_release_pfn_clean(pfn);
> >       return r;
> >  }
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
