Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA03DE91C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhHCJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234923AbhHCJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627981242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5GiUuBXx0CQkWfuXH9WxdMt4qULo7mS7FfWvbsbH9g=;
        b=aWKAWRAWb9egAjM1uoH1oP50Df219pbDR0MDCZuq9WgNBCNmuGhr2g9Nl3RgbF9Wi5FLq0
        AvX8fpUpAPzKsEs0tfoz+0SC/vtCExeuen8iSgjR4OybB1oMDEDc457g1606l44xUi9rVM
        61w5ULbmTTysLaDzBKUTxkabZ2CyjxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-kiHGdjt3Py-k6cNQXwtvpA-1; Tue, 03 Aug 2021 05:00:41 -0400
X-MC-Unique: kiHGdjt3Py-k6cNQXwtvpA-1
Received: by mail-wm1-f69.google.com with SMTP id f25-20020a1c6a190000b029024fa863f6b0so711290wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J5GiUuBXx0CQkWfuXH9WxdMt4qULo7mS7FfWvbsbH9g=;
        b=VhU6FcH61ze6BFtr4kvCIh2azA97BGsJsw0UCUhy5+jZTpmx1P6Ng+XwZL0uLDcDJB
         IUP+RILvh2A8gRxhg0lYmcbOq5TeITTaYT5ERI+7R7eFG+DeDPE5q/2J4jTKxsaOOag6
         jpBrSeWyJQ7STzvv4SyloT65/KrEyog+x5IR2TCROgUhSPo51bmKa1T0EExdQPSQn+yD
         QYbtAXeBZjA+XxpOE28+zGnhl+WIL2EV3Aq0FgXhlRF9doMKZBx0XDhS0p5h2jCY9O3L
         nS5kGVqvH61XBs4wy+zWeHN17LQAKSa7IH8cc/WQ077o7B1T2y0r5RIg7G3BU7/44z57
         OgCw==
X-Gm-Message-State: AOAM531EutdK0xFQOrC9ke+WF6O6qfOYI1yZ3nn6PCbDJnHYQ6t5Wjol
        AKpN4iZoW4TzdAMglhDpPt8ZIUAMj934/EjwbchQKt1eGakN8ru7w5W4/vBvD7f+QpH4wpFXxLz
        P7aw4MHSF3LWv3R55xR6i60t3
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr20103551wmg.173.1627981239956;
        Tue, 03 Aug 2021 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3tH7DXSsZEBeUSVL0Mr1gUa5SsOFdICr6lyHiB0qfX8afYVTunf9p5Gp8OfU/p1q4ICvrmw==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr20103538wmg.173.1627981239783;
        Tue, 03 Aug 2021 02:00:39 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id p5sm15594439wrd.25.2021.08.03.02.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 02:00:39 -0700 (PDT)
Subject: Re: [PATCH v3 04/12] KVM: x86/mmu: allow kvm_faultin_pfn to return
 page fault handling code
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210802183329.2309921-1-mlevitsk@redhat.com>
 <20210802183329.2309921-5-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41fa83df-c450-b3ff-24cd-9993f8df9b27@redhat.com>
Date:   Tue, 3 Aug 2021 11:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802183329.2309921-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/21 20:33, Maxim Levitsky wrote:
> This will allow it to return RET_PF_EMULATE for APIC mmio
> emulation.
> 
> This code is based on a patch from Sean Christopherson:
> https://lkml.org/lkml/2021/7/19/2970
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/mmu/mmu.c         | 17 ++++++++++-------
>   arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
>   2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c5e0ecf5f758..6f77f6efd43c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3844,7 +3844,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>   
>   static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, hva_t *hva,
> -			 bool write, bool *writable)
> +			 bool write, bool *writable, int *r)
>   {
>   	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
>   	bool async;
> @@ -3855,7 +3855,7 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   	 * be zapped before KVM inserts a new MMIO SPTE for the gfn.
>   	 */
>   	if (slot && (slot->flags & KVM_MEMSLOT_INVALID))
> -		return true;
> +		goto out_retry;
>   
>   	/* Don't expose private memslots to L2. */
>   	if (is_guest_mode(vcpu) && !kvm_is_visible_memslot(slot)) {
> @@ -3875,14 +3875,17 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   		if (kvm_find_async_pf_gfn(vcpu, gfn)) {
>   			trace_kvm_async_pf_doublefault(cr2_or_gpa, gfn);
>   			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
> -			return true;
> +			goto out_retry;
>   		} else if (kvm_arch_setup_async_pf(vcpu, cr2_or_gpa, gfn))
> -			return true;
> +			goto out_retry;
>   	}
>   
>   	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
>   				    write, writable, hva);
> -	return false;
> +
> +out_retry:
> +	*r = RET_PF_RETRY;
> +	return true;
>   }
>   
>   static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> @@ -3913,8 +3916,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>   	smp_rmb();
>   
>   	if (kvm_faultin_pfn(vcpu, prefault, gfn, gpa, &pfn, &hva,
> -			 write, &map_writable))
> -		return RET_PF_RETRY;
> +			 write, &map_writable, &r))
> +		return r;
>   
>   	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
>   		return r;
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index f349eae69bf3..7d03e9b7ccfa 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -882,8 +882,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>   	smp_rmb();
>   
>   	if (kvm_faultin_pfn(vcpu, prefault, walker.gfn, addr, &pfn, &hva,
> -			 write_fault, &map_writable))
> -		return RET_PF_RETRY;
> +			 write_fault, &map_writable, &r))
> +		return r;
>   
>   	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
>   		return r;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

