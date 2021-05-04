Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00002373202
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhEDVq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhEDVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:46:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:45:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso2322403ote.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4daw9Y4OB39yIbPmv1qSyV0lFSedRBWvMPVCNOlqsp8=;
        b=YuahOkppk59MZLC7WekMPtBRH1zWw4mEeRTjyXfWHcaFAEoHYyuVEdm8/VPkYC654O
         b1QkGuK3lh82Q6JJ4hpW+nrfmorwDx5CunnSLrtcPqR7OSJDAt3F3OePcN1EKaKkNZe+
         Grdgil++mGs5tb4rOyJ8Lz+vIwRBN9+BykAI/JI066eDtPrv8j0uoQFBFNefCPCZIltq
         If4Xh0JnegRP8P1123UI8CFoYdMj6+0HRiiFRB7CYVvuHFJ49EwY51SKdQFSJfnAbYHE
         ZnC1uGHHYmT6QcHm8hmo2gAlHybbUwmAM+EkMFxj1xZZnYxhj6VJs1eYLkhSdRQJAfVn
         Lpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4daw9Y4OB39yIbPmv1qSyV0lFSedRBWvMPVCNOlqsp8=;
        b=ef8jV2tT2xLgXBxVdHpEe+0C9/Or/eTcB4zts7d6P+sQUrDf7nSiWpwJQOPRcdjv3e
         2Vb+kpD4bEkSTYFR1bbKHXgCEqw28ygtdErAiJizMSoUQCxB4HR2F9M5aOA1t9HH6t26
         QJ6PHehzPtPfM7982XJdjMJ/2BxA4QwWI2jvGMJSiNiiMvvaltE0a/L4grAlqv77PIx3
         OK0MYOsiKhfXm37Q87jI7O/hD2ajuiJJ04rL3oAV5mDRYbgWFx/h/1//wgjRTV1kjU6j
         NK7zS/IP+PTeWcPpJeLypRsSUPkjtG6q8V25viB1cqdZ105jMoQvo2TEpnP1NGIsvM2y
         Iosw==
X-Gm-Message-State: AOAM531Ow4A6dV5RQk12xttu3mcGoRTPYN15Lk3Iqw66mgDWdH/HjDhu
        ePpPPi+lbI5k1DAeZd1iHFwFxkPBKwAZhwEEebGHzg==
X-Google-Smtp-Source: ABdhPJztXVSdXEkoqT3D2wPGFa8u15RwEty3GSdnIbvfUJ4PWmDHPCq3rJvSjQ3gJl1fT/PD4gLTEsmY7DzIesU+Ptw=
X-Received: by 2002:a05:6830:16c8:: with SMTP id l8mr21021609otr.56.1620164758579;
 Tue, 04 May 2021 14:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-4-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-4-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 4 May 2021 14:45:47 -0700
Message-ID: <CALMp9eSvXRJm-KxCGKOkgPO=4wJPBi5wDFLbCCX91UtvGJ1qBg@mail.gmail.com>
Subject: Re: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Intercept RDTSCP to inject #UD if RDTSC is disabled in the guest.
>
> Note, SVM does not support intercepting RDPID.  Unlike VMX's
> ENABLE_RDTSCP control, RDTSCP interception does not apply to RDPID.  This
> is a benign virtualization hole as the host kernel (incorrectly) sets
> MSR_TSC_AUX if RDTSCP is supported, and KVM loads the guest's MSR_TSC_AUX
> into hardware if RDTSCP is supported in the host, i.e. KVM will not leak
> the host's MSR_TSC_AUX to the guest.
>
> But, when the kernel bug is fixed, KVM will start leaking the host's
> MSR_TSC_AUX if RDPID is supported in hardware, but RDTSCP isn't available
> for whatever reason.  This leak will be remedied in a future commit.
>
> Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
...
> @@ -4007,8 +4017,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>         svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
>                              guest_cpuid_has(vcpu, X86_FEATURE_NRIPS);
>
> -       /* Check again if INVPCID interception if required */
> -       svm_check_invpcid(svm);
> +       svm_recalc_instruction_intercepts(vcpu, svm);

Does the right thing happen here if the vCPU is in guest mode when
userspace decides to toggle the CPUID.80000001H:EDX.RDTSCP bit on or
off?
