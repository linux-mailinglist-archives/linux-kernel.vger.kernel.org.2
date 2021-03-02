Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9232A7E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573039AbhCBQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448309AbhCBOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614694693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/a34d/ThKKTvt9Pjw7s1OmZdNqKzS+xr9zKYwHiwjM=;
        b=NaK754/XQ9lbLtn6u1O0it4IMPGGq55eubyGtEZLOmVxC22mzXH8zTVcblsHlsNLRjWAcN
        2BXGHB4AHOL1vXgjyTgW9I7E+oNYNMbnoGBN8PEXAg10Kj1lAMyQvpHKBeSAhmkOZEaP6F
        3ZANc2SkPddk9F81Opd3J4hKzcjODVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-7EMT7DIgPOqcorDb6kTz4w-1; Tue, 02 Mar 2021 09:18:11 -0500
X-MC-Unique: 7EMT7DIgPOqcorDb6kTz4w-1
Received: by mail-wr1-f70.google.com with SMTP id z17so2957688wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/a34d/ThKKTvt9Pjw7s1OmZdNqKzS+xr9zKYwHiwjM=;
        b=JQ/r49xdrGyke/j/blDI6JxQqbiPjxJLBL2KChM8XQUCT85fLGKNrlExKiZiwjaZiN
         gKESdYa9AxLMyxA/PTdDXB8Z8uPiPvm9VVdWTmbSS9WZLYvhkLQiVltgNdN3UZ+PpNR8
         MqChx52Vqi3itPGYEO8j28f5RmCQb5eYeMN0srK7QEWEYxxy5DBSz3aIcvcSttb5mevo
         bLLQn/PcpUZqTRqdquSDbV3B0HgQ6ZtZex43SLQCeBdwWbEZMv1qRm/8n86g6pUIMy5t
         nRDS0nYnh9FlWUAsO1eSmTmTlTNYioo55CvxEGSKjUezNzyZfRvcwAsTr1DfrirjeZGv
         KIIg==
X-Gm-Message-State: AOAM532jwSjkYqpUTAW6jNQtFcL2PmINGByNo05JrpJfQDqGs25Tc5eM
        54PFffZicZklXsTHZshpaUI2DGyiFlXbms1tXeTHe8kw+KcSKJxdSnFKwdrLSEDZta9PJle3iVa
        /k3gKef+o/CGxNy4lu3LRtDLD
X-Received: by 2002:a5d:544c:: with SMTP id w12mr22964630wrv.310.1614694689864;
        Tue, 02 Mar 2021 06:18:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAwlWdRva51z700E9YWuv8o9/2Ni0QrVl/8cWhmZODCSrapayICwLDgZD2YwtueDC2ATNlnw==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr22964609wrv.310.1614694689631;
        Tue, 02 Mar 2021 06:18:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j136sm2933145wmj.35.2021.03.02.06.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 06:18:09 -0800 (PST)
Subject: Re: [PATCH] KVM: nSVM: Optimize L12 to L2 vmcb.save copies
To:     Cathy Avery <cavery@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wei.huang2@amd.com
References: <20210301200844.2000-1-cavery@redhat.com>
 <YD2N/4sDKS4RJdlR@google.com>
 <9c7e4dec-2181-1720-5981-3ae25c5bb0d9@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2af5432a-6385-b32e-a69d-edfdccd7273b@redhat.com>
Date:   Tue, 2 Mar 2021 15:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9c7e4dec-2181-1720-5981-3ae25c5bb0d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/21 13:56, Cathy Avery wrote:
> On 3/1/21 7:59 PM, Sean Christopherson wrote:
>> On Mon, Mar 01, 2021, Cathy Avery wrote:
>  	svm->nested.vmcb12_gpa = 0;
> +	svm->nested.last_vmcb12_gpa = 0;


This should not be 0 to avoid a false match.  "-1" should be okay.

>>>       kvm_set_rflags(&svm->vcpu, vmcb12->save.rflags | 
>>> X86_EFLAGS_FIXED);
>>>       svm_set_efer(&svm->vcpu, vmcb12->save.efer);
>>>       svm_set_cr0(&svm->vcpu, vmcb12->save.cr0);
>>>       svm_set_cr4(&svm->vcpu, vmcb12->save.cr4);
>> Why not utilize VMCB_CR?
> I was going to tackle CR in a follow up patch. I should have mentioned 
> that but it makes sense to go ahead and do it now.

There is some trickiness.  For example, I would first prefer to move the 
checks on svm->vmcb->save.cr0 == vcpu->arch.cr0 ("hcr0 == cr0" in 
svm_set_cr0) to recalc_intercepts.

