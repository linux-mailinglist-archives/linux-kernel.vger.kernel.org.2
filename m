Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7210C44B419
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbhKIUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244511AbhKIUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636490269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gojg4VWkO45Ypb84clQ7fAq1QopxKBZsDHgCryO6+cM=;
        b=ahOG6q+GkqScQf5GpkUYnPxN6l+E69ERiTptHaBJlqvz2insw8nb/T/ze/VYbSG6quumL+
        JvxCDJTfu+B/HRNJ1SodMSEdK+/+RiO1Px9hJ7zr4J05DDLn4eB3emG/I8YdafY72gzHaa
        Kx3j9NBMXWeIAq1aNKLqGWS6Q3zOnm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-075CsU0VPpa0dvYj2PwzFg-1; Tue, 09 Nov 2021 15:37:48 -0500
X-MC-Unique: 075CsU0VPpa0dvYj2PwzFg-1
Received: by mail-wm1-f69.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so1946409wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gojg4VWkO45Ypb84clQ7fAq1QopxKBZsDHgCryO6+cM=;
        b=5aepVtEa3VC+TdhfnB6Uy37FsJKVTCpyJlQDIkgnhBtsyqRP58EHXjo7NK82CyMwsK
         JQ27zu0xvgv+hNjfBN5GJ+meR5587lV1mTzYsjWJPhst257BVDMMlNVJcZTa0y+XcmyE
         f9TTJCu7121DdPE9lfC3FJhnAYgnSdJIOFEM2ntHi84/TWZl94kTcoopnzb/RypDZIrA
         Edq23J83EOZDzgk0mHIk1E7+D4y9j5m7+Hefr9VQR+IYZlH76a1GHc5/zWgG6wWxS6xd
         wEGFbRN7s7IjRqLgRc/4zM9ZfcO4pI9HahusIJ9BZ+l/GmWWhjDK/NP3Vv7P97p/CBpc
         0SvA==
X-Gm-Message-State: AOAM531oOstr1o8qbsaDIxqNDMdzyGRYjhcoGtSTVW/FFOGOzlvVw+aA
        mm4voPzHVO1X88qDj7QRqsnByR6jRIjgcoUCa2twZ/mQOfrABiqnTLcOViaelBccL3ASl47AvVQ
        aLxLlDCzlisrVSbAuZjVivmCb
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr10545291wmk.27.1636490266864;
        Tue, 09 Nov 2021 12:37:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo6H+ZdYALE/GrXI74xIQHssW56Lq2WYRl3ECCaurkx5wEG9IUIS+rpCPn8YUhWjFj3YDoZA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr10545277wmk.27.1636490266685;
        Tue, 09 Nov 2021 12:37:46 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id y12sm20922993wrn.73.2021.11.09.12.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 12:37:46 -0800 (PST)
Subject: Re: [PATCH v4 12/21] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-13-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <a4b91fa5-12b0-afeb-4449-c2acb59e8cd7@redhat.com>
Date:   Tue, 9 Nov 2021 21:37:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-13-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_{PRIVATE, SHARED}_RESET. They are used by the
> guest to purge the private or shared SDEI events, which are registered
to reset all private SDEI event registrations of the calling PE (resp.
PRIVATE or SHARED)
> previously.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 3fb33258b494..62efee2b67b8 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -582,6 +582,29 @@ static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_reset(struct kvm_vcpu *vcpu,
> +					      bool private)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	unsigned int mask = private ? (1 << SDEI_EVENT_TYPE_PRIVATE) :
> +				      (1 << SDEI_EVENT_TYPE_SHARED);
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
> +
> +	spin_lock(&ksdei->lock);
> +	kvm_sdei_remove_kvm_events(kvm, mask, false);
With kvm_sdei_remove_kvm_events() implementation, why do you make sure
that events which have a running handler get unregistered once the
handler completes? I just see the refcount check that prevents the "KVM
event object" from being removed.
> +	spin_unlock(&ksdei->lock);
> +out:
> +	return ret;
> +}
> +
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	u32 func = smccc_get_function(vcpu);
> @@ -626,8 +649,14 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		break;
>  	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>  	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
> +		ret = SDEI_NOT_SUPPORTED;
> +		break;
>  	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
> +		ret = kvm_sdei_hypercall_reset(vcpu, true);
> +		break;
>  	case SDEI_1_0_FN_SDEI_SHARED_RESET:
> +		ret = kvm_sdei_hypercall_reset(vcpu, false);
> +		break;
>  	default:
>  		ret = SDEI_NOT_SUPPORTED;
>  	}
> 
Eric

