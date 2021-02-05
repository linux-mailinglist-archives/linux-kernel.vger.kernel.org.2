Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71E3107DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhBEJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhBEJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612517072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H9mnK0htSrk+0iAVGc6yh1bw0zDy0MOzHt8lRTm/x8=;
        b=YlEj+jnP+3Mz0VW3vCEoy3Dd9+bab/jRnc2lSxXgsxZSISMrKEhu1Rjy5vVLfo6zpxnw8p
        v06jnYltS9sXl2F3xHcAR55G6SlfEPbq4nIhwTz+KK5hB7LhYh6qxBzxIFlAkiJKu5NoB6
        yBtBszxJTAHZxWkROwR578bo+GpDiO4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-flAgNOPAMzaXg36sCuiymg-1; Fri, 05 Feb 2021 04:24:30 -0500
X-MC-Unique: flAgNOPAMzaXg36sCuiymg-1
Received: by mail-ej1-f69.google.com with SMTP id yh28so6420668ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3H9mnK0htSrk+0iAVGc6yh1bw0zDy0MOzHt8lRTm/x8=;
        b=MKmKGAGVEFsK198qHBzSAc2Qk3OqFMtvlmhzrcKtxZ/iYtOO2kc9+pjhbmdEDzQiGC
         PXPWByW0Gp2Vx0pXz3569adcalH93g9f5YtQEf/ILw1ziKV76MVfcGbQssU3ltY/Ar39
         CZIxD+FLJ8uUxps4eG+r4+7OR3bBikPRyX/sGqBEeyH/VIIxgO2TKKM0B4TAAgstzrEu
         PT/d6tl4VtyvwYCwKS5TVCkUrvPQnqnImds9plLd+X7U+33WQ0uOs3VgajJg6O93LoAW
         omJKPJNh1v7s0AMw14gwMqIabUgLHi6NbSKn/Y79imvgOGKSle0yeAUzh8qJr1dBx6C1
         2VOg==
X-Gm-Message-State: AOAM533KUwa2I1OrEbGUqhLAx4fFoouPleJX1FpD35I5dEIWhbn5RRBt
        ghx+lhAxuRnnzdjuSYM8beNMwIn8RQz0xxPovboXYWPiSSFkj9dZOqunEJ/0ynPVAxA3ThcYNfg
        BRwhHSKKTjsTRk8khSEpKyhhTf3S1WogA2Tn1jaOPeg1aBFe2BaLa62OqoUXFESGnf+UAXqXXz2
        k8
X-Received: by 2002:a17:906:5e5a:: with SMTP id b26mr3078688eju.327.1612517068436;
        Fri, 05 Feb 2021 01:24:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPtjWpIzA36eowWHr9mnl3mDIzunyyiX9F78zWN6lXErigabdX/+t41pV4Sj/j6GteMKCUBw==
X-Received: by 2002:a17:906:5e5a:: with SMTP id b26mr3078659eju.327.1612517068201;
        Fri, 05 Feb 2021 01:24:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ov9sm3671341ejb.53.2021.02.05.01.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:24:27 -0800 (PST)
