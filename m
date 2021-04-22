Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C3367A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhDVGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhDVGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619073935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQrWjP+kJ7EmltFhHDteE+B12uEaYO5koE8vqRgxs80=;
        b=iZtU4RCs4yni7W17JeElax9uAdMQlu4+Q+V8TbUoZTLZQ5GjHKjd+KkJcTjhwL5i2vILa0
        maNQIZXlbEdKsn8A8Bso8chu3W1w+vXanXOs6osZKjmHHQpVyBGzOborlxy88uDev69HzR
        MdR1HfyEdNyyKZw0SsUBrxLjybMkrfo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-sVUpfKbYOFKML5ye50pkoA-1; Thu, 22 Apr 2021 02:45:33 -0400
X-MC-Unique: sVUpfKbYOFKML5ye50pkoA-1
Received: by mail-ej1-f71.google.com with SMTP id g7-20020a1709065d07b029037c872d9cdcso6845961ejt.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQrWjP+kJ7EmltFhHDteE+B12uEaYO5koE8vqRgxs80=;
        b=PNhDLyX5bpywQTJ74nJmELvHqRLCYhb//hPDWShYnRU0vZAMKx5EoZ4Haef3LySXiJ
         O409Iv2kxAfp6k4i3mR5xgY7ZA/lKnRWVSQDLPS9J9L9rLjy/D7drZokflrCUa1rOgIo
         WN0DmoSD1YaIb4nWd+Q/2Jesw69HLgg+5rAuYhtj9pdRCmuDkPHFAygJlItswTUhYiTS
         RfueAuhQg6CesUmo5lNTflOlKSDGroU0SS9+zEn4jtNcYVSCRrxbymbzNn5VoDeCb0Ou
         At7nmGonShkxOKziscKxtJLaCjAQSXPUyJBWViycyCB2SN3JywvcfU0jC8R/Bz9nCD+1
         wbUw==
X-Gm-Message-State: AOAM5327c+4iT0ArTd2aM0IDJLY9bfDbdmQGLBcGidgbL2Kx0XWSWNtC
        8kvrm9mMep8tdFTXGHryOYFZxcFManWSqiWlw9IGx7VX52myM+W+INlJs6KIk8etoJgkobPAuWz
        HwYKvQDRuwHPFaKrms9aXB0YOYdyGUig+mDAtOtjfUi72UD82BZBus+vJtwKzPvKqDLJVQ5BMQK
        Jr
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr1673841ejs.243.1619073931560;
        Wed, 21 Apr 2021 23:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ8nKuR44HhrUwyvjhkj47pNw9l3luOVqmb6URlU2FKp5OZhl/xleJ8QG0KMrkLsv2oWVbVw==
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr1673824ejs.243.1619073931332;
        Wed, 21 Apr 2021 23:45:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nd36sm1151992ejc.21.2021.04.21.23.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 23:45:30 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: Delay restoration of host MSR_TSC_AUX until
 return to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210422001736.3255735-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71038b23-0902-1074-bd94-d5b30311faf0@redhat.com>
