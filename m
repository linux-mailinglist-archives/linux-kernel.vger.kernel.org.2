Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4721E365733
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhDTLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhDTLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618917044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9sXmDPr3SrHKrrVLfoS0DzDE5vOCttODNm+kskRChg=;
        b=Pr//Jl2BQ1Z/YsQovRs5gq4DDefhqRu40BVp2xX0skXG4h0hy3MaGH0SFqdIdJ2qXg8KRx
        LSuWDqNGwd1Q1oM72QD08jE8+kUMIIRBpMF2zTzo+8gF+3jhR7a9ALEkQZ6TYChv+8ZEk6
        f5RQFFIFmviyrKSBZ+EDdepBxAT8+3w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-cMYMrt7DM_6DxXgqG05paQ-1; Tue, 20 Apr 2021 07:10:42 -0400
X-MC-Unique: cMYMrt7DM_6DxXgqG05paQ-1
Received: by mail-ed1-f70.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso12907911edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9sXmDPr3SrHKrrVLfoS0DzDE5vOCttODNm+kskRChg=;
        b=nFKAatzYFo29q0dLcB7pPgcNTzAGk7Z4TAC/5O+OA1jKcIoabTN9ESiYRB0FQfK/F3
         ZjLEdsyBbn/KhUWNiAtR5eRY7vHYo/xHK3bkUeP4/Q5UN15U0q+8/sigaMExpTtnay5i
         fgL2cl4Hut6UvAj+sN76SJGpFar4l3AwD1BBKOkf5TTAGI9lsrLDdV1u42L8Qj6OoG66
         50yjUzEsmIZo/bxeDlfLOdf9qLdv1gyQ547Bt5yYLIO7JvtwESqq9VZ9D5Jt88444G2w
         tsxUHmD/cLsj2gNu9umvKH7C7oCYN7mvR1NWaa/nIV8X7sQ7V2t4KFCDOIh242AyvnUT
         4xyw==
X-Gm-Message-State: AOAM5329Jjc4SuuuD+efkpZV0o9vzWHtED+jOZ4+u4xXjDncxlZJ0uvm
        s/OuWsrcPwdz+DO10YokmMQbInr/jb0iSPi+MswO4IsvZIzBruWOYcQbsT6U7MuKTDGHXjm69j2
        JkwLPokfDYZPyF2Zr6hcHox5Q
X-Received: by 2002:a17:906:6bcb:: with SMTP id t11mr26110224ejs.395.1618917039216;
        Tue, 20 Apr 2021 04:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbGgFaSqksAQchF2l1+LJplvZlyrjpDQsObJpdSDJr+YTSzHN4SnzNHquNFpt8qI2wIAI7iw==
X-Received: by 2002:a17:906:6bcb:: with SMTP id t11mr26110193ejs.395.1618917038955;
        Tue, 20 Apr 2021 04:10:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b8sm16135579edu.41.2021.04.20.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:10:38 -0700 (PDT)
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <93d7f2c2888315adc48905722574d89699edde33.1618498113.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v13 08/12] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
 hypercall
Message-ID: <6e6b4e8c-bbfa-fd58-c1e8-895a157762fe@redhat.com>
Date:   Tue, 20 Apr 2021 13:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <93d7f2c2888315adc48905722574d89699edde33.1618498113.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 17:57, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> This hypercall is used by the SEV guest to notify a change in the page
> encryption status to the hypervisor. The hypercall should be invoked
> only when the encryption attribute is changed from encrypted -> decrypted
> and vice versa. By default all guest pages are considered encrypted.
> 
> The hypercall exits to userspace to manage the guest shared regions and
> integrate with the userspace VMM's migration code.

I think this should be exposed to userspace as a capability, rather than 
as a CPUID bit.  Userspace then can enable the capability and set the 
CPUID bit if it wants.

The reason is that userspace could pass KVM_GET_SUPPORTED_CPUID to
KVM_SET_CPUID2 and the hypercall then would break the guest.

