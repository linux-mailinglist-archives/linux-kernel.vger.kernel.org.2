Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB80843652D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhJUPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634828993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83A37QZOYVvxXVFXpAnu1+exjyyjf1N0SkLxb+/5xyI=;
        b=LZ0+fkSoxTQgIsqnx41GVHHHTZPSafH9f06E5H8p/tXH5xrfpD0H/TRp7WulROwwsrCV8u
        s4bo7+SfKKTSSY68DrQ3OAQa6uO+Txc29I/4xtYSneWfdiCRp9BuEkIoWDBuoByEnHK7uU
        a2LYlOVUiep0ygklyaSgdNvjWWVNSe0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-624ctmAQOG6to1NlDx0nwQ-1; Thu, 21 Oct 2021 11:09:51 -0400
X-MC-Unique: 624ctmAQOG6to1NlDx0nwQ-1
Received: by mail-ed1-f70.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so663479edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=83A37QZOYVvxXVFXpAnu1+exjyyjf1N0SkLxb+/5xyI=;
        b=bEjAfkEqUAoQFtY0CHkfhHlA78jYItZvyRgcg5KyKDaoqpFnfUl2euy8GS7M00QRi8
         l0zvMtBL5weBXzGyco39Naq8EnaY+E02WC3jeiaRIBZoQdaaO+6SA765xfy96C69/S0W
         HRhRb+0609vWxb2kwb8B3QdXbllexOS3MZQ/Ccu2NnKi4nyQRCv2AHHW/+MlzpvW4Eth
         fkLySq9MviiNTJaqF8k/nq/EFQYthIWAz6mDd2t3luDBSYVoKVTwznd6EU/0hBwUvFVf
         dv+pF2hDflCvmRdRFwpFQMRLi0hZmg1Uvr36FYwBZ3up4v/AYndmOohb1CvNrAv/DPm/
         pfkw==
X-Gm-Message-State: AOAM530LU8B4Aj2aI0FIhBiqUiCtlBbMdYUSIZNrBmo4k5wsdYnTf2d+
        nqbAzEvNSq4iGt/L/eRbBkWcJ79WGj7mtabQbYLGPND6BdGOdRf7b0OIvtvb7p/M/3lqHpJXHJV
        9MDbi91udC5vg7w5QsxPT8Xpy
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr7896382eji.434.1634828990613;
        Thu, 21 Oct 2021 08:09:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5osbNure7kSj2eOIIMK7ExqhTuzbJFqJ//gd+55tzrFkDqZraDqizfEQvo3PILlPFqdhHHw==
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr7896361eji.434.1634828990358;
        Thu, 21 Oct 2021 08:09:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r16sm2615032ejj.89.2021.10.21.08.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:09:49 -0700 (PDT)
Message-ID: <347b2e6f-8075-b15e-7d53-a6050856754f@redhat.com>
Date:   Thu, 21 Oct 2021 17:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: MMU: Reset mmu->pkru_mask to avoid stale data
Content-Language: en-US
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021071022.1140-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211021071022.1140-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/21 09:10, Chenyi Qiang wrote:
> When updating mmu->pkru_mask, the value can only be added but it isn't
> reset in advance. This will make mmu->pkru_mask keep the stale data.
> Fix this issue.
> 
> Fixes: commit 2d344105f57c ("KVM, pkeys: introduce pkru_mask to cache conditions")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c6ddb042b281..fe73d7ee5492 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4556,10 +4556,10 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
>   	unsigned bit;
>   	bool wp;
>   
> -	if (!is_cr4_pke(mmu)) {
> -		mmu->pkru_mask = 0;
> +	mmu->pkru_mask = 0;
> +
> +	if (!is_cr4_pke(mmu))
>   		return;
> -	}
>   
>   	wp = is_cr0_wp(mmu);
>   
> 

Queued, thanks.

Paolo

