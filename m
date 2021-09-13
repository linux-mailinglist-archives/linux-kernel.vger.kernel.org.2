Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB59408507
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbhIMG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237514AbhIMG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631516273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jCqRhc3bcZaCNkwZY/q58ovcD1/WO6KrpN3X1X+eYI=;
        b=IkrTD479NXQ06PrbYh028wQZiL7RxeQ0ScIegNi1Y77QHNZVzuciMI2iLbycil4B22CiKH
        UMivIQjGrOd707a7hTGedx/Ge4g6Cl+FdnChI7ThPQsxQ9JXk29tBSYGs3X6uslF94iBj0
        SROuNiJjnctp3DItLKCmNNCvuPrKT0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-R0KszsCEOwGFoaGV7_m6Ow-1; Mon, 13 Sep 2021 02:57:52 -0400
X-MC-Unique: R0KszsCEOwGFoaGV7_m6Ow-1
Received: by mail-ej1-f69.google.com with SMTP id jg32-20020a170907972000b005e801aed08aso3221379ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0jCqRhc3bcZaCNkwZY/q58ovcD1/WO6KrpN3X1X+eYI=;
        b=3+r9LPK+cXuJg5MBbVlxzwcn0D3SWz5ueWLUyVllwysNIPKExAymNEfsxDjPaX6FR1
         58qHOw3vPLlUw0iPHVDRTVJLmHohp3fz/K0Na2LVvTbYtcIguwST64/93nSk34oiJc6A
         tA2QwNDs0wXY5N7d9/r84TJLd9bi/5rPEbrBXPKKXXOBubiX+l1NI022jJi9PonlVSbx
         18E4ZTeMN0srOjwO0FTa7NTIQXPym05mJQl1Hbelp2MyYIfaaTcIqrqlJD0aG7q9EX+O
         8ONQ+Lv+gbfnZ9JV3Zg39Ew9gFa7aBYNI9mjq9M3EhuuelPx1xVGAPUm+en3AunlkUiB
         jT7w==
X-Gm-Message-State: AOAM530gs41TcRFZV+g+aSn/OEmSYRJOTtMZSItajdk1stdmZg6Fau+Z
        9svwPhhDjViS3uP9CBBT4tAJcMZOKNKO8jxto7+ZB0/bJZqc8YhvOfFHLdr5IeTQ6Hrx8jR7+Xu
        vkR3X2w19L1Vhy5p/9BIw+uSjd+BqI/s2w5UqTmwX62nwmXqdZX3ervYYx/vU8ECFxmjWYNmCih
        KU
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr11227392ejg.86.1631516271618;
        Sun, 12 Sep 2021 23:57:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5mdrAjiCCyG+UIsMaHgbGCKDsyGBnp8g9M9bsnrDoBc947WLZ+oMsZuxXFEZKzCu3CpSr9Q==
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr11227366ejg.86.1631516271318;
        Sun, 12 Sep 2021 23:57:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z6sm2897536ejj.13.2021.09.12.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:57:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: nVMX: Track whether changes in L0 require MSR
 bitmap for L2 to be rebuilt
In-Reply-To: <37efb41fda41317bf04c0cb805792af261894a1a.camel@redhat.com>
References: <20210910160633.451250-1-vkuznets@redhat.com>
 <20210910160633.451250-4-vkuznets@redhat.com>
 <37efb41fda41317bf04c0cb805792af261894a1a.camel@redhat.com>
