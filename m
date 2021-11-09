Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D360544B0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhKIQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:05:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236475AbhKIQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636473734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0NkQHNtByTMuU5oqC5nvNn2ilO38HykCMw0MGjwEAk=;
        b=QS75ua07N8qd6YHQ7KtvmUE6zGiJuB4+bDkGgdb9UKWixoUTC4Xb1OI4SqQZJPb87v0T8O
        9J8EZktH2aNrmXS2SXj4qlDcQdPLNpzGFKCLtw64+QEML2BTgt8VL3bkMiZnFwx9SCErhG
        iHthhz+573uRfExxr36+LI2uY912w1c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-VgXC9MPZMX6rHfm1qXA3gw-1; Tue, 09 Nov 2021 11:02:13 -0500
X-MC-Unique: VgXC9MPZMX6rHfm1qXA3gw-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so7917648wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0NkQHNtByTMuU5oqC5nvNn2ilO38HykCMw0MGjwEAk=;
        b=15Gy5YrIR1fp2OiriwE+MhRGjsbe85cuJ8m39jW7uZzHdppLe6qvpTzNgl+HslQVo+
         P9yhoXTtuS7sFan6+mpB6Rc8stL4f3RVDIeJG7ohYW+ltTeJ87kHQ+qQLCjU41HXb31e
         AyIMp8vVdgVovE42QCMn2+SAF1YgsQ/CWM4ppWzvKNBY/Onw844666YFPnlrNIdzivxl
         BDlj9TDzg48tgVLFCKC/jy/EJu3zAf7gePrpNNctOxI7W91Qm1PmxGlER9Z7WV1s0VGp
         Ys7Ayq+CYjJ5JQUS/ohResGXmcDC3ibqF+hbt5/8spZDCGtIoN7/eq8Alb5HviouZVWZ
         R/+w==
X-Gm-Message-State: AOAM532cn0qGloXbS60OCaltASF1AE8VdcOYekNzRCeNBERQKmIhMGPd
        VuSwc35mls0jhMcMTAon75XXeqWQjIHCSoh6pDmYpAh1NvJpz3wFk0YB1sUNChc9EuvfmMfrxQ5
        pUKLUrITMaGprxacFt09pFv+m
X-Received: by 2002:a5d:658c:: with SMTP id q12mr10616527wru.34.1636473731668;
        Tue, 09 Nov 2021 08:02:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp0D3kDsjHNuP+MJKyYIwWAs2FuuiuZ12DLM3XJ7oW9wcvQltGyhH8qsK2rMJxIaC0ruiexQ==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr10616477wru.34.1636473731405;
        Tue, 09 Nov 2021 08:02:11 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id y6sm21903594wrh.18.2021.11.09.08.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 08:02:10 -0800 (PST)
Subject: Re: [PATCH v4 05/21] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE}
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-6-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <4ce1aed4-d955-145c-777b-350efec2e7bc@redhat.com>
Date:   Tue, 9 Nov 2021 17:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-6-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_{ENABLE, DISABLE} hypercall. After SDEI
> event is registered by guest, it won't be delivered to the guest
> until it's enabled. On the other hand, the SDEI event won't be
> raised to the guest or specific vCPU if it's has been disabled
> on the guest or specific vCPU.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 68 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index d3ea3eee154b..b022ce0a202b 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -206,6 +206,70 @@ static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
> +					       bool enable)
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
I would rename into is_exposed_event_num()
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto out;
> +	}
> +
> +	/* Check if the KVM event exists */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
> +	if (!kske) {
> +		ret = SDEI_INVALID_PARAMETERS;
should be DENIED according to the spec, ie. nobody registered that event?
> +		goto unlock;
> +	}
> +
> +	/* Check if there is pending events */
does that match the "handler-unregister-pending state" case mentionned
in the spec?
> +	if (kske->state.refcount) {
> +		ret = SDEI_PENDING;
? not documented in my A spec? DENIED?
> +		goto unlock;
> +	}
> +
> +	/* Check if it has been registered */
isn't duplicate of /* Check if the KVM event exists */ ?
> +	kse = kske->kse;
> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
> +		vcpu->vcpu_idx : 0;
> +	if (!kvm_sdei_is_registered(kske, index)) {
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* Verify its enablement state */
> +	if (enable == kvm_sdei_is_enabled(kske, index)) {
spec says:
Enabling/disabled an event, which is already enabled/disabled, is
permitted and has no effect. I guess ret should be OK.
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* Update enablement state */
> +	if (enable)
> +		kvm_sdei_set_enabled(kske, index);
> +	else
> +		kvm_sdei_clear_enabled(kske, index);
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
> @@ -220,7 +284,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_register(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
> +		ret = kvm_sdei_hypercall_enable(vcpu, true);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
> +		ret = kvm_sdei_hypercall_enable(vcpu, false);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
> 
Eric

