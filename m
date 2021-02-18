Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC131EAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhBROfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:35:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhBRMmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613652001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeSRfXB/Q1c+GMlNdrKzm8+h6F8KMuy7PI9uKSadzg4=;
        b=Q58YMDeabgpL8A7gS6vfIWUKwuHHHr8t6tTs9o8hIe5RD0Lg9bNn4RNzObOcngFaRkANai
        v6ekOg7xLDZtvIFz+90mSgR6Tl+r4U3N5RMZ0toIP960w2RRlgldfoHhrkyp1qgudnvmN7
        CZ25KF4BXAxa+Znnn3V7lz/F8QDr7cI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-wfsCNcCePSqsx2nSf-u-HQ-1; Thu, 18 Feb 2021 07:36:26 -0500
X-MC-Unique: wfsCNcCePSqsx2nSf-u-HQ-1
Received: by mail-wr1-f69.google.com with SMTP id e11so891771wro.19
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FeSRfXB/Q1c+GMlNdrKzm8+h6F8KMuy7PI9uKSadzg4=;
        b=LAwyfouofibKFbeC5HUi6a2vcmZCUwWrAKPTnwPYhOiIMKfYxtXMEQ2Ukn5uBEjx5I
         xpKjBB/nAiegcPBOdAzn6BFi7Omu4x/HVC2CSYNcOt8VoC0a3jgB/St4dlxaqOmFW97r
         wRcuBA5GbaqofoY0B7KS471RvqIG3kYfwSNU0rpUaEsRwKfZgErh9lNOYAijIdIVThWE
         CUIu0l27WKz3HY/zNHsX9wGevPU3q4jSnEKFSy0oxCCI7HKVyL4IpGNV7+0kiSDHSts8
         +h837WMm7JZFOKVVl+uLe+EbvTdKca1xMsOIVt15usWgR8MPSAMGPsf3zRooM9jgZZXm
         spoQ==
X-Gm-Message-State: AOAM530RxZVJJcSO/TDLte8XGGAvdBpMDZzcDWIwrVcn1rGqVgfz9LRh
        +iltAkUWQfn4Q+y1hWctlhJYKOTjFsC33C/MBfW3YIBt/MiUvhevDH9I6dnJPry9tI2kXZyM3ir
        WLghBnQOcib8HkuGVKi6lwrRE
X-Received: by 2002:a1c:7501:: with SMTP id o1mr3308573wmc.105.1613651785234;
        Thu, 18 Feb 2021 04:36:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxM5WuhP7F/xkxk9ujCYy31ES9pJdjMKDKlfSLART+drS15HS9yZjSWYRkE/qVthhExGmUnUg==
X-Received: by 2002:a1c:7501:: with SMTP id o1mr3308556wmc.105.1613651784983;
        Thu, 18 Feb 2021 04:36:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id v11sm9193130wrr.3.2021.02.18.04.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 04:36:23 -0800 (PST)
Subject: Re: [PATCH 01/14] KVM: x86/mmu: Expand collapsible SPTE zap for TDP
 MMU to ZONE_DEVICE pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <264690d4-77f6-edc1-5867-da011fbc70c5@redhat.com>
Date:   Thu, 18 Feb 2021 13:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213005015.1651772-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 01:50, Sean Christopherson wrote:
> Zap SPTEs that are backed by ZONE_DEVICE pages when zappings SPTEs to
> rebuild them as huge pages in the TDP MMU.  ZONE_DEVICE huge pages are
> managed differently than "regular" pages and are not compound pages.
> 
> Cc: Ben Gardon <bgardon@google.com>
> Fixes: 14881998566d ("kvm: x86/mmu: Support disabling dirty logging for the tdp MMU")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 71e100a5670f..3cc332ed099d 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1348,7 +1348,8 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
>   
>   		pfn = spte_to_pfn(iter.old_spte);
>   		if (kvm_is_reserved_pfn(pfn) ||
> -		    !PageTransCompoundMap(pfn_to_page(pfn)))
> +		    (!PageTransCompoundMap(pfn_to_page(pfn)) &&
> +		     !kvm_is_zone_device_pfn(pfn)))
>   			continue;
>   
>   		tdp_mmu_set_spte(kvm, &iter, 0);
> 

I added a note to the commit message that a similar check is found in 
kvm_mmu_zap_collapsible_spte.

Paolo

