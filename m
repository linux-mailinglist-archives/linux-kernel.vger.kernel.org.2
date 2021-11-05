Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04908446319
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhKEMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232832AbhKEMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636113787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QFtRJa6fXxJb5Blssvwh+XqvE8JdPrEz8mODr6e1JI=;
        b=QZDiRzTBvRSqb1wKTQSbwBqCzn/e7Q3TLc2uEnXknyCTgmWLUtchDlf+KNV6YzGKOlV9l9
        7efkag2PiOZKlphWCfXNR6PLqDVhZz7M3ObHVuxQnw+NdLONSjDQj9D2WXfqeYP4KbfRTx
        PgF16VrMfvOpTCPpOwEW8QRbkPmjp4k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-oJEcsxuoMcaOr2InQjsx1g-1; Fri, 05 Nov 2021 08:03:06 -0400
X-MC-Unique: oJEcsxuoMcaOr2InQjsx1g-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso2250384wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 05:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6QFtRJa6fXxJb5Blssvwh+XqvE8JdPrEz8mODr6e1JI=;
        b=CAU97OqiF3KJFW/34bClKPYsYeGSMWMLq8iNudA4HqmbqcdoNLmof78Dvws6oXUlON
         CIA20siQrd5seudFd0wH2h2yIhJapVi7SvVRbLZrOpUmPoOkxeE6nxFt4pUclhO7vSyr
         uWgUDEKar1eP1gD9X5oZIj0rfMGk6Cj15QE6y2NzMbcyn61JLuUqmPqq396HnkD+vAav
         rCMgPDxXvXDUkAI9m+0U0z6iHayWy3rRutSTe4QNwvkoHnTr0APXpOo2KNMS/UgWiD4h
         CTZEKWiig8oBZoqPaKjEHIpSJUxhyGa/jDMRM9osbA2w1BxCSNaM00xQ1JBmL8ytP+59
         LXCw==
X-Gm-Message-State: AOAM530BuwxSsuPxoo0plOP5/hooNKGRVTCTqkuYhvCogegWJH9jGVRV
        wuqhE6Aw6qfl+5FuvJ1H0aTD2QN3GYQSboJ8fYsHBn1Hx4o/QT3JzqjJwhoCpheRpDt3uSswFXX
        8khTDtACvQ9faQ2/YXmDM0n1riyt+ZmgSzln+VrmXzJcg6bSIMfk6zDMYz5hHgaHPPc+Xw5wA4o
        kS
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr31663594wrs.435.1636113785104;
        Fri, 05 Nov 2021 05:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAU17O16GODKHSlfRSZLi1fwRykHnh0clQnHPHKuuFcA+KlkO2tvGWAb2k2FPeYYS0DnWXCA==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr31663532wrs.435.1636113784798;
        Fri, 05 Nov 2021 05:03:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r8sm9166846wrz.43.2021.11.05.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 05:03:04 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: nVMX: Don't use Enlightened MSR Bitmap for L3
In-Reply-To: <YYSAPotqLVIScunK@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-2-vkuznets@redhat.com>
 <YYSAPotqLVIScunK@google.com>
Date:   Fri, 05 Nov 2021 13:03:03 +0100
Message-ID: <878ry2lsi0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
>> 3-level nesting is also not a very common setup nowadays.
>
> Says who? :-D
>

The one who wants to sleep well at night ;-)

>> Don't enable 'Enlightened MSR Bitmap' feature for KVM's L2s (real L3s) for
>> now.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 21 ++++++++++++---------
>>  1 file changed, 12 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 1c8b2b6e7ed9..e82cdde58119 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2655,15 +2655,6 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>>  		if (!loaded_vmcs->msr_bitmap)
>>  			goto out_vmcs;
>>  		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
>> -
>> -		if (IS_ENABLED(CONFIG_HYPERV) &&
>> -		    static_branch_unlikely(&enable_evmcs) &&
>> -		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
>> -			struct hv_enlightened_vmcs *evmcs =
>> -				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
>> -
>> -			evmcs->hv_enlightenments_control.msr_bitmap = 1;
>> -		}
>>  	}
>>  
>>  	memset(&loaded_vmcs->host_state, 0, sizeof(struct vmcs_host_state));
>> @@ -6903,6 +6894,18 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>>  
>>  	vmx->loaded_vmcs = &vmx->vmcs01;
>>  
>> +	/*
>> +	 * Use Hyper-V 'Enlightened MSR Bitmap' feature when KVM runs as a
>> +	 * nested (L1) hypervisor and Hyper-V in L0 supports it.
>
> And maybe call out specifically that KVM intentionally uses this only for vmcs02?
>
>> +	 */
>> +	if (IS_ENABLED(CONFIG_HYPERV) && static_branch_unlikely(&enable_evmcs)
>> +	    && (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
>
> && on the previous line, I think we'll survive the 82 char line :-)
>
>> +		struct hv_enlightened_vmcs *evmcs =
>> +			(struct hv_enlightened_vmcs *)vmx->loaded_vmcs->vmcs;
>
> Hmm, what about landing this right after vmcs01's VMCS is allocated?  It's kinda
> weird, but it makes it more obvious that ->vmcs is not NULL.  And if the cast is
> simply via a "void *" it all fits on one line.
>
> 	err = alloc_loaded_vmcs(&vmx->vmcs01);
> 	if (err < 0)
> 		goto free_pml;
>
> 	/*
> 	 * Use Hyper-V 'Enlightened MSR Bitmap' feature when KVM runs as a
> 	 * nested (L1) hypervisor and Hyper-V in L0 supports it.  Enable an
> 	 * enlightened bitmap only for vmcs01, KVM currently isn't equipped to
> 	 * realize any performance benefits from enabling it for vmcs02.
> 	 */ 
> 	if (IS_ENABLED(CONFIG_HYPERV) && static_branch_unlikely(&enable_evmcs) &&
> 	    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
> 		struct hv_enlightened_vmcs *evmcs = (void *)vmx->vmcs01.vmcs;

(void *) usually smells a bit fishy to me but it seems to fit here.

>
> 		evmcs->hv_enlightenments_control.msr_bitmap = 1;
> 	}
>

>> +
>> +		evmcs->hv_enlightenments_control.msr_bitmap = 1;
>> +	}
>> +
>>  	if (cpu_need_virtualize_apic_accesses(vcpu)) {
>>  		err = alloc_apic_access_page(vcpu->kvm);
>>  		if (err)
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

