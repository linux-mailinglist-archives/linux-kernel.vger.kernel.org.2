Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6A3736A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhEEIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhEEIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620204715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwBoUgG9rsb1FyPIyfZB9zmIC0y2jE3CV4jFXKDxs70=;
        b=JLvXoN2+bcA3HtrsMLM2+aqBorK+B9FWX+Rey3AJ9PTHVNUkytNaMBvdaAJ3RGnwHTVYcg
        54dsq+AKOLk1UJLcxt/+SyMoY+ufOoMXaxE+ZnlpnMsZ8eGmPOvCqeNfGm8I5WrtDzbAjf
        cW2HR3q2KD6kAFvyiO1Fhiz6hTsjqi8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Z5CPuOuSPy6S8-zhgyboDg-1; Wed, 05 May 2021 04:51:53 -0400
X-MC-Unique: Z5CPuOuSPy6S8-zhgyboDg-1
Received: by mail-ej1-f72.google.com with SMTP id qk30-20020a170906d9deb02903916754e1b6so208257ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 01:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kwBoUgG9rsb1FyPIyfZB9zmIC0y2jE3CV4jFXKDxs70=;
        b=IZNFSMV73HJvQAHAKVL34nyHlWgFzKKL3W8xqg9lv91Sgt88kf99SC2C0F2srOimHm
         LpAlGar558pjYkFaEJTBPuFjrTa/Uzq3HzkxzFnp9vYQJ1W566nK1ZnrraW8okpu2eSI
         jzriIz51HORlSGX1rvSYEYcHs5Kj2ZhH6hppkR7FYUWAk76JP1bFqh25O+ZxjCmErnyI
         o9d5oU4LFZPyIaSBHx4uNzzc/2e/kMahvMLA1MdQXZ5sQaLMlFb8fdBq+HLUtfdtyTK3
         ucHBSvI+QpmGXUPwAJbNWkz/2LWuy2dDACh6CFlWIlyvbv3ff3ViTNM7TPe/oyclhKsU
         attw==
X-Gm-Message-State: AOAM530naUx+Gl7Xm36SPi9stC7Cp+jYBIpwn/yP+jDRiisJnF1/sRZa
        qerH+IfBCvICMLEqEXuuDAVELSUoZWjKmvInBNS7yYaeRQzM21Xe1Py5v1/KlqdWybwj8X0lcGu
        yNIUbK/2udYckv0LwJzYbZOuw
X-Received: by 2002:a17:906:3bc6:: with SMTP id v6mr26589950ejf.165.1620204711957;
        Wed, 05 May 2021 01:51:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKhVGEbXFUoRmi0GpQF9un2itAZ0PFYe4lbqCtJ5cX6iJ098WDoejhk0IrXlEU3+r8Mr/EgQ==
X-Received: by 2002:a17:906:3bc6:: with SMTP id v6mr26589922ejf.165.1620204711694;
        Wed, 05 May 2021 01:51:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y10sm2523746ejh.105.2021.05.05.01.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 01:51:51 -0700 (PDT)
Subject: Re: [PATCH 00/15] KVM: x86: RDPID/RDTSCP fixes and uret MSR cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbd2b720-632a-0e03-a000-bb52168f6c24@redhat.com>
Date:   Wed, 5 May 2021 10:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504171734.1434054-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 19:17, Sean Christopherson wrote:
> This is a continuation of a less ambitious effort to unify MSR_TSC_AUX
> handling across SVM and VMX.  Reiji pointed out that MSR_TSC_AUX exists if
> RDTSCP *or* RDPID is supported, and things went downhill from there.
> 
> The first half of this series fixes a variety of RDTSCP and RDPID related
> bugs.
> 
> The second half of the series cleans up VMX's user return MSR framework
> and consolidates more of the uret logic into common x86.
> 
> The last two patches leverage the uret MSR cleanups to move MSR_TSC_AUX
> handling to common x86 and add sanity checks to guard against misreporting
> of RDPID and/or RDTSCP support.
> 
> This will conflict with my vCPU RESET/INIT cleanup series.  Feel free to
> punt the conflicts to me.
> 
> Other "fun" things to tackle:
> 
>   - The kernel proper also botches RDPID vs. RDTSCP, as MSR_TSC_AUX is
>     configured if RDTSCP is supported, but is consumed if RDPID is
>     supported.  I'll send this fix separately.
> 
>   - Commit 844d69c26d83 ("KVM: SVM: Delay restoration of host MSR_TSC_AUX
>     until return to userspace") unwittingly fixed a bug where KVM would
>     write MSR_TSC_AUX with the guest's value when svm->guest_state_loaded
>     is false, which could lead to running the host with the guest's value.
>     The bug only exists in 5.12 (maybe 5.11 too?), so crafting a fix for
>     stable won't be too awful.
> 
> Sean Christopherson (15):
>    KVM: VMX: Do not adverise RDPID if ENABLE_RDTSCP control is
>      unsupported
>    KVM: x86: Emulate RDPID only if RDTSCP is supported
>    KVM: SVM: Inject #UD on RDTSCP when it should be disabled in the guest
>    KVM: x86: Move RDPID emulation intercept to its own enum
>    KVM: VMX: Disable preemption when probing user return MSRs
>    KVM: SVM: Probe and load MSR_TSC_AUX regardless of RDTSCP support in
>      host
>    KVM: x86: Add support for RDPID without RDTSCP
>    KVM: VMX: Configure list of user return MSRs at module init
>    KVM: VMX: Use flag to indicate "active" uret MSRs instead of sorting
>      list
>    KVM: VMX: Use common x86's uret MSR list as the one true list
>    KVM: VMX: Disable loading of TSX_CTRL MSR the more conventional way
>    KVM: x86: Export the number of uret MSRs to vendor modules
>    KVM: x86: Move uret MSR slot management to common x86
>    KVM: x86: Tie Intel and AMD behavior for MSR_TSC_AUX to guest CPU
>      model
>    KVM: x86: Hide RDTSCP and RDPID if MSR_TSC_AUX probing failed
> 
>   arch/x86/include/asm/kvm_host.h |   9 +-
>   arch/x86/kvm/cpuid.c            |  18 ++-
>   arch/x86/kvm/emulate.c          |   2 +-
>   arch/x86/kvm/kvm_emulate.h      |   1 +
>   arch/x86/kvm/svm/svm.c          |  50 +++-----
>   arch/x86/kvm/vmx/vmx.c          | 217 ++++++++++++++++----------------
>   arch/x86/kvm/vmx/vmx.h          |  12 +-
>   arch/x86/kvm/x86.c              | 101 ++++++++++++---
>   8 files changed, 245 insertions(+), 165 deletions(-)
> 

Queued, thanks.

Paolo

