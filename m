Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F03FC964
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHaOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230478AbhHaOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630418918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mk5ulB/sJnXWATjcBk59gJWvrwHsxe0fgZRViunJDv8=;
        b=HOmCBUuTw/hd6sqaGmHwhCuncGIRU2X2XKjHYL1BweYE6MEZJYvN0thrypAyfyDQF4LJL5
        /lRQxAXPR2EgKLgV80USTiTmoddvaT4QdpV7qFGfGL0T9zD0Evwdcvp0IrRUQY00GB0izk
        WNxbIOoWOxIFZ2RKTYY9abdG328cEao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-1c03msTdMyqPJVfoDSGXQg-1; Tue, 31 Aug 2021 10:08:36 -0400
X-MC-Unique: 1c03msTdMyqPJVfoDSGXQg-1
Received: by mail-wr1-f70.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so4082929wrn.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mk5ulB/sJnXWATjcBk59gJWvrwHsxe0fgZRViunJDv8=;
        b=I/ZQtR7pAk82rLtQ5SXjAGQZTS36oL1eIKc2AUY4XxW7u+qDB9E4uUPriWhiW23yTq
         nBdhHxwVhkQ9DFkwFRtFCbHUGOfm+cRuQl7UiGDpdduLuYz7l0Fw7z+wjkV+1kQhurQj
         CKWII5880Tfc8p3cXkUJ0oYJFIrHmpFl6ApQJmPrbXSdl1AN4Q010uwyAJ0TjMehs9Ml
         6/C1fbRJM692MLGUTQ8gOYmN6R6VMKBoRimps1b+qx185bieQz3i2adTQHmr7YGMU85W
         z3cHI7TVpLlaUGXiRFwuLvqKhJbnaWF8NVKoroacGlx8LQRjPi6+24a3MuEAkWuhBXHk
         0FBw==
X-Gm-Message-State: AOAM5314IBMCF7jHdiZA6pNRCWaLOymfDsJSa3ruxtIRmRJVszv64b06
        YX0GVe3/JtALrNcfcHNBHes7qE8W+EbrB/pcvIFD/z3vgMEAS9NQsYVlYIxy7wG9pYj88Dio55C
        IXt9hW8erZK/o+AD7w4hpopPfPkS4H6HcaHIy7rdUBbZbgP3EMryRQvELRkw+pxMQ84sAEBO7
X-Received: by 2002:adf:b789:: with SMTP id s9mr21263473wre.315.1630418915674;
        Tue, 31 Aug 2021 07:08:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWWutNM16gAtmpsGvqXoBgY4Kyes/Y8/gUxBFVp48/XHeLuFfK/v9T34UmkA7/LJtH8CB5hw==
X-Received: by 2002:adf:b789:: with SMTP id s9mr21263440wre.315.1630418915491;
        Tue, 31 Aug 2021 07:08:35 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id z19sm2875100wma.0.2021.08.31.07.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:08:35 -0700 (PDT)
Subject: Re: [PATCH 4/6] mm/page_alloc.c: use helper function zone_spans_pfn()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7dd3aae5-bc31-c163-b661-2cf1df830615@redhat.com>
Date:   Tue, 31 Aug 2021 16:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830141051.64090-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.21 16:10, Miaohe Lin wrote:
> Use helper function zone_spans_pfn() to check whether pfn is within a
> zone to simplify the code slightly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b5edcfe112aa..7bb79e959ab4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1576,7 +1576,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
>   	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>   		struct zone *zone = &pgdat->node_zones[zid];
>   
> -		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
> +		if (zone_spans_pfn(zone, pfn))
>   			break;
>   	}
>   	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

