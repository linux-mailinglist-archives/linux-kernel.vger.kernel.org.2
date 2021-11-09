Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1D44B1DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhKIRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238356AbhKIRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636478404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeoeqnN42iO2HBA0In6NdJ3XgDyDHyboIkYWjl3H/UQ=;
        b=HpW+w9yyZkJtbdct8+iAnry/wqMwA4rWXeXjMWm9shPHZNMOYUjlkl+f2JyUeM3Haj0jq2
        gstePxzbRqhS7Ms+65UzNmYF520Hwkt309QPRiriiym4kBN7LeI/6f2BVN90LHoFYMUtDK
        MPiQ0VPdsVQ68UHaMHcyFn2Vegf/imU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-EwWiNOLpMJaQlKcNXo9l_Q-1; Tue, 09 Nov 2021 12:20:02 -0500
X-MC-Unique: EwWiNOLpMJaQlKcNXo9l_Q-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so8017509wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EeoeqnN42iO2HBA0In6NdJ3XgDyDHyboIkYWjl3H/UQ=;
        b=fJFx0W0evUgyEqzqOXAAo2k5xirKH0gI5MxrlY5MOYI2D5TfdTvkYb4B7ya7wMl9FJ
         KoNZeZiq/wEVJ2s00YSyRnE5lPRYc0R7KMtbitgG1m4Pcf4q67BXzXclxdRkTsyJjzSi
         JeHP/SGDKvKnL6obUjgAt9Mlc8Uc5nIdmo6NgmOWUUbRl/h2IOA3hKRjDc1YM30oiAem
         k5KqpiX1q6TwydyOyfbbyX3eDekPNmO/jZ7lq9UY+O/7lwcsJOxCt3GwtHnnEb1EUJ1t
         FJurt9q5naWdvG5ThA9WeOfevEZbHwN0ejc3Q325MZY4yYhCZA8ENYI0M4TJUq29sLlk
         rApw==
X-Gm-Message-State: AOAM532ox5/uDA2XDWAJWBD984W6IsWCNrXsU2p6HrsqKuICCSp+JfeH
        xqBPnEbET6AgOQdGflckFE+1EBguVu5hhzu386AnJrR6Sy20IVVFzFcBXHieXZl4GSsLu965Uuk
        fl1CsYZqNQj88BAMt21+EWRyc
X-Received: by 2002:adf:f448:: with SMTP id f8mr11639333wrp.47.1636478400330;
        Tue, 09 Nov 2021 09:20:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCCtys+DFTB9rGKP29bXN2P+dxcKGg761X5Ys6eQzwFD7BzaaXV521w8QRy/G0gOuB6O4KJA==
X-Received: by 2002:adf:f448:: with SMTP id f8mr11639296wrp.47.1636478400112;
        Tue, 09 Nov 2021 09:20:00 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n8sm20410332wrp.95.2021.11.09.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:19:59 -0800 (PST)
Subject: Re: [PATCH v4 09/21] KVM: arm64: Support SDEI_EVENT_GET_INFO
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-10-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <03e9b1fb-af79-69bf-f242-00fef3b11a81@redhat.com>
Date:   Tue, 9 Nov 2021 18:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-10-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_GET_INFO hypercall. It's used by the guest
> to retrieve various information about the supported (exported) events,
> including type, signaled, route mode and affinity for the shared
> events.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index b95b8c4455e1..5dfa74b093f1 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -415,6 +415,80 @@ static unsigned long kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	unsigned long event_num = smccc_get_arg1(vcpu);
> +	unsigned long event_info = smccc_get_arg2(vcpu);
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
> +
> +	/*
> +	 * Check if the KVM event exists. The event might have been
> +	 * registered, we need fetch the information from the registered
s/fetch/to fetch
> +	 * event in that case.
> +	 */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
> +	kse = kske ? kske->kse : NULL;
> +	if (!kse) {
> +		kse = kvm_sdei_find_event(kvm, event_num);
> +		if (!kse) {
> +			ret = SDEI_INVALID_PARAMETERS;
this should have already be covered by !kvm_sdei_is_valid_event_num I
think (although this latter only checks the since static event num with
KVM owner mask)
> +			goto unlock;
> +		}
> +	}
> +
> +	/* Retrieve the requested information */
> +	switch (event_info) {
> +	case SDEI_EVENT_INFO_EV_TYPE:
> +		ret = kse->state.type;
> +		break;
> +	case SDEI_EVENT_INFO_EV_SIGNALED:
> +		ret = kse->state.signaled;
> +		break;
> +	case SDEI_EVENT_INFO_EV_PRIORITY:
> +		ret = kse->state.priority;
> +		break;
> +	case SDEI_EVENT_INFO_EV_ROUTING_MODE:
> +	case SDEI_EVENT_INFO_EV_ROUTING_AFF:
> +		if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
> +			ret = SDEI_INVALID_PARAMETERS;
> +			break;
> +		}
> +
> +		if (event_info == SDEI_EVENT_INFO_EV_ROUTING_MODE) {
> +			ret = kske ? kske->state.route_mode :
> +				     SDEI_EVENT_REGISTER_RM_ANY;
no, if event is not registered (!kske) DENIED should be returned
> +		} else {
same here
> +			ret = kske ? kske->state.route_affinity : 0;
> +		}
> +
> +		break;
> +	default:
> +		ret = SDEI_INVALID_PARAMETERS;
> +	}
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
> @@ -446,6 +520,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_status(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
> +		ret = kvm_sdei_hypercall_info(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>  	case SDEI_1_0_FN_SDEI_PE_MASK:
>  	case SDEI_1_0_FN_SDEI_PE_UNMASK:
> 
Eric