For cr4, instead, we need to go through kvm_update_cpuid_runtime in case 
host CR4 is not equal to CR4 (for which we have a testcase in svm.flat 
already, I think).

>>> -    svm->vcpu.arch.cr2 = vmcb12->save.cr2;
>>> +    svm->vmcb->save.cr2 = svm->vcpu.arch.cr2 = vmcb12->save.cr2;
>> Same question for VMCB_CR2.
>>
>> Also, isn't writing svm->vmcb->save.cr2 unnecessary since svm_vcpu_run()
>> unconditionally writes it?
>>
>> Alternatively, it shouldn't be too much work to add proper dirty 
>> tracking for CR2.  VMX has to write the real CR2 every time because there's no VMCS 
>> field, but I assume can avoid the write and dirty update on the majority of 
>> VMRUNs.
> 
> I'll take a look at CR2 as well.

That's a separate patch, to some extent unrelated to nesting.  Feel free 
to look at it, but for now we should apply this part with only the 
svm->vmcb->save.cr2 assignment removed.  Please send a v2, thanks!

Paolo

> Thanks for the feedback,
> 
> Cathy
> 
>>
>>> +
>>>       kvm_rax_write(&svm->vcpu, vmcb12->save.rax);
>>>       kvm_rsp_write(&svm->vcpu, vmcb12->save.rsp);
>>>       kvm_rip_write(&svm->vcpu, vmcb12->save.rip);
>>>       /* In case we don't even reach vcpu_run, the fields are not 
>>> updated */
>>> -    svm->vmcb->save.cr2 = svm->vcpu.arch.cr2;
>>>       svm->vmcb->save.rax = vmcb12->save.rax;
>>>       svm->vmcb->save.rsp = vmcb12->save.rsp;
>>>       svm->vmcb->save.rip = vmcb12->save.rip;
>>> -    svm->vmcb->save.dr7 = vmcb12->save.dr7 | DR7_FIXED_1;
>>> -    svm->vcpu.arch.dr6  = vmcb12->save.dr6 | DR6_ACTIVE_LOW;
>>> -    vmcb_mark_dirty(svm->vmcb, VMCB_DR);
>>> +    /* These bits will be set properly on the first execution when 
>>> new_vmc12 is true */
>>> +    if (unlikely(new_vmcb12 || vmcb_is_dirty(vmcb12, VMCB_DR))) {
>>> +        svm->vmcb->save.dr7 = vmcb12->save.dr7 | DR7_FIXED_1;
>>> +        svm->vcpu.arch.dr6  = vmcb12->save.dr6 | DR6_ACTIVE_LOW;
>>> +        vmcb_mark_dirty(svm->vmcb, VMCB_DR);
>>> +    }
>>>   }
>>>   static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>> index 54610270f66a..9761a7ca8100 100644
>>> --- a/arch/x86/kvm/svm/svm.c
>>> +++ b/arch/x86/kvm/svm/svm.c
>>> @@ -1232,6 +1232,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>>>       svm->asid = 0;
>>>       svm->nested.vmcb12_gpa = 0;
>>> +    svm->nested.last_vmcb12_gpa = 0;
>> We should use INVALID_PAGE, '0' is a legal physical address and could
>> theoretically get a false negative on the "new_vmcb12" check.
>>
>>>       vcpu->arch.hflags = 0;
>>>       if (!kvm_pause_in_guest(vcpu->kvm)) {
>>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>>> index fbbb26dd0f73..911868d4584c 100644
>>> --- a/arch/x86/kvm/svm/svm.h
>>> +++ b/arch/x86/kvm/svm/svm.h
>>> @@ -93,6 +93,7 @@ struct svm_nested_state {
>>>       u64 hsave_msr;
>>>       u64 vm_cr_msr;
>>>       u64 vmcb12_gpa;
>>> +    u64 last_vmcb12_gpa;
>>>       /* These are the merged vectors */
>>>       u32 *msrpm;
>>> @@ -247,6 +248,11 @@ static inline void vmcb_mark_dirty(struct vmcb 
>>> *vmcb, int bit)
>>>       vmcb->control.clean &= ~(1 << bit);
>>>   }
>>> +static inline bool vmcb_is_dirty(struct vmcb *vmcb, int bit)
>>> +{
>>> +        return !test_bit(bit, (unsigned long *)&vmcb->control.clean);
>>> +}
>>> +
>>>   static inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
>>>   {
>>>       return container_of(vcpu, struct vcpu_svm, vcpu);
>>> -- 
>>> 2.26.2
>>>
> 

