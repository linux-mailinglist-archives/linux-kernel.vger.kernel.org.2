Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8341420A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhIVGm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhIVGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4eS+67AEBYvtqXGAO5BJQzp3vg53OlrVoOKQgtt1lA=;
        b=R0CpLYBVOqp9E3R8+l6iSCCxDo4BW/+rizeBoeRtEpcrnR11/cJBADJq8DoPydUeQ+pbQ1
        3yklShXi9q18WULTdOhFHhA1f0CTsYi5egN7+Q8Ookasv91q+BkzEAlacq2QWE95TLiNwv
        GSRkFc/WHCAfV1YDIhDUodFVAAPaol4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-Kp94yw5ROvWZc2kmdIrC6g-1; Wed, 22 Sep 2021 02:40:53 -0400
X-MC-Unique: Kp94yw5ROvWZc2kmdIrC6g-1
Received: by mail-ed1-f72.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso1920925edp.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y4eS+67AEBYvtqXGAO5BJQzp3vg53OlrVoOKQgtt1lA=;
        b=Ih+b7/xal0kCUplyVewg+kNzWXBDa/qRnmnvbGAgpT71kGegf3LRwztHAQiXa5HxrV
         M73UxooH5qGjlduP4RYt9OqYVmQ5xZw2ruf4uL++q5xd8TegdoPo/mf0FlG/Gzw3U9Jr
         VbwLCsdBCAx1Bg2PL47bAOSjhAAmBe5lPPTo9IIRbA++ZdOStyZ8FwKIxcy2rECpkIRy
         gASt7OtCK1LQpp4/yBiTiUZtJZOqEOP5dN/38GKBFHtXUyPRx9Xn6tQPvL5juuCSO438
         3O07z6VCJF3ENzmfooLlYibtWkFKGOXHOtOB8IbTDCD5MCzB9eUz9XRZDsQSWxbHH75r
         aBJQ==
X-Gm-Message-State: AOAM5302aYjzbB+zPwHJHOoA5Drg0TSAZ2W7Wk5JKV4B04908wYbLG3x
        KdPJyvSPjigJJIoj9rDvw4AptPgOy3OOTR4wiJMAg4ZFEcjhyzqfLfoSaMh/oQMOR/qicR900Os
        +eukOSOl8U+Vq1DhbpFJMD4u5
X-Received: by 2002:a50:d84c:: with SMTP id v12mr39445963edj.203.1632292851015;
        Tue, 21 Sep 2021 23:40:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlo4LRB2M8qmmWv+FM3u6P6lvmJINGGsRc/N/kQ7rKED6NNzY0+dunHYjRokMbMUtgN8H1BQ==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr39445930edj.203.1632292850792;
        Tue, 21 Sep 2021 23:40:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t24sm618083edr.84.2021.09.21.23.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:40:50 -0700 (PDT)
