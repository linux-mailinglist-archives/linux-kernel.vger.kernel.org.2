Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428283D682D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGZTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232169AbhGZTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627331608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5y5iIzB/XJicNUoEyIMufLhZEfNA3WcOGOUF/t0F00=;
        b=V+iyJ5SaDeUDapxOoPwagjDE4bRkaTWCvWP75r+8WlSbOwHORnPq1vw2hZ1dg/PN/FSu84
        u7iR7WSH3v0DEP3wjA2E0Dpu7fBYJTt1vJJ9uwAsKvxr/36V7d33+5AYO79gOSSoYzNw8J
        wcse8I5SXuOWEH3Pu+Qoq5o0F9+scfU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-ErDqaiRZPBSzARwGbi6U6w-1; Mon, 26 Jul 2021 16:33:25 -0400
X-MC-Unique: ErDqaiRZPBSzARwGbi6U6w-1
Received: by mail-ed1-f71.google.com with SMTP id n10-20020a05640206cab02903a4b3e93e15so5328402edy.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5y5iIzB/XJicNUoEyIMufLhZEfNA3WcOGOUF/t0F00=;
        b=PnFpC/AsHEZNhmuXJo1RrnyfG29+LiSlNjkOcUPtyF4Z/lUQnD4JgVV++H+Uashx8p
         uloynOPh2z+qHoMipkUKSeRidTj47CRTaBQCxvFRXZRBfnJEF6eDnXXeYZEs+5tgroAJ
         p5n6MZ/TUwv/zfM7k7D7cfSsa1WpC4BkpVV86Xksfbac5W2AjK87UHtle9F0muUpDzQA
         Fa5uSIOnRoe5INhYdkRZgQoZD3900Y5U9Kzh5LZfUXy1mplFAxeJRqOvSPn3++VWGmpJ
         soA6LJcV9LBXw9WBD0CPwaOt7vEPMaTistUYwMQKv51SbB82mmNYgNyKrg3dB5ss/7by
         U+Ww==
X-Gm-Message-State: AOAM533JAaHDURRjrKATYZLRWzTD/gzF/vQ9Lzo4ExXpcrg27nXmlasq
        7B2YTrjMEJ2+Q7fNJ1sOj2pylsOy6KKnoeFT477sDOLG05JozKRDVCDwCcx5mF8Bm+X0YsdZ4pT
        sUyC4NXvwQy8Zp09fBU0xAXag
X-Received: by 2002:a17:906:4d94:: with SMTP id s20mr7661763eju.152.1627331604739;
        Mon, 26 Jul 2021 13:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/CjjMGAATqLBcCyBccrOgLostjm2vjSWe8JNBhnSnyDpdYSlfsbMLLLeEN00kYPzHYJ4QZA==
X-Received: by 2002:a17:906:4d94:: with SMTP id s20mr7661753eju.152.1627331604595;
        Mon, 26 Jul 2021 13:33:24 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id e7sm212218ejt.80.2021.07.26.13.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 13:33:23 -0700 (PDT)
Subject: Re: [PATCH v2 09/46] KVM: SVM: Drop a redundant init_vmcb() from
 svm_create_vcpu()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210713163324.627647-1-seanjc@google.com>
 <20210713163324.627647-10-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77b78927-77ca-39b8-8882-458fc3ec9ba8@redhat.com>
Date:   Mon, 26 Jul 2021 22:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713163324.627647-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/21 18:32, Sean Christopherson wrote:
> Drop an extra init_vmcb() from svm_create_vcpu(), svm_vcpu_reset() is
> guaranteed to call init_vmcb() and there are no consumers of the VMCB
> data between ->vcpu_create() and ->vcpu_reset().  Keep the call to
> svm_switch_vmcb() as sev_es_create_vcpu() touches the current VMCB, but
> hoist it up a few lines to associate the switch with the allocation of
> vmcb01.
> 
> Reviewed-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 44248548be7d..cef9520fe77f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1431,15 +1431,13 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>   
>   	svm->vmcb01.ptr = page_address(vmcb01_page);
>   	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
> +	svm_switch_vmcb(svm, &svm->vmcb01);
>   
>   	if (vmsa_page)
>   		svm->vmsa = page_address(vmsa_page);
>   
>   	svm->guest_state_loaded = false;
>   
> -	svm_switch_vmcb(svm, &svm->vmcb01);
> -	init_vmcb(vcpu);
> -
>   	svm_init_osvw(vcpu);
>   	vcpu->arch.microcode_version = 0x01000065;

While this patch makes sense, I'd rather not include it to reduce the 
part of the code in which svm->vmcb is NULL.   See for example the issue 
reported by the static analyzer in which 
svm_hv_vmcb_dirty_nested_enlightenments (called by svm_vcpu_init_msrpm) 
dereferences svm->vmcb.

Paolo

