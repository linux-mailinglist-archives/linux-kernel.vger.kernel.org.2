Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39C3B1B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFWN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhFWN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624454797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jein3OgAGJf2ndq/BFeAbkmeJx56zKLxIWuxbrPBB4M=;
        b=AQfgYJd5hErQjZbJFMvCHfF1anIHEk5B+0Q99IkbetU6tHmq4E5iz4i14NOHwoukYkvOUm
        UFAIjd8olP0RqNHmjjTlssyjDweJFpapjrvVaoYHXKdJgVyWYJfj5v3hNK5uhHstlHh47d
        ykzj2JfUB4RlxG/sLfg05wq1c6IGq3M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Bq5auiqeMMK6DAg_yLh2hA-1; Wed, 23 Jun 2021 09:26:35 -0400
X-MC-Unique: Bq5auiqeMMK6DAg_yLh2hA-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso1316992edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jein3OgAGJf2ndq/BFeAbkmeJx56zKLxIWuxbrPBB4M=;
        b=LgzlvBcm9I+K5RmxUeBM+sjLFA0mck+DzKqhKf+cYs+jqXDMiGO2cGDG7aQxqOftcp
         7t+tDbqqOCvSTPAe9EZK3/iIkVGN5+GMvRUKEVyNrMNVDx6cEtg5F/umbMUokg8YOxTL
         LrPnexFPwYFAeAqQvZeUjBMVdohsuFw3V/7drUiEwftqxeM1JOcTqzEoXGshX7wU3lwW
         oZykLVGxgKPIYIn9iNn2nG1MinL/iJCnpU5pEjwOQG4/8I2vkrtJhCC89txVBRGYO9f5
         Pn/4122LkOoUBEveN5eSSlMsgQZB/uQXvdj5DA+ljw+YNjr/TA2gac8EDm4e/E8TO/2U
         ACpg==
X-Gm-Message-State: AOAM533XDdXSc5g4yQl4SHWaHkJu002Fz+4rBX2gig/Av1SqNs7rCoyl
        qiWQkVY3IZnSvjtAKD0Q8J1a7UExRqZ8rdcR2JJ2LQEUTb75VQ2c9Xzk2LYPcOXDx6HCQbynhQX
        795RdeS7IlyN+JMcjfiQ7/RRv
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr12194105edc.378.1624454794585;
        Wed, 23 Jun 2021 06:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzlSOxb7lbpcotdS4uDG5xrI8FxTSTF/ULhHzfoh+poh7JEazeDY32Kvg1DyKRveBLBSH1ww==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr12194086edc.378.1624454794437;
        Wed, 23 Jun 2021 06:26:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id mm27sm5462669ejb.67.2021.06.23.06.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:26:33 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Don't WARN on a NULL shadow page in TDP MMU
 check
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
References: <20210622072454.3449146-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acb21d4b-679c-69ee-584a-85a6723ace96@redhat.com>
Date:   Wed, 23 Jun 2021 15:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622072454.3449146-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 09:24, Sean Christopherson wrote:
> Treat a NULL shadow page in the "is a TDP MMU" check as valid, non-TDP
> root.  KVM uses a "direct" PAE paging MMU when TDP is disabled and the
> guest is running with paging disabled.  In that case, root_hpa points at
> the pae_root page (of which only 32 bytes are used), not a standard
> shadow page, and the WARN fires (a lot).
> 
> Fixes: 0b873fd7fb53 ("KVM: x86/mmu: Remove redundant is_tdp_mmu_enabled check")
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Queued, thanks.

Paolo

> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> index b981a044ab55..1cae4485b3bc 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.h
> +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> @@ -94,11 +94,13 @@ static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
>   	if (WARN_ON(!VALID_PAGE(hpa)))
>   		return false;
>   
> +	/*
> +	 * A NULL shadow page is legal when shadowing a non-paging guest with
> +	 * PAE paging, as the MMU will be direct with root_hpa pointing at the
> +	 * pae_root page, not a shadow page.
> +	 */
>   	sp = to_shadow_page(hpa);
> -	if (WARN_ON(!sp))
> -		return false;
> -
> -	return is_tdp_mmu_page(sp) && sp->root_count;
> +	return sp && is_tdp_mmu_page(sp) && sp->root_count;
>   }
>   #else
>   static inline bool kvm_mmu_init_tdp_mmu(struct kvm *kvm) { return false; }
> 

