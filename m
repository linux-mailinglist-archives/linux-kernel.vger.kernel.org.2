Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81C367EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhDVKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235954AbhDVKg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619087780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK5U5dXbkwFpCBp/gShcg1bhC7LrD77rsahqB3DzIno=;
        b=bwZW2N4t1mpZ+3aWLH8nZB6nSRFOVLc7AoiE1ER/gBysLJtu2yomuvMV5kXijnMZkEwyD0
        dLNrWK6Ue4sjHVwdgxJwBTiA56Wny+A4oJ9xu8y3qoL+2h4Z+ep68tuIpLbXuB1StVmxuh
        qJPF9b5IDixQbGCNGhGIubpgCdnJxXI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-9buY9gRMNTyvmukKE0B6Kw-1; Thu, 22 Apr 2021 06:36:01 -0400
X-MC-Unique: 9buY9gRMNTyvmukKE0B6Kw-1
Received: by mail-ej1-f71.google.com with SMTP id jl27-20020a17090775dbb029037ccdce96e6so7001256ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zK5U5dXbkwFpCBp/gShcg1bhC7LrD77rsahqB3DzIno=;
        b=JFSqqgzLkWrSFii4Xr3fzhPbrUwHqdqp5C7DtqTaG6NegHDejWJMtS6f2by3lqXFZj
         DSEt/eMQS9DdHAKq6+jvQv9Yph/01Uqy4igIddWoWUyhwqo/0aI4TtwzP7TqjmSGYUje
         vTwiO5GR9YjQrUXDVQd6uM6kIQ5ZdfFWI2lqr8x1Atu64IuCOUOKfyZ+WP0Dg+F5Mjb9
         OFIHZIY6I9XCRcRvDf7yJV7KdDsSjfUkXOZyx2EusbyP75aG3Ky1SHHgGeeDAPe4gJVj
         ek0OzBWC36kjdOTmk+En4UljTnjPUsrS8vLh0EpztTuQkaoexTuPAicFJ3vW2i31YxkA
         x7Hg==
X-Gm-Message-State: AOAM5303BjVQF/YdQ0GTUHUATtfuTBz0aucfZYVGIwmeo2IX17dWYdm6
        1zWq7QewSpL1/Qkllt96/0tJIfMJF77kZSOnWLvBWTcbRXgnLso+IVBBoyMoqi6BfpdFbibnVVZ
        FxVLz8Hghnxa5engUYSKz0m0E
X-Received: by 2002:a17:906:b34e:: with SMTP id cd14mr2717444ejb.369.1619087759945;
        Thu, 22 Apr 2021 03:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzou7r7WMcBgmw1y5sWFhuuzWkBuhHTkKys162oeyQepu9tDCQYqJXtGttfHiRf4cDHlu+4gA==
X-Received: by 2002:a17:906:b34e:: with SMTP id cd14mr2717425ejb.369.1619087759781;
        Thu, 22 Apr 2021 03:35:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f19sm1768437edu.12.2021.04.22.03.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:35:59 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Take advantage of
 kvm_arch_dy_has_pending_interrupt()
To:     lihaiwei.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org,
        Haiwei Li <lihaiwei@tencent.com>
References: <20210421032513.1921-1-lihaiwei.kernel@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c1c0771-5ff7-03e9-53e3-ee7b2cfe63a6@redhat.com>
Date:   Thu, 22 Apr 2021 12:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210421032513.1921-1-lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/21 05:25, lihaiwei.kernel@gmail.com wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> `kvm_arch_dy_runnable` checks the pending_interrupt as the code in
> `kvm_arch_dy_has_pending_interrupt`. So take advantage of it.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>   arch/x86/kvm/x86.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d696a9f..08bd616 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11125,28 +11125,25 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
>   	return kvm_vcpu_running(vcpu) || kvm_vcpu_has_events(vcpu);
>   }
>   
> -bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
> +bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
>   {
> -	if (READ_ONCE(vcpu->arch.pv.pv_unhalted))
> -		return true;
> -
> -	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
> -		kvm_test_request(KVM_REQ_SMI, vcpu) ||
> -		 kvm_test_request(KVM_REQ_EVENT, vcpu))
> -		return true;
> -
>   	if (vcpu->arch.apicv_active && static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
>   		return true;
>   
>   	return false;
>   }
>   
> -bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
> +bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
>   {
> -	if (vcpu->arch.apicv_active && static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
> +	if (READ_ONCE(vcpu->arch.pv.pv_unhalted))
>   		return true;
>   
> -	return false;
> +	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
> +		kvm_test_request(KVM_REQ_SMI, vcpu) ||
> +		 kvm_test_request(KVM_REQ_EVENT, vcpu))
> +		return true;
> +
> +	return kvm_arch_dy_has_pending_interrupt(vcpu);
>   }
>   
>   bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
> 

Looks good, but I'd like to take a look at the other patches for 
directed yield first.  Thanks!

Paolo

