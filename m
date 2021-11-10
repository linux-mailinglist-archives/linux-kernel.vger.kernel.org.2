Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9804244C003
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhKJLTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636542999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7mp+5lU0MhnDm60HKtkVOloR5zR9YnN9HfGbstaIfs=;
        b=RADyz6GKBXyQD6XJsM/MD/cDFYvZ+01dnlrT7Uvduxw9ZjvKsj6Gs56AnW1mO24rgBeCTS
        puhUYdcnWQJwMNLrXamUYTOkHgbfT1rEZruLMnkyPv2uF7YeC/pO0BPb1cpoaEw/TOMlxR
        lvFTq5IvDJbWbiUzDz92mr8Mf8ntfS8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-2YcnvT6wOVm1EbY1IPNsTQ-1; Wed, 10 Nov 2021 06:16:38 -0500
X-MC-Unique: 2YcnvT6wOVm1EbY1IPNsTQ-1
Received: by mail-wm1-f70.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so160186wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7mp+5lU0MhnDm60HKtkVOloR5zR9YnN9HfGbstaIfs=;
        b=Bc/vDuJu4TWbJFZ+RPe9T/V4jnx4G1bCokAGjzzV0t28djcSniaaTV3zoJNxdxcHlz
         uZZ2/cG5NVb88DjWE+oOfmFnOLRfdHy1kDb+g7Jk1zRPD1CKepFjbyRsUHgsIVIRT8nQ
         jFV0Me6H2JvcpLDlzuLQvHoJekFioOlQweKCN0hY3tGCQsHF1Phg6kfW2ZjM98/CXWt2
         vRkFuP5YsSFofg0YiFHWPO6azP7QYHJEPZhvO9atWOce/RamgZ2DIe5/K12SQj9+BvsV
         xSIXzeuUK95MDW8rlGWIaOk/bYLdG5pUgE3TWQaaufkO4vezbxjwCNlClDap6qt/W+ru
         2WSQ==
X-Gm-Message-State: AOAM533NxKScOk6RfIgGyNW8USPo/8jzWhhAc+hfwcI/SEzTfkjTAl4f
        xaDx337KscUKAJPXho3DT12R+oKKhr2i6SSK3mHQZyEL2C8KDf+Hck12P2JMAPwr9oYkb74Qz8A
        Br4zbTXlxGL4pjsRbp6MAMFnZ
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr15762572wmp.165.1636542997131;
        Wed, 10 Nov 2021 03:16:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFgu1WvaBJtOekSSDZd6W0/5PVsCaDO0G5c6yrDZz8jXAaT6s3N0Oam2ZI1nIihQXdcquXCw==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr15762550wmp.165.1636542996946;
        Wed, 10 Nov 2021 03:16:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id h1sm5337881wmb.7.2021.11.10.03.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:16:36 -0800 (PST)
From:   Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
Message-ID: <d9471e38-1840-1f79-c028-8f78afc0d2c7@redhat.com>
Date:   Wed, 10 Nov 2021 12:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-7-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
> to retrieved the original registers (R0 - R17) in its SDEI event
> handler. Those registers can be corrupted during the SDEI event
> delivery.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index b022ce0a202b..b4162efda470 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -270,6 +270,44 @@ static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_vcpu_regs *regs;
> +	unsigned long index = smccc_get_arg1(vcpu);
s/index/param_id to match the spec?
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
> +
> +	if (index > ARRAY_SIZE(vsdei->state.critical_regs.regs)) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto out;
> +	}
I would move the above after regs = and use regs there (although the
regs ARRAY_SIZE of both is identifical)
> +
> +	/* Check if the pending event exists */
> +	spin_lock(&vsdei->lock);
> +	if (!(vsdei->critical_event || vsdei->normal_event)) {
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* Fetch the requested register */
> +	regs = vsdei->critical_event ? &vsdei->state.critical_regs :
> +				       &vsdei->state.normal_regs;
> +	ret = regs->regs[index];
> +
> +unlock:
> +	spin_unlock(&vsdei->lock);
> +out:
> +	return ret;
> +}
> +
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	u32 func = smccc_get_function(vcpu);
> @@ -290,6 +328,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_enable(vcpu, false);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
> +		ret = kvm_sdei_hypercall_context(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>  	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
> 
Eric

