Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB60037616F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhEGHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235878AbhEGHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620373704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WD7r2JQtvlTzyvMK3Pf5d+3elrc1CD6XezsQIERJnSo=;
        b=fbUkQJoplCAaLdgVBbGoTH37k+HgwaOXm0H97upBLYBBYlQVR+e6X1ayBZIi5c1tcU0q9Z
        GvNfQGRkZ1Zt/C1F56tPSTFDn5UA/YCJXBTRsxpppCl0mC5xsfqX4HDvHeVNZrxpLniBbM
        znRfjXm+azdZFhZ9OgIcKKMcE2DxdiY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-1vmiun1_NJapfpfjDeMu5g-1; Fri, 07 May 2021 03:48:22 -0400
X-MC-Unique: 1vmiun1_NJapfpfjDeMu5g-1
Received: by mail-wr1-f70.google.com with SMTP id t18-20020adfdc120000b02900ffe4432d8bso3238361wri.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WD7r2JQtvlTzyvMK3Pf5d+3elrc1CD6XezsQIERJnSo=;
        b=Pw+KBw6cSzmZAETz5avEbu75ELUqDC6m3h9LFeg2mUHVIHQ9XR46OCudCfZRzikOaf
         R+njtc83LfYIbvEZglV7XE5amXmEDN3kn5oJJeYUpzcpT4X98woqAksJXURlqDANEqFp
         Z0nKwjEfS3cbBxmaSlyiGSqTpHrQZkQnDv0nVFvVbIorw3rp4my/OmbMWo30At83XLf2
         ibw6/1uPhTzh6XpYE7k4BYMIjGmJu6f2P1SKEeOk5fCikwSof8KCVK5dEktE4FQT+YZb
         887R+QbCp0mIZz2HNfFiaoFXQIPBiRUGPBaZWAEN0MR3S200HbpIfEiWz1ungHxI6LhN
         +x7A==
X-Gm-Message-State: AOAM531YYqpYlIElGDeG/BruetR6ygLdGSwzG9oV9p9uTrdQW0FhsjIw
        IWe6EvqSyxNZpSoh4y/7+zfiPSHfAkhWi9oQ/2c9eEeGWyVhI14nQ+yt/iyBFnH9s28hAFWMmEW
        g3rFBjya8p1zIyYuGpq01um8v
X-Received: by 2002:adf:ed43:: with SMTP id u3mr10521135wro.334.1620373701372;
        Fri, 07 May 2021 00:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Xp4Xil7ssE0k+V5LYNHt8+OhdUr7lfJvCRSeJy9RusgymqI+68/egfYrjCnZ7siNjWEuqA==
X-Received: by 2002:adf:ed43:: with SMTP id u3mr10521116wro.334.1620373701194;
        Fri, 07 May 2021 00:48:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63c0.dip0.t-ipconnect.de. [91.12.99.192])
        by smtp.gmail.com with ESMTPSA id s6sm13145893wms.0.2021.05.07.00.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:48:20 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] KVM: mmu: Refactor memslot copy
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20210506184241.618958-1-bgardon@google.com>
 <20210506184241.618958-4-bgardon@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7c2be781-7a10-a1b3-a8e8-d26ff4100746@redhat.com>
Date:   Fri, 7 May 2021 09:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506184241.618958-4-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 20:42, Ben Gardon wrote:
> Factor out copying kvm_memslots from allocating the memory for new ones
> in preparation for adding a new lock to protect the arch-specific fields
> of the memslots.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   virt/kvm/kvm_main.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2799c6660cce..c8010f55e368 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1306,6 +1306,18 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
>   	return old_memslots;
>   }
>   
> +static size_t kvm_memslots_size(int slots)
> +{
> +	return sizeof(struct kvm_memslots) +
> +	       (sizeof(struct kvm_memory_slot) * slots);

no need for the extra set of parentheses

> +}
> +
> +static void kvm_copy_memslots(struct kvm_memslots *from,
> +			      struct kvm_memslots *to)
> +{
> +	memcpy(to, from, kvm_memslots_size(from->used_slots));
> +}
> +
>   /*
>    * Note, at a minimum, the current number of used slots must be allocated, even
>    * when deleting a memslot, as we need a complete duplicate of the memslots for
> @@ -1315,19 +1327,16 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
>   					     enum kvm_mr_change change)
>   {
>   	struct kvm_memslots *slots;
> -	size_t old_size, new_size;
> -
> -	old_size = sizeof(struct kvm_memslots) +
> -		   (sizeof(struct kvm_memory_slot) * old->used_slots);
> +	size_t new_size;
>   
>   	if (change == KVM_MR_CREATE)
> -		new_size = old_size + sizeof(struct kvm_memory_slot);
> +		new_size = kvm_memslots_size(old->used_slots + 1);
>   	else
> -		new_size = old_size;
> +		new_size = kvm_memslots_size(old->used_slots);
>   
>   	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
>   	if (likely(slots))
> -		memcpy(slots, old, old_size);
> +		kvm_copy_memslots(old, slots);
>   
>   	return slots;
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

