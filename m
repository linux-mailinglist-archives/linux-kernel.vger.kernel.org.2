Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB543D5971
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhGZLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233713AbhGZLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627302425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pLQHCoDSsXCllDb0GnTFJnUbcQ1cRoUJbtUYUP6ANM=;
        b=jOXdu0zNi9TkRzrfSpc5Fu5PvDwKrbfn1n2daN5+i+Buipf4z0p2XJGfSC9bJ1oMgpjADk
        bSR+OF+Ceux5WY+zMe+6ZCkYGXg4QQqe8C2UtgMpyoRZFFoNqgeeqc0ZQ7EaixU9ddZIhH
        +erorFfLa44IADfg9GeoNnhyN7ZSYe8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-UCqD3D1XOHGfPc9ZotmlTw-1; Mon, 26 Jul 2021 08:27:04 -0400
X-MC-Unique: UCqD3D1XOHGfPc9ZotmlTw-1
Received: by mail-ed1-f71.google.com with SMTP id n10-20020a05640206cab02903a4b3e93e15so4660648edy.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pLQHCoDSsXCllDb0GnTFJnUbcQ1cRoUJbtUYUP6ANM=;
        b=eQEdO8oRjIxbldiYBqVk58SLF76V6Cono39phOe77UUbI9olkCTY+W4cSxRirKoFri
         lfrFVQu4Bs+y7gbb8PWZhNV9/Bl/oMQqeM+8e0sIVd4sNJVZcwYzg3oVsel7ZCZ7jnEY
         Pg26XoJMTZlkCSqubupwveYauJgvIcQszFbdNEJKLm6LjobVDKh6SIM5UXNJHXXkE10/
         oLPi5YQCJ15kmOAzqXQGlIWzfypx1L3+a5VgT7/BmjpsZHrLUBrOkrqBOZbZkC2d5O2Z
         Vnts3FFDLcmDqKlCYmiNrelWFtFaLbcm1TUAQTMjz00F+2af9yxmrY8iIWGGDshfKus1
         VCpg==
X-Gm-Message-State: AOAM5300VM9iPzzJXOLhCkT2iIv2qNq4IAUgNgcCd7PVlBGYaEmSVEAg
        OtVzfqu8vsuGKHsJeZBstR9xCavWQwDZ/5dRa1lD+aDItTsj/q/x/fwyp+pSOGE3t8V2XaUL8kY
        i8AZ3BdqoNibfjQTMpNYUZcAJl84QK8Kpgq3BDas71b/eqZMD24hzstkDuD4cgIa9qpoaxuDJ49
        0z
X-Received: by 2002:a17:906:4158:: with SMTP id l24mr16328187ejk.245.1627302423002;
        Mon, 26 Jul 2021 05:27:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvjMhQPXalA1SR9kEMp1/APEZND8KBWzgcVBR8Mit7Cbs2RpIvZ6rtl7cJkX/IzptkkpiJ7w==
X-Received: by 2002:a17:906:4158:: with SMTP id l24mr16328166ejk.245.1627302422762;
        Mon, 26 Jul 2021 05:27:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c5sm12159692edk.26.2021.07.26.05.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 05:27:02 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Check the right feature bit for
 MSR_KVM_ASYNC_PF_ACK access
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
References: <20210722123018.260035-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8500354-b204-3e21-f6c9-1e6a80f88851@redhat.com>
Date:   Mon, 26 Jul 2021 14:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722123018.260035-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/21 14:30, Vitaly Kuznetsov wrote:
> MSR_KVM_ASYNC_PF_ACK MSR is part of interrupt based asynchronous page fault
> interface and not the original (deprecated) KVM_FEATURE_ASYNC_PF. This is
> stated in Documentation/virt/kvm/msr.rst.
> 
> Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/x86.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d715ae9f9108..88ff7a1af198 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3406,7 +3406,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   			return 1;
>   		break;
>   	case MSR_KVM_ASYNC_PF_ACK:
> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
>   			return 1;
>   		if (data & 0x1) {
>   			vcpu->arch.apf.pageready_pending = false;
> @@ -3745,7 +3745,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		msr_info->data = vcpu->arch.apf.msr_int_val;
>   		break;
>   	case MSR_KVM_ASYNC_PF_ACK:
> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
>   			return 1;
>   
>   		msr_info->data = 0;
> 

Queued, thanks.

Paolo

