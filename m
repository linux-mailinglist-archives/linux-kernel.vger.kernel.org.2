Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAD3FC956
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhHaOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhHaOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630418763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzECLjZfLJYpLvQ5t/F5N2XADprf0KnFp98nx4CJfPs=;
        b=IzauzWKfz5D6R4tj66vMeVSUuBvgg6Z5j4XN+srnxjWWTit+92XJEdOE1INEgh8QUvIVQL
        BqYlgNS6S5UyaxAXAOprt5jxsirlF1VGnakajcEoCvVk5SALvGqt4xtc3Gy+iootEX8aR4
        9CKMakufrXegFeYaMTiKXiMSucmchjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-Ad0sWJx0OMSpZA_f4yl9EQ-1; Tue, 31 Aug 2021 10:06:02 -0400
X-MC-Unique: Ad0sWJx0OMSpZA_f4yl9EQ-1
Received: by mail-wm1-f70.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1366769wmr.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UzECLjZfLJYpLvQ5t/F5N2XADprf0KnFp98nx4CJfPs=;
        b=HaCFPIzQJ2kJPIgnvvqGHkxXrLM3EDTVUPytFG/gltE4tfJ4cMgjW1gUcgBU4n2xtB
         HK7WxF28lLsdVgKA5iTo3TKaETAka9Xn9sd+M7AKsv8TXztnumPCafbycrXxa/VdJ0Dk
         haDBJd8Cb0Cnk+CQWDNa2Eu286wpJS4iKkvrLfQnDol/csCDg1RqIGw97G0LYb4ChJ4E
         6VE+vzijci2TgeEnkb6Cg/z5nZysqe1fu0MQIBPgt4G3KgzqWp3MGICthqozoC/ZmpmP
         1zPMhbrxM+PjqbzeuG4g5QFkxpXq9nriOWRneBq9gWbKRQmeRaPnuzrXT+zzIC93LM1w
         Tu+A==
X-Gm-Message-State: AOAM5333o37SPeucF16oEC0XgvBaEUMZhm2px5ePYVUwqweb0Z4cywnh
        M8zgAPsiXv08J0bwRt9gYTV0Exh29+Uy+4ziCF8Tx1NwVA1F9YJSRz/sPy/rt/Vrk8Q+GMjMENd
        ei5Mwso43DiciFfQJ+SXhhNX4nUbfZjN5c9+YSb5iiqJEDlp+5hYMn7QE1alI+X4oXPhvM6aW
X-Received: by 2002:adf:8102:: with SMTP id 2mr30566397wrm.89.1630418760985;
        Tue, 31 Aug 2021 07:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY0s3JMLdy+AoHqP6C5Lc7FYO8MmvKj2V0IH21QbolCvRHQMCzHc4ppkhmHVSFKVgKasZbpA==
X-Received: by 2002:adf:8102:: with SMTP id 2mr30566364wrm.89.1630418760679;
        Tue, 31 Aug 2021 07:06:00 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id k1sm18867586wrz.61.2021.08.31.07.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:06:00 -0700 (PDT)
Subject: Re: [PATCH 1/6] mm/page_alloc.c: remove meaningless VM_BUG_ON() in
 pindex_to_order()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3a642b19-6d89-3af4-7efc-3b8a0d28a0f0@redhat.com>
Date:   Tue, 31 Aug 2021 16:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830141051.64090-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.21 16:10, Miaohe Lin wrote:
> It's meaningless to VM_BUG_ON() order != pageblock_order just after
> setting order to pageblock_order. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91edb930b8ab..dbb3338d9287 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -677,10 +677,8 @@ static inline int pindex_to_order(unsigned int pindex)
>   	int order = pindex / MIGRATE_PCPTYPES;
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +	if (order > PAGE_ALLOC_COSTLY_ORDER)
>   		order = pageblock_order;
> -		VM_BUG_ON(order != pageblock_order);
> -	}
>   #else
>   	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>   #endif
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

