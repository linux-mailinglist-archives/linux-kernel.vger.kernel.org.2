Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F633BD846
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhGFOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbhGFOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625581693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GEYToz9UGkj5qm0ImJKs8heV1zy8ZipitXq+LmQpYg=;
        b=WMYOqxdPlT1ilxIBj5HaoCO58ptSkA7zTwUUyNBGupE+z0llsTxvDbObIA6v47G92n85xb
        51Y510MyxgPs9nqxH/q7hroHiSukTKaAiJh5A91a8EXjufw97fmKdd8YJ1CP4IGdeuzRZe
        BkLUGZFmxWLRl2MOknNnUJfUQUm2agM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-iZBdcUsKNc-XJSOiAUDomQ-1; Tue, 06 Jul 2021 10:22:08 -0400
X-MC-Unique: iZBdcUsKNc-XJSOiAUDomQ-1
Received: by mail-ed1-f72.google.com with SMTP id i8-20020a50fc080000b02903989feb4920so5420304edr.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GEYToz9UGkj5qm0ImJKs8heV1zy8ZipitXq+LmQpYg=;
        b=YiJmcG32xsWJLTGiG67VENmKbP1/2j0LA/F5VVZrwBPTEvNJ0CDIpW5Hj37z4qB/o1
         5uq4ij75uUXNZNWNSw1A6NWuoyUeJG06P+7tsAOSrRtvMJNmJSvUlhgNakzldKtGuiTg
         rPwGae7bwBNi4UzsiNchmxlain6RSmx/JdgxYlb+x8TsI1DJ3gswSPCIOCo60uaR/O9O
         y5hLkxhYEAWp85utC5UQHkB94EotcPiSUhAFjvTMP5QzKyG7InoP2Xr/xyzL7pPVIgRq
         9dmHu/fkPNQy0x+/Ns0JcaLfrypl5xKW19sJ9vHmJnvbeIrXI9oPdnuJcL30vvbqVZjN
         YU1Q==
X-Gm-Message-State: AOAM532xZgWetsH/9DEFGuwcPtwJECtVu59XmSKCilBEf7wlguvdasrm
        oamNmDNJGUp1Cg8XGlaMUydAK5zzsgqBEE9A3EL3xs/LBhxFb5dUq5gj6DmP4p2mXMJO5dtoCPg
        tDuCJ9gxn1KNmjdl/UxssMkjY
X-Received: by 2002:a17:906:4fce:: with SMTP id i14mr8816391ejw.231.1625581326916;
        Tue, 06 Jul 2021 07:22:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPVTyy71iN1zsNglx8JRKhOkl4/84YFu6o8CZLhwV75mwOcTtwqWL/Rh/ITsWYsdP7hQ/jBQ==
X-Received: by 2002:a17:906:4fce:: with SMTP id i14mr8816367ejw.231.1625581326738;
        Tue, 06 Jul 2021 07:22:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s3sm5816276ejm.49.2021.07.06.07.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:22:05 -0700 (PDT)
Subject: Re: [RFC PATCH v2 65/69] KVM: X86: Introduce initial_tsc_khz in
 struct kvm_arch
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <5f87f0b888555b52041a0fe32280adee0d563e63.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <792040b0-4463-d805-d14e-ba264a3f8bbf@redhat.com>
Date:   Tue, 6 Jul 2021 16:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5f87f0b888555b52041a0fe32280adee0d563e63.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Introduce a per-vm variable initial_tsc_khz to hold the default tsc_khz
> for kvm_arch_vcpu_create().
> 
> This field is going to be used by TDX since TSC frequency for TD guest
> is configured at TD VM initialization phase.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 +
>   arch/x86/kvm/x86.c              | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)

So this means disabling TSC frequency scaling on TDX.  Would it make 
sense to delay VM creation to a separate ioctl, similar to 
KVM_ARM_VCPU_FINALIZE (KVM_VM_FINALIZE)?

Paolo

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a47e17892258..ae8b96e15e71 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1030,6 +1030,7 @@ struct kvm_arch {
>   	u64 last_tsc_nsec;
>   	u64 last_tsc_write;
>   	u32 last_tsc_khz;
> +	u32 initial_tsc_khz;
>   	u64 cur_tsc_nsec;
>   	u64 cur_tsc_write;
>   	u64 cur_tsc_offset;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a8299add443f..d3ebed784eac 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10441,7 +10441,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   	else
>   		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
>   
> -	kvm_set_tsc_khz(vcpu, max_tsc_khz);
> +	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.initial_tsc_khz);
>   
>   	r = kvm_mmu_create(vcpu);
>   	if (r < 0)
> @@ -10894,6 +10894,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	pvclock_update_vm_gtod_copy(kvm);
>   
>   	kvm->arch.guest_can_read_msr_platform_info = true;
> +	kvm->arch.initial_tsc_khz = max_tsc_khz;
>   
>   	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
>   	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
> 

