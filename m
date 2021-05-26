Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81FB39112B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEZHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEZHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:06:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7467C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:04:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so147166ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EnWzCrCjMkBA9yDDFJOkeJ9fcIzJ3+RLUTB4gLbZcg=;
        b=cgehxhl99cjGZQyweR9ri+4IHaenJsxSFUR85TvBKZq4WmukDc45ElIewp+VoUp80l
         +IhXOhEGlqnmpojVKEXeKrYODo00lM8FkBhuuv0KaZ8kbiezXYP2S4WgafEkBf2VCx4C
         w6m9jxUovt42R4IaqB1vS/jIC8E580v9nN7coHNRJsZqXZPrWFKz3mgbKFoyE2C/I5wF
         ckHHlR/0H2EjVukktONdiUVSPl2WBIctb4TDRQ1FLkLBDAC56nFRXH4azMVtfNo6TJJB
         WrsnJ1ANB/toDodAxwMwCG7l7QQahtf06aKhFqZau49Lym1Zhd2HyDDO3+v9qZNoIK4f
         6vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EnWzCrCjMkBA9yDDFJOkeJ9fcIzJ3+RLUTB4gLbZcg=;
        b=IEVmNT5rio1yDhJwbqwo2LM512sgoiXtpNbzhqnLybhi3+XCl+vZ/Tc11sDt7FV/q8
         rvwLhxIZK4xys5XFH8yjyHx8VeQcNHGd+c7xc/35AkcC3XCYiJD4HXxVikiGN7jOtKRC
         tX0S587IcFHHFyCqmdrSM02ZR166qxFnE328D21qWlvrD03mcXVDPCFwbf2zHtGGGagC
         ulc/G6UxWXlhUU2hRmWvgaj0E98ip3t1jDDIsR4FmaG8YyQMrD6P+rgPOX8hcwitSObC
         8QTZXYNzz8r3dl11bsm2lFw4Paxte+P9hQNqeLr7J5i2Dc+PInhYl8KsZq7iqcvwMuXn
         Ge3g==
X-Gm-Message-State: AOAM5332sw9sF6pUKjUm+0NAhKNbOGvw9cw3KL1n2YuT7WQCR5KeR+Q5
        McybekHZpeaiMbZ1oazjk3xUBQnuzR3NxsuUpPDhsw==
X-Google-Smtp-Source: ABdhPJyOAoJ00XEnqH4r8aB6WS1NFX4IHuoS0DZpueYY1Z36KtN1KjazL8ggYd054SBzKdj8Xgq60ik5QOw1bMIusOU=
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr2475201pjh.170.1622012689272;
 Wed, 26 May 2021 00:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-18-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-18-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Wed, 26 May 2021 00:04:33 -0700
Message-ID: <CAAeT=Fw2zfvTkvCSuRqo6K1+L7LaPOpsSHHU1oGbUnUSDtELVQ@mail.gmail.com>
Subject: Re: [PATCH 17/43] KVM: x86: Open code necessary bits of
 kvm_lapic_set_base() at vCPU RESET
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Stuff vcpu->arch.apic_base and apic->base_address directly during APIC
> reset, as opposed to bouncing through kvm_set_apic_base() while fudging
> the ENABLE bit during creation to avoid the other, unwanted side effects.
>
> This is a step towards consolidating the APIC RESET logic across x86,
> VMX, and SVM.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index b088f6984b37..b1366df46d1d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2305,7 +2305,6 @@ EXPORT_SYMBOL_GPL(kvm_apic_update_apicv);
>  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
>         struct kvm_lapic *apic = vcpu->arch.apic;
> -       u64 msr_val;
>         int i;
>
>         if (!apic)
> @@ -2315,10 +2314,13 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>         hrtimer_cancel(&apic->lapic_timer.timer);
>
>         if (!init_event) {
> -               msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
> +               vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
> +                                      MSR_IA32_APICBASE_ENABLE;
>                 if (kvm_vcpu_is_reset_bsp(vcpu))
> -                       msr_val |= MSR_IA32_APICBASE_BSP;
> -               kvm_lapic_set_base(vcpu, msr_val);
> +                       vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
> +
> +               apic->base_address = MSR_IA32_APICBASE_ENABLE;

I think you wanted to make the code above set apic->base_address
to APIC_DEFAULT_PHYS_BASE (not MSR_IA32_APICBASE_ENABLE).

Thanks,
Reiji
