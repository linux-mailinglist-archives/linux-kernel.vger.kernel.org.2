Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4144B403
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhKIUe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242750AbhKIUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636489897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAm+Uh+IE22+DUbyhwUyZ8uYJG0ltyMl2q6EpG0f1c0=;
        b=gZn7mKqCwq3UEFQoEhVnKtXohG4JWzLHAYrKN7GXM01C3AEKnDnwdgrze7fGxrhk68Hw2M
        M7mmQQsjjfCjgwswlygJek9CrfXAHuZzzynoQuBife4e2p2q/qIXoKoiL5yOLZUgr+84ee
        8oZforjYyBC4uhU9W2YMDlsUkMLyFLU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Tej3VyZ1O7WMMWzXP2wO7g-1; Tue, 09 Nov 2021 15:31:35 -0500
X-MC-Unique: Tej3VyZ1O7WMMWzXP2wO7g-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so166561wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAm+Uh+IE22+DUbyhwUyZ8uYJG0ltyMl2q6EpG0f1c0=;
        b=Ap1ktAIofaOTnXVlAVWyAk2rLIiByPRdBOQZ6N6/+konIq+yUBUB/IkV1nsdk5EyK1
         HOtYJS7ypKFgjD87nXQjIEYy8Yq1T9W5ltjot9CdsL3xHMQDIy/b17Bf8BqFShUJxNC8
         dx2jQC7Rq1yumsRa5z+X2MYwffFuaZiG1Ya3Nk2R3OwbCE12yAeRVCBPi8/mvAKetPu4
         rADQBHKa1pkczVcuW6cR/vi/s8KG+rym46gTcRS9t84/ozQJwfXA2tQ031zj2TMEKeWM
         TAioFOABysq6VDfFU70I8NYR0rX/88vfWID1Si2t27VHQAyQK4ItIT9iTWpu+jvaMPNN
         MvEw==
X-Gm-Message-State: AOAM532yumDXUBYdi7PIMvn/7/2oUM05ebucKWQjrKykimJ+BBkR5zgK
        kwzt7HUPe8ANCALScd80L+b2UiNWQ2bXP57R7KY/5IR6n9+ATqxgMGNG98xB/EeH7mLJHxVhfsD
        XMRuZZh1JB+lIZErFaepe+koi
X-Received: by 2002:adf:f209:: with SMTP id p9mr12748369wro.191.1636489894173;
        Tue, 09 Nov 2021 12:31:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxe5lKaSE8vCkApCROWS0oJxDYib0FmnYoWXwNee2qMFilSc/uvd/npDY1fjsOp8y96Ktlw2A==
X-Received: by 2002:adf:f209:: with SMTP id p9mr12748342wro.191.1636489893975;
        Tue, 09 Nov 2021 12:31:33 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id o26sm3494880wmc.17.2021.11.09.12.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 12:31:33 -0800 (PST)
Subject: Re: [PATCH v4 11/21] KVM: arm64: Support SDEI_PE_{MASK, UNMASK}
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-12-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <e5acdb48-fb16-ab18-4938-c03265c4cfbf@redhat.com>
Date:   Tue, 9 Nov 2021 21:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-12-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_PE_{MASK, UNMASK} hypercall. They are used by
> the guest to stop the specific vCPU from receiving SDEI events.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 458695c2394f..3fb33258b494 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -551,6 +551,37 @@ static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
> +					     bool mask)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
> +
> +	spin_lock(&vsdei->lock);
> +
> +	/* Check the state */
> +	if (mask == vsdei->state.masked) {
> +		ret = SDEI_DENIED;
are you sure? I don't this error documented in 5.1.12?

Besides the spec says:
"
This call can be invoked by the client to mask the PE, whether or not
the PE is already masked."
> +		goto unlock;
> +	}
> +
> +	/* Update the state */
> +	vsdei->state.masked = mask ? 1 : 0;
> +
> +unlock:
> +	spin_unlock(&vsdei->lock);
> +out:
> +	return ret;
In case of success the returned value is SUCESS for UNMASK but not for
MASK (see table in 5.1.12).

By the way I have just noticed there is a more recent of the spec than
the A:

ARM_DEN0054C

You should update the cover letter and [PATCH v4 02/21] KVM: arm64: Add
SDEI virtualization infrastructure commit msg


> +}
> +
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	u32 func = smccc_get_function(vcpu);
> @@ -588,7 +619,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_route(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_PE_MASK:
> +		ret = kvm_sdei_hypercall_mask(vcpu, true);
> +		break;
>  	case SDEI_1_0_FN_SDEI_PE_UNMASK:
> +		ret = kvm_sdei_hypercall_mask(vcpu, false);
> +		break;
>  	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>  	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>  	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
> 
Eric

