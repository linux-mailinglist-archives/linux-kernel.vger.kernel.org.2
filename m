Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E93FD763
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhIAKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhIAKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630491071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qvu8f0am/SlQm3BBQ8kcFlHtYY52i34qaBeBiT+B1I=;
        b=Y/zg4yYoObhWURXKwtRBtncM1SHUDWoaj+p9JqRsl0T2yD9gfaNqNRwS7bxECMBVBWShLq
        hNVvuR/wrkX4iVh9QAErUCzbJ4ni1nWk0WGDvjhWkskLV165z1vB7ApebkUY2qa1/igU2s
        DCo8US6NMdyVwcSfhw2wKxZ04qpFpTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-Cx7sk-RiPwiKvzrxirPcbQ-1; Wed, 01 Sep 2021 06:11:07 -0400
X-MC-Unique: Cx7sk-RiPwiKvzrxirPcbQ-1
Received: by mail-wm1-f71.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so2606157wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Qvu8f0am/SlQm3BBQ8kcFlHtYY52i34qaBeBiT+B1I=;
        b=D9maZiq0GOVJqo6efIkuoOxzFi63BC0qaK2RVel1Vsz22dRWJDrhgP55Mj1jzkUYFW
         03SErcVMu7rAIWzpk8AyHZct2fRIj7HoPlMfuthahOMLwEjpskS883Kk9i/e0lA5of9o
         dkSsanlT9Ez4/Fgqd5R10WdwgmI5dNKTaHZCOGBEqvRmAXeUpU/yBaANbD8FW87XMJwa
         BBKMmfgEyf6AnrprLbvQ2swywt9InmXeWSL1gHNonWaSlI4XyT8+kKXhfp7okPOlsQ/2
         NE/Yya313+SLyZs/G3H2P+a9qEoP+4/jIGjZz/6PeMHlSmBXbakW42POwDIUcfKAx1f6
         JWFw==
X-Gm-Message-State: AOAM530/6SFiiRyLEV36ZTvCb3FjY1Jq+tjMXcNgu6xLaN5Q4qJH/f8C
        0ild6Ig119NAb5JxE0iFx0jANr5Kx/d2OVz+hB31tyzrEqPOT4/iJ8Uv9IdSdfZMUqT3nVPskKW
        AfwJp8QhCU57rLfWVGiHb0qK7
X-Received: by 2002:adf:dbd0:: with SMTP id e16mr36434444wrj.402.1630491066747;
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoJvOC5ivwrzHTukER5oblEKCEnKLApZDh0Fa4VvnmniV9qnGBK5T9FaXi46sq4fgGHu226Q==
X-Received: by 2002:adf:dbd0:: with SMTP id e16mr36434410wrj.402.1630491066497;
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id u26sm19587498wrd.32.2021.09.01.03.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
Subject: Re: [PATCH 1/1] mm/early_ioremap.c: remove redundant
 early_ioremap_shutdown()
To:     Weizhao Ouyang <o451686892@gmail.com>, arnd@arndb.de,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210901082917.399953-1-o451686892@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ca43a9f-b62d-26df-0b9c-1cfa2f7dc611@redhat.com>
Date:   Wed, 1 Sep 2021 12:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901082917.399953-1-o451686892@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 10:29, Weizhao Ouyang wrote:
> early_ioremap_reset() reserved a weak function so that architectures can
> provide a specific cleanup. Now no architectures use it, remove this
> redundant function.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   include/asm-generic/early_ioremap.h | 6 ------
>   mm/early_ioremap.c                  | 5 -----
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
> index 9def22e6e2b3..9d0479f50f97 100644
> --- a/include/asm-generic/early_ioremap.h
> +++ b/include/asm-generic/early_ioremap.h
> @@ -19,12 +19,6 @@ extern void *early_memremap_prot(resource_size_t phys_addr,
>   extern void early_iounmap(void __iomem *addr, unsigned long size);
>   extern void early_memunmap(void *addr, unsigned long size);
>   
> -/*
> - * Weak function called by early_ioremap_reset(). It does nothing, but
> - * architectures may provide their own version to do any needed cleanups.
> - */
> -extern void early_ioremap_shutdown(void);
> -
>   #if defined(CONFIG_GENERIC_EARLY_IOREMAP) && defined(CONFIG_MMU)
>   /* Arch-specific initialization */
>   extern void early_ioremap_init(void);
> diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
> index 164607c7cdf1..74984c23a87e 100644
> --- a/mm/early_ioremap.c
> +++ b/mm/early_ioremap.c
> @@ -38,13 +38,8 @@ pgprot_t __init __weak early_memremap_pgprot_adjust(resource_size_t phys_addr,
>   	return prot;
>   }
>   
> -void __init __weak early_ioremap_shutdown(void)
> -{
> -}
> -
>   void __init early_ioremap_reset(void)
>   {
> -	early_ioremap_shutdown();
>   	after_paging_init = 1;
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

