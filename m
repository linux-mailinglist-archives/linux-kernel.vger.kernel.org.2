Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FBB351EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbhDASvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236572AbhDASca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617301946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtDBz7ykDKRMTtDTrLTSXxwTFQJuBtQJjv1Xfg77ytQ=;
        b=PWI3ffGtTOJDJBl5AAj3AsGjYH/QQcwSyydmi59VnMvg0vCXWfP45omRQLEMpHPD/wiA96
        BINv19ZMzF7dmEV9ZD4yya/M3VbG//hlYUGIKYNUNyUIOW5e04Vh9yPclqu32GtdxE0DfK
        WXiTSFT5tal1M/O29ZKhahDbDv/KC0c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-esezSe7VNRq9Ss-fvpkYnA-1; Thu, 01 Apr 2021 10:31:42 -0400
X-MC-Unique: esezSe7VNRq9Ss-fvpkYnA-1
Received: by mail-ej1-f71.google.com with SMTP id k16so2295488ejg.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 07:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtDBz7ykDKRMTtDTrLTSXxwTFQJuBtQJjv1Xfg77ytQ=;
        b=uXxXYTe1dJt42xlqTPIbVehag/RV24GjEB8i1ZHU6PwB75+DwkyiUO3vct/OB4a9Q/
         rmnneueslwyZ+Ofj/T1xqnX8o3lPjVhet22MVh/DJwF2+MuEabgZkQcn/uSQI+52H4f/
         vo1xg3CR71LRhtJFacJ1gc4Faq+1QWQI3jR3Na9/jDkBI1jRSh2aGEHY80hywK07v0zb
         m9mF1HUiJDzV4yQxdulDHznFgDQCppGhiH4mOa4T1fDiwbrF7LdG5tdEoybCTNg3Zi7m
         mlBLg1UuJeaQ1SLTdSdEktwmRfyJs7QmrNOHkFyeSM2Ywje+cfvSLZEKMZNFxW8cyz2d
         nrjg==
X-Gm-Message-State: AOAM532WEjpeJ1FKJJRJgHTziRsE7BTg8wqExPICOOL4MuMjK+wQDijv
        +8gVzWOaiiELpq18B/Pg9waEZ5S4vZNOzxWHuPS0zNoSJgyg6Bu/UBJGyL9GyfZIjWaZfGBlps6
        YhnMnFCjwSXX+N2ppGKkPP5ci
X-Received: by 2002:a50:fe08:: with SMTP id f8mr10085898edt.217.1617287501388;
        Thu, 01 Apr 2021 07:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrkplglsUx4FWy5ZDzoNBFaTl9LRJrAQoJMJg7M+SOTlXx6lpwIPeSi7qSlRenq6FjNWqKjg==
X-Received: by 2002:a50:fe08:: with SMTP id f8mr10085877edt.217.1617287501236;
        Thu, 01 Apr 2021 07:31:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nd36sm2840882ejc.21.2021.04.01.07.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 07:31:40 -0700 (PDT)
Subject: Re: [PATCH 3/6] KVM: x86: introduce kvm_register_clear_available
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20210401141814.1029036-1-mlevitsk@redhat.com>
 <20210401141814.1029036-4-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75dc7aba-fc9e-8217-e120-9c6ef3a601c8@redhat.com>
Date:   Thu, 1 Apr 2021 16:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401141814.1029036-4-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 16:18, Maxim Levitsky wrote:
> Small refactoring that will be used in the next patch.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/kvm_cache_regs.h | 7 +++++++
>   arch/x86/kvm/svm/svm.c        | 6 ++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 2e11da2f5621..07d607947805 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -55,6 +55,13 @@ static inline void kvm_register_mark_available(struct kvm_vcpu *vcpu,
>   	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
>   }
>   
> +static inline void kvm_register_clear_available(struct kvm_vcpu *vcpu,
> +					       enum kvm_reg reg)
> +{
> +	__clear_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
> +	__clear_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
> +}
> +
>   static inline void kvm_register_mark_dirty(struct kvm_vcpu *vcpu,
>   					   enum kvm_reg reg)
>   {
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 271196400495..2843732299a2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3880,10 +3880,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   		vcpu->arch.apf.host_apf_flags =
>   			kvm_read_and_reset_apf_flags();
>   
> -	if (npt_enabled) {
> -		vcpu->arch.regs_avail &= ~(1 << VCPU_EXREG_PDPTR);
> -		vcpu->arch.regs_dirty &= ~(1 << VCPU_EXREG_PDPTR);
> -	}
> +	if (npt_enabled)
> +		kvm_register_clear_available(vcpu, VCPU_EXREG_PDPTR);
>   
>   	/*
>   	 * We need to handle MC intercepts here before the vcpu has a chance to
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

