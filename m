Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596D2423CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhJFL1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238416AbhJFLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633519401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+j8kGyfSEc1b5J6pZ1nvHDgoskjSsEnkTn7JsOcRG8=;
        b=a6i4oDCaH3GPQ8HAMH7m+v85I00vbHCoxvNTk0oZ/Q3do//hArQjjoBMQhqzy2Uqbep17+
        FqMtA1fIzzzCJkZ6qMYNGLktyD+qd1yFQmBGhoGkdjL5aq3Z6w6UZTHQArzanlXkjgRpOC
        XDtobzEajMDlBZb1/8zcJRDrYmxEfNc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-T_mU0YAEMTKxAdCvXzeIfw-1; Wed, 06 Oct 2021 07:23:20 -0400
X-MC-Unique: T_mU0YAEMTKxAdCvXzeIfw-1
Received: by mail-ed1-f71.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so2316422edi.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K+j8kGyfSEc1b5J6pZ1nvHDgoskjSsEnkTn7JsOcRG8=;
        b=42Ywqa/+4TFwDNHQPIFc+pKORPRlU3mAuWz7cFVYU0736EqCVBEtZj/TYm0JbpmpQv
         U5slNWyKVfhtG2tUlJPlstJRsBtaMmqJragKfv7tv9cGTZnsjPld/GjW3L3+k8vLz7Vs
         Ib4dJHPwbc+Ky4tl0XiQLmg9Akgn7fmDxZNVnJRiOQXJoDgFkbSlJks1wT54MJhJ/VGM
         DpljcrDJhM9o11wDNyNGVU9UjyQUl7Jg1kB1ZxAA3lXiAMq/gDVX4FN7J+IMIj9A2+GH
         wCuqy5L+GFJCeaWnhNEAEaWTKbNMV5qB79J6hmwmkaYVPdxKUZ6/3uPaxh9kq5NkhySK
         +KkA==
X-Gm-Message-State: AOAM533c/wTazOKMKkXu5WpOeSP4t0ZyvWy+Dq6gYbgyu4xxCQ+z+bLh
        L1e0Y0uKqSH59bLqbF5dhnT/kIWCwxvk0L/jCtHT39e5yn58lz6SBbkLMr/FKSVEo35zmeriWag
        AYbGrQsqPT3aAtflDE83DDfUF
X-Received: by 2002:a17:907:767a:: with SMTP id kk26mr30836884ejc.134.1633519399605;
        Wed, 06 Oct 2021 04:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSbrR9RR6C4+3Fp2VVhrEAk9547+8U10Y9UDSOeD6CeQ+ifciYYe5Ljeu4bqSDszAHdpZXPA==
X-Received: by 2002:a17:907:767a:: with SMTP id kk26mr30836865ejc.134.1633519399407;
        Wed, 06 Oct 2021 04:23:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id s3sm8842345eja.87.2021.10.06.04.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:18 -0700 (PDT)
Message-ID: <f4abdd97-d451-f689-75c4-26d412bcc920@redhat.com>
Date:   Wed, 6 Oct 2021 13:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.10 6/7] KVM: x86: nSVM: restore int_vector in
 svm_clear_vintr
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, kvm@vger.kernel.org
References: <20211006111234.264020-1-sashal@kernel.org>
 <20211006111234.264020-6-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006111234.264020-6-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 13:12, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit aee77e1169c1900fe4248dc186962e745b479d9e ]
> 
> In svm_clear_vintr we try to restore the virtual interrupt
> injection that might be pending, but we fail to restore
> the interrupt vector.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-Id: <20210914154825.104886-2-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/svm/svm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1c23aee3778c..5e1d7396a6b8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1497,6 +1497,8 @@ static void svm_clear_vintr(struct vcpu_svm *svm)
>   			(svm->nested.ctl.int_ctl & V_TPR_MASK));
>   		svm->vmcb->control.int_ctl |= svm->nested.ctl.int_ctl &
>   			V_IRQ_INJECTION_BITS_MASK;
> +
> +		svm->vmcb->control.int_vector = svm->nested.ctl.int_vector;
>   	}
>   
>   	vmcb_mark_dirty(svm->vmcb, VMCB_INTR);
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

