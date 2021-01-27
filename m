Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8530576E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhA0Jxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbhA0Juo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611740937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydaRB29RJtt52FSXiTlXaP4Ln7O0VcYefbrxc6K6p2E=;
        b=bGqKgf67KKIUzVBmXq3hC/mQqRaFij+zlZRuoDwEoSNK/va2Em4PDtXiw3shcrxVT2p2uk
        KKZUgmSO1LXoBRthbkboA1eSeo4RUb3Vza+qen87GqqyVtvKUoXXgR5UHDFPfsfm3LaEuT
        dJhxiaAVF0tbGanfCtSiBKKiTs7J6yU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-pBG9u6L1Nbe4LMNa8CxCWw-1; Wed, 27 Jan 2021 04:48:55 -0500
X-MC-Unique: pBG9u6L1Nbe4LMNa8CxCWw-1
Received: by mail-ej1-f71.google.com with SMTP id jg11so437799ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydaRB29RJtt52FSXiTlXaP4Ln7O0VcYefbrxc6K6p2E=;
        b=Mo/N3g6SZL7M98yQPP1jhqYl/3I+KEpi5PD3+vBTXSRnnITMu8f6W3/7HqHbxbKKMb
         bkiIg3z/v2SaSLhimETNc/cHWDDC8iEZekWEmxJ867t8wksG4MV1zTdhgkKtt3mE2hOD
         w/N6wUpO1USYcyIfCIBJhUMBmYN+d3oYlEJy6FIu1V6z6ySIBjTOizxpPFXv5iz9LuOe
         0ntbrC34A4+nu2k+W9Q/NGzYD3MCj6+y9KGQK15dVyC8X3W+6aWZetHQnXNedFCBCMlc
         rTIRJfoU5XqWfH8Q1o3GP6lPtUFQbNaoyiBi6UF1G1XqSxYfSfOpBPq99UOGT4/iaEAN
         XHlA==
X-Gm-Message-State: AOAM5312tAexL2z99N1BVPGbW1RxIdG/U9rdfMNt56GGCBbocNgz5sYy
        XU1VKlrXKc7hUhvRiYX1/7iiWoy5Ev6xZ811gB7ogBIRGnPpGZBL8l+YRT4WM1W5F+mlnptYIpF
        f4WdN/ly9tr2mRZSsLm7jS7MT
X-Received: by 2002:a05:6402:2346:: with SMTP id r6mr8473469eda.8.1611740934251;
        Wed, 27 Jan 2021 01:48:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn9gmSbJo4Pspyx7dyn5uVWMly+9aJphrjnuOIsbl99TlsvDoBHK3bJxZqVVn5PPuW+wqiXQ==
X-Received: by 2002:a05:6402:2346:: with SMTP id r6mr8473459eda.8.1611740934102;
        Wed, 27 Jan 2021 01:48:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q4sm570488ejx.8.2021.01.27.01.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 01:48:52 -0800 (PST)
Subject: Re: [RESEND v13 03/10] KVM: x86/pmu: Use IA32_PERF_CAPABILITIES to
 adjust features visibility
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210108013704.134985-1-like.xu@linux.intel.com>
 <20210108013704.134985-4-like.xu@linux.intel.com>
 <a1291d0b-297c-9146-9689-f4a4129de3c6@redhat.com>
 <fd7df596-9715-e6a8-0040-18aecedb0fae@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5da57047-db15-adb6-f3bc-6152753d0b49@redhat.com>
Date:   Wed, 27 Jan 2021 10:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <fd7df596-9715-e6a8-0040-18aecedb0fae@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 07:04, Like Xu wrote:
> On 2021/1/26 17:42, Paolo Bonzini wrote:
>> On 08/01/21 02:36, Like Xu wrote:
>>>
>>> @@ -401,6 +398,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>>          pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
>>>          pmu->fixed_counters[i].current_config = 0;
>>>      }
>>> +
>>> +    vcpu->arch.perf_capabilities = guest_cpuid_has(vcpu, 
>>> X86_FEATURE_PDCM) ?
>>> +        vmx_get_perf_capabilities() : 0;
>>
>> There is one thing I don't understand with this patch: intel_pmu_init 
>> is not called when CPUID is changed.  So I would have thought that 
>> anything that uses guest_cpuid_has must stay in intel_pmu_refresh.  As 
>> I understand it vcpu->arch.perf_capabilities is always set to 0 
>> (vmx_get_perf_capabilities is never called), and kvm_set_msr_common 
>> would fail to set any bit in the MSR.  What am I missing?
>>
>> In addition, the code of patch 4:
>>
>> +    if (!intel_pmu_lbr_is_enabled(vcpu)) {
>> +        vcpu->arch.perf_capabilities &= ~PMU_CAP_LBR_FMT;
>> +        lbr_desc->records.nr = 0;
>> +    }
>>
>> is not okay after MSR changes.  The value written by the host must be 
>> either rejected (with "return 1") or applied unchanged.
>>
>> Fortunately I think this code is dead if you move the check in 
>> kvm_set_msr from patch 9 to patch 4.  However, in patch 9 
>> vmx_get_perf_capabilities() must only set the LBR format bits if 
>> intel_pmu_lbr_is_compatible(vcpu).
> 
> Thanks for the guidance. How about handling it in this way:
> 
> In the intel_pmu_init():
> 
>      vcpu->arch.perf_capabilities = 0;
>      lbr_desc->records.nr = 0;
> 
> In the intel_pmu_refresh():
> 
>      if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM)) {
>          vcpu->arch.perf_capabilities = vmx_get_perf_capabilities();
>          if (!lbr_desc->records.nr)
>              vcpu->arch.perf_capabilities &= ~PMU_CAP_LBR_FMT;
>      }
> 
> In the vmx_set_msr():
> 
>      case MSR_IA32_PERF_CAPABILITIES:
>          // set up lbr_desc->records.nr
>          if (!intel_pmu_lbr_is_compatible(vcpu))

Maybe pass msr_info.data to intel_pmu_lbr_is_compatible?  Otherwise 
seems okay, thanks Like.

Paolo

