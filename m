Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C422C416350
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbhIWQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242349AbhIWQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/oIhWC7fKtGzqQpQFubKmVS4zDGgUypTCxx/i3WpJk=;
        b=Ep3Me2D3rqt+IQs7c1bqIw65ePUelRnmmTywYXH2mg6DIR8ClMX/AR/PdIdFgSTIAOyXqo
        F0ECOv9vTqXG602nCLMVJqbS26z7doO/Df5UI82brF9M567JYNVqizpTkpbPEZXV08eX7Z
        rkNdkGg1Y/cDrCBj6+bTyXWQlkqNT9A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-OEkTdMc2PdmOO81N7cm0Hg-1; Thu, 23 Sep 2021 12:27:09 -0400
X-MC-Unique: OEkTdMc2PdmOO81N7cm0Hg-1
Received: by mail-ed1-f69.google.com with SMTP id e7-20020aa7d7c7000000b003d3e6df477cso7243178eds.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/oIhWC7fKtGzqQpQFubKmVS4zDGgUypTCxx/i3WpJk=;
        b=IdJX0xoNEZXsaxH4t/IJgfXf3tsWqq9LyOR8MsNT/K0YiAKN+4mfBEXjZ6dFtMRpm4
         quMhx4Wda7pZ2WGVeSB9/g3A/ICe51cWP5K5qZfb1VwCcR7ZKz4YC05uSaHzEAwUo1lj
         GtV3hwNq8mjosuofntvNLO956cDku91NaAFHU0rXJB3/gl7HoGhvtOiaHDs0aUi9C1S9
         /hHn3DSKd2hQQetbg8TToZImvQQ3gh9WbCCarJyI7EKX6PqGxr5MSZ052qH1fn1p5u5e
         atzBHxi9ybDFemIreiyt8yCqQJkKeJTSAWAZTCRs7Mndu/WV5nTbKeXPC+1EYsTzdAAY
         YhsA==
X-Gm-Message-State: AOAM531XeKKt1Xffih/i/S72VGPIyTkY3qROsG4+M6dU6875cr93KeFZ
        xdcV9duE03YqJE2xdS6Qk9d5TkyVAZTvtWQO9AusozwOiSCwJdX7cIdDNkihv5VuUvGbWcTFRWN
        lZUCj/BKnu9pg48Ry3CBCDL3O
X-Received: by 2002:a50:9d44:: with SMTP id j4mr6516102edk.173.1632414427950;
        Thu, 23 Sep 2021 09:27:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjtsayXjj1zF617T7nkdYFU89qfJnNI5OfixDS0D2PT/D4EIs3CWG+OjES7T9V4qthIO2T+g==
X-Received: by 2002:a50:9d44:: with SMTP id j4mr6516062edk.173.1632414427707;
        Thu, 23 Sep 2021 09:27:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u10sm3720729eds.83.2021.09.23.09.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:27:07 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Complete prefetch for trailing SPTEs for
 direct, legacy MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Ben Gardon <bgardon@google.com>
References: <20210818235615.2047588-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c47ae22f-39ba-7f6b-c9c4-105a2e4c026d@redhat.com>
Date:   Thu, 23 Sep 2021 18:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818235615.2047588-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/21 01:56, Sean Christopherson wrote:
> Make a final call to direct_pte_prefetch_many() if there are "trailing"
> SPTEs to prefetch, i.e. SPTEs for GFNs following the faulting GFN.  The
> call to direct_pte_prefetch_many() in the loop only handles the case
> where there are !PRESENT SPTEs preceding a PRESENT SPTE.
> 
> E.g. if the faulting GFN is a multiple of 8 (the prefetch size) and all
> SPTEs for the following GFNs are !PRESENT, the loop will terminate with
> "start = sptep+1" and not prefetch any SPTEs.
> 
> Prefetching trailing SPTEs as intended can drastically reduce the number
> of guest page faults, e.g. accessing the first byte of every 4kb page in
> a 6gb chunk of virtual memory, in a VM with 8gb of preallocated memory,
> the number of pf_fixed events observed in L0 drops from ~1.75M to <0.27M.
> 
> Note, this only affects memory that is backed by 4kb pages as KVM doesn't
> prefetch when installing hugepages.  Shadow paging prefetching is not
> affected as it does not batch the prefetches due to the need to process
> the corresponding guest PTE.  The TDP MMU is not affected because it
> doesn't have prefetching, yet...
> 
> Fixes: 957ed9effd80 ("KVM: MMU: prefetch ptes when intercepted guest #PF")
> Cc: Sergey Senozhatsky <senozhatsky@google.com>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Cc'd Ben as this highlights a potential gap with the TDP MMU, which lacks
> prefetching of any sort.  For large VMs, which are likely backed by
> hugepages anyways, this is a non-issue as the benefits of holding mmu_lock
> for read likely masks the cost of taking more VM-Exits.  But VMs with a
> small number of vCPUs won't benefit as much from parallel page faults,
> e.g. there's no benefit at all if there's a single vCPU.
> 
>   arch/x86/kvm/mmu/mmu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a272ccbddfa1..daf7df35f788 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2818,11 +2818,13 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
>   			if (!start)
>   				continue;
>   			if (direct_pte_prefetch_many(vcpu, sp, start, spte) < 0)
> -				break;
> +				return;
>   			start = NULL;
>   		} else if (!start)
>   			start = spte;
>   	}
> +	if (start)
> +		direct_pte_prefetch_many(vcpu, sp, start, spte);
>   }
>   
>   static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
> 

Queued, thanks.

Paolo

