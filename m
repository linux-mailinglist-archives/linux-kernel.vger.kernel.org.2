Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B04197D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhI0P1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235095AbhI0P1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632756354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBGEP5tGgom1+kN1R+/bNbLDkQMV2fPI4kG5Llx+Ie4=;
        b=Lb8rIiprgm/P32V6g2+huVUiF4QH7n1TpeewQ3S7iy/krT1t8boFZK6jeFi47sod4woDND
        YR6DaUFFgXPoQhEJ6IBbahaehvNFP1Qucmn9ZFMZ4Tx8Z3QUyT5ui6Ou7D1ktvmYfGpnPC
        lKjz1F15rE8ttq6uJGiTgnLjE8wkpRo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-ffCR9dQPNsiJEwQxREDW7w-1; Mon, 27 Sep 2021 11:25:53 -0400
X-MC-Unique: ffCR9dQPNsiJEwQxREDW7w-1
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so14326243wrh.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBGEP5tGgom1+kN1R+/bNbLDkQMV2fPI4kG5Llx+Ie4=;
        b=oER3dZk+lPZ9qvwtMZLszgT3TJFzmZLtf36Z5NUTIJb31O/7iAJLwcNKgfQmMT7H/9
         j03ZbWL3WTp4kT+y5/pJkvos/updCSwG9VE4FWED8kGIAH+lbtIAPQME6FJ6y0RT6ceL
         P82/cOotuANQTTHdDoPxJc4rynHsbjyV1nWmQe8WN4Xa6eOQwKx84XStp5IyukJde+5B
         xEjghNoOoTZzeavgqxDg0pQQXQwJbqwwLEfq0UXYAOPvQEj1dPal7Vp+eP6ZeQNE9X9Z
         KGrVSw9Od27+4Ljld8qhFLXh0kxJUKNqc341+lMMPPJKVrEgVHvIafM+bS6in22jTknr
         /ygw==
X-Gm-Message-State: AOAM533mLK5gJOtsMFyq+L6uPhGtoS2iGY9srU8HEyXWSbnpNUO5dvIu
        8cM0meFlJM8r/dnmArcxeFzghEXgE+/m3/jlqjnBqIPp1qiewM+h5AEveKtzqYqT/gKeMigIqjo
        E7cl8LA52uY8jVJSQX/YOQygf
X-Received: by 2002:adf:e88d:: with SMTP id d13mr477970wrm.91.1632756352372;
        Mon, 27 Sep 2021 08:25:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws1BekiS36TGbShKY8RhMssUatC3zpVlGX2yvXwi/uWLlL1/wtlyqFvEN8KfWvzNAfHcjpJQ==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr477941wrm.91.1632756352144;
        Mon, 27 Sep 2021 08:25:52 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c18sm9557576wmb.27.2021.09.27.08.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:25:51 -0700 (PDT)
Message-ID: <df876461-17a6-dbdd-2292-9822db68b6b8@redhat.com>
Date:   Mon, 27 Sep 2021 17:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] KVM: VMX: Fix a TSX_CTRL_CPUID_CLEAR field mask issue
Content-Language: en-US
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
References: <20210926015545.281083-1-zhenzhong.duan@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210926015545.281083-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/21 03:55, Zhenzhong Duan wrote:
> When updating the host's mask for its MSR_IA32_TSX_CTRL user return entry,
> clear the mask in the found uret MSR instead of vmx->guest_uret_msrs[i].
> Modifying guest_uret_msrs directly is completely broken as 'i' does not
> point at the MSR_IA32_TSX_CTRL entry.  In fact, it's guaranteed to be an
> out-of-bounds accesses as is always set to kvm_nr_uret_msrs in a prior
> loop. By sheer dumb luck, the fallout is limited to "only" failing to
> preserve the host's TSX_CTRL_CPUID_CLEAR.  The out-of-bounds access is
> benign as it's guaranteed to clear a bit in a guest MSR value, which are
> always zero at vCPU creation on both x86-64 and i386.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8ea8b8d6f869 ("KVM: VMX: Use common x86's uret MSR list as the one true list")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0c2c0d5ae873..cbf3d33432b9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6833,7 +6833,7 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>   		 */
>   		tsx_ctrl = vmx_find_uret_msr(vmx, MSR_IA32_TSX_CTRL);
>   		if (tsx_ctrl)
> -			vmx->guest_uret_msrs[i].mask = ~(u64)TSX_CTRL_CPUID_CLEAR;
> +			tsx_ctrl->mask = ~(u64)TSX_CTRL_CPUID_CLEAR;
>   	}
>   
>   	err = alloc_loaded_vmcs(&vmx->vmcs01);
> 

Queued, thanks.

Paolo

