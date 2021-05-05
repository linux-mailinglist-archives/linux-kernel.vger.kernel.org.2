Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEB37369C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhEEIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbhEEIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620204588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29V+H59ihZvB+veqIvoMKc9+NOTSbPAa2eKaOK9eB7o=;
        b=ICX7yy0ow+fNdofCnguKJo+FdsIm/hZaoJ/31gMdCqjpPM6EqMqnnprH4M+GkGKvdlJVVW
        hGohaSifgV9gg5Ofg6WBIq9KJXRMdUR6hgJ+AAYIdvqkL4l0u0uDAAGaU187Va/HjXQhRw
        /oaNqX/0xejY3hv9SOYKQ63xWQq6L6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-7HzILVRNPGKJWPBeLd6fkQ-1; Wed, 05 May 2021 04:49:47 -0400
X-MC-Unique: 7HzILVRNPGKJWPBeLd6fkQ-1
Received: by mail-ej1-f69.google.com with SMTP id z13-20020a1709067e4db02903a28208c9bdso212974ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 01:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29V+H59ihZvB+veqIvoMKc9+NOTSbPAa2eKaOK9eB7o=;
        b=GWu799UheXl8Dg9oHAngdyueUlMmcEBylR6QEGDNw1JHXJCVZ0aQYYRTnvAMzOqbuj
         eYlQ/Xo0s0N7So2DZ9owO24+GNWA7rPA2jF2N2pGrRw+0mTZL/mARpgPGveWZt8uS7UQ
         na0U+hUJ8LoQDQ2IC4fVwQ+pUXDFdCJaUxQkPoZKu7F4/KstMkcqCnMpF6Yhv+e1pL1W
         QM2jRTbO6Dv+tbGkCbILz0XgbHwjEQgcLxZMcQpADeRwOaaiGEbHPXR7mmSLbpTxddN+
         /6xPcg1z83w39hOBjInjmbxDG/igariOH1ifXnb5ralwYMaifUcIfjrIKtP61A3lHl2J
         iAgQ==
X-Gm-Message-State: AOAM531m/mntmFegxhfZgrZYSUME2zwGqYZradMbSB/fmcndX6+4eo22
        zrd5wuieZa7kxuYnsz3iebauEgkYBUuXXzA4bEQXmp1TxH5w3hRtE8D43PqXA7UBDE3Kuw9Dwgl
        ONM8Hd3/ouOZaMgVeLUmoCJJu
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr25878205ejd.220.1620204586296;
        Wed, 05 May 2021 01:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi+ao8G1OtHyMGJx8iniEaDVC4+0sEIRI0oG5ZRyybeoPnAJbchOxnoCpdmbD9TPJncJvljw==
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr25878182ejd.220.1620204586102;
        Wed, 05 May 2021 01:49:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g13sm2621744ejx.51.2021.05.05.01.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 01:49:45 -0700 (PDT)
Subject: Re: [PATCH 11/15] KVM: VMX: Disable loading of TSX_CTRL MSR the more
 conventional way
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-12-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08a4afca-c3cb-1999-02a6-a72440ab2214@redhat.com>
Date:   Wed, 5 May 2021 10:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504171734.1434054-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 19:17, Sean Christopherson wrote:
> Tag TSX_CTRL as not needing to be loaded when RTM isn't supported in the
> host.  Crushing the write mask to '0' has the same effect, but requires
> more mental gymnastics to understand.

This doesn't explain _why_ this is now possible.  What about:

Now that user return MSRs is always present in the list, we don't have
the problem that the TSX_CTRL MSR needs a slot vmx->guest_uret_msrs even
if RTM is not supported in the host (and therefore there is nothing to
enable).  Thus we can simply tag TSX_CTRL as not needing to be loaded
instead of crushing the write mask to '0'.  That has the same effect,
but requires less mental gymnastics to understand.

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4b432d2bbd06..7a53568b34fc 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1771,7 +1771,13 @@ static void setup_msrs(struct vcpu_vmx *vmx)
>   			   guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDTSCP) ||
>   			   guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDPID));
>   
> -	vmx_setup_uret_msr(vmx, MSR_IA32_TSX_CTRL, true);
> +	/*
> +	 * hle=0, rtm=0, tsx_ctrl=1 can be found with some combinations of new
> +	 * kernel and old userspace.  If those guests run on a tsx=off host, do
> +	 * allow guests to use TSX_CTRL, but don't change the value in hardware
> +	 * so that TSX remains always disabled.
> +	 */
> +	vmx_setup_uret_msr(vmx, MSR_IA32_TSX_CTRL, boot_cpu_has(X86_FEATURE_RTM));
>   
>   	if (cpu_has_vmx_msr_bitmap())
>   		vmx_update_msr_bitmap(&vmx->vcpu);
> @@ -6919,23 +6925,15 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>   		vmx->guest_uret_msrs[i].data = 0;
>   		vmx->guest_uret_msrs[i].mask = -1ull;
>   	}
> -	tsx_ctrl = vmx_find_uret_msr(vmx, MSR_IA32_TSX_CTRL);
> -	if (tsx_ctrl) {
> +	if (boot_cpu_has(X86_FEATURE_RTM)) {
>   		/*
>   		 * TSX_CTRL_CPUID_CLEAR is handled in the CPUID interception.
>   		 * Keep the host value unchanged to avoid changing CPUID bits
>   		 * under the host kernel's feet.
> -		 *
> -		 * hle=0, rtm=0, tsx_ctrl=1 can be found with some combinations
> -		 * of new kernel and old userspace.  If those guests run on a
> -		 * tsx=off host, do allow guests to use TSX_CTRL, but do not
> -		 * change the value on the host so that TSX remains always
> -		 * disabled.
>   		 */
> -		if (boot_cpu_has(X86_FEATURE_RTM))
> +		tsx_ctrl = vmx_find_uret_msr(vmx, MSR_IA32_TSX_CTRL);
> +		if (tsx_ctrl)
>   			vmx->guest_uret_msrs[i].mask = ~(u64)TSX_CTRL_CPUID_CLEAR;
> -		else
> -			vmx->guest_uret_msrs[i].mask = 0;
>   	}
>   
>   	err = alloc_loaded_vmcs(&vmx->vmcs01);
> 

