Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0238FC55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEYINV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231319AbhEYIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjNqiqiXVGP3DJ5wl1DJMtCI9aa0pRIGSjankLipvdY=;
        b=BYv1wIrxkH8IQioGzt+y5PuY4MZF+pULFyIJtWK0mv7+HQ8U2/k+iiiagmvw7uVrNufaUS
        CHmqsxfEWyj9aGE5TWEINnCMIk6vWbQ5bCVfpa86tZG9/FbA/Ou7l0udETr1crMUIJ3vyD
        8vdUQF3hcYxPx0dVSiOw0zImmyybS0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-UO_6TPnYNnyuERs59x8lPw-1; Tue, 25 May 2021 04:01:23 -0400
X-MC-Unique: UO_6TPnYNnyuERs59x8lPw-1
Received: by mail-wr1-f70.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso14222181wrj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JjNqiqiXVGP3DJ5wl1DJMtCI9aa0pRIGSjankLipvdY=;
        b=rL1tMTDQ9Bd7YgnjiiE3CO9dOz58bdhYmv9jDOn2snAIZqeQmSFZowbLf5ZblRfJHj
         1StF8J9rg8Z6BbBhSRfx136ec9eEOMCMXjfab7E+ZB7ws7GRh+fVqoXxRCV/qpe5aESu
         Mtx0m1bKipZogQ3pnKF5YDehLLwo5Zm6m38SZ1kPEnk8ptTwiFSS83tdmJ8Sj+h//zJf
         QTkZE5KTklH4gBmJvm02s/blRE1U0cSm8SWwsq1Ibm0QnukniA5cQXgXUBchDxLjbbIl
         wYoM67WG2nbJzFZYVSk0gvuQTgJVlJil9mNLlGTvi/5Sv0bs3vgwYR60l09GRHFgPTvM
         WlTw==
X-Gm-Message-State: AOAM5304jYc1bCCep2q0aW4lnZjSYhhLkbx0ux6B8Jx8Ud2aDNFK/KQn
        964GPzd0X3hktCvg8r05X9qrCumhhbcJqdH+TD5nXOtgAw07Uhioc8jJyHVoF80ZbL0ybLuLRSQ
        5VLCzuYmsL0yw6L/uZRr8GNPy
X-Received: by 2002:a1c:4602:: with SMTP id t2mr2512685wma.173.1621929682747;
        Tue, 25 May 2021 01:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzikjnPJqkXBvfVZB+3A6fA3p1ARG+OLBPRXRyF31+3yFFLV71/sueRzeVrJeNPVTYKkRuaTQ==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr2512665wma.173.1621929682533;
        Tue, 25 May 2021 01:01:22 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id p10sm14153763wrr.58.2021.05.25.01.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 01:01:22 -0700 (PDT)
Subject: Re: [PATCH 5/5] mm/page_alloc: improve memmap_pages and dma_reserve
 dbg msg
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-6-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <69b5a56c-e9a0-01e7-5fd5-78c6e656fa68@redhat.com>
Date:   Tue, 25 May 2021 10:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517112044.233138-6-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 13:20, Dong Aisheng wrote:
> Make debug message more accurately.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   mm/page_alloc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3100fcb08500..16f494352f58 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7263,14 +7263,15 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>   					pr_debug("  %s zone: %lu pages used for memmap\n",
>   						 zone_names[j], memmap_pages);
>   			} else
> -				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
> +				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
>   					zone_names[j], memmap_pages, freesize);
>   		}
>   
>   		/* Account for reserved pages */
>   		if (j == 0 && freesize > dma_reserve) {
>   			freesize -= dma_reserve;
> -			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
> +			pr_debug("  %s zone: %lu pages reserved for dma\n",
> +				 zone_names[0], dma_reserve);

... which is not really correct I think. See the comment above 
set_dma_reserve(). It's called dma_reserve because it involves the first 
zone -- where many unfreeable allocations like the kernel image end up.

Memory is not reserved for dma purposes ... and the zone name should be 
sufficient.

-- 
Thanks,

David / dhildenb

