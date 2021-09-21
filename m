Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F4413927
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhIURvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231797AbhIURvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Z2PolRqIGMr2xNU27IWiova+R5tE/K6n/IJmumOaXg=;
        b=M7YyGqyLK7/26i/ZKqHA1/k1ITsArMQ31g1w9PPDsrFN9IaDEEx2n0bEwnFPs9KKoPlYVO
        J8k3Ee41W6jv2gdo+VbeTYOVRnfiqjsHDvgzhqghZit5K17ne2+pjFD1dvlDIYAAhsll5b
        EXq1Dqyh1RJ/aTWRMD6WLuGdZqW8tN8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-JMGBiidaMB2nktCnOH7GIA-1; Tue, 21 Sep 2021 13:50:05 -0400
X-MC-Unique: JMGBiidaMB2nktCnOH7GIA-1
Received: by mail-ed1-f69.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so19783755edv.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Z2PolRqIGMr2xNU27IWiova+R5tE/K6n/IJmumOaXg=;
        b=zG9uByvkJhNIgeJJrNs2TWhrrbw/zOf8FSHolNAUMn/LzblvdKHC1WFNuh0zY7IVjo
         ZWMW2FiR0+6GO1AjUqhhucyrAXnQ9fqm0lCRqjouS50soAEdcJ+VmWzkTXDvOpMgE7+k
         FvHt9L0076MflCEZ1gl+floZG+rKTU78Qeyw8JtR41qiH/0DtLEhK9asUsaGChgK4ocZ
         ciKFf5ncYuqwc+RRakRoNj2pEIJRmAurlbPS2hbxS3drpM8SIUoq24+LEn1yWg7zjJht
         5l+Vf1ocBPRaF+wyZcXXJQpJ85mrJr9St24pHlpXOtOliH/kjgvbqcuAyc8WY4xTInLr
         T7HA==
X-Gm-Message-State: AOAM533XVilVeZa3dm89VQIjcVFsyqxtOv+HP5o9GlZssWFVhHrZ1RyY
        28XJoDHWlXnLgiotLRcBTAwlu/XhxNUsPrlCxJXvNLv43ruI3EJw+7KST06O8vPB9LzejetEAO8
        atvK83lbJpZAdG3VvBZ9El2fK
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr37037155edp.57.1632246603112;
        Tue, 21 Sep 2021 10:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0hlOxCPHRCeODAso0ApC62KfNbelRAejTEfzzZ3nS1WRW0BvJMgl056iYBoxZz04xJCByVw==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr37037131edp.57.1632246602924;
        Tue, 21 Sep 2021 10:50:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f18sm4262674edt.60.2021.09.21.10.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:50:02 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: fix comments of handle_vmon()
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, seanjc@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org
References: <20210908171731.18885-1-yu.c.zhang@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a2a32a9-3de9-acda-f00e-46424c5614a8@redhat.com>
Date:   Tue, 21 Sep 2021 19:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908171731.18885-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/21 19:17, Yu Zhang wrote:
> "VMXON pointer" is saved in vmx->nested.vmxon_ptr since
> commit 3573e22cfeca ("KVM: nVMX: additional checks on
> vmxon region"). Also, handle_vmptrld() & handle_vmclear()
> now have logic to check the VMCS pointer against the VMXON
> pointer.
> 
> So just remove the obsolete comments of handle_vmon().
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/nested.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bc6327950657..90f34f12f883 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4862,14 +4862,7 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
>   	return -ENOMEM;
>   }
>   
> -/*
> - * Emulate the VMXON instruction.
> - * Currently, we just remember that VMX is active, and do not save or even
> - * inspect the argument to VMXON (the so-called "VMXON pointer") because we
> - * do not currently need to store anything in that guest-allocated memory
> - * region. Consequently, VMCLEAR and VMPTRLD also do not verify that the their
> - * argument is different from the VMXON pointer (which the spec says they do).
> - */
> +/* Emulate the VMXON instruction. */
>   static int handle_vmon(struct kvm_vcpu *vcpu)
>   {
>   	int ret;
> 

Queued, thanks.

Paolo

