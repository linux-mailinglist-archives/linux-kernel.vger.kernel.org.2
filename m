Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2B307382
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhA1KQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231811AbhA1KQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611828914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=264k/ES24/5FzBGHM2fYr7IzBwxBwCNGsVT8SMTVVPM=;
        b=ApM+nrpf7PV7A+Grhv8G2ZVY2I9Gtx6KXf19qlq4Tsr7/J+WaCMQb7cWXIl6/lxF43HAXC
        l87TI4BIaQchiYCZ6jZmQ37edDDv6ftjX4vLNCq4Ryar+/x4Dcg9LExCgHSY9GNdni8LJk
        hi4L1KouO7/nCn1AhUJjdUVcjatkRiQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-bAzsECiPPdOlizDuaeO9wA-1; Thu, 28 Jan 2021 05:15:12 -0500
X-MC-Unique: bAzsECiPPdOlizDuaeO9wA-1
Received: by mail-ej1-f70.google.com with SMTP id ar27so835936ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=264k/ES24/5FzBGHM2fYr7IzBwxBwCNGsVT8SMTVVPM=;
        b=PKVCKozquDETifwQvhht7V64CJUVYHvN8U1HCjtljSuxJqPWkZdBBkQaA1snLs5Bc0
         HHk6fBE6YcNjvMz/iP9dPI0YtzRNfcK4B8jucZXGCvj/3PDiYkcGQ5+APxk9G+W9C2EW
         eQhopAkECvBeWIiIzABXs3+6683UUCozZ49quO8HOyPY/8HzJ3B+SNp6GK2AftknvLh8
         cKXrblHzdP4KQ/l3BaXSTAAW46PgB7yrAY2OxNAvswItfKOcKr0azmHTNYxWGjPbWyC+
         Q6Lam3jXlr1cePrfQ/pYYDxJ74qwTKAT7XJxXe0IoxAxoh0k3Knqob5bwcr0rsuJhXVY
         WwrA==
X-Gm-Message-State: AOAM532qFfhg1I02NUv6/GLThhSkrHDuFzizzsSEYzKVyU9tGH1KVjbm
        6xweNX8DAgR9fXlwJP4MlnKwLHfOOEey6ml4/wGT8iaIB4r7mBznSvH/5vSBuCK9B5xP117twx1
        u5j8WIsi08WUIjrespILTygpYSqpm1LcxKDaypCgpXiB7E0Zszr/SvrJspoelSjsV368r9JkR1E
        22
X-Received: by 2002:a05:6402:556:: with SMTP id i22mr12971205edx.56.1611828911400;
        Thu, 28 Jan 2021 02:15:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4SAH7IU0R5i26466TR/gOXJqVjt6mKq2oIXhXos1oK+4OFr5vXHw1ve0htUjPFzXJN36T8Q==
X-Received: by 2002:a05:6402:556:: with SMTP id i22mr12971163edx.56.1611828911092;
        Thu, 28 Jan 2021 02:15:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f22sm2080999eje.34.2021.01.28.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:15:10 -0800 (PST)
Subject: Re: [PATCH V2] Fix unsynchronized access to sev members through
 svm_register_enc_region
To:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210127161524.2832400-1-pgonda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfb1205a-5442-536e-931c-206f4904e188@redhat.com>
Date:   Thu, 28 Jan 2021 11:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127161524.2832400-1-pgonda@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 17:15, Peter Gonda wrote:
> Grab kvm->lock before pinning memory when registering an encrypted
> region; sev_pin_memory() relies on kvm->lock being held to ensure
> correctness when checking and updating the number of pinned pages.
> 
> Add a lockdep assertion to help prevent future regressions.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 1e80fdc09d12 ("KVM: SVM: Pin guest memory when SEV is active")
> Signed-off-by: Peter Gonda <pgonda@google.com>
> 
> V2
>   - Fix up patch description
>   - Correct file paths svm.c -> sev.c
>   - Add unlock of kvm->lock on sev_pin_memory error
> 
> V1
>   - https://lore.kernel.org/kvm/20210126185431.1824530-1-pgonda@google.com/
> 
> ---
>   arch/x86/kvm/svm/sev.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c8ffdbc81709..b80e9bf0a31b 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -342,6 +342,8 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>   	unsigned long first, last;
>   	int ret;
>   
> +	lockdep_assert_held(&kvm->lock);
> +
>   	if (ulen == 0 || uaddr + ulen < uaddr)
>   		return ERR_PTR(-EINVAL);
>   
> @@ -1119,12 +1121,20 @@ int svm_register_enc_region(struct kvm *kvm,
>   	if (!region)
>   		return -ENOMEM;
>   
> +	mutex_lock(&kvm->lock);
>   	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages, 1);
>   	if (IS_ERR(region->pages)) {
>   		ret = PTR_ERR(region->pages);
> +		mutex_unlock(&kvm->lock);
>   		goto e_free;
>   	}
>   
> +	region->uaddr = range->addr;
> +	region->size = range->size;
> +
> +	list_add_tail(&region->list, &sev->regions_list);
> +	mutex_unlock(&kvm->lock);
> +
>   	/*
>   	 * The guest may change the memory encryption attribute from C=0 -> C=1
>   	 * or vice versa for this memory range. Lets make sure caches are
> @@ -1133,13 +1143,6 @@ int svm_register_enc_region(struct kvm *kvm,
>   	 */
>   	sev_clflush_pages(region->pages, region->npages);
>   
> -	region->uaddr = range->addr;
> -	region->size = range->size;
> -
> -	mutex_lock(&kvm->lock);
> -	list_add_tail(&region->list, &sev->regions_list);
> -	mutex_unlock(&kvm->lock);
> -
>   	return ret;
>   
>   e_free:
> 

Queued, thanks.

Paolo

