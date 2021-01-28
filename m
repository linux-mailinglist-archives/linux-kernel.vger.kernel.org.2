Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28208307C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhA1RcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233109AbhA1R0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611854709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvzLnQV83UjGmhjL45DZ7eCVOKze42prwXNVTupzJKM=;
        b=J3S+2mAv8ehNUSmOVpy0bIPTy+iG3u8v0OP1IBuwkkDIQDIRmwFnC8uKUcwYul0wBEbmBi
        TEUPggWL0iTW8jHbfg0BlG1EAaNA3nCqKEPt0IDi8EUKbTbYxQZ0QIvmMn8PcDnv8VbuLW
        W86dqKTbR5RQLjkg2TVOQArNqF3z27g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-19hXtrA4Ml-iI7kuLElWSA-1; Thu, 28 Jan 2021 12:25:07 -0500
X-MC-Unique: 19hXtrA4Ml-iI7kuLElWSA-1
Received: by mail-ej1-f72.google.com with SMTP id x22so2494829ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvzLnQV83UjGmhjL45DZ7eCVOKze42prwXNVTupzJKM=;
        b=lQYB65V4UjpUa32cgJmT7EcVIFg6smzsivSzjlVQg3bhCQrhKwyZidLu9Z0ASM65Vc
         CB18ca0baF6gZFVMg09rnt7yGlB8C17cZ5q8ejwI0KWz+acYCrf+5waEWAwd6w0jD11T
         2UJRSx5yPaIK+y3tWihedr9dfUbFrOc/TAoXLsB3Zrun8zllI71eKgduszCw2qKtvHzm
         UpcBTKdAyh/TEOclDXjMONJgk1p+H2imdUiNPM+k5Kea+euTR8P43QvPNP6jVYEWi2XJ
         luujGoljjOgVBI7vUZy7ebuiJ1+nSfvdPWnjgTQhRY4G8iW3i/U9XsiCMZty4u+t5zmf
         rLdA==
X-Gm-Message-State: AOAM530kzrhgLc/VsyR2pIK1+GWnzFbdqaZNqMY88zr8q1uqLF4gpfN+
        FWyt5xpU9yKmQMxIkp5WDmGacOaUeh0I6S5LSYi9YawCy5Gz1FpdKtgNlZYhOQC3uEvgEICK5QH
        CzzTYjZQmJGl3FrpP51mzHXOA
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr703855edd.0.1611854706493;
        Thu, 28 Jan 2021 09:25:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtOL/S/cD3z5oCNOg2PKmdtIyy9IJN3TBOI+ONGmeMo6ik2bjQtL6XiRo14sQPPNELnEDn5g==
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr703832edd.0.1611854706290;
        Thu, 28 Jan 2021 09:25:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h12sm3180823edb.16.2021.01.28.09.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:25:05 -0800 (PST)
Subject: Re: [PATCH v2 05/14] KVM: x86: Override reported SME/SEV feature
 flags with host mask
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-6-seanjc@google.com>
 <74642db3-14dc-4e13-3130-dc8abe1a2b6e@redhat.com>
 <YBLvvpeEORjVd2IP@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fa5e165-6f93-572f-81d5-07cdeb23b590@redhat.com>
Date:   Thu, 28 Jan 2021 18:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBLvvpeEORjVd2IP@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 18:09, Sean Christopherson wrote:
> On Thu, Jan 28, 2021, Paolo Bonzini wrote:
>> On 14/01/21 01:36, Sean Christopherson wrote:
>>> Add a reverse-CPUID entry for the memory encryption word, 0x8000001F.EAX,
>>> and use it to override the supported CPUID flags reported to userspace.
>>> Masking the reported CPUID flags avoids over-reporting KVM support, e.g.
>>> without the mask a SEV-SNP capable CPU may incorrectly advertise SNP
>>> support to userspace.
>>>
>>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>    arch/x86/kvm/cpuid.c | 2 ++
>>>    arch/x86/kvm/cpuid.h | 1 +
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>> index 13036cf0b912..b7618cdd06b5 100644
>>> --- a/arch/x86/kvm/cpuid.c
>>> +++ b/arch/x86/kvm/cpuid.c
>>> @@ -855,6 +855,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>>    	case 0x8000001F:
>>>    		if (!boot_cpu_has(X86_FEATURE_SEV))
>>>    			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>>> +		else
>>> +			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
>>>    		break;
>>>    	/*Add support for Centaur's CPUID instruction*/
>>>    	case 0xC0000000:
>>> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
>>> index dc921d76e42e..8b6fc9bde248 100644
>>> --- a/arch/x86/kvm/cpuid.h
>>> +++ b/arch/x86/kvm/cpuid.h
>>> @@ -63,6 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>>>    	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
>>>    	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
>>>    	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
>>> +	[CPUID_8000_001F_EAX] = {0x8000001f, 1, CPUID_EAX},
>>>    };
>>>    /*
>>>
>>
>> I don't understand, wouldn't this also need a kvm_cpu_cap_mask call
>> somewhere else?  As it is, it doesn't do anything.
> 
> Ugh, yes, apparently I thought the kernel would magically clear bits it doesn't
> care about.
> 
> Looking at this again, I think the kvm_cpu_cap_mask() invocation should always
> mask off X86_FEATURE_SME.  SME cannot be virtualized, and AFAIK it's not
> emulated by KVM.  This would fix an oddity where SME would be advertised if SEV
> is also supported.
> 
> Boris has queue the kernel change to tip/x86/cpu, I'll spin v4 against that.

You can send it after the 5.12 merge window.

Paolo

