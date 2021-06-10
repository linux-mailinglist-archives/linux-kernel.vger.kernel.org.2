Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8393A3178
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFJQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhFJQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623344086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZKjUYbhn+ujM88CtYMrYHvT2/okwVu6dwL5yqGGQwE=;
        b=M/utuYbrhkhx8AaiE5F71OYkaSZmfFI06sdRf9HLhO82dIDSprcGxA9Q+3K29so+jONNWN
        +nbIAVpzzhIAcFA4luX425yXL/7h7tvXAf+P8jEwQjjtpbDcFl+uqY27fNTiNCj4VYivDT
        DHOz0gcJdWhcUquuN7DAFfS7NIYuXvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-2LFhRj-RNBeGEaVR-1THAA-1; Thu, 10 Jun 2021 12:54:44 -0400
X-MC-Unique: 2LFhRj-RNBeGEaVR-1THAA-1
Received: by mail-wr1-f70.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so1256636wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZKjUYbhn+ujM88CtYMrYHvT2/okwVu6dwL5yqGGQwE=;
        b=OPaJRcCzB//xrlZClAJF4Cf62CZucKGQFqV/OwrKy8m9d/O2Y8T83LQlTKG+3eiQjo
         XVN9YrQzliHuNX0jaxIqZKqEMaEnqw8ssbrfzOgKYBlpt1K3k1bvNx6sQFc5kN8Fo689
         WLz2p5yuufMQG4WDPNVYpRXD+NyZ6xfVzGjlPx00F9yqPwwHwwAS0/i/Mq2eBGhmNeKu
         1txVwnDBx+qbXOOl6hL+maUtA7HTgha0/sFi0v3viCUsXPOS/81piUtHhNo0+rtgkB5s
         W41bzbjpgGtVA0TBO9w4YAmTN92t2CLxYE90HYspnV7/rCfOIHBXl88zwYF5AYqobndO
         eaBg==
X-Gm-Message-State: AOAM532bORtKbSK8tpn5nyDoWdoExakIlRWnAsPVkzUveYW29Lm9TtTG
        Yi5IB+u0ocX/Uyza5AmpDYLaQd8CNZdgXhEN5eAx8/uCg6reamSnWfmtAMoy1km6Mb2U7AwX+YU
        pjpQUKRIN0Lp7o/e5SIqV2voNv5JFDZo0CoGAe86+GzFkDVyGfEo25fwatyxXl2gLyehyd1RUoL
        AK
X-Received: by 2002:adf:bd84:: with SMTP id l4mr6537603wrh.346.1623344082593;
        Thu, 10 Jun 2021 09:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5Hib/kxF0630vGEVFBfE4WOFd32F/WLvmzJkHsZhqBtMxBsbDYfbxUVIUt00BXa5XytFuIQ==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr6537582wrh.346.1623344082336;
        Thu, 10 Jun 2021 09:54:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id r2sm4273867wrv.39.2021.06.10.09.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:54:41 -0700 (PDT)
