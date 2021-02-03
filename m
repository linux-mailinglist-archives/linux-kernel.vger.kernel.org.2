Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD530D9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhBCMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhBCMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShpPYTvXC1QZW794cxDqP5Ce8luBrirDryFdaZVPazQ=;
        b=ez8fAf0GNCPtj69mASG/uNzGbtjpk+b7jvwiDv+SNAnznYlmxoWep9djlmZbU+NKvj7vXJ
        X9pYSDt0QdY2AAYXJvFpJ4h1sEM27IX063hUJvUzXNABvZjq/T/rOz9Z6gqO7/fr9QDloJ
        HiMWBwuuDSFcyuL6pZk7rtkmS63KT+Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-wlv0rgPWOLOtBZkO4HkrbA-1; Wed, 03 Feb 2021 07:40:05 -0500
X-MC-Unique: wlv0rgPWOLOtBZkO4HkrbA-1
Received: by mail-ed1-f72.google.com with SMTP id bo11so4898398edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShpPYTvXC1QZW794cxDqP5Ce8luBrirDryFdaZVPazQ=;
        b=P17gNWr2tMXd27YVz5MHQd25zFECvWNk5PPdn2xOqF1psv3+5OlYujvIax6WdkElBZ
         E6dZc6A20VSzA4Ji19dljTzDrXQ7IScOsIsYVH+qWXewP9+bZSbZLCEpj6PJkBLxvGPM
         D7w66eWUDaXM9k7Jby0N8AyrY1flimmXtRbRzqRAWPsYy0MVzsovOq9h86fIIxjotFNI
         LH+xtgWnR5Xt5opgMZOov86pHV565KvR3KAgZiv4nR6f5TRhplv5b60DfogtFfZkt0BH
         L1r2gltG4Uk58zVsQgPd5YxEM7PF0jDccLtl3UFfe9q2mSG94vL3gHBdFSvYSeTxbkQS
         eyKw==
X-Gm-Message-State: AOAM533XPcIrm8IloFCTilZaBwa0AIVPmOSkHUXJ8JLXkEhOJMpxwErD
        2FZJltQKj7PVLfTJUmaGaVz4Vm3TmUtJWUwNBIK53SaWtE05vLG1aHiBRIGYj+LLncRXxrv1E1E
        zxdKBIGsqYky2unb3QlrnqZIy
X-Received: by 2002:a17:906:1241:: with SMTP id u1mr2393976eja.196.1612356003814;
        Wed, 03 Feb 2021 04:40:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxI2NgX8yDD2sDxEpBgMA4iC8hNfwxh5iFjNfnBiD5rXzpoHpMCscQwBRBlWPCtqVqWoya6Wg==
X-Received: by 2002:a17:906:1241:: with SMTP id u1mr2393878eja.196.1612356002595;
        Wed, 03 Feb 2021 04:40:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x42sm830572ede.64.2021.02.03.04.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 04:40:01 -0800 (PST)
Subject: Re: [PATCH v15 00/14] Introduce support for guest CET feature
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yu.c.zhang@linux.intel.com
References: <20210203113421.5759-1-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f98faaa8-8bc5-9ba7-c4e1-33f8a890e1e3@redhat.com>
Date:   Wed, 3 Feb 2021 13:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210203113421.5759-1-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 12:34, Yang Weijiang wrote:
> Control-flow Enforcement Technology (CET) provides protection against
> Return/Jump-Oriented Programming (ROP/JOP) attack. There're two CET
> subfeatures: Shadow Stack (SHSTK) and Indirect Branch Tracking (IBT).
> SHSTK is to prevent ROP and IBT is to prevent JOP.
> 
> Several parts in KVM have been updated to provide guest CET support, including:
> CPUID/XSAVES settings, MSR passthrough, user-space MSR access interface,
> vmentry/vmexit config, nested VM etc. These patches are dependent on CET
> kernel patches for XSAVES support and CET definitions, e.g., MSR and related
> feature flags.
> 
> CET kernel patches: refer to [1], [2].
> 
> Previous CET KVM patches: refer to [3].
> 
> CET QEMU patches: refer to [4].
> 
> CET KVM unit-test patch: refer to [5].
> 
> [1]: CET Shadow Stack patches v18:
> https://lkml.kernel.org/linux-api/20210127212524.10188-1-yu-cheng.yu@intel.com/
> 
> [2]: Indirect Branch Tracking patches v18:
> https://lkml.kernel.org/linux-api/20210127213028.11362-1-yu-cheng.yu@intel.com/
> 
> [3]: CET KVM patches v14:
> https://lkml.kernel.org/kvm/20201106011637.14289-1-weijiang.yang@intel.com/
> 
> [4]: CET QEMU patches:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20201013051935.6052-2-weijiang.yang@intel.com/
> 
> [5]: CET KVM unit-test patch:
> https://patchwork.kernel.org/project/kvm/patch/20200506082110.25441-12-weijiang.yang@intel.com/
> 
> Changes in v15:
> - Changed patches per Paolo's review feedback on v14.
> - Added a new patch for GUEST_SSP save/restore in guest SMM case.
> - Fixed guest call-trace issue due to CET MSR interception.
> - Removed unnecessary guest CET state cleanup in VMCS.
> - Rebased patches to 5.11-rc6.
> 
> 
> Sean Christopherson (2):
>    KVM: x86: Report XSS as an MSR to be saved if there are supported
>      features
>    KVM: x86: Load guest fpu state when accessing MSRs managed by XSAVES
> 
> Yang Weijiang (12):
>    KVM: x86: Refresh CPUID on writes to MSR_IA32_XSS
>    KVM: x86: Add #CP support in guest exception dispatch
>    KVM: VMX: Introduce CET VMCS fields and flags
>    KVM: x86: Add fault checks for CR4.CET
>    KVM: VMX: Emulate reads and writes to CET MSRs
>    KVM: VMX: Add a synthetic MSR to allow userspace VMM to access
>      GUEST_SSP
>    KVM: x86: Report CET MSRs as to-be-saved if CET is supported
>    KVM: x86: Enable CET virtualization for VMX and advertise CET to
>      userspace
>    KVM: VMX: Pass through CET MSRs to the guest when supported
>    KVM: nVMX: Add helper to check the vmcs01 MSR bitmap for MSR
>      pass-through
>    KVM: nVMX: Enable CET support for nested VMX
>    KVM: x86: Save/Restore GUEST_SSP to/from SMRAM
> 
>   arch/x86/include/asm/kvm_host.h      |   4 +-
>   arch/x86/include/asm/vmx.h           |   8 ++
>   arch/x86/include/uapi/asm/kvm.h      |   1 +
>   arch/x86/include/uapi/asm/kvm_para.h |   1 +
>   arch/x86/kvm/cpuid.c                 |  26 +++-
>   arch/x86/kvm/emulate.c               |  11 ++
>   arch/x86/kvm/vmx/capabilities.h      |   5 +
>   arch/x86/kvm/vmx/nested.c            |  57 ++++++--
>   arch/x86/kvm/vmx/vmcs12.c            |   6 +
>   arch/x86/kvm/vmx/vmcs12.h            |  14 +-
>   arch/x86/kvm/vmx/vmx.c               | 202 ++++++++++++++++++++++++++-
>   arch/x86/kvm/x86.c                   |  67 ++++++++-
>   arch/x86/kvm/x86.h                   |  10 +-
>   13 files changed, 387 insertions(+), 25 deletions(-)
> 

Queued, though not for 5.12 unless the bare metal support is there too.

Paolo

