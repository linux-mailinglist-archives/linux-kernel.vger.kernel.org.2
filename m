Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F138F162
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhEXQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhEXQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vbtJz1B6PVgjPOA+u4nJ3svJYu5vKUQ2E1CuhCFrHNU=;
        b=Ogmp1KB02MGbw93aCmX4i0dcnA/5O/fKQR10DeuGf1KefKbOn/VlxeY6auWi1QskUL/VFS
        56f++eBsxI1mpAo5z36og3fjSUWvNc+/AusmgL1Zk1jZ1QMCC+zFohNWFN68xctxWlCN6n
        XQLo8+yNvJhT4FXmEQB/C0yhdMthlNg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-yv_WnlZTO9qELlcQG0M4Ig-1; Mon, 24 May 2021 12:21:22 -0400
X-MC-Unique: yv_WnlZTO9qELlcQG0M4Ig-1
Received: by mail-ed1-f69.google.com with SMTP id n6-20020a0564020606b029038cdc241890so15819706edv.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbtJz1B6PVgjPOA+u4nJ3svJYu5vKUQ2E1CuhCFrHNU=;
        b=TWLwumJkp1re6n/I/QC8237NYqQLpM53F1Jwy26D9p68i/uQBX5fZamUFHEdmbcD2D
         Ghe0a3mOHCmfxWHrf0Tvu0t3C/OGY6tGrJ6Eonzj9tkULhxpYibfNBLQYYHRPRSXPc7g
         igi/vkByQIIIUR6FqIPG6b/cOz3rE8RnS2Yz6grQ1NP3lMwovqVeG+cA419kR74jb5lQ
         RVopyfyZqhstRGKkTMyxM5GRCN4ziNJTfGbhQizWDh0N9himUatzOJX3ATPS7ThvzCtE
         nkN4nYRPXiSlFwRssI5M5QRAyFeLqBUp6Kb3Dw/bXphV7rgf+783gOSyLrjYL52mi+kj
         rvcg==
X-Gm-Message-State: AOAM531k9taa1wWAM4HKTTzAg2UwQslikfvKeF0muHPEskgBm1oWFNqN
        juvAOobEvfCR6Sd7ihlKvPyC6tYKq6q9p+uzZzS+Z4MJMssBI7wT7Xps8gQrom2lATZnPfcsAwa
        3ljKvmqP1ydU+PxLjbbewYyWnMBhfIm5Scf2E2K/tqCDPe1xhu9elIMSjbSDi7uvSUrRX2dyVZN
        gf
X-Received: by 2002:a50:fd17:: with SMTP id i23mr27592129eds.54.1621873280337;
        Mon, 24 May 2021 09:21:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm863y5lfpQdNIOD2nZa7MOniCUm6EVbqV7tFHhyQ18EZCIeYhCuz7nIN2OybL6GU1wN8IIQ==
X-Received: by 2002:a50:fd17:: with SMTP id i23mr27591992eds.54.1621873279146;
        Mon, 24 May 2021 09:21:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w3sm2879892eds.78.2021.05.24.09.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 09:21:18 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] KVM: x86: hyper-v: Deactivate APICv only when
 AutoEOI feature is in use
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-6-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82e2a6a0-337a-4b92-2271-493344a38960@redhat.com>
Date:   Mon, 24 May 2021 18:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518144339.1987982-6-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/21 16:43, Vitaly Kuznetsov wrote:
> APICV_INHIBIT_REASON_HYPERV is currently unconditionally forced upon
> SynIC activation as SynIC's AutoEOI is incompatible with APICv/AVIC. It is,
> however, possible to track whether the feature was actually used by the
> guest and only inhibit APICv/AVIC when needed.
> 
> TLFS suggests a dedicated 'HV_DEPRECATING_AEOI_RECOMMENDED' flag to let
> Windows know that AutoEOI feature should be avoided. While it's up to
> KVM userspace to set the flag, KVM can help a bit by exposing global
> APICv/AVIC enablement: in case APICv/AVIC usage is impossible, AutoEOI
> is still preferred.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Should it also disable APICv unconditionally if 
HV_DEPRECATING_AEOI_RECOMMENDED is not in the guest CPUID?  That should 
avoid ping-pong between enabled and disabled APICv even in pathological 
cases that we cannot think about.

Paolo

> ---
>   arch/x86/include/asm/kvm_host.h |  3 +++
>   arch/x86/kvm/hyperv.c           | 27 +++++++++++++++++++++------
>   2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index bf5807d35339..5e03ab4c0e4f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -936,6 +936,9 @@ struct kvm_hv {
>   	/* How many vCPUs have VP index != vCPU index */
>   	atomic_t num_mismatched_vp_indexes;
>   
> +	/* How many SynICs use 'AutoEOI' feature */
> +	atomic_t synic_auto_eoi_used;
> +
>   	struct hv_partition_assist_pg *hv_pa_pg;
>   	struct kvm_hv_syndbg hv_syndbg;
>   };
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index f98370a39936..89e7d5b99279 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -87,6 +87,10 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
>   static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>   				int vector)
>   {
> +	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
> +	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
> +	int auto_eoi_old, auto_eoi_new;
> +
>   	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>   		return;
>   
> @@ -95,10 +99,25 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>   	else
>   		__clear_bit(vector, synic->vec_bitmap);
>   
> +	auto_eoi_old = bitmap_weight(synic->auto_eoi_bitmap, 256);
> +
>   	if (synic_has_vector_auto_eoi(synic, vector))
>   		__set_bit(vector, synic->auto_eoi_bitmap);
>   	else
>   		__clear_bit(vector, synic->auto_eoi_bitmap);
> +
> +	auto_eoi_new = bitmap_weight(synic->auto_eoi_bitmap, 256);
> +
> +	/* Hyper-V SynIC auto EOI SINTs are not compatible with APICV */
> +	if (!auto_eoi_old && auto_eoi_new) {
> +		if (atomic_inc_return(&hv->synic_auto_eoi_used) == 1)
> +			kvm_request_apicv_update(vcpu->kvm, false,
> +						 APICV_INHIBIT_REASON_HYPERV);
> +	} else if (!auto_eoi_new && auto_eoi_old) {
> +		if (atomic_dec_return(&hv->synic_auto_eoi_used) == 0)
> +			kvm_request_apicv_update(vcpu->kvm, true,
> +						 APICV_INHIBIT_REASON_HYPERV);
> +	}
>   }
>   
>   static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
> @@ -931,12 +950,6 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
>   
>   	synic = to_hv_synic(vcpu);
>   
> -	/*
> -	 * Hyper-V SynIC auto EOI SINT's are
> -	 * not compatible with APICV, so request
> -	 * to deactivate APICV permanently.
> -	 */
> -	kvm_request_apicv_update(vcpu->kvm, false, APICV_INHIBIT_REASON_HYPERV);
>   	synic->active = true;
>   	synic->dont_zero_synic_pages = dont_zero_synic_pages;
>   	synic->control = HV_SYNIC_CONTROL_ENABLE;
> @@ -2198,6 +2211,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>   				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>   			if (!cpu_smt_possible())
>   				ent->eax |= HV_X64_NO_NONARCH_CORESHARING;
> +			if (enable_apicv)
> +				ent->eax |= HV_DEPRECATING_AEOI_RECOMMENDED;
>   			/*
>   			 * Default number of spinlock retry attempts, matches
>   			 * HyperV 2016.
> 

