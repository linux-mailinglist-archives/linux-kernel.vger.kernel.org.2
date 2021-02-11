Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8233186A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBKI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhBKI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613033806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXSb9jYxKBqqlvxwQZRvY2KHUZBMAWGJJY1gsihXjD0=;
        b=ES+0IQoLeDftaqyklWl8Pe06T9BF2ffVaNI1HyDjsy/bB3xEnV2M92QV8cqHooiZbwhSm1
        9TFYhK9EdIA4KYeXPQvvi+JRIC8TnCaJ4reAIfbM7eP1aNHV/FzRGP91dRkhhkaXIDQ3FW
        VsUcqKolMWpy5VWBbEZeTLl33LWNO4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-j8PvDPzkPcS0kQhYjCz5WQ-1; Thu, 11 Feb 2021 03:56:43 -0500
X-MC-Unique: j8PvDPzkPcS0kQhYjCz5WQ-1
Received: by mail-wm1-f71.google.com with SMTP id j204so2906173wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXSb9jYxKBqqlvxwQZRvY2KHUZBMAWGJJY1gsihXjD0=;
        b=Sbg4yoaIrphRHuaSe8E2kZyUCxaw6cVeZ4yojwjWD/ImyVOoD5l69M/VFc/2oJYKml
         d2N3tRD3duFN3cEutcOzmBvgLLKorexu08SKc1p71He3WjM8mXvET7jiglBveu20Rir2
         ZjnCqa30X1wLGqIl+19GVhdDjPLLp9+sBHinA+UGwrn/rEYc2gi5a0Do8WYu3QxuBjM2
         yrnutRDetO5g7gJH1GVqN9BC2hjMD0kgZCZMbGSRBkNq9/2lYMfKHogCQi/sP0j9F/g3
         SgtFKpFjnqPJn8RtmMElwx/sgN7yYVtiHa7RJQj/qy+y4fgMfK66Zw9o+2r5WbvlVleR
         fQpA==
X-Gm-Message-State: AOAM5307EaanT9JOj89A7rfu2ySB9EHAEXGAiMHA2M2vSc7ytfyNmPOJ
        29ZMpBr+gE7Gz/+uj3DnzAEsafptcKknTCNiNE4Wq/OyCvT6PuaSEr3UaEw66OGe/nj3vgFrKsW
        SFd9JP5EUXfWdfITdmBjbRYKj
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr3958909wmi.117.1613033802425;
        Thu, 11 Feb 2021 00:56:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoKxb9orBX3ovmg/8fWwDXc5sx7mzAAlo92ffJkaduKwtKgD37SvZKBNxZFh2MV1qH3Vwytw==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr3958886wmi.117.1613033802162;
        Thu, 11 Feb 2021 00:56:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f14sm2170081wmg.28.2021.02.11.00.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 00:56:41 -0800 (PST)
To:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, tony.luck@intel.com, wanpengli@tencent.com,
        kvm@vger.kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        seanjc@google.com, joro@8bytes.org, x86@kernel.org,
        kyung.min.park@intel.com, linux-kernel@vger.kernel.org,
        krish.sadhukhan@oracle.com, hpa@zytor.com, mgross@linux.intel.com,
        vkuznets@redhat.com, kim.phillips@amd.com, wei.huang2@amd.com,
        jmattson@google.com
References: <161188083424.28787.9510741752032213167.stgit@bmoger-ubuntu>
 <161188100955.28787.11816849358413330720.stgit@bmoger-ubuntu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/2] KVM: SVM: Add support for Virtual SPEC_CTRL
Message-ID: <addd9d50-4a2e-b3ae-ff32-5332ab664463@redhat.com>
Date:   Thu, 11 Feb 2021 09:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <161188100955.28787.11816849358413330720.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/21 01:43, Babu Moger wrote:
> This support also fixes an issue where a guest may sometimes see an 
> inconsistent value for the SPEC_CTRL MSR on processors that support this 
> feature. With the current SPEC_CTRL support, the first write to 
> SPEC_CTRL is intercepted and the virtualized version of the SPEC_CTRL 
> MSR is not updated.

This is a bit ugly, new features should always be enabled manually (AMD 
did it right for vVMLOAD/vVMSAVE for example, even though _in theory_ 
assuming that all hypervisors were intercepting VMLOAD/VMSAVE would have 
been fine).

Also regarding nested virtualization:

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 7a605ad8254d..9e51f9e4f631 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -534,6 +534,7 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
>  		hsave->save.cr3    = vmcb->save.cr3;
>  	else
>  		hsave->save.cr3    = kvm_read_cr3(&svm->vcpu);
> +	hsave->save.spec_ctrl = vmcb->save.spec_ctrl;
>  
>  	copy_vmcb_control_area(&hsave->control, &vmcb->control);
>  
> @@ -675,6 +676,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  	kvm_rip_write(&svm->vcpu, hsave->save.rip);
>  	svm->vmcb->save.dr7 = DR7_FIXED_1;
>  	svm->vmcb->save.cpl = 0;
> +	svm->vmcb->save.spec_ctrl = hsave->save.spec_ctrl;
>  	svm->vmcb->control.exit_int_info = 0;
>  
>  	vmcb_mark_all_dirty(svm->vmcb);

I think this is incorrect.  Since we don't support this feature in the 
nested hypervisor, any writes to the SPEC_CTRL MSR while L2 (nested 
guest) runs have to be reflected to L1 (nested hypervisor).  In other 
words, this new field is more like VMLOAD/VMSAVE state, in that it 
doesn't change across VMRUN and VMEXIT.  These two hunks can be removed.

If we want to do it, exposing this feature to the nested hypervisor will 
be a bit complicated, because one has to write host SPEC_CTRL | 
vmcb01.GuestSpecCtrl in the host MSR, in order to free the vmcb02 
GuestSpecCtrl for the vmcb12 GuestSpecCtrl.

It would also be possible to emulate it on processors that don't have 
it.  However I'm not sure it's a good idea because of the problem that 
you mentioned with running old kernels on new processors.

I have queued the patches with the small fix above.  However I plan to 
only include them in 5.13 because I have a bunch of other SVM patches, 
those have been tested already but I need to send them out for review 
before "officially" getting them in kvm.git.

Paolo