Subject: Re: [PATCH 00/43] KVM: x86: vCPU RESET/INIT fixes and consolidation
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210424004645.3950558-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ac56ad5-7475-c99f-0ca4-171bc3da45b5@redhat.com>
Date:   Thu, 10 Jun 2021 18:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/21 02:46, Sean Christopherson wrote:
> For the record, I went into this thinking it was going to be a simple code
> shuffle between {svm,vmx}_vcpu_reset() and kvm_vcpu_reset().  The actual
> goal is to consolidate the RESET/INIT code, both to deduplicate code and
> to try to avoid divergent behavior/bugs, e.g. SVM only recently started
> updating vcpu->arch.cr4 on INIT.
> 
> The TL;DR of why it takes 40+ patches to get there is that the RESET/INIT
> flows have multiple latent bugs and hidden dependencies, but "work"
> because they're rarely touched, are mostly fixed flows in both KVM and the
> guest, and because guests don't sanity check state after INIT.
> 
> While several of the patches have Fixes tags, I am absolutely terrified of
> backporting most of them due to the likelihood of breaking a different
> version of KVM.  And, for the most part the bugs are benign in the sense
> no guest has actually encountered any of these bugs.  For that reason, I
> intentionally omitted stable@ entirely.  The only patches I would consider
> even remotely safe for backporting are the first two patches in the series.
> 
> 
> Sean Christopherson (43):
>    KVM: nVMX: Set LDTR to its architecturally defined value on nested
>      VM-Exit
>    KVM: VMX: Set EDX at INIT with CPUID.0x1, Family-Model-Stepping
>    KVM: SVM: Require exact CPUID.0x1 match when stuffing EDX at INIT
>    KVM: SVM: Fall back to KVM's hardcoded value for EDX at RESET/INIT
>    KVM: x86: Split out CR0/CR4 MMU role change detectors to separate
>      helpers
>    KVM: x86: Properly reset MMU context at vCPU RESET/INIT
>    KVM: VMX: Remove explicit MMU reset in enter_rmode()
>    KVM: SVM: Drop explicit MMU reset at RESET/INIT
>    KVM: SVM: Drop a redundant init_vmcb() from svm_create_vcpu()
>    KVM: VMX: Move init_vmcs() invocation to vmx_vcpu_reset()
>    KVM: x86: WARN if the APIC map is dirty without an in-kernel local
>      APIC
>    KVM: x86: Remove defunct BSP "update" in local APIC reset
>    KVM: x86: Migrate the PIT only if vcpu0 is migrated, not any BSP
>    KVM: x86: Don't force set BSP bit when local APIC is managed by
>      userspace
>    KVM: x86: Set BSP bit in reset BSP vCPU's APIC base by default
>    KVM: VMX: Stuff vcpu->arch.apic_base directly at vCPU RESET
>    KVM: x86: Open code necessary bits of kvm_lapic_set_base() at vCPU
>      RESET
>    KVM: x86: Consolidate APIC base RESET initialization code
>    KVM: x86: Move EDX initialization at vCPU RESET to common code
>    KVM: SVM: Don't bother writing vmcb->save.rip at vCPU RESET/INIT
>    KVM: VMX: Invert handling of CR0.WP for EPT without unrestricted guest
>    KVM: VMX: Remove direct write to vcpu->arch.cr0 during vCPU RESET/INIT
>    KVM: VMX: Fold ept_update_paging_mode_cr0() back into vmx_set_cr0()
>    KVM: nVMX: Do not clear CR3 load/store exiting bits if L1 wants 'em
>    KVM: VMX: Pull GUEST_CR3 from the VMCS iff CR3 load exiting is
>      disabled
>    KVM: VMX: Process CR0.PG side effects after setting CR0 assets
>    KVM: VMX: Skip emulation required checks during pmode/rmode
>      transitions
>    KVM: nVMX: Don't evaluate "emulation required" on VM-Exit
>    KVM: SVM: Tweak order of cr0/cr4/efer writes at RESET/INIT
>    KVM: SVM: Drop redundant writes to vmcb->save.cr4 at RESET/INIT
>    KVM: SVM: Stuff save->dr6 at during VMSA sync, not at RESET/INIT
>    KVM: VMX: Skip pointless MSR bitmap update when setting EFER
>    KVM: VMX: Refresh list of user return MSRs after setting guest CPUID
>    KVM: VMX: Don't _explicitly_ reconfigure user return MSRs on vCPU INIT
>    KVM: x86: Move setting of sregs during vCPU RESET/INIT to common x86
>    KVM: VMX: Remove obsolete MSR bitmap refresh at vCPU RESET/INIT
>    KVM: nVMX: Remove obsolete MSR bitmap refresh at nested transitions
>    KVM: VMX: Don't redo x2APIC MSR bitmaps when userspace filter is
>      changed
>    KVM: VMX: Remove unnecessary initialization of msr_bitmap_mode
>    KVM: VMX: Smush x2APIC MSR bitmap adjustments into single function
>    KVM: VMX: Remove redundant write to set vCPU as active at RESET/INIT
>    KVM: VMX: Drop VMWRITEs to zero fields at vCPU RESET
>    KVM: x86: Drop pointless @reset_roots from kvm_init_mmu()
> 
>   arch/x86/include/asm/kvm_host.h |   5 -
>   arch/x86/kvm/i8254.c            |   3 +-
>   arch/x86/kvm/lapic.c            |  26 +--
>   arch/x86/kvm/mmu.h              |   2 +-
>   arch/x86/kvm/mmu/mmu.c          |  13 +-
>   arch/x86/kvm/svm/nested.c       |   2 +-
>   arch/x86/kvm/svm/sev.c          |   1 +
>   arch/x86/kvm/svm/svm.c          |  33 +---
>   arch/x86/kvm/vmx/nested.c       |  26 ++-
>   arch/x86/kvm/vmx/vmx.c          | 271 +++++++++++++-------------------
>   arch/x86/kvm/vmx/vmx.h          |   5 +-
>   arch/x86/kvm/x86.c              |  51 +++++-
>   12 files changed, 189 insertions(+), 249 deletions(-)
> 

I'm waiting for a v2 of this; it applies with relatively few conflicts, 
but there were some comments so it's better if you take care of updating it.

Paolo

