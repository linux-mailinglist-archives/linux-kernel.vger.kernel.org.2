Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121F544B051
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhKIP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235782AbhKIP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636471570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPHOaPm18j2Z6M7uu1JTM0F6CYuFdr82KoODnjFlc9g=;
        b=YAQhJTHDcrGSJ1Jbcg+E3k09DkDdPe80whTI1scaZnIkXUjyCftbRf7pGUA7vZ5Jk53WoJ
        tAbLV3Ezfrf0A/7D62GvI3FLtaxPi9WF/6XxMqtqnNzUMupmiJA8dFG8b+ghnGF2thKYMv
        rkbx++GX/+FnQiyxPXotpLiG5ic5GwI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Tq__TCJSPEubNWo7jissgA-1; Tue, 09 Nov 2021 10:26:08 -0500
X-MC-Unique: Tq__TCJSPEubNWo7jissgA-1
Received: by mail-wr1-f72.google.com with SMTP id z5-20020a5d6405000000b00182083d7d2aso4891272wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPHOaPm18j2Z6M7uu1JTM0F6CYuFdr82KoODnjFlc9g=;
        b=25xQdWQQXtlLUBIyFiqpVs4hjjsuCdeCtEsEGMFIv5mNejC6/NZ5JmAz1JAnaZ0nvo
         UVXem02wWb+wRmEJfWwHUS19gPyJVQMSOXw0++yOK8puERrJDU5HQI+Xxe0sBFdBRlae
         dVLHa8JfHKZ8KbYPZH02AunHklBUTEQfsNe96HY/g5CgC15Ce8rKTQHEo/gBVP5Ocv+1
         rP+8dAnWomYR/0eQkn7UmmmSMsvbdUJsK+xieaV5w680uVlsSLf3qYRygxlxzCk/x3op
         Wd+VyjjN3tHjLcLpYKEf1xFickRI8jS1rbGfqXbHnga4vAqDV/8whtLHzT+kmnGH3apY
         IQ5g==
X-Gm-Message-State: AOAM5311G6x4IdS6gf+jkAo3UTl0AiMImOueaa92G8oMpovoSD0QFgHw
        j4BF2tkzl0vOtVQOBGRE35ZSx+2e4cg+iQrt6h4hTf7ZMcASOmgYIg+H1sSnh3i3AaqEdvb59g5
        1w5jarwTC/MwYz+kJHDw+cZNQ
X-Received: by 2002:adf:b604:: with SMTP id f4mr10642689wre.111.1636471567755;
        Tue, 09 Nov 2021 07:26:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj4mW7KmawaErXG/bkbQYML4AiemLmaiJ6RS/NPf7ijkc4rvHOTmAvgZDTC52J+J9rIde5JQ==
X-Received: by 2002:adf:b604:: with SMTP id f4mr10642661wre.111.1636471567600;
        Tue, 09 Nov 2021 07:26:07 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l4sm19431635wrv.94.2021.11.09.07.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:26:06 -0800 (PST)
Subject: Re: [PATCH v4 03/21] KVM: arm64: Support SDEI_VERSION hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-4-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <3160dd62-1d96-7dcb-e99a-7ac923abc2c7@redhat.com>
Date:   Tue, 9 Nov 2021 16:26:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-4-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_VERSION hypercall by returning v1.0.0 simply
s/This supports/Add Support. I think this is the prefered way to start
the commit msg. Here and elsewhere.
> when the functionality is supported on the VM and vCPU.
Can you explain when the functionality isn't supported on either. From
the infra patch I have the impression that an allocation failure is the
sole cause of lack of support?
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index ab330b74a965..aa9485f076a9 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -70,6 +70,22 @@ static void kvm_sdei_remove_vcpu_events(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	unsigned long ret = SDEI_NOT_SUPPORTED;
nit: I would remove ret local variable
> +
> +	if (!(ksdei && vsdei))
> +		return ret;
> +
> +	/* v1.0.0 */
> +	ret = (1UL << SDEI_VERSION_MAJOR_SHIFT);
> +
> +	return ret;
> +}
> +
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	u32 func = smccc_get_function(vcpu);
> @@ -78,6 +94,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  
>  	switch (func) {
>  	case SDEI_1_0_FN_SDEI_VERSION:
> +		ret = kvm_sdei_hypercall_version(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>  	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>  	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
> 

Eric