Date:   Thu, 22 Apr 2021 08:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422001736.3255735-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 02:17, Sean Christopherson wrote:
> Use KVM's "user return MSRs" framework to defer restoring the host's
> MSR_TSC_AUX until the CPU returns to userspace.  Add/improve comments to
> clarify why MSR_TSC_AUX is intercepted on both RDMSR and WRMSR, and why
> it's safe for KVM to keep the guest's value loaded even if KVM is
> scheduled out.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> v2: Rebased to kvm/queue (ish), commit 0e91d1992235 ("KVM: SVM: Allocate SEV
>      command structures on local stack")
>   
>   arch/x86/kvm/svm/svm.c | 50 ++++++++++++++++++------------------------
>   arch/x86/kvm/svm/svm.h |  7 ------
>   2 files changed, 21 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cd8c333ed2dc..596361449f25 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -213,6 +213,15 @@ struct kvm_ldttss_desc {
>   
>   DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
>   
> +/*
> + * Only MSR_TSC_AUX is switched via the user return hook.  EFER is switched via
> + * the VMCB, and the SYSCALL/SYSENTER MSRs are handled by VMLOAD/VMSAVE.
> + *
> + * RDTSCP and RDPID are not used in the kernel, specifically to allow KVM to
> + * defer the restoration of TSC_AUX until the CPU returns to userspace.
> + */
> +#define TSC_AUX_URET_SLOT	0
> +
>   static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
>   
>   #define NUM_MSR_MAPS ARRAY_SIZE(msrpm_ranges)
> @@ -958,6 +967,9 @@ static __init int svm_hardware_setup(void)
>   		kvm_tsc_scaling_ratio_frac_bits = 32;
>   	}
>   
> +	if (boot_cpu_has(X86_FEATURE_RDTSCP))
> +		kvm_define_user_return_msr(TSC_AUX_URET_SLOT, MSR_TSC_AUX);
> +
>   	/* Check for pause filtering support */
>   	if (!boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
>   		pause_filter_count = 0;
> @@ -1423,19 +1435,10 @@ static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
>   {
>   	struct vcpu_svm *svm = to_svm(vcpu);
>   	struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
> -	unsigned int i;
>   
>   	if (svm->guest_state_loaded)
>   		return;
>   
> -	/*
> -	 * Certain MSRs are restored on VMEXIT (sev-es), or vmload of host save
> -	 * area (non-sev-es). Save ones that aren't so we can restore them
> -	 * individually later.
> -	 */
> -	for (i = 0; i < NR_HOST_SAVE_USER_MSRS; i++)
> -		rdmsrl(host_save_user_msrs[i], svm->host_user_msrs[i]);
> -
>   	/*
>   	 * Save additional host state that will be restored on VMEXIT (sev-es)
>   	 * or subsequent vmload of host save area.
> @@ -1454,29 +1457,15 @@ static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
>   		}
>   	}
>   
> -	/* This assumes that the kernel never uses MSR_TSC_AUX */
>   	if (static_cpu_has(X86_FEATURE_RDTSCP))
> -		wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
> +		kvm_set_user_return_msr(TSC_AUX_URET_SLOT, svm->tsc_aux, -1ull);
>   
>   	svm->guest_state_loaded = true;
>   }
>   
>   static void svm_prepare_host_switch(struct kvm_vcpu *vcpu)
>   {
> -	struct vcpu_svm *svm = to_svm(vcpu);
> -	unsigned int i;
> -
> -	if (!svm->guest_state_loaded)
> -		return;
> -
> -	/*
> -	 * Certain MSRs are restored on VMEXIT (sev-es), or vmload of host save
> -	 * area (non-sev-es). Restore the ones that weren't.
> -	 */
> -	for (i = 0; i < NR_HOST_SAVE_USER_MSRS; i++)
> -		wrmsrl(host_save_user_msrs[i], svm->host_user_msrs[i]);
> -
> -	svm->guest_state_loaded = false;
> +	to_svm(vcpu)->guest_state_loaded = false;
>   }
>   
>   static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> @@ -2893,12 +2882,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>   			return 1;
>   
>   		/*
> -		 * This is rare, so we update the MSR here instead of using
> -		 * direct_access_msrs.  Doing that would require a rdmsr in
> -		 * svm_vcpu_put.
> +		 * TSC_AUX is usually changed only during boot and never read
> +		 * directly.  Intercept TSC_AUX instead of exposing it to the
> +		 * guest via direct_acess_msrs, and switch it via user return.
>   		 */
>   		svm->tsc_aux = data;
> -		wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
> +
> +		preempt_disable();
> +		kvm_set_user_return_msr(TSC_AUX_URET_SLOT, data, -1ull);
> +		preempt_enable();
>   		break;
>   	case MSR_IA32_DEBUGCTLMSR:
>   		if (!boot_cpu_has(X86_FEATURE_LBRV)) {
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 454da1c1d9b7..9dce6f290041 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -23,11 +23,6 @@
>   
>   #define __sme_page_pa(x) __sme_set(page_to_pfn(x) << PAGE_SHIFT)
>   
> -static const u32 host_save_user_msrs[] = {
> -	MSR_TSC_AUX,
> -};
> -#define NR_HOST_SAVE_USER_MSRS ARRAY_SIZE(host_save_user_msrs)
> -
>   #define	IOPM_SIZE PAGE_SIZE * 3
>   #define	MSRPM_SIZE PAGE_SIZE * 2
>   
> @@ -128,8 +123,6 @@ struct vcpu_svm {
>   
>   	u64 next_rip;
>   
> -	u64 host_user_msrs[NR_HOST_SAVE_USER_MSRS];
> -
>   	u64 spec_ctrl;
>   	/*
>   	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
> 

Queued, thanks.

Paolo

