Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60644B050
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhKIP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235782AbhKIP2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636471564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wxou4MKPQ1jK4eND4O3g/qSLs6HMqmw3NMGLlftk3PU=;
        b=SWV4XQ/kGsOGXwn6gIGzAGe0mFt+4XaNI1rpvt96M9zmz/6pPv6LHzW3sK7I/6PTlpp4SF
        sDBRPnmjGk5fTOu2LeeshVKBBlx0cMNaM+1DgVaszrCIQgPD+pdvik9ccU++ZZhDAvqEai
        ZzreDWIy2WN7GnEmq2OkRLzV/xst7/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-9otYH0EbOFKVp74JnomnIg-1; Tue, 09 Nov 2021 10:26:03 -0500
X-MC-Unique: 9otYH0EbOFKVp74JnomnIg-1
Received: by mail-wm1-f71.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso1529515wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wxou4MKPQ1jK4eND4O3g/qSLs6HMqmw3NMGLlftk3PU=;
        b=4oOypwyZtXa4XlZNWGSOlbBzJ/pJ3iLs0wCVUsQ7CrEyT+9tGeUUq5TIA8edSpuplt
         7RjDdLDn3tJrxAAoPVNqE8NwwkpGnio2eFukfCPnNybh/F8csrklXonjZUEF1d1/gvL5
         5l5KMzUkt6rb8xvtKncyCFpNkgEgDAwYG36lUVTvWYGN/JK/ILwL+wZe5Gaz/20UCKt7
         OM0t6+poN6lQoftpZILoVvag4kzE3bm0nNe1dafNgv++m7vo8lq8Y1PcPJTwu3PvmyfL
         BCSfuMM502tqDykUA3z8Mr8O37faxgDmfE8JMZxFNNJELWmT5FmYBb3wixFLDVWVvmJ3
         LNNA==
X-Gm-Message-State: AOAM532+MqEWu86+ouHMk3gm90jwCXOsjy9RERVT+tYH0/TsAB8qy0/o
        9oPlpNg6h0l47Siwko2QtqgTkJcFnt/oA+u1iF/Ur/8lXCvOOVUGuKvNfLuuA/Zg4EbfgKHxXsg
        4JI81o0GHcphw0mpa0a6gT4eg
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr7949006wmk.195.1636471562547;
        Tue, 09 Nov 2021 07:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBnpOsut7rKZlaSBPduXJ5xAffRhNOu1HUeYRQRdK/um4HGi+o+P1Cz2Qt1sVLYNWJ5qGPUA==
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr7948982wmk.195.1636471562339;
        Tue, 09 Nov 2021 07:26:02 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u6sm2826590wmc.29.2021.11.09.07.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:26:01 -0800 (PST)
Subject: Re: [PATCH v4 01/21] KVM: arm64: Introduce template for inline
 functions
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-2-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <5112b3ba-d038-f622-c67f-e53695cbef37@redhat.com>
Date:   Tue, 9 Nov 2021 16:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> The inline functions used to get the SMCCC parameters have same
> layout. It means these functions can be presented by a template,
> to make the code simplified. Besides, this adds more similar inline
> functions like smccc_get_arg{4,5,6,7,8}() to visit more SMCCC arguments,
> which are needed by SDEI virtualization support.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/kvm/arm_hypercalls.h | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> index 0e2509d27910..ebecb6c68254 100644
> --- a/include/kvm/arm_hypercalls.h
> +++ b/include/kvm/arm_hypercalls.h
> @@ -6,27 +6,21 @@
>  
>  #include <asm/kvm_emulate.h>
>  
> -int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
> -
> -static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 0);
> +#define SMCCC_DECLARE_GET_FUNC(type, name, reg)			\
> +static inline type smccc_get_##name(struct kvm_vcpu *vcpu)	\
> +{								\
> +	return vcpu_get_reg(vcpu, reg);				\
>  }
>  
> -static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 1);
> -}
> -
> -static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 2);
> -}
> -
> -static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 3);
> -}
> +SMCCC_DECLARE_GET_FUNC(u32,           function, 0)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg1,     1)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg2,     2)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg3,     3)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg4,     4)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg5,     5)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg6,     6)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg7,     7)
> +SMCCC_DECLARE_GET_FUNC(unsigned long, arg8,     8)
I think I would keep smccc_get_function() and add macros to get the
64-bit args. SMCCC_DECLARE_GET_FUNC is an odd macro name for a function
fetching an arg. I would suggest:

> +#define SMCCC_DECLARE_GET_ARG(reg)			\
> +static inline unsigned long smccc_get_arg##reg(struct kvm_vcpu *vcpu)	\
> +{								\
> +	return vcpu_get_reg(vcpu, reg);				\
>  }
>  
>  static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
>  				    unsigned long a0,
> @@ -40,4 +34,6 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
>  	vcpu_set_reg(vcpu, 3, a3);
>  }
>  
> +int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
> +
spurious change?
>  #endif
> 
Thanks

Eric

