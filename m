Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7E38E8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhEXOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhEXOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621866191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSxK4tWZIJT5bCptETDU8DGp8zILSQdltaxd/yNnY9s=;
        b=A0uM1BOAr3YKjjusn0HkMDIrHsCUh/CMPCrgWOaz70xSpP1W7vRwrkfF1RX4RC94I7WOLw
        D+HirIGVQp4qYUBr/VohPH5YDwkkCbmgJpEweVucgDvU2JhI66fGdPkX0RbzF04tomfHxD
        a3lpBhxL4DwZGyJg7Q5Q4Ka4HRpaFr4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-y9EyFZn3M2Oc-6fL-TBNZA-1; Mon, 24 May 2021 10:23:09 -0400
X-MC-Unique: y9EyFZn3M2Oc-6fL-TBNZA-1
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso7596517ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kSxK4tWZIJT5bCptETDU8DGp8zILSQdltaxd/yNnY9s=;
        b=UJ5leDlqpbMBpokFl7kwcpejO/OGh3g5CWv5HjXoMjKeXjZA4VcMdAUBQnw8rpVubF
         Q5KXAmZQ3xE1gR6z48QD7ODkdTe0Rh3IhRX0iT6wUOYluEDOs92kM3kpC4CtePXwKyXV
         3OLFK2ktQFFe6OuhVcJvD9DJEHS4yuTtWZ2UxDoKomf7CkD5YwcFub6MK9hPfaB5VT0W
         zzXRbgST+zqbTQL9+jOKj9Pkgz+++tpDuhp0l4HPd/ON5kLg5LrAIXqf3OTx7jjjweyl
         cLe0sWBEUUuYaNHcklMOqID22fxIERr7bGRxcStYzPqYvm6/Bb90e2qFaYw0N2XR2sK4
         cJoQ==
X-Gm-Message-State: AOAM531f99PJ2ztbeG5fvmvSp91VYwdUjqTOlbkNk/qo2jDSJ0nzDcwg
        uqGF0cwJv0gGXz10CRdq5RNmJmIPoUk5+hZTF5GkZs0ib2/eBKj7Xm5tApcsw9rHrubTGXIwHQO
        jkwShhmzIlKWzZlSfRXT9Mtel
X-Received: by 2002:a17:906:1f91:: with SMTP id t17mr23310956ejr.217.1621866188480;
        Mon, 24 May 2021 07:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIgkDRdVV+E7jd/IGylsPVUfdUbKs15rXOWvjJ9bB3PUB3LR50e4FMcVRGghtLOiNziuBT/g==
X-Received: by 2002:a17:906:1f91:: with SMTP id t17mr23310941ejr.217.1621866188285;
        Mon, 24 May 2021 07:23:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o21sm7821393ejh.57.2021.05.24.07.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 07:23:07 -0700 (PDT)
Subject: Re: [PATCH v3 04/12] KVM: X86: Add a ratio parameter to
 kvm_scale_tsc()
To:     Ilias Stamatis <ilstam@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mlevitsk@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        zamsden@gmail.com, mtosatti@redhat.com, dwmw@amazon.co.uk
References: <20210521102449.21505-1-ilstam@amazon.com>
 <20210521102449.21505-5-ilstam@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cba90aa4-0665-a2d5-29e0-133e0aa45ad2@redhat.com>
Date:   Mon, 24 May 2021 16:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521102449.21505-5-ilstam@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 12:24, Ilias Stamatis wrote:
> @@ -3537,10 +3539,14 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		 * return L1's TSC value to ensure backwards-compatible
>   		 * behavior for migration.
>   		 */
> -		u64 tsc_offset = msr_info->host_initiated ? vcpu->arch.l1_tsc_offset :
> -							    vcpu->arch.tsc_offset;
> -
> -		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + tsc_offset;
> +		if (msr_info->host_initiated)
> +			msr_info->data = kvm_scale_tsc(
> +				vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio
> +				) + vcpu->arch.l1_tsc_offset;

Better indentation:

	msr_info->data = vcpu->arch.l1_tsc_offset +
		kvm_scale_tsc(vcpu, rdtsc(),
			      vcpu->arch.tsc_scaling_ratio);

Same below.

Paolo

> +		else
> +			msr_info->data = kvm_scale_tsc(
> +				vcpu, rdtsc(), vcpu->arch.tsc_scaling_ratio
> +				) + vcpu->arch.tsc_offset;
>   		break;
>   	}
>   	case MSR_MTRRcap:
> 

