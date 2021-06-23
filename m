Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6A3B22CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 17:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFWVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624485178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACXvqcTUp2VEtZUNNrQgxrgIuroJ2VQXJ3O6aUtKlgU=;
        b=F78Cc5VZFou942qSWQvfm56iJ0y/fczdYwBSR8nONCzv3+F1/rwadmqCXhGtWLkRygk1wf
        wUKOcrrlE9PGDynKh1F23pcC8sq+z7LN0PdJL8mzWu+wABoE6Fz9IzxpNDEOPAkutBSaV2
        nrPuor9ybZCGmDOEo2Z03jS4CbHfyms=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-0Ir9RWMSMcyvAkXN8Qmw0w-1; Wed, 23 Jun 2021 17:52:56 -0400
X-MC-Unique: 0Ir9RWMSMcyvAkXN8Qmw0w-1
Received: by mail-ed1-f69.google.com with SMTP id g13-20020a056402090db02903935a4cb74fso2095977edz.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ACXvqcTUp2VEtZUNNrQgxrgIuroJ2VQXJ3O6aUtKlgU=;
        b=ar5QjYxNByKLMk0quGmpa4V7+1zIYPEQFOcGm2eLttbpOpXmbCLVOz7TBZYDG60cll
         F+Z49yzNc6PZ4W8qWTZ7a7mUNu4Q963kTVm4ImNk0V81hfRcM2BNeAITjdkKCFCAOg2F
         mdSOQEpOrFxEmKwtKA+LTGnkxUrDRelAVJhbWCmtuwCq0rmQ5nunyp35eyXfKHikXJQm
         n0VYygFRvGMDf9YIFx+4Lj+SGBTPmKSdYJf8UQga4vlCisukZS/LimdTbL+0bkAn3qjP
         D0Je9txg7z2PoIia3MllVkz7sL7xLYzFQl/4ym7szu9xFX7bbtYwKlyDaJBfCUeZdJ32
         +O7A==
X-Gm-Message-State: AOAM532I7FkEHgAq01HsOQPUAkx110Bev1yNMvCX1Iq+uMZ7LmwLop40
        NHG5MDuNO+FqXuhiJChdugqXnpZuz832IXGeiElJKpEY6NK9Win7oYKe4rXeCj4n//SpSNiodJc
        pixgKf+n2pCcH0ups1ALZWgwN
X-Received: by 2002:a05:6402:1510:: with SMTP id f16mr2429314edw.377.1624485175447;
        Wed, 23 Jun 2021 14:52:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhxr240/C1q6g952wJj7Uq9npWIdFVmvprVIKXPcuEUAEomJqmW+y8uav6RIN3m1STWgJQnw==
X-Received: by 2002:a05:6402:1510:: with SMTP id f16mr2429299edw.377.1624485175324;
        Wed, 23 Jun 2021 14:52:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d22sm391752ejj.47.2021.06.23.14.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 14:52:54 -0700 (PDT)
Subject: Re: [PATCH 06/10] KVM: SVM: tweak warning about enabled AVIC on
 nested entry
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>
References: <20210623113002.111448-1-mlevitsk@redhat.com>
 <20210623113002.111448-7-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30c057c7-3c42-90cd-0beb-a4c7fdff39ea@redhat.com>
Date:   Wed, 23 Jun 2021 23:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623113002.111448-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 13:29, Maxim Levitsky wrote:
> It is possible that AVIC was requested to be disabled but
> not yet disabled, e.g if the nested entry is done right
> after svm_vcpu_after_set_cpuid.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index dca20f949b63..253847f7d9aa 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -505,7 +505,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>   	 * Also covers avic_vapic_bar, avic_backing_page, avic_logical_id,
>   	 * avic_physical_id.
>   	 */
> -	WARN_ON(svm->vmcb01.ptr->control.int_ctl & AVIC_ENABLE_MASK);
> +	WARN_ON(kvm_apicv_activated(svm->vcpu.kvm));
>   
>   	/* Copied from vmcb01.  msrpm_base can be overwritten later.  */
>   	svm->vmcb->control.nested_ctl = svm->vmcb01.ptr->control.nested_ctl;
> 

Queued, thanks.

Paolo

