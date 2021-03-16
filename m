Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D65633CF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhCPIRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234315AbhCPIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615882614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NixAWo2L192GjS49CTRpMpnX6TxvYjn/CDZBxz3kWA=;
        b=fFJpZZb7PxgPZ5ecJALIaNpZV3Ph3k1e+FtPVYtnGww5j745/Ip2v5JpeJsyXFYZT2isEZ
        AmQKqM8lzY6+g/yjXqT+/CHgOJhhef/gzych7mzNvgCmXn3TH0eAMRZS6rHG4xxgiMSVlT
        YlmnJw0lNloc08UWf9XulouhEQZOOy0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-bjUnNQePMPOVkJCgjw4www-1; Tue, 16 Mar 2021 04:16:52 -0400
X-MC-Unique: bjUnNQePMPOVkJCgjw4www-1
Received: by mail-ej1-f71.google.com with SMTP id t21so5275050ejf.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NixAWo2L192GjS49CTRpMpnX6TxvYjn/CDZBxz3kWA=;
        b=IZPMrKv3js7UVA8rBpB0ZX0sanxIqpm6be4E+x6IYDL/9fCkA2/xicm7Plba1vkvr/
         xQDwrounri4k0jyW9aDvOpw+4p3zwdGvu1YcFK/7ERHaLZAWiQaYWa4gAhtKaGOSo0p2
         C8LNm6wso5MAKMOrGvKLD+F56SXbudS0T6FS3UGj1PvbAxc24j1RvUVsRx+22zppywPA
         L061Sa6C2pvausaiLY7bxig9a59582zddQmildEyuWsqN9AEgvxbVvIEaDvGPtAM8acs
         7g4hZAYrjOvjpuHxPb1k/DSIUikx6MAXVnwNZIklwVuRrtg8eBMUw/kK5HXqTL9BNLYp
         eyMg==
X-Gm-Message-State: AOAM533hkVBkxiov4mZKJZCILAC9JP9vzkLXnuyofTHDOiUn2JG8hl1v
        Xe6THytIq9cPDfJQvho+BJRJXbDEMHS58movbSRZQmgsx+8d0n4EHmKJ/2dyKqOYRCHxHFOiD/q
        TfjaSPnbYcKwA2qt7UPXkRVEG
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr23001138edb.204.1615882611040;
        Tue, 16 Mar 2021 01:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7t3H6KEhXgNFGrOMSYsDwObIjgAAGOnyeOOpn3KmGoF03QOd8bbqUwjVPSy85EYSfsd9kKQ==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr23001122edb.204.1615882610883;
        Tue, 16 Mar 2021 01:16:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b18sm9024900ejb.77.2021.03.16.01.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:16:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: nSVM: improve SYSENTER emulation on AMD
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>
References: <20210315174316.477511-1-mlevitsk@redhat.com>
 <20210315174316.477511-3-mlevitsk@redhat.com>
 <0dbcff57-8197-8fbb-809d-b47a4f5e9e77@redhat.com>
 <1a4f35e356c50e38916acef6c86175b24efca0a3.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1ee6230-760e-b614-5290-663b44fe1436@redhat.com>
Date:   Tue, 16 Mar 2021 09:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1a4f35e356c50e38916acef6c86175b24efca0a3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 19:19, Maxim Levitsky wrote:
> On Mon, 2021-03-15 at 18:56 +0100, Paolo Bonzini wrote:
>> On 15/03/21 18:43, Maxim Levitsky wrote:
>>> +	if (!guest_cpuid_is_intel(vcpu)) {
>>> +		/*
>>> +		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
>>> +		 * in VMCB and clear intercepts to avoid #VMEXIT.
>>> +		 */
>>> +		if (vls) {
>>> +			svm_clr_intercept(svm, INTERCEPT_VMLOAD);
>>> +			svm_clr_intercept(svm, INTERCEPT_VMSAVE);
>>> +			svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
>>> +		}
>>> +		/* No need to intercept these msrs either */
>>> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 1, 1);
>>> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 1, 1);
>>> +	}
>>
>> An "else" is needed here to do the opposite setup (removing the "if
>> (vls)" from init_vmcb).
> 
> init_vmcb currently set the INTERCEPT_VMLOAD and INTERCEPT_VMSAVE and it doesn't enable vls

There's also this towards the end of the function:

         /*
          * If hardware supports Virtual VMLOAD VMSAVE then enable it
          * in VMCB and clear intercepts to avoid #VMEXIT.
          */
         if (vls) {
                 svm_clr_intercept(svm, INTERCEPT_VMLOAD);
                 svm_clr_intercept(svm, INTERCEPT_VMSAVE);
                 svm->vmcb->control.virt_ext |= 
VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
         }

> thus there is nothing to do if I don't want to enable vls.
> It seems reasonable to me.
> 
> Both msrs I marked as '.always = false' in the
> 'direct_access_msrs', which makes them be intercepted by the default.
> If I were to use '.always = true' it would feel a bit wrong as the intercept is not always
> enabled.

I agree that .always = false is correct.

> What do you think?

You can set the CPUID multiple times, so you could go from AMD to Intel 
and back.

Thanks,

Paolo

