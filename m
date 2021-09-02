Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADF3FED97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbhIBMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344053AbhIBMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630584831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqPSPzSUaCvr89fYf7X2rIuK0UXpdRDiuT57nCVYGHk=;
        b=JMlRGokq85YQgKfGk5X6VmdGq2O9hBGxaeLrmoNt1fxFyxGDh/23Y5pEedEzRMWMILLzXS
        VBedVR0zhxLoUwcI//G8LmI5o7H5MWyreQ2qA6vTErkRVXVTx4ytFxwbrSdlUh4RBc+a6V
        nTK1ziGU5D/N5vJMxOBwmdmKSOQQMlY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-sp_ycRaXMMKWDMKn9UlX4w-1; Thu, 02 Sep 2021 08:13:50 -0400
X-MC-Unique: sp_ycRaXMMKWDMKn9UlX4w-1
Received: by mail-wm1-f70.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso908920wma.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rqPSPzSUaCvr89fYf7X2rIuK0UXpdRDiuT57nCVYGHk=;
        b=iqDLA3Z/SYFs285Z6aiJv/mgM82KMZXTZNK6C8TmmdOt4/AwLRYeVmgEAUhbdxng2S
         /+eKKdVi7UcXfXkOO/e4ImlYwEPMgwYXcrwyNjIKZpU2nVbSQYP7l6cyVj8fD/bI6dyI
         MjjN0k4g8y+Si6DdNrYFMvlT7fWEoOgHL6loA+QPT5mPwNL+7xHgqIkmBCvJTYr0iXwR
         EgCzdsF/eRp6zaEqbapHL9WbyJ6H3LcseESUJyMkLh4i9Yroj1+GC+TSY6N3kiexMUW9
         kipXZq7peG4JA0563t1i6iihPAho6u1Tgy9OA7/kvVvgfQtNtPMCJvu6TqZ/P+DbnwfM
         KZ/A==
X-Gm-Message-State: AOAM532uSFaClfVnorHJuWglPC1Ql0vTuElcjejXwkkwTiGltCLwLW2e
        4/Ku/U4B0RRoBdDUEtSbK7hPm67EgU7IAG7RYqfm3yAW58a9+Q4kiUXBFQAS6vi6GatwWfhHMAA
        Xg+ALCc0Jjl8/tfmdIroXdgQfbhwM2fFsBUc6hcaRZJl1FKlw1cLdx8IMHvVjYrUMBoPfwoPR
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr2853107wmq.44.1630584829426;
        Thu, 02 Sep 2021 05:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgdVixWXxgjrfce5Mk0e7FJX9/rSNhRkjtXGLRgv9FnrjAuox4WemEHgxgvGClZv8hv3p6lw==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr2853074wmq.44.1630584829124;
        Thu, 02 Sep 2021 05:13:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id m3sm2107274wrg.45.2021.09.02.05.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:13:48 -0700 (PDT)
Subject: Re: [PATCH v2] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, peterz@infradead.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902115447.57050-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e95f26dc-4b22-8ede-0da4-511cc03076d1@redhat.com>
Date:   Thu, 2 Sep 2021 14:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902115447.57050-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.21 13:54, Miaohe Lin wrote:
> If it's not prepared to free unref page, the pcp page migratetype is
> unset. Thus We will get rubbish from get_pcppage_migratetype() and
> might list_del &page->lru again after it's already deleted from the
> list leading to grumble about data corruption.
> 
> Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: <stable@vger.kernel.org>
> ---
>   mm/page_alloc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c09dcb24149..a3c6acafa478 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3420,8 +3420,10 @@ void free_unref_page_list(struct list_head *list)
>   	/* Prepare pages for freeing */
>   	list_for_each_entry_safe(page, next, list, lru) {
>   		pfn = page_to_pfn(page);
> -		if (!free_unref_page_prepare(page, pfn, 0))
> +		if (!free_unref_page_prepare(page, pfn, 0)) {
>   			list_del(&page->lru);
> +			continue;
> +		}
>   
>   		/*
>   		 * Free isolated pages directly to the allocator, see
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