Date:   Mon, 13 Sep 2021 08:57:49 +0200
Message-ID: <87ilz52c9e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Fri, 2021-09-10 at 18:06 +0200, Vitaly Kuznetsov wrote:
>> Introduce a flag to keep track of whether MSR bitmap for L2 needs to be
>> rebuilt due to changes in MSR bitmap for L1 or switching to a different
>> L2. This information will be used for Enlightened MSR Bitmap feature for
>> Hyper-V guests.
>> 
>> Note, setting msr_bitmap_changed to 'true' from set_current_vmptr() is
>> not really needed for Enlightened MSR Bitmap as the feature can only
>> be used in conjunction with Enlightened VMCS but let's keep tracking
>> information complete, it's cheap and in the future similar PV feature can
>> easily be implemented for KVM on KVM too.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/nested.c | 9 ++++++++-
>>  arch/x86/kvm/vmx/vmx.c    | 2 ++
>>  arch/x86/kvm/vmx/vmx.h    | 6 ++++++
>>  3 files changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index ccb03d69546c..42cd95611892 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2053,10 +2053,13 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>>  	 * Clean fields data can't be used on VMLAUNCH and when we switch
>>  	 * between different L2 guests as KVM keeps a single VMCS12 per L1.
>>  	 */
>> -	if (from_launch || evmcs_gpa_changed)
>> +	if (from_launch || evmcs_gpa_changed) {
>>  		vmx->nested.hv_evmcs->hv_clean_fields &=
>>  			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>>  
>> +		vmx->nested.msr_bitmap_changed = true;
>> +	}
>> +
>>  	return EVMPTRLD_SUCCEEDED;
>>  }
>>  
>> @@ -3240,6 +3243,8 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>>  	else
>>  		exec_controls_clearbit(vmx, CPU_BASED_USE_MSR_BITMAPS);
>>  
>> +	vmx->nested.msr_bitmap_changed = false;
>
> Very minor nitpick: Maybe I would put this into nested_vmx_prepare_msr_bitmap,
> a bit closer to the action, but this is fine like this as well.
>

I don't have a strong preference here, can move it to nested_vmx_prepare_msr_bitmap().

>> +
>>  	return true;
>>  }
>>  
>> @@ -5273,6 +5278,7 @@ static void set_current_vmptr(struct vcpu_vmx *vmx, gpa_t vmptr)
>>  		vmx->nested.need_vmcs12_to_shadow_sync = true;
>>  	}
>>  	vmx->nested.dirty_vmcs12 = true;
>> +	vmx->nested.msr_bitmap_changed = true;
>>  }
>>  
>>  /* Emulate the VMPTRLD instruction */
>> @@ -6393,6 +6399,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>  		goto error_guest_mode;
>>  
>>  	vmx->nested.dirty_vmcs12 = true;
>> +	vmx->nested.msr_bitmap_changed = true;
>
> Is this needed? Setting the nested state should eventually trigger call to
> nested_vmx_handle_enlightened_vmptrld.
>
>  

Strictly speaking - no (meaning that nothing is going to change if we
just drop this hunk). My intention was to keep tracking information
complete: after vmx_set_nested_state() we certainly need to re-build MSR
Bitmap 02 and that's what 'msr_bitmap_changed' tracks. We can replace
this with a comment if needed (but I'd slightly prefer to keep it -
unless there's a reason not to).

>
>>  	ret = nested_vmx_enter_non_root_mode(vcpu, false);
>>  	if (ret)
>>  		goto error_guest_mode;
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index ad33032e8588..2dbfb5d838db 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -3734,6 +3734,8 @@ static void vmx_msr_bitmap_l01_changed(struct vcpu_vmx *vmx)
>>  	 */
>>  	if (static_branch_unlikely(&enable_evmcs))
>>  		evmcs_touch_msr_bitmap();
>> +
>> +	vmx->nested.msr_bitmap_changed = true;
>>  }
>>  
>>  void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index 4858c5fd95f2..b6596fc2943a 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -148,6 +148,12 @@ struct nested_vmx {
>>  	bool need_vmcs12_to_shadow_sync;
>>  	bool dirty_vmcs12;
>>  
>> +	/*
>> +	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
>> +	 * changes in MSR bitmap for L1 or switching to a different L2.
>> +	 */
>> +	bool msr_bitmap_changed;
>> +
>>  	/*
>>  	 * Indicates lazily loaded guest state has not yet been decached from
>>  	 * vmcs02.
>
>
> Best regards,
> 	Maxim Levitsky
>

-- 
Vitaly

