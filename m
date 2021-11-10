Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2544C2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKJOIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhKJOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636553141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jj5VWreri1Cq4IUj2RAKn1UrTLkppAlKfSLNXLYemI4=;
        b=ZPGrhqJ7uebmSXlgZdEF5sE77MnJUkAfFNzCr0wK8kzrTSbIrZMy6U06bUb0/59ViUve0U
        bQHaUL01WrIp9NNsdrSPbSIC9e3L0VwR4F1Wx0iierbPktaFUXyLf8ESYaiyTncFLB445O
        CFbkXoYejBdLaPT768dCGhjJThsY9Zs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-57J8Yp4vOROJvztCcmju8w-1; Wed, 10 Nov 2021 09:05:40 -0500
X-MC-Unique: 57J8Yp4vOROJvztCcmju8w-1
Received: by mail-wr1-f72.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so438022wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jj5VWreri1Cq4IUj2RAKn1UrTLkppAlKfSLNXLYemI4=;
        b=xzXUvkO68ErI9/w08hmJ/dGP+7u+U+h6rv1k14oiV0333l7/ZGN0I3OtabDzL5O5EG
         EUCvRjCRoVppBoWiDx2aheB1YLufmQyGwmyZsREGtBv/E1tyd1XRz277YUj8jnZsjBVZ
         Fci8OlNLxqBb/qQNbSZ6/WTTHKpgDdt/ff0v/k0DEfEDvloiB1kUmENNnDwcA/DZeW1m
         lhHqKKueFJsWuUpRkoNwiArj9K5PqeLPn/psvslCBPaQkx1aJuTVlb7+Js1WsMVNy1dw
         sF7QvUfb60wJ5iJ3PLRHNVzqRS8NpvmzVEsccqajjjQbgIoKrpj7PzegtoSH3u+aE6hO
         aotw==
X-Gm-Message-State: AOAM532/sprhy7XH5fVhWs6FzaUHcCxX1Ph4HJQ5ubhpVajIwxh4WBCM
        uuHK42zEf/8J9U2yx8K31kvddWO2PtfFTar+lc+UE2MQ+McdSJWzWLVeF6BYiQr7JaJRNSjwLjD
        sFdqOFGVuLj9Mb/VFZni3Wdga
X-Received: by 2002:a1c:447:: with SMTP id 68mr16791278wme.69.1636553137526;
        Wed, 10 Nov 2021 06:05:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxja9oMSCV/h+9FDdKfXS7b9KKTIne9SQJuNkZzMrSBTtEcY6h3oZNZAeViu3afBOTsGiQf7Q==
X-Received: by 2002:a1c:447:: with SMTP id 68mr16791145wme.69.1636553136514;
        Wed, 10 Nov 2021 06:05:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t8sm5496973wmn.44.2021.11.10.06.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 06:05:35 -0800 (PST)
