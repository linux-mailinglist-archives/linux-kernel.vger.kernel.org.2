Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3444B2D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhKISun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242606AbhKISum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636483675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0RovrZWpwirwAExhIJwYKka0MpzBNZCqhlUn9GM8bg=;
        b=P92Mp/nD/nuk0XLCSI43W0gt2yUMcJV33sLBrxWgQYoxwIdcMKm4vq2ExgJgnlB/KSqRNn
        aSrfy1ZsUZdT0rxI1G/yb7DK9OMwl4Z1TtEBinksNY5/DJWTifpJAg/BlB6tOCNpog6s9C
        rh1c0dCNmlGmFvatzUYAFAjkjZ/0KVw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-1SPezxh3OiiEbFKE6ASM9w-1; Tue, 09 Nov 2021 13:47:54 -0500
X-MC-Unique: 1SPezxh3OiiEbFKE6ASM9w-1
Received: by mail-wr1-f72.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so4403924wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y0RovrZWpwirwAExhIJwYKka0MpzBNZCqhlUn9GM8bg=;
        b=LC4RcEZ9L0bxtMkbE6+QQCPq2ogUjtXyFO2IncLWEmzrGJVzHOoVmLA1hO1Yym/Ovq
         9fyjyqVOp6XTU9KzyT4ArAZgCABrNkM4qAYoPIxO9bd1xBk8moG91Vd+FsOy6sI9Izio
         Z/4uFCaJep71XVYovUHCVOG46KmZ+XPEe26ssGX0ReGvxDq8TVS8qCeNMuYvkAtGrKKU
         ThzpowH+d36UaClaBjGXFN5YHxfBSEhJbdTFFxuXU8ghCwiTt3zsc5mRqHZfwsdef8YW
         3RNWYy02tLaZDbnB2Kh5ymk1mIYn235INvwVCZ8rAPL5E/Xr43JEJXDVYm3ss8csCJS8
         zP3A==
X-Gm-Message-State: AOAM531QojMtE6eSAHBgd3P19wEbAj7kQ5dhVwv9DuLvW1pNjS0WIKxZ
        nTL6u6kIthuPs6wcJFqYdVr9XUjmkEBnvLWo0zuqyRYjMMYAMi49NmVVLw3zoKB7N2gkhAQaQsk
        W/esZEIB9uBQ5e5loLoq7G6Gx
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr9674018wmr.134.1636483672874;
        Tue, 09 Nov 2021 10:47:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwosnr4qtmp9gIyxAanUH2RRhXq8QfVnuZRB+FSoEkfAQ8fHaZCCxXpv2LDlJQ1Y+laoJpIw==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr9673989wmr.134.1636483672615;
        Tue, 09 Nov 2021 10:47:52 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p13sm3556837wmi.0.2021.11.09.10.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 10:47:52 -0800 (PST)
Subject: Re: [PATCH v4 10/21] KVM: arm64: Support SDEI_EVENT_ROUTING_SET
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-11-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <0d46c17b-1a37-cbf6-4d34-aa03d30e39ef@redhat.com>
Date:   Tue, 9 Nov 2021 19:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-11-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,
On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
> guest to set route mode and affinity for the registered KVM event.
> It's only valid for the shared events. It's not allowed to do so
> when the corresponding event has been raised to the guest.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 5dfa74b093f1..458695c2394f 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -489,6 +489,68 @@ static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	unsigned long event_num = smccc_get_arg1(vcpu);
> +	unsigned long route_mode = smccc_get_arg2(vcpu);
> +	unsigned long route_affinity = smccc_get_arg3(vcpu);
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
> +
> +	if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
> +	      route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto out;
> +	}
Some sanity checking on the affinity arg could be made as well according
to 5.1.2  affinity desc. The fn shall return INVALID_PARAMETER in case
of invalid affinity.
> +
> +	/* Check if the KVM event has been registered */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
> +	if (!kske) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto unlock;
> +	}
> +
> +	/* Validate KVM event state */
> +	kse = kske->kse;
> +	if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto unlock;
> +	}
> +
Event handler is in a state other than: handler-registered.
> +	if (!kvm_sdei_is_registered(kske, index) ||
> +	    kvm_sdei_is_enabled(kske, index)     ||
> +	    kske->state.refcount) {
I am not sure about the refcount role here. Does it make sure the state
is != handler-enabled and running or handler-unregister-pending?

I think we would gain in readibility if we had a helper to check whether
we are in those states?
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* Update state */
> +	kske->state.route_mode     = route_mode;
> +	kske->state.route_affinity = route_affinity;
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
> @@ -523,6 +585,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_info(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
> +		ret = kvm_sdei_hypercall_route(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_PE_MASK:
>  	case SDEI_1_0_FN_SDEI_PE_UNMASK:
>  	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
> 
Eric

