Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6663B1FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFWSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:06:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:03:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t4-20020a9d66c40000b029045e885b18deso2818040otm.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ID4YxNs3xN3x+8LywFzdmj0UktQ90FUDosmq+5vRnZg=;
        b=Z4I7dR3Epkl8D+3m2daYH8xBRXBye6C2eiqERp3ozT2NT66IB6OEYAiiBox9SPtdGX
         WW6euVurh5nUW0esCn4eTZjwLwbUFEmKx2xmIQQs/OtVvL5SzAYYk/e5wc9E28PE89ZS
         DIR8lNXYE5rXpddmiCqCLFJeAqhSj2J+rkRH86oeKYXGk0j9chtqURs7154BAbYDVub4
         5CF025BNnCNUqtY3haDTE0EDAFYrIWe2RQIx0/waA6u0BXTe23bed27rTtNOTIwxJmIX
         bl57el2tfLa1o3njokVh+wx5L4HSLjPhzPpdnJY1qpGL6GTTJc0s6S0BmE8q0V6nvq2w
         fFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ID4YxNs3xN3x+8LywFzdmj0UktQ90FUDosmq+5vRnZg=;
        b=WLiAaNOrCA9SoHRxGhf+dO8mFqwQBZCeztM91o7sPyJDD74X/gxogGoLRls9bpl5Vm
         JzKqpmDOhZZ+78iMrlL1X+uFIdrelRwrjBywgrn40nat8TVPKcR74DnKdVIbFnykHZII
         37azpjpiwJzd0SGE262z7yQXNjfDnCBHuO6jbtoCgxOz5c/p7cON6pq4mxt72fnHajP9
         Og/QZXNPx2zSd9XCfyooJI/W1LibjS5FIj1wXL3GUQTN8DbnWTQno5UUE/K/jlB383Pj
         H/krooiQoTMdLh1lV9lhNIzWgYOBTxNUWW2U2fcCLbnlnoqN1DvZ8PxkL0700MIWp11L
         njpw==
X-Gm-Message-State: AOAM532BMbWQEgJkgRIg2hoT5PCTAi7NiYswvFxeVFAXe0ydCLIWUHrx
        5IvQQ1zl1A5SEKG2nPKs09niKssYDRBOqvg3G0FYWQ==
X-Google-Smtp-Source: ABdhPJxQLLEgrnmknnF8EVFw8E0MWMzyT9d728esAcvYEZ3n7jXuR/S5XRUckZHuCzZvrYIgn3W0/Pygl0fwwwENudA=
X-Received: by 2002:a9d:550e:: with SMTP id l14mr1037619oth.241.1624471430417;
 Wed, 23 Jun 2021 11:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210510081535.94184-1-like.xu@linux.intel.com> <20210510081535.94184-4-like.xu@linux.intel.com>
In-Reply-To: <20210510081535.94184-4-like.xu@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Jun 2021 11:03:39 -0700
Message-ID: <CALMp9eT-KL-xDgV9p31NgnbW2tnwPes7r6GhJbMedim5e9Ab4g@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 03/10] KVM: vmx/pmu: Add MSR_ARCH_LBR_DEPTH
 emulation for Arch LBR
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 1:16 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> The number of Arch LBR entries available for recording operations
> is dictated by the value in MSR_ARCH_LBR_DEPTH.DEPTH. The supported
> LBR depth values can be found in CPUID.(EAX=01CH, ECX=0):EAX[7:0]
> and for each bit "n" set in this field, the MSR_ARCH_LBR_DEPTH.DEPTH
> value of "8*(n+1)" is supported.
>
> On a guest write to MSR_ARCH_LBR_DEPTH, all LBR entries are reset to 0.
> KVM emulates the reset behavior by introducing lbr_desc->arch_lbr_reset.
> KVM writes the guest requested value to the native ARCH_LBR_DEPTH MSR
> (this is safe because the two values will be the same) when the Arch LBR
> records MSRs are pass-through to the guest.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 43 ++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h       |  3 +++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 9efc1a6b8693..d9c9cb6c9a4b 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -220,6 +220,9 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>                 ret = pmu->version > 1;
>                 break;
> +       case MSR_ARCH_LBR_DEPTH:
> +               ret = guest_cpuid_has(vcpu, X86_FEATURE_ARCH_LBR);
> +               break;

This doesn't seem like a very safe test, since userspace can provide
whatever CPUID tables it likes. You should definitely think about
hardening this code against a malicious userspace.

When you add a new guest MSR, it should be enumerated by
KVM_GET_MSR_INDEX_LIST. Otherwise, userspace will not save/restore the
MSR value on suspend/resume.
