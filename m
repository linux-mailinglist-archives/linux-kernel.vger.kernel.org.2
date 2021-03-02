Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5732A49B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446412AbhCBKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349554AbhCBKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614681345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntJc1vtjNdieqIbSV3Z/3YUY9v5a7BvhLBCSmXa57ec=;
        b=W2sKV4DakW72HGw5SHEZvkB4MQBdvc1fle0AH6gXnnL91tpt/u+kkt9upBt43cGKp6XuVs
        iKrMMtt1eZapTm5GHf/vLMSd12jATGQDmvr4wu9BKkfO/GAERnlYSjnXA1KbiJs/pYMirW
        8NrusSiF1aWDDiUpqQbuG5mIAj3ToTQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-WbVfILQwPhOwk3XUo5-wdg-1; Tue, 02 Mar 2021 05:35:43 -0500
X-MC-Unique: WbVfILQwPhOwk3XUo5-wdg-1
Received: by mail-ej1-f71.google.com with SMTP id 11so1722597ejz.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ntJc1vtjNdieqIbSV3Z/3YUY9v5a7BvhLBCSmXa57ec=;
        b=X38VNBnBnrZaQc8UWgkfPquxSXyKafF94UtOxHVeuq2kV3lMvkf13JsVlRro4ru7R1
         P/DiyusolFNPZJpbUHdCgPuqSKVjPKgioZwUUduxv62Nc3OFL7IXyrDR8JfZGZJH2Aq4
         CUdWdLmfjHkIh957x12JxiJaZKXVKPZCPOBATV4aZ0syRmdqnl2VH7h3mSgYCcGAyE8g
         cKviimF6+RrZyatN9YYgUI7AvgP8flTB4EObhE7pob1TNTvdJak730B0YuNSxqIS/MU/
         rb4d/P4SARY4LSyG6/Rvfhj5lVY62bmVDf/5RLYOM3WqNKGxWJZHrpKuYwZacWgX1r7C
         lt7Q==
X-Gm-Message-State: AOAM533zHHdhqkwGfxmkZP8JfucRwmIbUMmAGwvnGCjRFsb9IXPImJXo
        9BIui/hpNfCFFDAwBOtlv30YLdzj8NQOu5TG6wYFCVYVxXnvPvXB7GeOmqWrAXNrDEDS/WuHCwm
        Ntu903IzDcGg7ZN9Hr7URUj+SSRMjhwok1HaUbeYAGGij88L5Xdb6musaK8jIMGSU0jB/JYiuv2
        4A
X-Received: by 2002:aa7:cd8d:: with SMTP id x13mr19660736edv.286.1614681342669;
        Tue, 02 Mar 2021 02:35:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2fUeTTgU9ANlcwXLzW5t2ozKbQnPsSw5DdDXqr1gn7k47UtfpI8PCZXXOIsYe5YbLpxSGMg==
X-Received: by 2002:aa7:cd8d:: with SMTP id x13mr19660724edv.286.1614681342468;
        Tue, 02 Mar 2021 02:35:42 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v1sm16893126ejd.3.2021.03.02.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:35:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: nVMX: Sync L2 guest CET states between L1/L2
In-Reply-To: <YD0oa99pgXqlS07h@google.com>
References: <20210225030951.17099-1-weijiang.yang@intel.com>
 <20210225030951.17099-2-weijiang.yang@intel.com>
 <YD0oa99pgXqlS07h@google.com>
Date:   Tue, 02 Mar 2021 11:35:41 +0100
Message-ID: <87y2f5etc2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> +Vitaly
>
> On Thu, Feb 25, 2021, Yang Weijiang wrote:
>> These fields are rarely updated by L1 QEMU/KVM, sync them when L1 is trying to
>> read/write them and after they're changed. If CET guest entry-load bit is not
>> set by L1 guest, migrate them to L2 manaully.
>> 
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
>> 
>> change in v2:
>>  - Per Sean's review feedback, change CET guest states as rarely-updated fields.
>>    And also migrate L1's CET states to L2 if the entry-load bit is not set.
>>  - Opportunistically removed one blank line.
>> ---
>>  arch/x86/kvm/cpuid.c      |  1 -
>>  arch/x86/kvm/vmx/nested.c | 29 +++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/vmx.h    |  3 +++
>>  3 files changed, 32 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 46087bca9418..afc97122c05c 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -143,7 +143,6 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>>  		}
>>  		vcpu->arch.guest_supported_xss =
>>  			(((u64)best->edx << 32) | best->ecx) & supported_xss;
>> -
>>  	} else {
>>  		vcpu->arch.guest_supported_xss = 0;
>>  	}
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 9728efd529a1..1703b8874fad 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2516,6 +2516,12 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>>  	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
>>  
>>  	set_cr4_guest_host_mask(vmx);
>> +
>> +	if (kvm_cet_supported()) {
>
> This needs to be conditioned on CET coming from vmcs12, it's on the loading of
> host state on VM-Exit that is unconditional (if CET is supported).
>
> 	if (kvm_cet_supported() && vmx->nested.nested_run_pending &&
> 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
>
> I also assume these should be guarded by one of the eVMCS fields, though a quick
> search of the public docs didn't provide a hit on the CET fields.
>
> Vitaly, any idea if these will be GUEST_GRP2 or something else?
>

The latest published TLFS I see is 6.0b and it doesn't list anything CET
related in eVMCS v1.0 :-( So I agree with Paolo: we just need to adjust
EVMCS1_UNSUPPORTED_VMENTRY_CTRL/ EVMCS1_UNSUPPORTED_VMEXIT_CTRL for now
and enable it separately later.

>> +		vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
>> +		vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
>> +		vmcs_writel(GUEST_INTR_SSP_TABLE, vmcs12->guest_ssp_tbl);
>> +	}
>>  }
>

-- 
Vitaly

