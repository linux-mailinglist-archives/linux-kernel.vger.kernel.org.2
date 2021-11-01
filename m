Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E76441996
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhKAKP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhKAKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635761557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TfOBbcFUo3MlyRxf8pzaH9LBcQfTLxJwUxJ635rEfO8=;
        b=NncHVdMnzXhXekXnyzXUAFPaHjQlFfBvofAy65SsFUGpXRUhDGgTVnQwuVWcDkRR9+3T2D
        xetWUl+z1F/hIPwV2isKzHUwvLFCE0vP6YH54qa6vR7rWv8oMaAQ+jcE+Ztg0zz7OByOvN
        hhnPtOnB17ikmFBGp4PUZPaiz2S7m3Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-tvHxUz5zMJCgvc8sDdADFw-1; Mon, 01 Nov 2021 06:12:36 -0400
X-MC-Unique: tvHxUz5zMJCgvc8sDdADFw-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso2109114edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 03:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TfOBbcFUo3MlyRxf8pzaH9LBcQfTLxJwUxJ635rEfO8=;
        b=pVfmRm+Ip862Vo6X4o9qY3YkC3mAeb+RzMlVKRnJ4tC39U5Ilj1/EeOpc3gKVGNQI2
         cP+KZ6qZBitd3s5XNHT/jZHeMft6zvjoSTZpFr8QRvazWmx4etdp3h0IH9v3HSTEUGab
         pKBZsG+sJ0Vvd+oq7TjMVpaRSxXUB4v4Kdtn160TGPwQTUyEr5fzFXxDL4bersaoNPZT
         EZvbEDD30Mp45Uv6/b1spm0wYuOVxyOM9luTewyZ5EfUIoquk5bbom9xL9VLvNea4WAB
         ud0WqC8SZqEVAHJ9dpTxjWf5V7G3qUKeqVVmZzUp+I5mzVCOi6Jd2GAeksXPvgxbjz3i
         pUOA==
X-Gm-Message-State: AOAM532cznu1bYLc7/+YrObVz0t75TpqNaqAjZ9b3FWVDaA3agk1b18Z
        mALGUKgnJGLSdnvV0M4WmM10b9ST+fyvDNpdC1wdn/7NGajsUmp1oh+pgjR4gomwgUuCEg+AMyD
        ovY4OW+7osC2MCMBU+OyyuY7k
X-Received: by 2002:a17:907:2daa:: with SMTP id gt42mr35225567ejc.4.1635761554819;
        Mon, 01 Nov 2021 03:12:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSx1/8yRpS7f665nZNMl+PFxsb9G23WIxxDQGBGDODAKIOXvnCF8WJsXd07ySvfagNJ8aPqA==
X-Received: by 2002:a17:907:2daa:: with SMTP id gt42mr35225544ejc.4.1635761554604;
        Mon, 01 Nov 2021 03:12:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dk5sm768922edb.20.2021.11.01.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:12:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/8] KVM: x86: Shove vp_bitmap handling down into
 sparse_set_to_vcpu_mask()
