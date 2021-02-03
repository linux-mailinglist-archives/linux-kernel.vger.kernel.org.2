Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8F30D68A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhBCJpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233206AbhBCJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612345406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8JlE3EMtIPG4yCYd+JdmIn+AhVOjwW2E0U1D9Qnw6LQ=;
        b=fi8SRjoTf88esqi5Iog2hXOBp8sF8wzuibrvOntX1BhugDiliFGlcA5RMwqYyPdsMZ/LN1
        OonDCQpBmfP0QifWlzbxWU0ScW3g4o6HI19DxzCUwYPEIY3IK5qcZmlbGHgOw04LVamIGg
        oVEixwP6pbbkC93/Iyu3pJwUQZMbBMk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-6AKbNT1oNl6F8s0749jYxw-1; Wed, 03 Feb 2021 04:43:22 -0500
X-MC-Unique: 6AKbNT1oNl6F8s0749jYxw-1
Received: by mail-ed1-f70.google.com with SMTP id ay16so2238187edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JlE3EMtIPG4yCYd+JdmIn+AhVOjwW2E0U1D9Qnw6LQ=;
        b=Tb9wBY8dISupfIH/Bx3QEVCIGTLYu6cuhmA+DY3x7EGkYUCqewzVpBJyXu0bv4/Pqz
         tv99P0m6bzH5QdiA7lPWldH4OS1FU1dFWoSPBQZUgTNjHI/p8WT2+3/SNEuCNwWiBPWc
         PKw3NEt0cfWtbcb+XWG/2qqF1R2tHh8HM7ur1NwumWdh6znQ370PIXmC1hPkr6Bazdoo
         gboL0mOo6NQpWZM13a54Ip7i1HsLKXEyaE7Vht48lg2r1FFwSESDMlQUm2pRDXJPfHYH
         sTy99KaLl2PWikYjPPYo40wiuUdrJEb2r8q9rBpERR37JE70V72HJZfKbwsLVK7F9pyV
         drJA==
X-Gm-Message-State: AOAM530KTcFedC9MZyd3C7lmmq6A7ibbP1JWyb++16ykz/2+5BQ7K22W
        1z/qN125TEftobq1Yw5/qAvFj7Pe3YqXNOJUKnnzPhuRw4xUr51eoO5ixfoCdcPPjPuTNspX3Zy
        0r5TGhvSq9/mHJMcVPtG/zSIc
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr2297887ejc.466.1612345401122;
        Wed, 03 Feb 2021 01:43:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE4w0SXKWGuwkGTges5EuIVt6D0Y/P3+luaD05sg14cWZ/nhDE7xP9Qy9/NVNV/hAIky3YOg==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr2297878ejc.466.1612345400921;
        Wed, 03 Feb 2021 01:43:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j23sm599190edv.45.2021.02.03.01.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 01:43:20 -0800 (PST)
Subject: Re: [PATCH v2 10/28] KVM: x86/mmu: Fix TDP MMU zap collapsible SPTEs
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-11-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbb72860-3f3a-e1e7-361f-2961a5a526c1@redhat.com>
Date:   Wed, 3 Feb 2021 10:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> There is a bug in the TDP MMU function to zap SPTEs which could be
> replaced with a larger mapping which prevents the function from doing
> anything. Fix this by correctly zapping the last level SPTEs.
> 
> Fixes: 14881998566d ("kvm: x86/mmu: Support disabling dirty logging for the tdp MMU")
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index c3075fb568eb..e3066d08c1dc 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1098,8 +1098,8 @@ bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot)
>   }
>   
>   /*
> - * Clear non-leaf entries (and free associated page tables) which could
> - * be replaced by large mappings, for GFNs within the slot.
> + * Clear leaf entries which could be replaced by large mappings, for
> + * GFNs within the slot.
>    */
>   static void zap_collapsible_spte_range(struct kvm *kvm,
>   				       struct kvm_mmu_page *root,
> @@ -1111,7 +1111,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
>   
>   	tdp_root_for_each_pte(iter, root, start, end) {
>   		if (!is_shadow_present_pte(iter.old_spte) ||
> -		    is_last_spte(iter.old_spte, iter.level))
> +		    !is_last_spte(iter.old_spte, iter.level))
>   			continue;
>   
>   		pfn = spte_to_pfn(iter.old_spte);
> 

Queued for 5.11-rc, thanks.

Paolo