Subject: Re: [PATCH v3 10/16] KVM: x86: Drop current_vcpu for kvm_running_vcpu
 + kvm_arch_vcpu variable
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-11-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5948ba8-3f4d-e749-e645-b9b82f405863@redhat.com>
Date:   Wed, 22 Sep 2021 08:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Use the generic kvm_running_vcpu plus a new 'handling_intr_from_guest'
> variable in kvm_arch_vcpu instead of the semi-redundant current_vcpu.
> kvm_before/after_interrupt() must be called while the vCPU is loaded,
> (which protects against preemption), thus kvm_running_vcpu is guaranteed
> to be non-NULL when handling_intr_from_guest is non-zero.
> 
> Switching to kvm_get_running_vcpu() will allows moving KVM's perf
> callbacks to generic code, and the new flag will be used in a future
> patch to more precisely identify the "NMI from guest" case.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  3 +--
>   arch/x86/kvm/pmu.c              |  2 +-
>   arch/x86/kvm/x86.c              | 21 ++++++++++++---------
>   arch/x86/kvm/x86.h              | 10 ++++++----
>   4 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1080166fc0cf..2d86a2dfc775 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -763,6 +763,7 @@ struct kvm_vcpu_arch {
>   	unsigned nmi_pending; /* NMI queued after currently running handler */
>   	bool nmi_injected;    /* Trying to inject an NMI this entry */
>   	bool smi_pending;    /* SMI queued after currently running handler */
> +	u8 handling_intr_from_guest;
>   
>   	struct kvm_mtrr mtrr_state;
>   	u64 pat;
> @@ -1874,8 +1875,6 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
>   int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
>   void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
>   
> -unsigned int kvm_guest_state(void);
> -
>   void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>   				     u32 size);
>   bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 5b68d4188de0..eef48258e50f 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -87,7 +87,7 @@ static void kvm_perf_overflow_intr(struct perf_event *perf_event,
>   		 * woken up. So we should wake it, but this is impossible from
>   		 * NMI context. Do it from irq work instead.
>   		 */
> -		if (!kvm_guest_state())
> +		if (!kvm_handling_nmi_from_guest(pmc->vcpu))
>   			irq_work_queue(&pmc_to_pmu(pmc)->irq_work);
>   		else
>   			kvm_make_request(KVM_REQ_PMI, pmc->vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6cc66466f301..24a6faa07442 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8264,15 +8264,17 @@ static void kvm_timer_init(void)
>   			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
>   }
>   
> -DEFINE_PER_CPU(struct kvm_vcpu *, current_vcpu);
> -EXPORT_PER_CPU_SYMBOL_GPL(current_vcpu);
> +static inline bool kvm_pmi_in_guest(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu && vcpu->arch.handling_intr_from_guest;
> +}
>   
> -unsigned int kvm_guest_state(void)
> +static unsigned int kvm_guest_state(void)
>   {
> -	struct kvm_vcpu *vcpu = __this_cpu_read(current_vcpu);
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>   	unsigned int state;
>   
> -	if (!vcpu)
> +	if (!kvm_pmi_in_guest(vcpu))
>   		return 0;
>   
>   	state = PERF_GUEST_ACTIVE;
> @@ -8284,9 +8286,10 @@ unsigned int kvm_guest_state(void)
>   
>   static unsigned long kvm_guest_get_ip(void)
>   {
> -	struct kvm_vcpu *vcpu = __this_cpu_read(current_vcpu);
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>   
> -	if (WARN_ON_ONCE(!vcpu))
> +	/* Retrieving the IP must be guarded by a call to kvm_guest_state(). */
> +	if (WARN_ON_ONCE(!kvm_pmi_in_guest(vcpu)))
>   		return 0;
>   
>   	return kvm_rip_read(vcpu);
> @@ -8294,10 +8297,10 @@ static unsigned long kvm_guest_get_ip(void)
>   
>   static unsigned int kvm_handle_intel_pt_intr(void)
>   {
> -	struct kvm_vcpu *vcpu = __this_cpu_read(current_vcpu);
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>   
>   	/* '0' on failure so that the !PT case can use a RET0 static call. */
> -	if (!vcpu)
> +	if (!kvm_pmi_in_guest(vcpu))
>   		return 0;
>   
>   	kvm_make_request(KVM_REQ_PMI, vcpu);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 7d66d63dc55a..a9c107e7c907 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -387,18 +387,20 @@ static inline bool kvm_cstate_in_guest(struct kvm *kvm)
>   	return kvm->arch.cstate_in_guest;
>   }
>   
> -DECLARE_PER_CPU(struct kvm_vcpu *, current_vcpu);
> -
>   static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu)
>   {
> -	__this_cpu_write(current_vcpu, vcpu);
> +	WRITE_ONCE(vcpu->arch.handling_intr_from_guest, 1);
>   }
>   
>   static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
>   {
> -	__this_cpu_write(current_vcpu, NULL);
> +	WRITE_ONCE(vcpu->arch.handling_intr_from_guest, 0);
>   }
>   
> +static inline bool kvm_handling_nmi_from_guest(struct kvm_vcpu *vcpu)
> +{
> +	return !!vcpu->arch.handling_intr_from_guest;
> +}
>   
>   static inline bool kvm_pat_valid(u64 data)
>   {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

