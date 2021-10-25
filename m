Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0974399C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhJYPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233628AbhJYPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635174738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euwk1jl5AJ6LtLgQs5yWOlThVZuR59vdDf7Eg6dCdpg=;
        b=Rn2uvqBu567VLgCC2+oGjn/yBjAj2LETf7M6AvXs8OpdhMjkFUKR4MvUpYDgKdVEqye2do
        vNiAIljLR3ZPJn2kuIjqpuMZYBNNO/pGnR3EARRWtQoXf4HkiPoBjL1Ya0rjc2/y0H/SlB
        /85QERqM3W75Id+Nk190B6yeloZ4J9k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6W-nMP3RMqi2_bMdiobc2Q-1; Mon, 25 Oct 2021 11:12:17 -0400
X-MC-Unique: 6W-nMP3RMqi2_bMdiobc2Q-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so10238064edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=euwk1jl5AJ6LtLgQs5yWOlThVZuR59vdDf7Eg6dCdpg=;
        b=B/oHwKBeluZpGtjVRI5fg75zFsjPoTsfnmKe0ltAgNJ1jVzSnbdyLdKmHxMH2YkAVK
         Kp6IxGld28yuW8Tzl36GeUDG4wWTPyzYChwOQO49NHt1XhLW/eCB1ihq3uwJO7//6kHl
         qBtISFFKpeSItMzUuBZiKxJJVAN1bp8UL6jmLIwkC6pgU6eeWuSHRpj499HwpsiKVObw
         FLK6hdGaMC2PgCVYBSUu0c8RrT3qjkHlpj1JcsxNix8Aoa7o9auqTcdWCRrJRbcI24W5
         XwEyJ8SczA5GKqZRJ3IMtWMh8PxZCkmbcNhgdXfTQuFes9LT4FREC0UfqHfBOg1MvQz6
         kV7g==
X-Gm-Message-State: AOAM5308P1GMjyDeLiiwm9im2KxOUAHEWXSDDl1lhZB5xX+Wyewf9NvR
        alifsr0Yo7qY5B05/hSisoV+rwLLYUPhEmEpRjnMfk3JBgL0pGhiOu++sCWwTX/3FTXCItxxygr
        8So38inOs+l/mXhLXdkULGU3/
X-Received: by 2002:a50:e005:: with SMTP id e5mr26990896edl.211.1635174736317;
        Mon, 25 Oct 2021 08:12:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3A1Ck43BCK0qWIbMOHfdcVYiG+QXmW0S+M8lsEXcpgW4eSCYTg5202CEjUeurqiaIuR9dcg==
X-Received: by 2002:a50:e005:: with SMTP id e5mr26990843edl.211.1635174735934;
        Mon, 25 Oct 2021 08:12:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x26sm7585747ejf.103.2021.10.25.08.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:12:14 -0700 (PDT)
Message-ID: <6ccc8ee5-264b-8341-0af7-bbc6731e93a8@redhat.com>
Date:   Mon, 25 Oct 2021 17:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v5 0/7] KVM: PKS Virtualization support
Content-Language: en-US
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210811101126.8973-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210811101126.8973-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/21 12:11, Chenyi Qiang wrote:
> This patch series is based on top of kernel patchset:
> https://lore.kernel.org/lkml/20210804043231.2655537-1-ira.weiny@intel.com/
> 
> To help patches review, one missing info in SDM is that PKSR will be
> cleared on Powerup/INIT/RESET, which should be listed in Table 9.1
> "IA-32 and Intel 64 Processor States Following Power-up, Reset, or INIT"
> 
> ---
> 
> Protection Keys for Supervisor Pages(PKS) is a feature that extends the
> Protection Keys architecture to support thread-specific permission
> restrictions on supervisor pages.
> 
> PKS works similar to an existing feature named PKU(protecting user pages).
> They both perform an additional check after normal paging permission
> checks are done. Access or Writes can be disabled via a MSR update
> without TLB flushes when permissions changes. If violating this
> addional check, #PF occurs and PFEC.PK bit will be set.
> 
> PKS introduces MSR IA32_PKRS to manage supervisor protection key
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
> Detailed information about PKS can be found in the latest Intel 64 and
> IA-32 Architectures Software Developer's Manual.

Hi Chenyi,

pkrs_cache does not yet exist in Linux 5.15.  What is the state of the 
bare-metal support for PKS?

Thanks,

Paolo

> 
> ---
> 
> Changelogs:
> 
> v4->v5
> - Make setting of MSR intercept/vmcs control bits not dependent on guest.CR4.PKS.
>    And set them if PKS is exposed to guest. (Suggested by Sean)
> - Add pkrs to standard register caching mechanism to help update
>    vcpu->arch.pkrs on demand. Add related helper functions. (Suggested by Sean)
> - Do the real pkrs update in VMCS field in vmx_vcpu_reset and
>    vmx_sync_vmcs_host_state(). (Sean)
> - Add a new mmu_role cr4_pks instead of smushing PKU and PKS together.
>    (Sean & Paolo)
> - v4: https://lore.kernel.org/lkml/20210205083706.14146-1-chenyi.qiang@intel.com/
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
> Chenyi Qiang (7):
>    KVM: VMX: Introduce PKS VMCS fields
>    KVM: VMX: Add proper cache tracking for PKRS
>    KVM: X86: Expose IA32_PKRS MSR
>    KVM: MMU: Rename the pkru to pkr
>    KVM: MMU: Add support for PKS emulation
>    KVM: VMX: Expose PKS to guest
>    KVM: VMX: Enable PKS for nested VM
> 
>   arch/x86/include/asm/kvm_host.h | 17 ++++---
>   arch/x86/include/asm/vmx.h      |  6 +++
>   arch/x86/kvm/cpuid.c            |  2 +-
>   arch/x86/kvm/kvm_cache_regs.h   |  7 +++
>   arch/x86/kvm/mmu.h              | 25 +++++----
>   arch/x86/kvm/mmu/mmu.c          | 68 ++++++++++++++-----------
>   arch/x86/kvm/vmx/capabilities.h |  6 +++
>   arch/x86/kvm/vmx/nested.c       | 41 ++++++++++++++-
>   arch/x86/kvm/vmx/vmcs.h         |  1 +
>   arch/x86/kvm/vmx/vmcs12.c       |  2 +
>   arch/x86/kvm/vmx/vmcs12.h       |  4 ++
>   arch/x86/kvm/vmx/vmx.c          | 89 ++++++++++++++++++++++++++++++---
>   arch/x86/kvm/vmx/vmx.h          |  7 ++-
>   arch/x86/kvm/x86.c              |  6 ++-
>   arch/x86/kvm/x86.h              |  8 +++
>   arch/x86/mm/pkeys.c             |  6 +++
>   include/linux/pkeys.h           |  5 ++
>   17 files changed, 243 insertions(+), 57 deletions(-)
> 

