Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5735A30BD9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBBMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:02:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBBMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612267254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHGKh34huCoeQ10zAXIKIqStyqxcdVd3EczNNrrMJKo=;
        b=A9mxHpJmTJTTG0NJXB+6FtDGR09y3GZYk1tBK9c5jqr1I8aQZkZ7ZMklLJUeR3H77IaLvL
        ncsAMYwsX3vkydVm3uf4C2SCTQGpJtioPi8353L1ud44H5rmKcA/unyzf72g67dvF3cLzG
        ogw38A+j4RTrPNvP62+O5xhRVwtJAFA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ydA_z31ZOF-4PIWQDfsKXw-1; Tue, 02 Feb 2021 07:00:49 -0500
X-MC-Unique: ydA_z31ZOF-4PIWQDfsKXw-1
Received: by mail-ed1-f71.google.com with SMTP id y6so9442162edc.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 04:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHGKh34huCoeQ10zAXIKIqStyqxcdVd3EczNNrrMJKo=;
        b=oinXH2egeFZSnYEk405vj0puoHdKpGAdEfU6ZNp3FH9HXEMLI4Gq8LHRJzFPM16KUS
         nX5OTNCprNNkrWWqRMrY4iZ07pAcNBluv6WyqxIVRE46ubm3s/gsaL2uBP0CTOgISIwU
         I3KWxm4/r8urWNgHn1VUct+1H3sHbL517yQGy4NjvT62xgPvYzF9gN58K1NdTjSLl2Qh
         igULtPrryGW8lUciRv60KgCyFCQ8utPfCOGDO9gFn6VXvRMqrr5/ylhwhB1MiTyewJVu
         wdrTdr2TBJViL8ixdIl3RJnZAXi6VkvhptZF0NHbEK3Nkx+41ZLC25bubkKrMFkfe/mu
         skOA==
X-Gm-Message-State: AOAM5301JZIhfQ9XodJQDUIjRevkbN+OEXgNvqkWVdjVbGk3RuzdLGy7
        A+f6YULlQ/m65+ggpaJCMD8MPvC8lxPMuyaTaS6YslJODC0hrLQbP3Pty8chedqqLNPJlIGXb8H
        nUk2ueQS+thCm1IIT259my3ObatRazy5YMy0MqqxaC+E1JkiwIw8y22oXTk80kd3wQrIQ2DL0ju
        xa
X-Received: by 2002:aa7:db13:: with SMTP id t19mr6287746eds.74.1612267247655;
        Tue, 02 Feb 2021 04:00:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAoDNQ+n37lIfK2cZm2KBd+D3ZU/PVDvl7vRG2S41PzSISFuqSXCIAJs/okgJWX3zfEz4F6w==
X-Received: by 2002:aa7:db13:: with SMTP id t19mr6287709eds.74.1612267247385;
        Tue, 02 Feb 2021 04:00:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z20sm9910231edx.15.2021.02.02.04.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 04:00:46 -0800 (PST)
Subject: Re: [PATCH v14 03/11] KVM: vmx/pmu: Add PMU_CAP_LBR_FMT check when
 guest LBR is enabled
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com,
        alex.shi@linux.alibaba.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210201051039.255478-1-like.xu@linux.intel.com>
 <20210201051039.255478-4-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0ffee96-366c-205a-1507-7db1d8b44de5@redhat.com>
Date:   Tue, 2 Feb 2021 13:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201051039.255478-4-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/21 06:10, Like Xu wrote:
> Usespace could set the bits [0, 5] of the IA32_PERF_CAPABILITIES
> MSR which tells about the record format stored in the LBR records.
> 
> The LBR will be enabled on the guest if host perf supports LBR
> (checked via x86_perf_get_lbr()) and the vcpu model is compatible
> with the host one.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/capabilities.h |  1 +
>   arch/x86/kvm/vmx/pmu_intel.c    | 17 +++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c          |  7 +++++++
>   arch/x86/kvm/vmx/vmx.h          | 11 +++++++++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index a58cf3655351..db1178a66d93 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -19,6 +19,7 @@ extern int __read_mostly pt_mode;
>   #define PT_MODE_HOST_GUEST	1
>   
>   #define PMU_CAP_FW_WRITES	(1ULL << 13)
> +#define PMU_CAP_LBR_FMT		0x3f
>   
>   struct nested_vmx_msrs {
>   	/*
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index f632039173ff..01b2cd8eca47 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -168,6 +168,21 @@ static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
>   	return get_gp_pmc(pmu, msr, MSR_IA32_PMC0);
>   }
>   
> +bool intel_pmu_lbr_is_compatible(struct kvm_vcpu *vcpu)
> +{
> +	struct x86_pmu_lbr *lbr = vcpu_to_lbr_records(vcpu);
> +
> +	/*
> +	 * As a first step, a guest could only enable LBR feature if its
> +	 * cpu model is the same as the host because the LBR registers
> +	 * would be pass-through to the guest and they're model specific.
> +	 */
> +	if (boot_cpu_data.x86_model != guest_cpuid_model(vcpu))
> +		return false;
> +
> +	return !x86_perf_get_lbr(lbr);

This seems the wrong place to me.  What about adding

+	if (intel_pmu_lbr_is_compatible(vcpu))
+		x86_perf_get_lbr(lbr_desc);
+	else
+		lbr_desc->records.nr = 0;
  }

at the end of intel_pmu_refresh instead?

Paolo

