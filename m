Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2DE44B1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhKIRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhKIRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636477966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itzQ0IJHUze6zygYKZqaj/ELO8lr8mqZkASjXKCWKPk=;
        b=g/LhhAvkAi6QKZrLT0pRxDD2S7eB5BcwV88DqIQaaB+FWEvY0j0At3xn/Btf781kBVxKos
        sO+MC8BsTmbDkwMTz5lueRZrneGq1La0TxaJMZjp0hHarwjg7YvevPs4WLPPHgS2flJfZR
        +pVDWzLcJAy3Jk0jxcn92UCUMbSWSjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-cO54OlNZOuCkFzaaNsbloQ-1; Tue, 09 Nov 2021 12:12:45 -0500
X-MC-Unique: cO54OlNZOuCkFzaaNsbloQ-1
Received: by mail-wm1-f71.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso8026545wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=itzQ0IJHUze6zygYKZqaj/ELO8lr8mqZkASjXKCWKPk=;
        b=sIGeJ8/siQ6QlwcFveO+YwPd2fVqpzTFXVkYQFU11UyOHv58jWwJrd5nyJ7303Z0ML
         70B84FjhoPL7yOLdW5WlB+3qrIUTiCYPFxDDp6UukABp2j56HNFvAcJ9gjmb3XienDex
         ueV+77BunFU3qCuaJyVHXgLqSuwACoK0xiJUFVfqNx//tbjcUzqpTH0wgdTZagjzRRZR
         AENNHCF1OcWzyZMbP6+I84o0xUjz5sWXa8/UTFB0C6MEAuuO3pQ7wVZLQaMzfoOGYPpj
         HoP83Pr5mHYXk32LTL7cajgL6JIudlR6fHoceehZv5X5TfTOxA/1DyS0FqM1SOZW0x2H
         G3Xw==
X-Gm-Message-State: AOAM532wwPyZVG8xGOcZlBoYSy0WzSb1MpKXdjpjH7KTQiCbMXRgJkLq
        bfHsKVYZUbXgs0Kk5GVGr/3pvES7wMcORY6rzsEFZOAm5jlbFjU+wjHUKrOytt9gPmEUd/bBMGm
        RZUSfHEE43h2ub3qkBT8LHwxw
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr8704341wmq.77.1636477964269;
        Tue, 09 Nov 2021 09:12:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz53OVWvuTZM63VElmCOXuGyy0d7vSRcf6ZLE9rhLSzl92PQ5p+WlBK2KEaDuhh8aa7rVU8vw==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr8704315wmq.77.1636477964097;
        Tue, 09 Nov 2021 09:12:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id a4sm3050291wmb.39.2021.11.09.09.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:12:43 -0800 (PST)
Subject: Re: [PATCH v4 08/21] KVM: arm64: Support SDEI_EVENT_STATUS hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-9-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <36f2f2cf-3e6e-30ce-53d2-6c44be93272d@redhat.com>
Date:   Tue, 9 Nov 2021 18:12:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-9-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_STATUS hypercall. It's used by the guest
> to retrieve a bitmap to indicate the SDEI event states, including
> registration, enablement and delivery state.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index a3ba69dc91cb..b95b8c4455e1 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -367,6 +367,54 @@ static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	unsigned long event_num = smccc_get_arg1(vcpu);
> +	int index = 0;
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
> +
> +	if (!kvm_sdei_is_valid_event_num(event_num)) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto out;
> +	}
if we were to support bound events, I do not know if a given even num
can disapper inbetween that check and the rest of the code, in which
case a lock would be needed?
> +
> +	/*
> +	 * Check if the KVM event exists. None of the flags
> +	 * will be set if it doesn't exist.
> +	 */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
> +	if (!kske) {
> +		ret = 0;
> +		goto unlock;
> +	}
> +
> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
> +		vcpu->vcpu_idx : 0;
> +	if (kvm_sdei_is_registered(kske, index))
> +		ret |= (1UL << SDEI_EVENT_STATUS_REGISTERED);
> +	if (kvm_sdei_is_enabled(kske, index))
> +		ret |= (1UL << SDEI_EVENT_STATUS_ENABLED);
> +	if (kske->state.refcount)
> +		ret |= (1UL << SDEI_EVENT_STATUS_RUNNING);
> +
> +unlock:
> +	spin_unlock(&ksdei->lock);
> +out:
> +	return ret;
> +}
> +
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	u32 func = smccc_get_function(vcpu);
> @@ -395,6 +443,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_unregister(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
> +		ret = kvm_sdei_hypercall_status(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>  	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>  	case SDEI_1_0_FN_SDEI_PE_MASK:
> 
Thanks

Eric

