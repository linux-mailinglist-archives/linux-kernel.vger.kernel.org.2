Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E33E8099
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhHJRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235701AbhHJRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628617662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKwZewLNwIKw9eTm9yw5mCeEiy999huF3GYCsztRI6w=;
        b=aScngYrW3uIQlgyW1uohcOP03MeK8wREY44wxNrm13zzVH0iyz7Gqwu74ThqRdPRMlYnVB
        xceG7usPYhoPCSNq4LMQt6dqZO91VgarcDg5O0+SXY3bk5ENO/HWjGJ192/g+TryK02rkZ
        NKr/2McC9tBNqGeGEF/fx+W+RBWvVCM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-8Mnv2OenOAyQzPfvb5t74A-1; Tue, 10 Aug 2021 13:47:41 -0400
X-MC-Unique: 8Mnv2OenOAyQzPfvb5t74A-1
Received: by mail-ej1-f72.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso5925198ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKwZewLNwIKw9eTm9yw5mCeEiy999huF3GYCsztRI6w=;
        b=YICK8byAhFguA0A/5+uATE3Hhg7RUCagBMu2sgQCfBACzlOmdwPqvoRUB1nkpRcT0D
         cEGtn2Ud+Zs9+zrjjmqdPObfM3Dw8MGMEGnoldjNQzCL8N831cfk7jNIBrrfDniAg2w3
         EOa5LWmMhsgkle7X8HRGx/8WDIZBPBBsXyqq63abKXeFXuqyFUPzTT1inC1vWg25bPw+
         VOAMdfgnLOo0U8wH190HjlzSVSDkEfPjN9wBd3FsFGOMvxtOhcu+1ukQgTdGP9Gxsk4w
         vGPY6L1lH2vOIiJ4rJHd7yaGKQpGH9jS38bZT9dL/reryTyQT16n6syMFRVUgZQc7Cce
         ASng==
X-Gm-Message-State: AOAM532DrOOfY54oCEHYZOfyEIHgQ12KWDApjv6x67eZJBRkljX7kugh
        yvOOJZtxidCoLEpYrfFY2/gSM+CNaydleu64kcOi6efo007sz/rbcSvv/4oSYe26xDb2gCQljbA
        0Ejv5vR4qM4FIBncB/ffqPlnThqRjnhkmhdwm2k9WGxirVSDD0mS5+i7RaibSAy7jN8IjAGmeH9
        BM
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr6456937edb.40.1628617659951;
        Tue, 10 Aug 2021 10:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+ES4XSZWUizraO18WCMcWHJOOU0rhg3kEBHAyUa+hl1Ftwln9z4N1I5esSDtKj6taDpZdMQ==
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr6456908edb.40.1628617659705;
        Tue, 10 Aug 2021 10:47:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id n13sm7133872ejk.97.2021.08.10.10.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 10:47:38 -0700 (PDT)
Subject: Re: [PATCH 2/5] KVM: x86: Clean up redundant CC macro definition
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210809093410.59304-1-likexu@tencent.com>
 <20210809093410.59304-3-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26603f6e-f215-af19-1cf3-2e0022c20750@redhat.com>
Date:   Tue, 10 Aug 2021 19:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809093410.59304-3-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/21 11:34, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> With the exception of drivers/dma/pl330.c, the CC macro is defined and used
> in {svm, vmx}/nested.c, and the KVM_NESTED_VMENTER_CONSISTENCY_CHECK
> macro it refers to is defined in x86.h, so it's safe to move it into x86.h
> without intended functional changes.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>

This one is just a shortcut that should not available outside nested.c, 
so I am not applying it.

Paolo

> ---
>   arch/x86/kvm/svm/nested.c | 2 --
>   arch/x86/kvm/vmx/nested.c | 2 --
>   arch/x86/kvm/x86.h        | 2 ++
>   3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 5e13357da21e..57c288ba6ef0 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -29,8 +29,6 @@
>   #include "lapic.h"
>   #include "svm.h"
>   
> -#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
> -
>   static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>   				       struct x86_exception *fault)
>   {
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0d0dd6580cfd..404db7c854d2 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -22,8 +22,6 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
>   static bool __read_mostly nested_early_check = 0;
>   module_param(nested_early_check, bool, S_IRUGO);
>   
> -#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
> -
>   /*
>    * Hyper-V requires all of these, so mark them as supported even though
>    * they are just treated the same as all-context.
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 6aac4a901b65..b8a024b0f91c 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -67,6 +67,8 @@ static __always_inline void kvm_guest_exit_irqoff(void)
>   	failed;								\
>   })
>   
> +#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
> +
>   #define KVM_DEFAULT_PLE_GAP		128
>   #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
>   #define KVM_DEFAULT_PLE_WINDOW_GROW	2
> 

