Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3F3D01DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGTSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGTSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:04:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:45:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m68so20989703qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+5lhU7M8IjaNDliv1AGOCjbrZiTwbIiNZC3cRm5Ft4=;
        b=kBNqGrqVO0AGRsiaL21hT9uj8jYrP1RH/zUuBTrpbBUb8A42hHHzVHzCvjT3dJ+Ty9
         yVNDKRMFvYehXW+I9SqWnToG1znHK9qyAECiy7F0h2h5UkSiMrAyD1iqLfcHmIRzqBa3
         3gLxomE2ztzKfdxeg1Dh4QidNGCiIfjBswBQkZ+D/owBOrYD/eqpSPrICPG/l2YXwhbz
         5Isa8wx3gsFgKoqDQmVfhIzKAQrNd0RLyOctfy3RpnRQJNWfmIzPwCt+VZOzjvbzpTqB
         PBkyGWSERoggfMqSRyQ2NYYmATiMWki7J0f+6OrXNWlGNm/0LPY1LZPNdt730Ui4K1R5
         7yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+5lhU7M8IjaNDliv1AGOCjbrZiTwbIiNZC3cRm5Ft4=;
        b=bnQDVK2Nk9QfgKRl2x/YHF6L4zXzDDqLPoDfepGMHYo1yCSofYm25khMhcwHPPQKmR
         RxaOXShO7PhmFkoy6/dv68/px/Mkwdjdl5bkaKj7T2dblvOWusnDD+oo5yUtL8DPWLDi
         AUfLMVEWSqaLBYPxEhldvIxqJzkP7dt803AkNgQC4n4sHy9TQTs7IiEQbil4czQtswqh
         MBWz7Yc3esaY2P0hdcZw1+hh/TXYl7vhuFbFeEKlDIspBJJbulLQdWVeCNKkr1uEL523
         skL22rJVA45OKU48+xAJO2xS0X6InmX6pklRlU4SV/215/e8vhuySgwo1V5K1kYrn047
         /JCA==
X-Gm-Message-State: AOAM532Ot7ypzpRch4hfhnHBN6cNTuY5tOF+Tp30bb7P6oY3A9HhuOni
        8UBNuVZCXGVAewkisatTIrv+SkRH6aXFHvXLy1eM1Q==
X-Google-Smtp-Source: ABdhPJz99PqGqDiAUjrgTCjXK83j0Ii/6/WjrhhzASEWUjObSqCXnA+g3kTJMOWUTIM3pS0bEje2lpMgJ/Z6UUAhjFU=
X-Received: by 2002:a37:8f44:: with SMTP id r65mr31378302qkd.20.1626806704872;
 Tue, 20 Jul 2021 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-5-senozhatsky@chromium.org> <874kcz33g5.wl-maz@kernel.org>
In-Reply-To: <874kcz33g5.wl-maz@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 20 Jul 2021 14:44:53 -0400
Message-ID: <CAJWu+oqCyj3H0=1KNo3c+crdcktYinFoTQJ5jHgU8gjeF4d2yA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] arm64: add host pv-vcpu-state support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:24 PM Marc Zyngier <maz@kernel.org> wrote:
>
[...]
> > +}
> > +
> > +static inline bool
> > +kvm_arm_is_vcpu_state_enabled(struct kvm_vcpu_arch *vcpu_arch)
> > +{
> > +     return (vcpu_arch->vcpu_state.base != GPA_INVALID);
> > +}
> > +
> > +void kvm_update_vcpu_preempted(struct kvm_vcpu *vcpu, bool preempted);
> > +
> >  void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
> >
> >  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index 989bb5dad2c8..2a3ee82c6d90 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -12,7 +12,8 @@ obj-$(CONFIG_KVM) += hyp/
> >
> >  kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
> >        $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
> > -      arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
> > +      arm.o mmu.o mmio.o psci.o perf.o hypercalls.o \
> > +      pvtime.o pv-vcpu-state.o \
> >        inject_fault.o va_layout.o handle_exit.o \
> >        guest.o debug.o reset.o sys_regs.o \
> >        vgic-sys-reg-v3.o fpsimd.o pmu.o \
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index e9a2b8f27792..43e995c9fddb 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -332,6 +332,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >       kvm_arm_reset_debug_ptr(vcpu);
> >
> >       kvm_arm_pvtime_vcpu_init(&vcpu->arch);
> > +     kvm_arm_vcpu_state_init(&vcpu->arch);
> >
> >       vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
> >
> > @@ -429,10 +430,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >       if (vcpu_has_ptrauth(vcpu))
> >               vcpu_ptrauth_disable(vcpu);
> >       kvm_arch_vcpu_load_debug_state_flags(vcpu);
> > +     kvm_update_vcpu_preempted(vcpu, false);
> >  }
> >
> >  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> >  {
> > +     kvm_update_vcpu_preempted(vcpu, true);
>
> This doesn't look right. With this, you are now telling the guest that
> a vcpu that is blocked on WFI is preempted. This really isn't the
> case, as it has voluntarily entered a low-power mode while waiting for
> an interrupt. Indeed, the vcpu isn't running. A physical CPU wouldn't
> be running either.

Can that be cured by just checking vcpu->preempted before calling
kvm_update_vcpu_preempted() ?

- Joel
