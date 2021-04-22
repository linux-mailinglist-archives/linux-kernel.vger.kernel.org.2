Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03435367ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhDVHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhDVHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619075672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IogrsY3cJq5WADFY6TutrJbboIoUZaCtFj92TrOe82w=;
        b=LBqY6Ps370YIuphmeZ8KEk/wdwr98PH08NobF4i13eIhJigTxuN2wAU95vezaGFbE5VkMJ
        8rAAzB6Bt2RGOyBDnKx99opemXckzHED3i81vEvovge0VikZeolzr6aZvPVkLWf2ryzBmL
        LrPviXEfzZiodEvrnzbECXbbZ/PbuFU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-fqXwljOnMtiNjlQ3GM-frA-1; Thu, 22 Apr 2021 03:14:30 -0400
X-MC-Unique: fqXwljOnMtiNjlQ3GM-frA-1
Received: by mail-ed1-f71.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so16216317edr.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IogrsY3cJq5WADFY6TutrJbboIoUZaCtFj92TrOe82w=;
        b=Yq/DhYb2ijhw60TL5EMkCVKtsW1XjLHxU4zk0NVzB7UDKTeaNSNl/cy02rsU7KpL4U
         3sLQqKvHKVenoVOVj9F8DMGJ+3Y1tZGambIjlj5UhFjvDsOjDYEFP1/YUsr4L/QYlVA2
         H5dgQfqkIEpPFaPZTFGTaOH/llYC4l7MDz5v9Gg1EcrNP/yR1RsEJUL2eJj1K6w3CMJO
         zjMpn9/iwEI0YI5jU2EVgGROnRSxJt7MaKRRTFopmiMharNaFzNoxjxQ3FOxhFyzRX7W
         GEwHVPrkcV5slidsl2+BE6FTcOAIfvFRs7WdpEycNrSiGsjNxBf0NbEuSKTAEY+XwbuK
         dypw==
X-Gm-Message-State: AOAM533N8fJ9QjG/sQH/CKxXkro295aBMwjUyrAJn5e/fNWOHMfGDoPL
        r1kb2gZFq37fjOnMUxtneB7amj0FmWk6y4Q5GWlLX16vTTYEN2aJP/N7XJW14SHYy58j2FSEdiP
        hk4arSu/r0aNIhnO7jyj96Qf2
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr1958968ejb.58.1619075668625;
        Thu, 22 Apr 2021 00:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwip4qdfn29LT5Urrukkg+Xlat6rXN10GBboYd0g+NCnt5pXUXcX3xQ7cHMVL1uQIIrAYE2ng==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr1958936ejb.58.1619075668395;
        Thu, 22 Apr 2021 00:14:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q12sm1236568ejy.91.2021.04.22.00.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:14:27 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Huang <wei.huang2@amd.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210422021125.3417167-1-seanjc@google.com>
 <20210422021125.3417167-4-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 03/15] KVM: SVM: Disable SEV/SEV-ES if NPT is disabled
Message-ID: <5e8a2d7d-67de-eef4-ab19-33294920f50c@redhat.com>
Date:   Thu, 22 Apr 2021 09:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422021125.3417167-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 04:11, Sean Christopherson wrote:
> Disable SEV and SEV-ES if NPT is disabled.  While the APM doesn't clearly
> state that NPT is mandatory, it's alluded to by:
> 
>    The guest page tables, managed by the guest, may mark data memory pages
>    as either private or shared, thus allowing selected pages to be shared
>    outside the guest.
> 
> And practically speaking, shadow paging can't work since KVM can't read
> the guest's page tables.
> 
> Fixes: e9df09428996 ("KVM: SVM: Add sev module_param")
> Cc: Brijesh Singh <brijesh.singh@amd.com
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fed153314aef..0e8489908216 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -970,7 +970,21 @@ static __init int svm_hardware_setup(void)
>   		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
>   	}
>   
> -	if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev) {
> +	/*
> +	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
> +	 * NPT isn't supported if the host is using 2-level paging since host
> +	 * CR4 is unchanged on VMRUN.
> +	 */
> +	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
> +		npt_enabled = false;

Unrelated, but since you're moving this code: should we be pre-scient 
and tackle host 5-level paging as well?

Support for 5-level page tables on NPT is not hard to fix and could be 
tested by patching QEMU.  However, the !NPT case would also have to be 
fixed by extending the PDP and PML4 stacking trick to a PML5.

However, without real hardware to test on I'd be a bit wary to do it. 
Looking at 5-level EPT there might be other issues (e.g. what's the 
guest MAXPHYADDR) and I would prefer to see what AMD comes up with 
exactly in the APM.  So I would just block loading KVM on hypothetical 
AMD hosts with CR4.LA57=1.

Paolo

> +	if (!boot_cpu_has(X86_FEATURE_NPT))
> +		npt_enabled = false;
> +
> +	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
> +	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
> +
> +	if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev && npt_enabled) {
>   		sev_hardware_setup();
>   	} else {
>   		sev = false;
> @@ -985,20 +999,6 @@ static __init int svm_hardware_setup(void)
>   			goto err;
>   	}
>   
> -	/*
> -	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
> -	 * NPT isn't supported if the host is using 2-level paging since host
> -	 * CR4 is unchanged on VMRUN.
> -	 */
> -	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
> -		npt_enabled = false;
> -
> -	if (!boot_cpu_has(X86_FEATURE_NPT))
> -		npt_enabled = false;
> -
> -	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
> -	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
> -
>   	if (nrips) {
>   		if (!boot_cpu_has(X86_FEATURE_NRIPS))
>   			nrips = false;
> 