Paolo

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Steve Rutherford <srutherford@google.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   Documentation/virt/kvm/hypercalls.rst | 15 ++++++++++++++
>   arch/x86/include/asm/kvm_host.h       |  2 ++
>   arch/x86/kvm/svm/sev.c                |  1 +
>   arch/x86/kvm/x86.c                    | 29 +++++++++++++++++++++++++++
>   include/uapi/linux/kvm_para.h         |  1 +
>   5 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/hypercalls.rst b/Documentation/virt/kvm/hypercalls.rst
> index ed4fddd364ea..7aff0cebab7c 100644
> --- a/Documentation/virt/kvm/hypercalls.rst
> +++ b/Documentation/virt/kvm/hypercalls.rst
> @@ -169,3 +169,18 @@ a0: destination APIC ID
>   
>   :Usage example: When sending a call-function IPI-many to vCPUs, yield if
>   	        any of the IPI target vCPUs was preempted.
> +
> +
> +8. KVM_HC_PAGE_ENC_STATUS
> +-------------------------
> +:Architecture: x86
> +:Status: active
> +:Purpose: Notify the encryption status changes in guest page table (SEV guest)
> +
> +a0: the guest physical address of the start page
> +a1: the number of pages
> +a2: encryption attribute
> +
> +   Where:
> +	* 1: Encryption attribute is set
> +	* 0: Encryption attribute is cleared
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3768819693e5..42eb0fe3df5d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1050,6 +1050,8 @@ struct kvm_arch {
>   
>   	bool bus_lock_detection_enabled;
>   
> +	bool page_enc_hc_enable;
> +
>   	/* Deflect RDMSR and WRMSR to user space when they trigger a #GP */
>   	u32 user_space_msr_mask;
>   	struct kvm_x86_msr_filter __rcu *msr_filter;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c9795a22e502..5184a0c0131a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -197,6 +197,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
>   	sev->active = true;
>   	sev->asid = asid;
>   	INIT_LIST_HEAD(&sev->regions_list);
> +	kvm->arch.page_enc_hc_enable = true;
>   
>   	return 0;
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f7d12fca397b..e8986478b653 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8208,6 +8208,13 @@ static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
>   		kvm_vcpu_yield_to(target);
>   }
>   
> +static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
> +{
> +	kvm_rax_write(vcpu, vcpu->run->hypercall.ret);
> +	++vcpu->stat.hypercalls;
> +	return kvm_skip_emulated_instruction(vcpu);
> +}
> +
>   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long nr, a0, a1, a2, a3, ret;
> @@ -8273,6 +8280,28 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   		kvm_sched_yield(vcpu->kvm, a0);
>   		ret = 0;
>   		break;
> +	case KVM_HC_PAGE_ENC_STATUS: {
> +		u64 gpa = a0, npages = a1, enc = a2;
> +
> +		ret = -KVM_ENOSYS;
> +		if (!vcpu->kvm->arch.page_enc_hc_enable)
> +			break;
> +
> +		if (!PAGE_ALIGNED(gpa) || !npages ||
> +		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> +		vcpu->run->hypercall.nr       = KVM_HC_PAGE_ENC_STATUS;
> +		vcpu->run->hypercall.args[0]  = gpa;
> +		vcpu->run->hypercall.args[1]  = npages;
> +		vcpu->run->hypercall.args[2]  = enc;
> +		vcpu->run->hypercall.longmode = op_64_bit;
> +		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
> +		return 0;
> +	}
>   	default:
>   		ret = -KVM_ENOSYS;
>   		break;
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index 8b86609849b9..847b83b75dc8 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -29,6 +29,7 @@
>   #define KVM_HC_CLOCK_PAIRING		9
>   #define KVM_HC_SEND_IPI		10
>   #define KVM_HC_SCHED_YIELD		11
> +#define KVM_HC_PAGE_ENC_STATUS		12
>   
>   /*
>    * hypercalls use architecture specific
> 

