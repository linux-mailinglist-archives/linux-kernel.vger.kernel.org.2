Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528741637C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhIWQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234744AbhIWQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zP+bWc/dUYs2mSzQjaFxDbmITT9MtxhTtHRPh17NjHA=;
        b=TPKDJjfuXIVRo5xU6AW7fuIajBJFi2faCg10z2m+v60OMBptEfjaDsQR2vTtNM7lfR9E7V
        Zs2FYzQrB68XKVWBH+qj3iDIi8MATyxYov5xO0PqQqxi15ov7+qIJX67wmJRsAG3DBSzI1
        yev4NtZXmH0iTTVKYkryxOXav/qbobQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-fRlILZotP5C0jC17iSc15g-1; Thu, 23 Sep 2021 12:40:59 -0400
X-MC-Unique: fRlILZotP5C0jC17iSc15g-1
Received: by mail-ed1-f71.google.com with SMTP id d1-20020a50f681000000b003d860fcf4ffso7259546edn.22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zP+bWc/dUYs2mSzQjaFxDbmITT9MtxhTtHRPh17NjHA=;
        b=30gMxQMuloOtncYjzyuxpFKRvNLT20zxCEbB+xDYi6sherrPkkASQLVCQb8L2aNnIX
         xmuruJkMDB/NvRSUgMlfIB+pmrXceBVx2P6h5elzBp6dJaiB2WX38aIONZxkS+38/IWs
         flobnLdmmWhJ0ImRr5x/oQ6qdYExRTsdDWyNb6QdqnUAa3tSjJu3Z3/lLh2xXhFHPNHG
         0fb+xl//AuQCy9ARNdQpCe/0oLJthRij0eYmsU3n85x/FHO3vNW36m0eD4eyCdd27eHY
         Acg3/BrLkHJ2NL7l8JOKlrTJCWPpi/IarCeaiZLnYaVqyzTVI81bYFufBteHaRBtYOta
         Kesg==
X-Gm-Message-State: AOAM530eqgYbCjoE7Rn5OY6iQVo5+Z8hmNb55abhkRa8y4gSN3Ik2L3E
        A5rrSOx2pz/NDVz7dX8lSLFqN7a3oFq7W5N6fDpxbZFCuOsdEkzq26p42F5i+7PaPFneLz13WnG
        +C0ZcX59sprjEAto7NTYZa/sy
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr6246847eji.261.1632415255515;
        Thu, 23 Sep 2021 09:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA3H1NEO39c84G7G9Gxn0iDSuQcLqjCEqbpf1IdiajRyX3HzH0gKAc7QxjqWRW/ttMCGcB5A==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr6246826eji.261.1632415255330;
        Thu, 23 Sep 2021 09:40:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id kx17sm3255053ejc.51.2021.09.23.09.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:40:54 -0700 (PDT)
Subject: Re: [PATCH 06/14] KVM: x86: SVM: don't set VMLOAD/VMSAVE intercepts
 on vCPU reset
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-7-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7289d070-152b-aece-1302-33e5a461657c@redhat.com>
Date:   Thu, 23 Sep 2021 18:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"),
> made init_vmcb set vmload/vmsave intercepts unconditionally,
> and relied on svm_vcpu_after_set_cpuid to clear them when possible.
> 
> However init_vmcb is also called when the vCPU is reset, and it is
> not followed by another call to svm_vcpu_after_set_cpuid because
> the CPUID is already set.
> 
> This mistake makes the VMSAVE/VMLOAD intercept to be set when
> it is not needed, and harms performance of the nested guest.
> 
> Fixes: adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD")
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6645542df9bd..861ac9f74331 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1199,8 +1199,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>   	svm_set_intercept(svm, INTERCEPT_SHUTDOWN);
>   	svm_set_intercept(svm, INTERCEPT_VMRUN);
>   	svm_set_intercept(svm, INTERCEPT_VMMCALL);
> -	svm_set_intercept(svm, INTERCEPT_VMLOAD);
> -	svm_set_intercept(svm, INTERCEPT_VMSAVE);
>   	svm_set_intercept(svm, INTERCEPT_STGI);
>   	svm_set_intercept(svm, INTERCEPT_CLGI);
>   	svm_set_intercept(svm, INTERCEPT_SKINIT);
> @@ -1377,6 +1375,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>   	svm->guest_state_loaded = false;
>   
>   	svm_switch_vmcb(svm, &svm->vmcb01);
> +
> +	svm_set_intercept(svm, INTERCEPT_VMLOAD);
> +	svm_set_intercept(svm, INTERCEPT_VMSAVE);
> +
>   	init_vmcb(vcpu);
>   
>   	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
> 

This needs to be redone after the latest refactoring of svm_vcpu_reset. 
  I'll send a patch myself.

Paolo

