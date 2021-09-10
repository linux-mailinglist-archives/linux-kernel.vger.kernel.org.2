Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD3406AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhIJLSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhIJLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631272622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgmNRK2XXvsyGHVA6iNyBLA7OD3Fi+KxaZPYTjoMmoI=;
        b=d8mBW6iUzt2G8QZGpKB+kcDyePu631lh5kilVpEXMTh0jn6ZcWnqAI7dnEoj0uZsshtC9D
        w23ijycRY0IZ+trVW/+jdpo8rZvKsBXPCG5SWjOUyFRdOwdvLF+ali64bkacRxivrHjL9b
        IHj4+a2klQTa7ZIs2qMp9xPS0w59CMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-rFVb1SEBOSinlBLnAyam8g-1; Fri, 10 Sep 2021 07:16:40 -0400
X-MC-Unique: rFVb1SEBOSinlBLnAyam8g-1
Received: by mail-wm1-f69.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso517492wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RgmNRK2XXvsyGHVA6iNyBLA7OD3Fi+KxaZPYTjoMmoI=;
        b=qKhsZKU7dlCVeDdjw4UEBvTR993a5nuaav006m3b123bkro1DESM0Lnsh2VClhi40d
         tKQ8QiZ8JwQz4QNMZmBRE6z2uMn8gr+NX+U4Ipa8R7ykcnUoMiWCNXhqxebhvUhrCCfJ
         twyIHyn9gvaz8nG4IK0fTE8qOsVQpxI/qTNY8oeVeHarKqDJjSzzoEI5JWZr0vPVOa0/
         IDrre1k5EPYI/LOm002xYvz+Q4uv8BzOs4BU/0JYRdHELF1AhSumE6qkA+faj8Lo5ZAJ
         EPfSlmQuozo7VcCrkRGGlJN98J4G3ZUjgL1tcLLgvM0Sh/7619D+IQEEbWqtmgyf6WjS
         6aTg==
X-Gm-Message-State: AOAM532xYhwXpupA4ts59wJN0wuSdsqBTfISpFAzuRtwadbah6xk3MJB
        HCc2ziIuKeCJxpi7f6T2CdcVIHJHzc87zL7mKHyK9ZKPvnjEij1bunpyJvWjEvDDtW3pODbuCv4
        1puNkApjIgSy14lPC1Mx6M/bFpp7fdTralnvH+/HMczXrBQZaT23iZPwCmufAahBNo8zucV45
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr9086823wre.419.1631272598978;
        Fri, 10 Sep 2021 04:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyJLflrPG0WzXGNJPgjOaLhkhTxeC/E3viJvptGpEjecvRADyKjbCDjSo6K/8XTEIDMgl6pw==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr9086791wre.419.1631272598767;
        Fri, 10 Sep 2021 04:16:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c600c.dip0.t-ipconnect.de. [91.12.96.12])
        by smtp.gmail.com with ESMTPSA id a6sm3974580wmb.7.2021.09.10.04.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 04:16:38 -0700 (PDT)
Subject: Re: [PATCH v1] mm, hwpoison: add is_free_buddy_page() in
 HWPoisonHandlable()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0363dc08-64af-8e59-7e1e-930194710e51@redhat.com>
Date:   Fri, 10 Sep 2021 13:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.21 02:41, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> commit fcc00621d88b ("mm/hwpoison: retry with shake_page() for
> unhandlable pages") changes the return value of __get_hwpoison_page() to
> retry for transiently unhandlable cases.  However, __get_hwpoison_page()
> currently fails to properly judge buddy pages as handlable, so hard/soft
> offline for buddy pages always fail as "unhandlable page".  This is
> totally regrettable.
> 
> So let's add is_free_buddy_page() in HWPoisonHandlable(), so that
> __get_hwpoison_page() returns different return values between buddy
> pages and unhandlable pages as intended.
> 
> Fixes: fcc00621d88b ("mm/hwpoison: retry with shake_page() for unhandlable pages")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
> index 60df8fcd0444..3416c55be810 100644
> --- v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c
> +++ v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
> @@ -1126,7 +1126,7 @@ static int page_action(struct page_state *ps, struct page *p,
>    */
>   static inline bool HWPoisonHandlable(struct page *page)
>   {
> -	return PageLRU(page) || __PageMovable(page);
> +	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
>   }
>   
>   static int __get_hwpoison_page(struct page *page)
> 

LGTM and I agree that code might desrve some cleanups.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

