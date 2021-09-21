Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958F41386D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhIURhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhIURhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632245763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgPiDD5j2AqzF61mlGvIsvFPJ7w1YHs7HAZrifi1D00=;
        b=WksF02vLXfsWp2B3buSaRXU5ipK7W0c44CFKjO+TSF4tWdMuojR/JTbfr9JB44TwxMcAgQ
        YqqQ98xpA5R4bdweMSUs67KCC0Tlv11c2JuVleOMY23qraRr/XFy5aOKTb2MU3juMGeCWE
        mvsiJejvhqqxbxFNXAp0Zj0Mev8rWuk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-it5fNUFvN_Og-UYhryYtwA-1; Tue, 21 Sep 2021 13:36:02 -0400
X-MC-Unique: it5fNUFvN_Og-UYhryYtwA-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so9450645wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgPiDD5j2AqzF61mlGvIsvFPJ7w1YHs7HAZrifi1D00=;
        b=b+9Ij9Ub+TD/hYKmDFI0v3IaVuB8YOKZYj2oob885jtbLL4yydy//yxjMwAfSJ/+nt
         leK2XkPcX92imekFhsVLAbRzr/cvf7EJf7sVeK1pJvkljY/c/iyj64n35SDmCePrgemv
         7tKpJCQDqBNPSwqbYCmvOmUgiMARvuGYRXuGPFZ8rvb7Hlf1I85QDTF/kqztI08FYoqD
         8Qfuu6j1E7ltQH+fcn5q4FquBL0GZOIZZIFDz+M77Zm8oywX12RVzKJk/qqX9MpyD0wq
         pwwJMSI9oN4PJa7qgzB88gA1Gdp8+gkHs+ozIShkC4EWZ0kXifeZ0xCwX04Pd73qioFi
         1UNw==
X-Gm-Message-State: AOAM532lT3UXvJYQoypipmY42vFmTFB/bnrnMlzspIy1zNm3mQTX0LHJ
        Qd3rV1zii6Q5xcYW+TRss+Mtk7N3lWoQXG2IoTvuBQX/7qh99aDPlqF2tQZ8u5bx5Cs4gBPpP1r
        uR1CXiMYmWe7tUUw1CPyxZ7Ob
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr5875566wmf.58.1632245760832;
        Tue, 21 Sep 2021 10:36:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUUudoY9HvptrgZ5/LyJJD0yp4dO/ucGU04k4bELWDe4QqQ5pOXt5EjJz4lAP6jqqovVOSVA==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr5875546wmf.58.1632245760567;
        Tue, 21 Sep 2021 10:36:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m2sm3520973wmm.3.2021.09.21.10.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:35:59 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] KVM: x86: Clear KVM's cached guest CR3 at
 RESET/INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <395d8222-9168-8568-255e-da57c2ac8b5b@redhat.com>
Date:   Tue, 21 Sep 2021 19:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921000303.400537-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/21 02:02, Sean Christopherson wrote:
> Explicitly zero the guest's CR3 and mark it available+dirty at RESET/INIT.
> Per Intel's SDM and AMD's APM, CR3 is zeroed at both RESET and INIT.  For
> RESET, this is a nop as vcpu is zero-allocated.  For INIT, the bug has
> likely escaped notice because no firmware/kernel puts its page tables root
> at PA=0, let alone relies on INIT to get the desired CR3 for such page
> tables.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e77a5bf2d940..2cb38c67ed43 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10899,6 +10899,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
>   	kvm_rip_write(vcpu, 0xfff0);
>   
> +	vcpu->arch.cr3 = 0;
> +	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
> +
>   	/*
>   	 * CR0.CD/NW are set on RESET, preserved on INIT.  Note, some versions
>   	 * of Intel's SDM list CD/NW as being set on INIT, but they contradict
> 

Queued patches 1-2 for 5.15-rc3, thanks.

Paolo

