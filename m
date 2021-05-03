Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733AF371823
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhECPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhECPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620056412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecMiMtDwOcYd8qIxuahdOpynUJcA9qmTkIzOJwjDg3g=;
        b=TXnCUaUVW9V3bxW00i1l8GaQTDq0osms5OTF/g2I9ry+CBMr84FBkiJpvxxqXTfmFTayfx
        ob//YMUoYTDUx2dM/tITiEMOU5R6BFHEdH9R91HBFVzmKBNPjFPCe0BBW6d9/M/bQo0I7H
        WrQv06VRUYN4YsZY4HQd8rmv2pbZztc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Yhg7LhHENXS8UyXxVc5U_g-1; Mon, 03 May 2021 11:40:10 -0400
X-MC-Unique: Yhg7LhHENXS8UyXxVc5U_g-1
Received: by mail-ej1-f71.google.com with SMTP id n10-20020a1709061d0ab029037caa96b8c5so2237263ejh.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecMiMtDwOcYd8qIxuahdOpynUJcA9qmTkIzOJwjDg3g=;
        b=CMQDSAoetw98tHQJd78Rfg9T1fGWrSurfrsY/1noRupaBLBR7mITgQnZrDPiEiHcgy
         SWZQQQvoLNSmNY7vD5U0ARoUC3+IvP7P7UY/thS+ksxPGu+Xlhqym9fj9BGtorw2iKl1
         Rq6XgmwSOJG4BwH4LIr26ucMmH+DfivmYLPvLtpalkhJBY+lC8DlPx7pAf91JwvGaXLV
         mZYZCnTmqfedhxg/L7/gtERxQXPYIL082Tf/7dUQe0WtDFJ4Hfe/agALN7P0zOtM92XC
         f6Yjs0p1aKNbOlNd06fzP1j1eqYbrE4hXiL7MEqJIch3gg+s2VWgLNzJbd8BFqZrMthw
         7ucQ==
X-Gm-Message-State: AOAM533kKK+/rW4HX5ICKrNC4GuIbnCqZkq4YH6UaHVF1HEz5ywZ2gK2
        64/znKyYDGgp4/tEnHT3NNjDQNW93YSrmpigbUQET2jksb2pF7r4AAMIkVdKBaiwF/KB72tEQQl
        EMAFO9FozkDRRcS5a0ROrjk67mIj6UB6xiWlGiNNz544Agy743IsVW/J/72kCzaJdq9F7tjWuJY
        1A
X-Received: by 2002:a05:6402:3495:: with SMTP id v21mr20519086edc.117.1620056409264;
        Mon, 03 May 2021 08:40:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCSWEMOnAvKantgHsr2jFZf8+i4gKIV4OBcQbyNrP5M1pmL92Cx59EovfRT5ncXaNeES8sUw==
X-Received: by 2002:a05:6402:3495:: with SMTP id v21mr20519062edc.117.1620056409030;
        Mon, 03 May 2021 08:40:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y16sm37248ejp.36.2021.05.03.08.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:40:08 -0700 (PDT)
Subject: Re: [PATCH] doc/kvm: Fix wrong entry for KVM_CAP_X86_MSR_FILTER
To:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Graf <graf@amazon.com>
Cc:     Alexander Graf <graf@amazon.de>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210503120059.9283-1-sidcha@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9be335ec-dcd4-97de-5f50-92c0dfc37df7@redhat.com>
Date:   Mon, 3 May 2021 17:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503120059.9283-1-sidcha@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 14:00, Siddharth Chandrasekaran wrote:
> The capability that exposes new ioctl KVM_X86_SET_MSR_FILTER to
> userspace is specified incorrectly as the ioctl itself (instead of
> KVM_CAP_X86_MSR_FILTER). This patch fixes it.
> 
> Fixes: 1a155254ff93 ("KVM: x86: Introduce MSR filtering")
> Cc: Alexander Graf <graf@amazon.de>
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>   Documentation/virt/kvm/api.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 307f2fcf1b02..e778f4aa08f4 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4713,7 +4713,7 @@ KVM_PV_VM_VERIFY
>   4.126 KVM_X86_SET_MSR_FILTER
>   ----------------------------
>   
> -:Capability: KVM_X86_SET_MSR_FILTER
> +:Capability: KVM_CAP_X86_MSR_FILTER
>   :Architectures: x86
>   :Type: vm ioctl
>   :Parameters: struct kvm_msr_filter
> @@ -6586,7 +6586,7 @@ accesses that would usually trigger a #GP by KVM into the guest will
>   instead get bounced to user space through the KVM_EXIT_X86_RDMSR and
>   KVM_EXIT_X86_WRMSR exit notifications.
>   
> -8.27 KVM_X86_SET_MSR_FILTER
> +8.27 KVM_CAP_X86_MSR_FILTER
>   ---------------------------
>   
>   :Architectures: x86
> 

Queued, thanks.

Paolo

