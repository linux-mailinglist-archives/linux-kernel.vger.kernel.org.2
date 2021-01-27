Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB83061BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhA0RSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhA0RPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:45 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:15:04 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w18so1595141pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MQopOgKi9I0dqqHp3bWWcA7RiGYJUqWcMoI+s76k8qI=;
        b=UxqTGJl8PhWaswBfpUw2xI2ClpcgdAiFxFuesEfI5mq96QTfyBWHXICqsvkyHlPToa
         E2/Xh6e4A9ElefIaReP8Ye67OL3sLcbea25PycjgHUfQDPLozqVRCrxipVgdmQT3ABe0
         C2WpVRaJ9Vcjg+IU/Hj5wDR0GV9DUA85GDPlyaDye3CQXoEHa4MVf1YrSD9Xd3uKpdEl
         6RBId/c8g7HR0fxVG+k1uYsaoDAMjujQLbAFe1TCKIGsDyv6U3dXjmht54sfPk8PudOy
         skVFJQz/byVhMdBFrU8GjLrpkPp1OrOU/cxpcbAKzVhU/p8SKMZSUe5aKvK1U4b3w1MC
         ErbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQopOgKi9I0dqqHp3bWWcA7RiGYJUqWcMoI+s76k8qI=;
        b=gTT/Ufj6a1PUYWMUX+mj7QUL87E/P6l28povl6gIbztHXObNoLv1u5v5mKrSoHa8PX
         UP+b2TJ9CT6CxbUeOAaIYGXu9XycPL0/G6obNVHy9SMqvFKPsIQHpj74JhVlnzP8aFDx
         wHHPhXfmudShb5B51jtTYcErTzjS0vGtVISU5YQJlSbCaHnb0gJ7jw+LxZLZKHpOCQHq
         wIvGwSAhEbHIYUXZFuJobXxILcaskh3WMLvYJt+Za4PnEYmjKI6JVfLVvBPuLbFgpHm6
         Ww6peg+xGMKf408PUY5RJDKkXffXQyZ2zwfdaEwi2IwfKSoulAYycMFnoXMsomVQdXCD
         ngxA==
X-Gm-Message-State: AOAM530bHlJbEa3qjDTtWgIzpDfVfAfJIA2B6bng1F8ea7W5NAn0nxfp
        AkXypUj6lmWhHzgLKdQjMxYAPg==
X-Google-Smtp-Source: ABdhPJxQ1RaIGVpFBFnucbCFfVhkpr4+n8JC97Q9uWl9YvrbtUevZebjHZPzm178deKEAjmPNhpjRA==
X-Received: by 2002:a62:1897:0:b029:1bd:ad37:3061 with SMTP id 145-20020a6218970000b02901bdad373061mr11606004pfy.6.1611767704259;
        Wed, 27 Jan 2021 09:15:04 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id r194sm3053529pfr.168.2021.01.27.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:15:03 -0800 (PST)
Date:   Wed, 27 Jan 2021 09:14:57 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
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
Subject: Re: [PATCH 24/24] kvm: x86/mmu: Allow parallel page faults for the
 TDP MMU
Message-ID: <YBGfka+E/+nYGm4P@google.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-25-bgardon@google.com>
 <YAjRGBu5tAEt9xpv@google.com>
 <CANgfPd_dCNQHWMtWDJiC5prVC9R4gtNO6v5L3=QioNZLDDXVMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_dCNQHWMtWDJiC5prVC9R4gtNO6v5L3=QioNZLDDXVMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021, Ben Gardon wrote:
> On Wed, Jan 20, 2021 at 4:56 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Jan 12, 2021, Ben Gardon wrote:
> > > Make the last few changes necessary to enable the TDP MMU to handle page
> > > faults in parallel while holding the mmu_lock in read mode.
> > >
> > > Reviewed-by: Peter Feiner <pfeiner@google.com>
> > >
> > > Signed-off-by: Ben Gardon <bgardon@google.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 280d7cd6f94b..fa111ceb67d4 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -3724,7 +3724,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> > >               return r;
> > >
> > >       r = RET_PF_RETRY;
> > > -     kvm_mmu_lock(vcpu->kvm);
> > > +
> > > +     if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> >
> > Off topic, what do you think about rewriting is_tdp_mmu_root() to be both more
> > performant and self-documenting as to when is_tdp_mmu_root() !=
> > kvm->arch.tdp_mmu_enabled?  E.g. key off is_guest_mode() and then do a thorough
> > audit/check when CONFIG_KVM_MMU_AUDIT=y?
> >
> > #ifdef CONFIG_KVM_MMU_AUDIT
> > bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
> > {
> >         struct kvm_mmu_page *sp;
> >
> >         if (!kvm->arch.tdp_mmu_enabled)
> >                 return false;
> >         if (WARN_ON(!VALID_PAGE(hpa)))
> >                 return false;
> >
> >         sp = to_shadow_page(hpa);
> >         if (WARN_ON(!sp))
> >                 return false;
> >
> >         return sp->tdp_mmu_page && sp->root_count;
> > }
> > #endif
> >
> > bool is_tdp_mmu(struct kvm_vcpu *vcpu)
> > {
> >         bool is_tdp_mmu = kvm->arch.tdp_mmu_enabled && !is_guest_mode(vcpu);
> >
> > #ifdef CONFIG_KVM_MMU_AUDIT
> >         WARN_ON(is_tdp_mmu != is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa));
> > #endif
> >         return is_tdp_mmu;
> > }
> 
> Great suggestions. In the interest of keeping this (already enormous)
> series small, I'm inclined to make those changes in a future series if
> that's alright with you.

Yep, definitely a different series.