Subject: Re: [PATCH v4 0/5] KVM: PKS Virtualization support
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adf80c59-8309-75a6-4678-7fee03529d7d@redhat.com>
Date:   Fri, 5 Feb 2021 10:24:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205083706.14146-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 09:37, Chenyi Qiang wrote:
> Protection Keys for Supervisor Pages(PKS) is a feature that extends the
> Protection Keys architecture to support thread-specific permission
> restrictions on supervisor pages.
> 
> PKS works similar to an existing feature named PKU(protecting user pages).
> They both perform an additional check after all legacy access
> permissions checks are done. If violated, #PF occurs and PFEC.PK bit will
> be set. PKS introduces MSR IA32_PKRS to manage supervisor protection key
> rights. The MSR contains 16 pairs of ADi and WDi bits. Each pair
> advertises on a group of pages with the same key which is set in the
> leaf paging-structure entries(bits[62:59]). Currently, IA32_PKRS is not
> supported by XSAVES architecture.
> 
> This patchset aims to add the virtualization of PKS in KVM. It
> implemented PKS CPUID enumeration, vmentry/vmexit configuration, MSR
> exposure, nested supported etc. Currently, PKS is not yet supported for
> shadow paging.
> 
> PKS bare metal support:
> https://lore.kernel.org/lkml/20201106232908.364581-1-ira.weiny@intel.com/
> 
> Detailed information about PKS can be found in the latest Intel 64 and
> IA-32 Architectures Software Developer's Manual.
> 
> ---
> 
> Changelogs:
> 
> v3->v4
> - Make the MSR intercept and load-controls setting depend on CR4.PKS value
> - shadow the guest pkrs and make it usable in PKS emultion
> - add the cr4_pke and cr4_pks check in pkr_mask update
> - squash PATCH 2 and PATCH 5 to make the dependencies read more clear
> - v3: https://lore.kernel.org/lkml/20201105081805.5674-1-chenyi.qiang@intel.com/
> 
> v2->v3:
> - No function changes since last submit
> - rebase on the latest PKS kernel support:
>    https://lore.kernel.org/lkml/20201102205320.1458656-1-ira.weiny@intel.com/
> - add MSR_IA32_PKRS to the vmx_possible_passthrough_msrs[]
> - RFC v2: https://lore.kernel.org/lkml/20201014021157.18022-1-chenyi.qiang@intel.com/
> 
> v1->v2:
> - rebase on the latest PKS kernel support:
>    https://github.com/weiny2/linux-kernel/tree/pks-rfc-v3
> - add a kvm-unit-tests for PKS
> - add the check in kvm_init_msr_list for PKRS
> - place the X86_CR4_PKS in mmu_role_bits in kvm_set_cr4
> - add the support to expose VM_{ENTRY, EXIT}_LOAD_IA32_PKRS in nested
>    VMX MSR
> - RFC v1: https://lore.kernel.org/lkml/20200807084841.7112-1-chenyi.qiang@intel.com/
> 
> ---
> 
> Chenyi Qiang (5):
>    KVM: VMX: Introduce PKS VMCS fields
>    KVM: X86: Expose PKS to guest
>    KVM: MMU: Rename the pkru to pkr
>    KVM: MMU: Add support for PKS emulation
>    KVM: VMX: Enable PKS for nested VM
> 
>   arch/x86/include/asm/kvm_host.h | 17 +++---
>   arch/x86/include/asm/pkeys.h    |  1 +
>   arch/x86/include/asm/vmx.h      |  6 ++
>   arch/x86/kvm/cpuid.c            |  3 +-
>   arch/x86/kvm/mmu.h              | 23 ++++----
>   arch/x86/kvm/mmu/mmu.c          | 81 +++++++++++++++------------
>   arch/x86/kvm/vmx/capabilities.h |  6 ++
>   arch/x86/kvm/vmx/nested.c       | 38 ++++++++++++-
>   arch/x86/kvm/vmx/vmcs.h         |  1 +
>   arch/x86/kvm/vmx/vmcs12.c       |  2 +
>   arch/x86/kvm/vmx/vmcs12.h       |  6 +-
>   arch/x86/kvm/vmx/vmx.c          | 99 +++++++++++++++++++++++++++++++--
>   arch/x86/kvm/vmx/vmx.h          |  1 +
>   arch/x86/kvm/x86.c              | 11 +++-
>   arch/x86/kvm/x86.h              |  8 +++
>   arch/x86/mm/pkeys.c             |  6 ++
>   include/linux/pkeys.h           |  4 ++
>   17 files changed, 249 insertions(+), 64 deletions(-)
> 

Looks mostly good, but I'll only be able to include it after the bare 
metal implementation is in.

Paolo

