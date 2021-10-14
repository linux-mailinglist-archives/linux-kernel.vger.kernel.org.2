Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515942DDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhJNPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhJNPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634224196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTxRkwer/L1jMFbVHe+gmT8Lx5IDhS6y3cTZBhYxWZc=;
        b=GUA6a2DSv/2Thu7sJktpbXcgV8Bc6FM9e1iH1yNM3Pl6HyarmH2VhqM6nqzRfWxf9Hy154
        QqK+yKOsGlsn57mZ5qGVLvkIk7/KkhNyBziPYQAngryjFDvcawZE8ZGd3ZEhULs0Cj2HMP
        63/l0Q7sVv7n5jlsuiOtV09YW9NlEqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-NDqmwTwsMT-cC5hlJUfdKw-1; Thu, 14 Oct 2021 11:09:53 -0400
X-MC-Unique: NDqmwTwsMT-cC5hlJUfdKw-1
Received: by mail-wr1-f70.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so4826743wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jTxRkwer/L1jMFbVHe+gmT8Lx5IDhS6y3cTZBhYxWZc=;
        b=qTpaEadwRq15cnA8WGHzu+N54PLsGFbx6rZ0kjtaV9NOLTDmRgbcd+BRoFzNpOOooj
         g4mcYfLV7rDQz1LFz4xtL8pz049ORUU1beaFsJkqV5iODe2aVmENRQOewd08Yii0GAeD
         EswapToaaX7ZjzwcHPe2JCNgbmna8W3DB3bUcREiigR6JitLo6f/puYc/AdaNezsilWw
         k6NPqT4HWyxW7P1iezFT3yZMyyXoj9QXBso5mwxVXbbOwN+2vNlcciJYvaywWQGktvgw
         FIjsPh/BK0lY8O2nZtFz15aAbtoCtYbCPb8GGPw3B1yII1EDRrsL+mI/SeGpg2I0K+2D
         uvlA==
X-Gm-Message-State: AOAM53296g7Co8KrVU6dbFY2dbDfPI6/efakRZhyLerlIebTdspxPt8E
        pGOdlhUoOwpd8ikngQoSphTJ6gBftLqOSV9+hg6+euv/OJuz3IbAejt6DZjKySO4vnEWzZgq4s5
        rBeW1YffSQQHdOjEysYZnU3s0
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr6271733wmp.65.1634224192157;
        Thu, 14 Oct 2021 08:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwspjmnn2UgF3wC80ffKADbfFGgTEqNvflKbpG+cgCWjua1idvpQ2j9r374S0fE1PxL0yFKA==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr6271697wmp.65.1634224191871;
        Thu, 14 Oct 2021 08:09:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id p25sm7981463wma.2.2021.10.14.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:09:51 -0700 (PDT)
Message-ID: <eaa8ed55-f364-5518-0b30-3fec6bde99dc@redhat.com>
Date:   Thu, 14 Oct 2021 17:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 5/5] brd: Kill usage of page->index
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alexander.h.duyck@linux.intel.com
References: <20211013160034.3472923-1-kent.overstreet@gmail.com>
 <20211013160034.3472923-6-kent.overstreet@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211013160034.3472923-6-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.21 18:00, Kent Overstreet wrote:
> As part of the struct page cleanups underway, we want to remove as much
> usage of page->mapping and page->index as possible, as frequently they
> are known from context.
> 
> In the brd code, we're never actually reading from page->index except in
> assertions, so references to it can be safely deleted.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  drivers/block/brd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 58ec167aa0..0a55aed832 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -72,8 +72,6 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>  	page = radix_tree_lookup(&brd->brd_pages, idx);
>  	rcu_read_unlock();
>  
> -	BUG_ON(page && page->index != idx);
> -
>  	return page;
>  }
>  
> @@ -108,12 +106,10 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
>  
>  	spin_lock(&brd->brd_lock);
>  	idx = sector >> PAGE_SECTORS_SHIFT;
> -	page->index = idx;
>  	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
>  		__free_page(page);
>  		page = radix_tree_lookup(&brd->brd_pages, idx);
>  		BUG_ON(!page);
> -		BUG_ON(page->index != idx);
>  	} else {
>  		brd->brd_nr_pages++;
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

