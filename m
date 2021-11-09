Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0C44B1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbhKIRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhKIRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636477506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+tFRg598ce+Pkksxlpyq2K1tm7az89DtXstWpm6hqc=;
        b=IVok75bKRuqJ1xnsFrmUsT7EMxVT6RsSKDEQ8SfRsUqCBge7tUSxCuxhUe3rFHximH5Qol
        hZvXJxqo9D0+RHwLMRf1K3WxLCSQsbmKxANTBTqslVu/Vq5BgvJWQIH0AXJXE1uHg4PO5E
        rnebcXTYycmGQj1Bi92Xb5p5fY8yygE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-yYhtFs_OP_mwdUqO9QiHMw-1; Tue, 09 Nov 2021 12:05:05 -0500
X-MC-Unique: yYhtFs_OP_mwdUqO9QiHMw-1
Received: by mail-wm1-f70.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso629242wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+tFRg598ce+Pkksxlpyq2K1tm7az89DtXstWpm6hqc=;
        b=ZR909O6yiD+MB3Lb9nZJlKLXT3K24FvEsSy7toytzwfJZDZ2Cb++kzruxvqVDtpWq3
         UPantXaG8RvN4YZErGzpech4qC/LRRUQnYX0tcu6dApMl8jTbhfiIPt1U6xY/FfcGH7s
         Je9lJ5RKMH+DdNRFBvG66uFX9JwyMakqcpJ50Tcm89iGB6NHbJljHKlkLMPEnWJFu/fQ
         L54ymQ1RUQSuFQ8xpeqjzJkDedA+4MmHQ/9LJDDbRBqZiqNkd3RB89fMsyYOBDzmhdRJ
         MenqpOfI66A+W8CgS+8vxtD7SGRTJUWAQhpXD+Nbrdpnvg1cBHxE2o0uymAvzPIh1RxV
         39uQ==
X-Gm-Message-State: AOAM531mkAZvGwirvMWewv0naC+tGGaofD/9E0xWs9K13sV1UnQmoE+R
        SgjcOGCse6+2G7PcHKKRtltkyQIHrSk27FNQ5lwbyD8QoiBf0KlY9ZuevSUilkhjA45dyBtte7b
        dyOlqAW+eZsqT5GDT+cJRxLNb
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr11472495wrj.338.1636477503999;
        Tue, 09 Nov 2021 09:05:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4zmFD63DlRvgaPFPwC/DJ0LRgwzSloKUJSs78C2aFK91vrl3ZK3k6EtXwUcJIi3p8AMau7A==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr11472455wrj.338.1636477503802;
        Tue, 09 Nov 2021 09:05:03 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id o12sm26601930wrc.85.2021.11.09.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:05:03 -0800 (PST)
Subject: Re: [PATCH v4 07/21] KVM: arm64: Support SDEI_EVENT_UNREGISTER
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-8-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <100a4aa0-6c2d-2fec-6f11-c7e64946ef0b@redhat.com>
Date:   Tue, 9 Nov 2021 18:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-8-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_UNREGISTER hypercall. It's used by the
> guest to unregister SDEI event. The SDEI event won't be raised to
> the guest or specific vCPU after it's unregistered successfully.
> It's notable the SDEI event is disabled automatically on the guest
> or specific vCPU once it's unregistered successfully.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index b4162efda470..a3ba69dc91cb 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -308,6 +308,65 @@ static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
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
> +
> +	/* Check if the KVM event exists */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
> +	if (!kske) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto unlock;
> +	}
> +
> +	/* Check if there is pending events */
> +	if (kske->state.refcount) {
> +		ret = SDEI_PENDING;
don't you want to record the fact the unregistration is outstanding to
perform subsequent actions? Otherwise nothing will hapen when the
current executing handlers complete?
> +		goto unlock;
> +	}
> +
> +	/* Check if it has been registered */
> +	kse = kske->kse;
> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
> +		vcpu->vcpu_idx : 0;
you could have an inline for the above as this is executed in many
functions. even including the code below.
> +	if (!kvm_sdei_is_registered(kske, index)) {
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* The event is disabled when it's unregistered */
> +	kvm_sdei_clear_enabled(kske, index);
> +	kvm_sdei_clear_registered(kske, index);
> +	if (kvm_sdei_empty_registered(kske)) {
a refcount mechanism would be cleaner I think.
> +		list_del(&kske->link);
> +		kfree(kske);
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
> @@ -333,6 +392,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>  	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
> +		ret = kvm_sdei_hypercall_unregister(vcpu);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>  	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>  	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
> 

