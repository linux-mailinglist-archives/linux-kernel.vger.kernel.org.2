Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB893B1A38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFWMec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhFWMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624451532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ITBT+QEBufJn00V7n1DCOlmsinYfRzugNltjS/8Qzo=;
        b=NabqudgoCyBg1Z3J04It6lEN6RgYxiGPDueKgTertfI1uhD5TYLvQeh04Xt1V7no8tdZKe
        Tg+2DU/dX0E/RndT+X1OnFZ9v+ud5YV2TzWagUilQkW5q3ZCviKm1H0/idj8B6EpAdjZD/
        LzsKOSqaTo/vCDIg2JYl1DIGcD7Hfuo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-QLZPyLa9MZayUPpNDBDBaw-1; Wed, 23 Jun 2021 08:32:11 -0400
X-MC-Unique: QLZPyLa9MZayUPpNDBDBaw-1
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c9b0290394f9be24d9so681058edd.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ITBT+QEBufJn00V7n1DCOlmsinYfRzugNltjS/8Qzo=;
        b=cGuOcvsxFT+bnl7333GRK6Ik75I4T3UfvYD/CAHYwoShpqFQpPJDonisomWvnf4Ymi
         1NefddYa7RAfs0VU1NliNEHyfA8qPPMf7MWBwzRHTQgRxfWzEomOWdGTCEbk8cliLgMD
         U+9ResNfFcbUwWeqwHjdKS6jPwuE9oqI+G586UpPiL6VFHGj0fJuQxpuNpdG9LK+O25C
         Kwg/uhYv9SWav0aLyVj84TgdlsXfrCe9xdBVLChwvmoM64EW/+NOu7C915Gipf2KhK9z
         CGGZ0VTQ46yTdBfqi+rIcgev8Q4MTey2LTz0pmqi/GmN1EBCxbnZtsf2xbzD0nnuxY7I
         HaCA==
X-Gm-Message-State: AOAM533YhouhVrNcRWa2V6Fd65dA6Zk/rd3ZiT/SnAdgO9eeMjZfwqZD
        d7cpHOykh2FlcxOPakUk3zIx5UcTfarOUjUNcSIuXzzXrjcWXJRr3JQ74Z3QVJwqv7vtKBUegkk
        zdlmcHsgZaO0mAlNwRcVGx3dD
X-Received: by 2002:a05:6402:5207:: with SMTP id s7mr12148985edd.363.1624451529870;
        Wed, 23 Jun 2021 05:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOIGqQMtH9uvdwy1Xd3KKl2b1o4KTT04+3H9I2jgRwDDhir/1RwNipLlcGatkV0qvYTcg2qA==
X-Received: by 2002:a05:6402:5207:: with SMTP id s7mr12148954edd.363.1624451529684;
        Wed, 23 Jun 2021 05:32:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p19sm3779268edr.73.2021.06.23.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:32:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Handle split-lock #AC exceptions that happen
 in L2
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20210622172244.3561540-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d94b9d9-d167-177b-7fc5-b6c93ea3555e@redhat.com>
Date:   Wed, 23 Jun 2021 14:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622172244.3561540-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:22, Sean Christopherson wrote:
> Mark #ACs that won't be reinjected to the guest as wanted by L0 so that
> KVM handles split-lock #AC from L2 instead of forwarding the exception to
> L1.  Split-lock #AC isn't yet virtualized, i.e. L1 will treat it like a
> regular #AC and do the wrong thing, e.g. reinject it into L2.
> 
> Fixes: e6f8b6c12f03 ("KVM: VMX: Extend VMXs #AC interceptor to handle split lock #AC in guest")
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/nested.c | 3 +++
>   arch/x86/kvm/vmx/vmcs.h   | 5 +++++
>   arch/x86/kvm/vmx/vmx.c    | 4 ++--
>   arch/x86/kvm/vmx/vmx.h    | 1 +
>   4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 183fd9d62fc5..fa3f50f0a3fa 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5833,6 +5833,9 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
>   		else if (is_breakpoint(intr_info) &&
>   			 vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
>   			return true;
> +		else if (is_alignment_check(intr_info) &&
> +			 !vmx_guest_inject_ac(vcpu))
> +			return true;
>   		return false;
>   	case EXIT_REASON_EXTERNAL_INTERRUPT:
>   		return true;
> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
> index de3b04d4b587..4b9957e2bf5b 100644
> --- a/arch/x86/kvm/vmx/vmcs.h
> +++ b/arch/x86/kvm/vmx/vmcs.h
> @@ -117,6 +117,11 @@ static inline bool is_gp_fault(u32 intr_info)
>   	return is_exception_n(intr_info, GP_VECTOR);
>   }
>   
> +static inline bool is_alignment_check(u32 intr_info)
> +{
> +	return is_exception_n(intr_info, AC_VECTOR);
> +}
> +
>   static inline bool is_machine_check(u32 intr_info)
>   {
>   	return is_exception_n(intr_info, MC_VECTOR);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ab6f682645d7..46d9ce39249d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4743,7 +4743,7 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
>    *  - Guest has #AC detection enabled in CR0
>    *  - Guest EFLAGS has AC bit set
>    */
> -static inline bool guest_inject_ac(struct kvm_vcpu *vcpu)
> +bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu)
>   {
>   	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
>   		return true;
> @@ -4851,7 +4851,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>   		kvm_run->debug.arch.exception = ex_no;
>   		break;
>   	case AC_VECTOR:
> -		if (guest_inject_ac(vcpu)) {
> +		if (vmx_guest_inject_ac(vcpu)) {
>   			kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
>   			return 1;
>   		}
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 5740f8e2aa23..3979a947933a 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -376,6 +376,7 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
>   void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
>   u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
>   
> +bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
>   void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
>   void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
>   bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
> 

Queued with Cc to stable, thanks.

Paolo

