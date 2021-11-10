Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42544C2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhKJOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232160AbhKJOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636553402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+V9WyF9pMhWUeAnQb8K3r7eRchvmHWHCwXm8++AnmI=;
        b=IREIaJlWPdkH18GPSk2zF+DpFvjIzYNf14BV2W9/doS2Bz9+yoLlehX1eFlD2GE9ZxvO2k
        wtjm7Sj3rACXlEO4L9zYXLjZ50suOWZsPezDlzn635Hr4m2BziUWQs071DrobrJt6f0Bne
        CR6Ad69NZH+6AhUc7HDpxMHafZl42kw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-Wrw3HOpLMxK2loTm0_iL-g-1; Wed, 10 Nov 2021 09:10:00 -0500
X-MC-Unique: Wrw3HOpLMxK2loTm0_iL-g-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1159957wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+V9WyF9pMhWUeAnQb8K3r7eRchvmHWHCwXm8++AnmI=;
        b=Lg3YKEpFBC5o0tU8uzpdutLV4bBN6E2S1hZSj8KkiJFT7RnwAUVLMzEinNA0R4e7tA
         7aqHSDzHHXkhP+baPNOggeXRoujOg9hyuDTvf+4iKS4U+ODgy/uRStT7zcLXShd3I31K
         L2fjhqvBflEpwMHs7xvS7zo2IWQm8h2gC3gMeB1gAeGEy9Fk1twUj1tqvBXskcXKVJcA
         ru4h8Wwg8I+c5I4X68ny9qiZaIb0tWHaYrvki1fT88lSYjyvamrGdddFhsbdntWk/AkJ
         W1Zy5J77e9g1djiFD6kN3zk6d2mqk42nmgy+GM0m489nf30eXKwQ0PH+1KU7PKfHILZQ
         MWUg==
X-Gm-Message-State: AOAM533Ea9GMlKDEPXVnVbkAq8+awbmFn7bQFe6CbK1SAUld48rZpJIn
        cDMXzHj7PhRAnTmhFeKtuUgRU8Q/shfblKaslh8chsyqWPN0NkqXrK3UpK6ZZ9VlevhqEQ+gkid
        fnRWbmDokkxr7GGD5KPsln03E
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr90475wrw.32.1636553399782;
        Wed, 10 Nov 2021 06:09:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7QBo1yRJhfsOQ2XVt81p0F1T6VQOT/KGKflHbyIhvjg5FfatM1OUKkNEOOIJJd02T3IvUKw==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr90444wrw.32.1636553399609;
        Wed, 10 Nov 2021 06:09:59 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l2sm6307842wmq.42.2021.11.10.06.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 06:09:59 -0800 (PST)
Subject: Re: [PATCH v4 19/21] KVM: arm64: Support SDEI event cancellation
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-20-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <6557af7a-ca00-d9dd-c970-3e85c81d1582@redhat.com>
Date:   Wed, 10 Nov 2021 15:09:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-20-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> The injected SDEI event is to send notification to guest. The SDEI
> event might not be needed after it's injected. This introduces API
> to support cancellation on the injected SDEI event if it's not fired
> to the guest yet.
> 
> This mechanism will be needed when we're going to support asynchronous
> page fault.

if we are able to manage the migration of an executing SDEI why can't we
manage the migration of pending SDEIs?

Eric
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_sdei.h |  1 +
>  arch/arm64/kvm/sdei.c             | 49 +++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
> index 51087fe971ba..353744c7bad9 100644
> --- a/arch/arm64/include/asm/kvm_sdei.h
> +++ b/arch/arm64/include/asm/kvm_sdei.h
> @@ -126,6 +126,7 @@ int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>  			       kvm_sdei_notifier notifier);
>  int kvm_sdei_inject(struct kvm_vcpu *vcpu,
>  		    unsigned long num, bool immediate);
> +int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num);
>  void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>  long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
>  long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 7c2789cd1421..4f5a582daa97 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -907,6 +907,55 @@ int kvm_sdei_inject(struct kvm_vcpu *vcpu,
>  	return ret;
>  }
>  
> +int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	struct kvm_sdei_vcpu_event *ksve = NULL;
> +	int ret = 0;
> +
> +	if (!(ksdei && vsdei)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/* Find the vCPU event */
> +	spin_lock(&vsdei->lock);
> +	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
> +	if (!ksve) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	/* Event can't be cancelled if it has been delivered */
> +	if (ksve->state.refcount <= 1 &&
> +	    (vsdei->critical_event == ksve ||
> +	     vsdei->normal_event == ksve)) {
> +		ret = -EINPROGRESS;
> +		goto unlock;
> +	}
> +
> +	/* Free the vCPU event if necessary */
> +	kske = ksve->kske;
> +	ksve->state.refcount--;
> +	if (!ksve->state.refcount) {
> +		list_del(&ksve->link);
> +		kfree(ksve);
> +	}
> +
> +unlock:
> +	spin_unlock(&vsdei->lock);
> +	if (kske) {
> +		spin_lock(&ksdei->lock);
> +		kske->state.refcount--;
> +		spin_unlock(&ksdei->lock);
> +	}
> +out:
> +	return ret;
> +}
> +
>  void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> 

