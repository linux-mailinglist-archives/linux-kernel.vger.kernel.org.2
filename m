Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F54084FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhIMGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhIMGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631516015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FeM9VbeOZW6Q8YpmpSes2OU2n8QPVYH3Vzvp3bUiPm4=;
        b=J0AUo7kQWOlYTlgzK2LMft8DymVSmeHO5EMLlbeWuOTkKsmkayb6vKcrg8PDI0KSEwVqBz
        a/LPNzFBJwS4zdvz3r+cPJuh9R6hhFdFPFMIzuFm9x533G0oBUSp1Gd5sBQIclAYMcuxdy
        hX96npikPJi/GND7nCxl8/b9BiCHrwo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-Mted3mf_NSSGHXEDkgxxrg-1; Mon, 13 Sep 2021 02:53:33 -0400
X-MC-Unique: Mted3mf_NSSGHXEDkgxxrg-1
Received: by mail-ed1-f69.google.com with SMTP id z17-20020a05640240d100b003cac681f4f4so4405866edb.21
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FeM9VbeOZW6Q8YpmpSes2OU2n8QPVYH3Vzvp3bUiPm4=;
        b=rfLP1IUCXOwQLxzrYYBDhD435ctjhhsghfSD8qeNxRj0AtYJEkVsHLvipZkme9Tfca
         dky+7Gp2c+781Budtnvnyzto7KTXivURZUSz7vedRTYUXq1c7aTWj8SlGZQZ80aHKn3u
         ypu6N61V1qCN87lea+qmtxsYUwCaqEFqKIZz1cdcrFoUTz+pLNmR6Pl9gO3PJQWYSQ5m
         m8XdOAtW2jgcebRlDnUO8QD+MnWUt6jV23rJXWnk5PJ+x2afUVfwecv+kIs1ZucQS4nm
         eDshZkdI6zQlsn7/YOO3yllhsLw3rZeNwqvmPmn6A/RrSBNDDVbXw8Vsp3THDWcNTRrO
         3KRA==
X-Gm-Message-State: AOAM532DNa1DpMctbIrk8yyMxvFcx8A1fqKUV3bPpml9oVWlOQWOFgtO
        UEZWkobYL2PL1DcT64G3sKqvXEvV+W63diNNi1APzEHPyNTaTd/3F3Ib1I+loN3ozvIhxDHjCM6
        a0rWck+BjeVst6/pXjVsVDLQB3ffhl8kzMjUpt0gtv0UiiYDmgaB7Wr5appKUhaxqU2Qmqm1P+L
        6m
X-Received: by 2002:aa7:c3cb:: with SMTP id l11mr11609231edr.310.1631516012357;
        Sun, 12 Sep 2021 23:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUGigNc+sq3gVdCwC4TFvas+vjbm9v+f5pAbfSRWMoSLIan1K0j0zN3DtoLbuM+ZVuamppSw==
X-Received: by 2002:aa7:c3cb:: with SMTP id l11mr11609214edr.310.1631516012101;
        Sun, 12 Sep 2021 23:53:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id eg14sm3418082edb.64.2021.09.12.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:53:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: nVMX: Don't use Enlightened MSR Bitmap for L3
In-Reply-To: <6424b309216b276e46a66573320b3eed8209a0ed.camel@redhat.com>
References: <20210910160633.451250-1-vkuznets@redhat.com>
 <20210910160633.451250-2-vkuznets@redhat.com>
 <6424b309216b276e46a66573320b3eed8209a0ed.camel@redhat.com>
Date:   Mon, 13 Sep 2021 08:53:33 +0200
Message-ID: <87lf412cgi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Fri, 2021-09-10 at 18:06 +0200, Vitaly Kuznetsov wrote:
>> When KVM runs as a nested hypervisor on top of Hyper-V it uses Enlightened
>> VMCS and enables Enlightened MSR Bitmap feature for its L1s and L2s (which
>> are actually L2s and L3s from Hyper-V's perspective). When MSR bitmap is
>> updated, KVM has to reset HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP from
>> clean fields to make Hyper-V aware of the change. For KVM's L1s, this is
>> done in vmx_disable_intercept_for_msr()/vmx_enable_intercept_for_msr().
>> MSR bitmap for L2 is build in nested_vmx_prepare_msr_bitmap() by blending
>> MSR bitmap for L1 and L1's idea of MSR bitmap for L2. KVM, however, doesn't
>> check if the resulting bitmap is different and never cleans
>> HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP in eVMCS02. This is incorrect and
>> may result in Hyper-V missing the update.
>> 
>> The issue could've been solved by calling evmcs_touch_msr_bitmap() for
>> eVMCS02 from nested_vmx_prepare_msr_bitmap() unconditionally but doing so
>> would not give any performance benefits (compared to not using Enlightened
>> MSR Bitmap at all). 3-level nesting is also not a very common setup
>> nowadays.
>> 
>> Don't enable 'Enlightened MSR Bitmap' feature for KVM's L2s (real L3s) for
>> now.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 0c2c0d5ae873..ae470afcb699 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2654,15 +2654,6 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
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
>> @@ -6861,6 +6852,19 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>>  	}
>>  
>>  	vmx->loaded_vmcs = &vmx->vmcs01;
>> +
>> +	/*
>> +	 * Use Hyper-V 'Enlightened MSR Bitmap' feature when KVM runs as a
>> +	 * nested (L1) hypervisor and Hyper-V in L0 supports it.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_HYPERV) && static_branch_unlikely(&enable_evmcs)
>> +	    && (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
>> +		struct hv_enlightened_vmcs *evmcs =
>> +			(struct hv_enlightened_vmcs *)vmx->loaded_vmcs->vmcs;
>> +
>> +		evmcs->hv_enlightenments_control.msr_bitmap = 1;
>> +	}
>> +
>>  	cpu = get_cpu();
>>  	vmx_vcpu_load(vcpu, cpu);
>>  	vcpu->cpu = cpu;
>
> Makes sense.
>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>
>
> However, just a note that it is very very confusing that KVM can use eVMCS in both ways.
>  
>  
> 'Client': It can both run under HyperV, and thus take advantage of eVMCS when it runs its guests (with
> help of
> HyperV)
>  
> 'Server' KVM can emulate some HyperV features, and one of these is eVMCS, thus a windows guest running
> under KVM, can use KVM's eVMCS implementation to run nested guests.
>  
> This patch fails under
> 'Client', while the other patches in the series fall under the 'Server' category,
> and even more confusing, the patch 2 moves 'Client' code around, but it is intended for following patches
> 3,4 which are
> for Server.
>  

All this is confusing indeed, KVM-on-Hyper-V and Hyper-V-on-KVM are two
different beasts but it's not always clear from patch subject. I was
thinking about adding this to patch prexes:

"KVM: VMX: KVM-on-Hyper-V: ... " 
"KVM: nVMX: Hyper-V-on-KVM ..."

or something similar.

>
> Thus this patch probably should be a separate patch, just to avoid confusion.
>

This patch is a weird one. We actually fix

Hyper-V-on-KVM-on-Hyper-V case.

Don't get confused! :-)


> However, since this patch series is already posted, and I figured that out, and hopefully explained it here,
> no need to do anything though!
>
>
> Best regards,
> 	Maxim Levitsky
>
>
>

-- 
Vitaly

