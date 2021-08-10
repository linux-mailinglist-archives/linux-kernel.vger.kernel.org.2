Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2843E5870
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhHJKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238566AbhHJKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628591746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSRHzUxeiOWloToTL5jVawnUzFMQbB9b5yC/gXW30eI=;
        b=FgL67QOJzLpKrClIOsNg504U+G2W6qE96ZlkoEsM5aDEMZi8WUhbvYc2IjKklYOy5YMeN6
        UQmRmARZXGRAaWfS71wXvwJkYc3PcBA4Y/B6nXSsyFwqpXvgX75NPiHcMoMwo0bCcTzqaa
        8sGiA7rimjzJOj567lA6hAMB71jyOlE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-nKt5HiJINUO6z8vNEZhXwg-1; Tue, 10 Aug 2021 06:35:45 -0400
X-MC-Unique: nKt5HiJINUO6z8vNEZhXwg-1
Received: by mail-ej1-f70.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso5452894ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSRHzUxeiOWloToTL5jVawnUzFMQbB9b5yC/gXW30eI=;
        b=YvcG/QMHXSWRjrdY6thrwdIbmkkDuGOiHwYVtC45nXsErcNfIFVZQPNI/79XdGWGCo
         8k6E4mKHfKf7m6QE92jMS/lhcetLpCCnFXXWGwWJpSetLPYeaOVF6AK2LZk/39cp0kJM
         eFFRQw1Bj1oaAdAg/qSWBJKfbIi/yMxbcXs7znQjkVzKJ2QcF3KV4Ym4EonHqi/9bRSJ
         jdn6Efv6oTX6xN+43LvLglYkHPpYqXqIR+3zS0S8OdSGt+Gab+4QlsIK86qi/EbsTVGb
         hA2yiJhG3PmHJdwxxvCNz7nwT0QjIHohu4V/JdbAEGsjHTCST8edjn0P8RqaTekTh9GH
         tehA==
X-Gm-Message-State: AOAM533GpY0NIrPKOrQIBQ1Ovzs6kU0Mhh5oXyZa3kkFdP5gSTfFnJKg
        GqGhd0OjIMCNQcNgG3I9sGX7gj+2cDjyNSAx0xnoGZXSsRVeqsScCb5E/6t90uHCZBIJzTDkWWC
        l4qpFqkpMJNyOUwYltXXfygBI
X-Received: by 2002:a05:6402:d5c:: with SMTP id ec28mr4202759edb.3.1628591744348;
        Tue, 10 Aug 2021 03:35:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKDKCZofFWud8zXiwgF6GPyAkOYeVeyPqDN8hJUOh/WyaQSKUTMTGHRr7mr7n+keuKU2nRHw==
X-Received: by 2002:a05:6402:d5c:: with SMTP id ec28mr4202742edb.3.1628591744153;
        Tue, 10 Aug 2021 03:35:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q11sm6710763ejb.10.2021.08.10.03.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 03:35:43 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] KVM: X86: Set the hardware DR6 only when
 KVM_DEBUGREG_WONT_EXIT
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <YRFdq8sNuXYpgemU@google.com>
 <20210809174307.145263-1-jiangshanlai@gmail.com>
 <20210809174307.145263-2-jiangshanlai@gmail.com>
 <68ed0f5c-40f1-c240-4ad1-b435568cf753@redhat.com>
 <45fef019-8bd9-2acb-bd53-1243a8a07c4e@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5967e16-3910-5604-7890-9a1741045ce8@redhat.com>
Date:   Tue, 10 Aug 2021 12:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <45fef019-8bd9-2acb-bd53-1243a8a07c4e@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 12:30, Lai Jiangshan wrote:
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index ae8e62df16dd..21a3ef3012cf 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -6625,6 +6625,10 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu 
>> *vcpu)
>>           vmx->loaded_vmcs->host_state.cr4 = cr4;
>>       }
>>
>> +    /* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
>> +    if (vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)
>> +        set_debugreg(vcpu->arch.dr6, 6);
> 
> 
> I also noticed the related code in svm.c, but I refrained myself
> to add a new branch in vmx_vcpu_run().  But after I see you put
> the code of resetting dr6 in vmx_sync_dirty_debug_regs(), the whole
> solution is much clean and better.
> 
> And if any chance you are also concern about the additional branch,
> could you add a new callback to set dr6 and call the callback from
> x86.c when KVM_DEBUGREG_WONT_EXIT.

The extra branch should be well predicted, and the idea you sketched 
below would cause DR6 to be marked uselessly as dirty in SVM, so I think 
this is cleaner.  Let's add an "unlikely" around it too.

Paolo

> The possible implementation of the callback:
> for vmx: set_debugreg(vcpu->arch.dr6, 6);
> for svm: svm_set_dr6(svm, vcpu->arch.dr6);
>           and always do svm_set_dr6(svm, DR6_ACTIVE_LOW); at the end of the
>           svm_handle_exit().
> 
> Thanks
> Lai
> 
>> +
>>       /* When single-stepping over STI and MOV SS, we must clear the
>>        * corresponding interruptibility bits in the guest state. 
>> Otherwise
>>        * vmentry fails as it then expects bit 14 (BS) in pending debug
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index a111899ab2b4..fbc536b21585 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -9597,7 +9597,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>>           set_debugreg(vcpu->arch.eff_db[1], 1);
>>           set_debugreg(vcpu->arch.eff_db[2], 2);
>>           set_debugreg(vcpu->arch.eff_db[3], 3);
>> -        set_debugreg(vcpu->arch.dr6, 6);
>>       } else if (unlikely(hw_breakpoint_active())) {
>>           set_debugreg(0, 7);
>>       }
>>
>> Paolo
> 