Subject: Re: [PATCH v4 18/21] KVM: arm64: Support SDEI event injection
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-19-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <6c11ed83-796e-765e-bb6a-116947d33eab@redhat.com>
Date:   Wed, 10 Nov 2021 15:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-19-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI event injection by implementing kvm_sdei_inject().
> It's called by kernel directly or VMM through ioctl command to inject
> SDEI event to the specific vCPU.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_sdei.h      |   2 +
>  arch/arm64/include/uapi/asm/kvm_sdei.h |   1 +
>  arch/arm64/kvm/sdei.c                  | 108 +++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
> index a997989bab77..51087fe971ba 100644
> --- a/arch/arm64/include/asm/kvm_sdei.h
> +++ b/arch/arm64/include/asm/kvm_sdei.h
> @@ -124,6 +124,8 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>  int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>  			       kvm_sdei_notifier notifier);
> +int kvm_sdei_inject(struct kvm_vcpu *vcpu,
> +		    unsigned long num, bool immediate);
>  void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>  long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
>  long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
> index b916c3435646..f7a6b2b22b50 100644
> --- a/arch/arm64/include/uapi/asm/kvm_sdei.h
> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
> @@ -67,6 +67,7 @@ struct kvm_sdei_vcpu_state {
>  #define KVM_SDEI_CMD_SET_VEVENT			7
>  #define KVM_SDEI_CMD_GET_VCPU_STATE		8
>  #define KVM_SDEI_CMD_SET_VCPU_STATE		9
> +#define KVM_SDEI_CMD_INJECT_EVENT		10
>  
>  struct kvm_sdei_cmd {
>  	__u32						cmd;
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 79315b77f24b..7c2789cd1421 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -802,6 +802,111 @@ int kvm_sdei_register_notifier(struct kvm *kvm,
>  	return ret;
>  }
>  
> +int kvm_sdei_inject(struct kvm_vcpu *vcpu,
> +		    unsigned long num,
> +		    bool immediate)
don't get the immediate param.
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	struct kvm_sdei_vcpu_event *ksve = NULL;
> +	int index, ret = 0;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if (!kvm_sdei_is_valid_event_num(num)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Check the kvm event */
> +	spin_lock(&ksdei->lock);
> +	kske = kvm_sdei_find_kvm_event(kvm, num);
> +	if (!kske) {
> +		ret = -ENOENT;
> +		goto unlock_kvm;
> +	}
> +
> +	kse = kske->kse;
> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
> +		vcpu->vcpu_idx : 0;
> +	if (!(kvm_sdei_is_registered(kske, index) &&
> +	      kvm_sdei_is_enabled(kske, index))) {
> +		ret = -EPERM;
> +		goto unlock_kvm;
> +	}
> +
> +	/* Check the vcpu state */
> +	spin_lock(&vsdei->lock);
> +	if (vsdei->state.masked) {
> +		ret = -EPERM;
> +		goto unlock_vcpu;
> +	}
> +
> +	/* Check if the event can be delivered immediately */
> +	if (immediate) {
According to the dispatcher pseudo code this should be always checked?
> +		if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL &&
> +		    !list_empty(&vsdei->critical_events)) {
> +			ret = -ENOSPC;
> +			goto unlock_vcpu;
> +		}
> +
> +		if (kse->state.priority == SDEI_EVENT_PRIORITY_NORMAL &&
> +		    (!list_empty(&vsdei->critical_events) ||
> +		     !list_empty(&vsdei->normal_events))) {
> +			ret = -ENOSPC;
> +			goto unlock_vcpu;
> +		}
> +	}
What about shared event dispatching. I don't see the afficinity checked
anywhere?
> +
> +	/* Check if the vcpu event exists */
> +	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
> +	if (ksve) {
> +		kske->state.refcount++;
> +		ksve->state.refcount++;
why this double refcount increment??
> +		kvm_make_request(KVM_REQ_SDEI, vcpu);
> +		goto unlock_vcpu;
> +	}
> +
> +	/* Allocate vcpu event */
> +	ksve = kzalloc(sizeof(*ksve), GFP_KERNEL);
> +	if (!ksve) {
> +		ret = -ENOMEM;
> +		goto unlock_vcpu;
> +	}
> +
> +	/*
> +	 * We should take lock to update KVM event state because its
> +	 * reference count might be zero. In that case, the KVM event
> +	 * could be destroyed.
> +	 */
> +	kske->state.refcount++;
> +	ksve->state.num      = num;
> +	ksve->state.refcount = 1;
> +	ksve->kske           = kske;
> +	ksve->vcpu           = vcpu;
> +
> +	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL)
> +		list_add_tail(&ksve->link, &vsdei->critical_events);
> +	else
> +		list_add_tail(&ksve->link, &vsdei->normal_events);
> +
> +	kvm_make_request(KVM_REQ_SDEI, vcpu);
> +
> +unlock_vcpu:
> +	spin_unlock(&vsdei->lock);
> +unlock_kvm:
> +	spin_unlock(&ksdei->lock);
> +out:
> +	return ret;
> +}
> +
>  void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> @@ -1317,6 +1422,9 @@ long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg)
>  	case KVM_SDEI_CMD_SET_VCPU_STATE:
>  		ret = kvm_sdei_set_vcpu_state(vcpu, &cmd->ksv_state);
>  		break;
> +	case KVM_SDEI_CMD_INJECT_EVENT:
> +		ret = kvm_sdei_inject(vcpu, cmd->num, false);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> 
Eric

