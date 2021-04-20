Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF9365F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhDTSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233363AbhDTSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618943994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyXhhq+2wOQb1FFEVdXTrbOYneoK2uCo4E7s9wM+LkA=;
        b=FAa8g1GCbyK+oBnjcRgRC4SzONg+7iPSlbuV6UgB/8ssohDSAVGhgcCNrnR1RReLgPyNaS
        ZZzpwGJsMkqHG8Mx+duuiS7Fal0xop5YVpsTSom6xZowjNsw/1hgla2OgMHFK6TFYT/zXP
        BxGMc27cuiSHvo/47J06Q6V4Ampgl9E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-mYdwETEbNRamZ9uy0ALWGA-1; Tue, 20 Apr 2021 14:39:50 -0400
X-MC-Unique: mYdwETEbNRamZ9uy0ALWGA-1
Received: by mail-ed1-f72.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so8027963edr.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyXhhq+2wOQb1FFEVdXTrbOYneoK2uCo4E7s9wM+LkA=;
        b=Q0ci2Snq7Sr7xSS9vHSGPGg7Gac51BRIwWeKjKh4qaiDFr+X4lHs4KvGK86jOkjPWy
         1csxE9kNqaFpAH2du2FVYZ1lyyI+bnZxHK6hECjKVIGwDC4uTp3q7VvllAw9CoRFb49A
         ZWw3zedTamWM0TOAUUsEIv3+yBLjlCdr1laGkYDRSl3h3CYZoCzZDLxlZKtuo/R8vNFX
         a6kmpQD10QkqO5g082eqO61nK0rrwGuEpyvyghPLI9aDtVVvlzKKDuf124ZvTDuSc6Ur
         C8Td/bO9aoueqGXRaSxz5C1kcxEjufthETpIBLbqg/cUupiAFah9n2Qt5AxRomqi98YN
         vsZA==
X-Gm-Message-State: AOAM533RVYK742Fe9gjCJmryDPD3aSm2IZRB41PUhdd0QFBDy3fwsNzF
        WPQK7COr7NbGyuiLps8lIg/GiZJCwQKa4mudr58kGOh6E3NCiST+SA3tUwT9cbjwWYCjDGyDUlg
        hMiUqk49gbPFy0IzAE1gKWdjl
X-Received: by 2002:a17:906:3e97:: with SMTP id a23mr29360804ejj.440.1618943989477;
        Tue, 20 Apr 2021 11:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBjkO8HO/asdyqv7Kin2bAByvw6ozVrVzsbE31VNjnhomXf1tNQkTv9/u8cjWadpMkjAZPsw==
X-Received: by 2002:a17:906:3e97:: with SMTP id a23mr29360785ejj.440.1618943989265;
        Tue, 20 Apr 2021 11:39:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id 9sm12890206ejv.73.2021.04.20.11.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 11:39:48 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        srutherford@google.com, joro@8bytes.org, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, Ashish Kalra <ashish.kalra@amd.com>
References: <20210420112006.741541-1-pbonzini@redhat.com>
 <YH8P26OibEfxvJAu@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] KVM: x86: guest interface for SEV live migration
Message-ID: <05129de6-c8d9-de94-89e7-6257197433ef@redhat.com>
Date:   Tue, 20 Apr 2021 20:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YH8P26OibEfxvJAu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 19:31, Sean Christopherson wrote:
>> +	case KVM_HC_PAGE_ENC_STATUS: {
>> +		u64 gpa = a0, npages = a1, enc = a2;
>> +
>> +		ret = -KVM_ENOSYS;
>> +		if (!vcpu->kvm->arch.hypercall_exit_enabled)
> 
> I don't follow, why does the hypercall need to be gated by a capability?  What
> would break if this were changed to?
> 
> 		if (!guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))

The problem is that it's valid to take KVM_GET_SUPPORTED_CPUID and send 
it unmodified to KVM_SET_CPUID2.  For this reason, features that are 
conditional on other ioctls, or that require some kind of userspace 
support, must not be in KVM_GET_SUPPORTED_CPUID.  For example:

- TSC_DEADLINE because it is only implemented after KVM_CREATE_IRQCHIP 
(or after KVM_ENABLE_CAP of KVM_CAP_IRQCHIP_SPLIT)

- MONITOR only makes sense if userspace enables KVM_CAP_X86_DISABLE_EXITS

X2APIC is reported even though it shouldn't be.  Too late to fix that, I 
think.

In this particular case, if userspace sets the bit in CPUID2 but doesn't 
handle KVM_EXIT_HYPERCALL, the guest will probably trigger some kind of 
assertion failure as soon as it invokes the HC_PAGE_ENC_STATUS hypercall.

(I should document that, Jim asked for documentation around 
KVM_GET_SUPPORTED_CPUID and KVM_GET_MSR_INDEX_LIST many times).

Paolo

>> +			break;
>> +
>> +		if (!PAGE_ALIGNED(gpa) || !npages ||
>> +		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
>> +		vcpu->run->hypercall.nr       = KVM_HC_PAGE_ENC_STATUS;
>> +		vcpu->run->hypercall.args[0]  = gpa;
>> +		vcpu->run->hypercall.args[1]  = npages;
>> +		vcpu->run->hypercall.args[2]  = enc;
>> +		vcpu->run->hypercall.longmode = op_64_bit;
>> +		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
>> +		return 0;
>> +	}
>>   	default:
>>   		ret = -KVM_ENOSYS;
>>   		break;
> 
> ...
> 
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 590cc811c99a..d696a9f13e33 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3258,6 +3258,14 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>   		vcpu->arch.msr_kvm_poll_control = data;
>>   		break;
>>   
>> +	case MSR_KVM_MIGRATION_CONTROL:
>> +		if (data & ~KVM_PAGE_ENC_STATUS_UPTODATE)
>> +			return 1;
>> +
>> +		if (data && !guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))
> 
> Why let the guest write '0'?  Letting the guest do WRMSR but not RDMSR is
> bizarre.

Because it was the simplest way to write the code, but returning 0 
unconditionally from RDMSR is actually simpler.

Paolo

>> +			return 1;
>> +		break;
>> +
>>   	case MSR_IA32_MCG_CTL:
>>   	case MSR_IA32_MCG_STATUS:
>>   	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
>> @@ -3549,6 +3557,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>   		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
>>   			return 1;
>>   
>> +		msr_info->data = 0;
>> +		break;
>> +	case MSR_KVM_MIGRATION_CONTROL:
>> +		if (!guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))
>> +			return 1;
>> +
>>   		msr_info->data = 0;
>>   		break;
>>   	case MSR_KVM_STEAL_TIME:
>> -- 
>> 2.26.2
>>
> 