In-Reply-To: <20211030000800.3065132-7-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-7-seanjc@google.com>
Date:   Mon, 01 Nov 2021 11:12:32 +0100
Message-ID: <871r40kwvj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Move the vp_bitmap "allocation" that's needed to handle mismatched vp_index
> values down into sparse_set_to_vcpu_mask() and drop __always_inline from
> said helper.  The need for an intermediate vp_bitmap is a detail that's
> specific to the sparse translation with mismatched VP<=>vCPU indexes and
> does not need to be exposed to the caller.
>
> Regarding the __always_inline, prior to commit f21dd494506a ("KVM: x86:
> hyperv: optimize sparse VP set processing") the helper, then named
> hv_vcpu_in_sparse_set(), was a tiny bit of code that effectively boiled
> down to a handful of bit ops.  The __always_inline was understandable, if
> not justifiable.  Since the aforementioned change, sparse_set_to_vcpu_mask()
> is a chunky 350-450+ bytes of code without KASAN=y, and balloons to 1100+
> with KASAN=y.  In other words, it has no business being forcefully inlined.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 65 +++++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 8832727d74d9..3d83d6a5d337 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1710,31 +1710,46 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
>  		return kvm_hv_get_msr(vcpu, msr, pdata, host);
>  }
>  
> -static __always_inline unsigned long *sparse_set_to_vcpu_mask(
> -	struct kvm *kvm, u64 *sparse_banks, u64 valid_bank_mask,
> -	u64 *vp_bitmap, unsigned long *vcpu_bitmap)
> +static void sparse_set_to_vcpu_mask(struct kvm *kvm, u64 *sparse_banks,
> +				    u64 valid_bank_mask, unsigned long *vcpu_mask)
>  {
>  	struct kvm_hv *hv = to_kvm_hv(kvm);
> +	bool has_mismatch = atomic_read(&hv->num_mismatched_vp_indexes);
> +	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>  	struct kvm_vcpu *vcpu;
>  	int i, bank, sbank = 0;
> +	u64 *bitmap;
>  
> -	memset(vp_bitmap, 0,
> -	       KVM_HV_MAX_SPARSE_VCPU_SET_BITS * sizeof(*vp_bitmap));
> +	BUILD_BUG_ON(sizeof(vp_bitmap) >
> +		     sizeof(*vcpu_mask) * BITS_TO_LONGS(KVM_MAX_VCPUS));
> +
> +	/*
> +	 * If vp_index == vcpu_idx for all vCPUs, fill vcpu_mask directly, else
> +	 * fill a temporary buffer and manually test each vCPU's VP index.
> +	 */
> +	if (likely(!has_mismatch))
> +		bitmap = (u64 *)vcpu_mask;
> +	else
> +		bitmap = vp_bitmap;
> +
> +	/*
> +	 * Each set of 64 VPs is packed into sparse_banks, with valid_bank_amsk

'valid_bank_mask'

> +	 * having a '1' for each bank that exits in sparse_banks.  Sets must be

'exists'

> +	 * in ascending order, i.e. bank0..bankN.
> +	 */
> +	memset(bitmap, 0, sizeof(vp_bitmap));
>  	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
>  			 KVM_HV_MAX_SPARSE_VCPU_SET_BITS)
> -		vp_bitmap[bank] = sparse_banks[sbank++];
> +		bitmap[bank] = sparse_banks[sbank++];
>  
> -	if (likely(!atomic_read(&hv->num_mismatched_vp_indexes))) {
> -		/* for all vcpus vp_index == vcpu_idx */
> -		return (unsigned long *)vp_bitmap;
> -	}
> +	if (likely(!has_mismatch))
> +		return;
>  
> -	bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
> +	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (test_bit(kvm_hv_get_vpindex(vcpu), (unsigned long *)vp_bitmap))
> -			__set_bit(i, vcpu_bitmap);
> +			__set_bit(i, vcpu_mask);
>  	}
> -	return vcpu_bitmap;
>  }
>  
>  struct kvm_hv_hcall {
> @@ -1771,9 +1786,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	struct kvm *kvm = vcpu->kvm;
>  	struct hv_tlb_flush_ex flush_ex;
>  	struct hv_tlb_flush flush;
> -	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
> -	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
> -	unsigned long *vcpu_mask;
> +	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>  	u64 valid_bank_mask;
>  	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>  	bool all_cpus;
> @@ -1858,11 +1871,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	if (all_cpus) {
>  		kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH_GUEST);
>  	} else {
> -		vcpu_mask = sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
> -						    vp_bitmap, vcpu_bitmap);
> +		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>  
> -		kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST,
> -					    vcpu_mask);
> +		kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST, vcpu_mask);
>  	}
>  
>  ret_success:
> @@ -1895,9 +1906,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	struct kvm *kvm = vcpu->kvm;
>  	struct hv_send_ipi_ex send_ipi_ex;
>  	struct hv_send_ipi send_ipi;
> -	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
> -	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
> -	unsigned long *vcpu_mask;
> +	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>  	unsigned long valid_bank_mask;
>  	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>  	u32 vector;
> @@ -1953,11 +1962,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
>  		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  
> -	vcpu_mask = all_cpus ? NULL :
> -		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
> -					vp_bitmap, vcpu_bitmap);
> +	if (all_cpus) {
> +		kvm_send_ipi_to_many(kvm, vector, NULL);
> +	} else {
> +		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>  
> -	kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
> +		kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
> +	}
>  
>  ret_success:
>  	return HV_STATUS_SUCCESS;

With the nitpicks above addressed,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

