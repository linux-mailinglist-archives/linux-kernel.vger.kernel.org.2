Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA83A12B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhFIL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238767AbhFIL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623238070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF6jqZYlf/bv5JENXOK7CNcI0f9PC8RJLld/dQYmgdQ=;
        b=MPSB8Pg9rBk5rHNwlG/35MMHhKWJHiwpKdoFpTT5MWZXMC9aIZoEsCXsyp9QWNKq6it53j
        yF1MmlcXKBSvChlB481+VJGHasj0Kcq7I8P8k+zpByRMM3tTARm2LYFCEMYQ4vYbiWJwcM
        6UpUYHDv2RxJrD8Rjd5jTr0t1KAxUcg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-VAXeNDIYOSKLe7jMaIY6SQ-1; Wed, 09 Jun 2021 07:27:48 -0400
X-MC-Unique: VAXeNDIYOSKLe7jMaIY6SQ-1
Received: by mail-wr1-f72.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so10665865wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iF6jqZYlf/bv5JENXOK7CNcI0f9PC8RJLld/dQYmgdQ=;
        b=dEsmQs3T8DSuCbgEcBXK5YasqvJHIGxoR/qUxotEeb21OtmaDJUG8dNkbrih7NP52i
         gtAQUnkvUO13ftIrSx4azbBRPRJAAbPdSnK6v/QmMrCN5jZRyepD0ej5LjhT1zrhAwNh
         lhifHwyxydNf0fapZqCqbWyCodlwCG2XVTskZZgwHM1STijOwPnLQ7wTDv6DMM7doAeg
         /CSMDt8Jw+m/kneX1twDGwcMW1Wb7Se+Ehy7lJ+V3FEctxUbONwSRWeWQxNWwuYQq3lP
         090w1h/pyNRbFCJBKDZJLdQqwdE20Av+3YOtWGW7Lj9AOZ/ETO15GKNnNLNA77xusgkP
         V1iw==
X-Gm-Message-State: AOAM533f9dvN59dr8d9CAP/78WuDAqSyW94ipt4u7UzeoNfZSSKU2r/T
        3o+3cAo8TIlZrguyZJevHux19d44w4ApyiZ/0NWEhvUGTb5QQJbbCJxxhgbbAEk7Qh5DQjLL1i0
        jSiWvDA5Z9GudiuE/aFjxZVXf
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr9512140wmf.171.1623238067800;
        Wed, 09 Jun 2021 04:27:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL7rALUqayOImlS1fyAzzBYx5tARF2xTQg0IXBsrMcuq9thrQ0YBslazZ4yV2ce3+8jWdrxA==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr9512127wmf.171.1623238067600;
        Wed, 09 Jun 2021 04:27:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id n12sm8010868wrw.83.2021.06.09.04.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:27:47 -0700 (PDT)
Subject: Re: [PATCH] mm: compaction: remove duplicate !list_empty(&sublist)
 check
To:     Liu Xiang <liu.xiang@zlingsmart.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
References: <20210609095409.19920-1-liu.xiang@zlingsmart.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bba6e865-ff2e-4c01-b95d-3b1a9e6dc0da@redhat.com>
Date:   Wed, 9 Jun 2021 13:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609095409.19920-1-liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.21 11:54, Liu Xiang wrote:
> The list_splice_tail(&sublist, freelist) also do
> !list_empty(&sublist) check, so remove the duplicate call.
> 
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> ---
>   mm/compaction.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 84fde270a..5b1dc832f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1297,8 +1297,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>   
>   	if (!list_is_last(freelist, &freepage->lru)) {
>   		list_cut_before(&sublist, freelist, &freepage->lru);
> -		if (!list_empty(&sublist))
> -			list_splice_tail(&sublist, freelist);
> +		list_splice_tail(&sublist, freelist);
>   	}
>   }
>   
> @@ -1315,8 +1314,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>   
>   	if (!list_is_first(freelist, &freepage->lru)) {
>   		list_cut_position(&sublist, freelist, &freepage->lru);
> -		if (!list_empty(&sublist))
> -			list_splice_tail(&sublist, freelist);
> +		list_splice_tail(&sublist, freelist);
>   	}
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

