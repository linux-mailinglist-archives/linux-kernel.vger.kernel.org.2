Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4828A401AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhIFME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhIFMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630929776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frAukOYVGtOJ1Dxa66lVEbsorbkE/tBlVsVnTX50G4U=;
        b=Kyz1vOhoJ9ojl+e+swl5WFC8Ui9J9VO74441zJEVR5v3wPuWzh0u2VMEzXVODar95MGJ4/
        CAOIigM2+oGrSTfJhKZe89eitKWt0UqVMNCTRDlul++2cPJ0/dTswD/sR5jNSq7r/3tFVD
        SXtDHJ0F6byz3I4T2tV7NRXA5yg7bvw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-kgqMND5LMC2yhCcueEktxg-1; Mon, 06 Sep 2021 08:02:55 -0400
X-MC-Unique: kgqMND5LMC2yhCcueEktxg-1
Received: by mail-wr1-f72.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso1132709wrs.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=frAukOYVGtOJ1Dxa66lVEbsorbkE/tBlVsVnTX50G4U=;
        b=WJYe2ImY9wRJUQCg/WmBQa+EzpqE9XnXa6EVvtZpQGzI2Hbciaz83GIut86rphc6b8
         6zq2O9pNi63S7uavveNrvxLBp4tfYvLwRDR1y+frmEbx7OwnIhymKPn5RBVM+Zxfm48n
         iWpFTq1D+biH01rmRhEYGXPdqD1sUo5+bLx9XLAsKv3yO35y2I5o4VhT60dGRWjvUH53
         zOciEFKPq2JMAupM+M+72UFLf/a8SNuXr3NxjsweAPK5ne21/jHK+oQa+abuQCRG5WUI
         aSpg3zcvbeNGXQs8CbEmHyaYdlenUNACq7QP6xwIM+Gw8NBhRyoenIB9d4IIhzEysehe
         HbUQ==
X-Gm-Message-State: AOAM533hbNBCJvZqwHMoCyYUUGV40zpFxVWqU8ccmzQe2Hjw0jultMu/
        quwZlAqL/K1pMgCME0rcH/Iij900DfPjrtTpd95w6T11c+gwsmQC/UTBBnZBPAV6pzNzfnF7SjG
        j9q6mAMN3GCgU8fYjZJN5yxamynntoDj/PCYfIBFbnmFiPFVt9uGsKVEsLg3dl5e0q98mv+z6
X-Received: by 2002:adf:df0c:: with SMTP id y12mr13034299wrl.155.1630929774457;
        Mon, 06 Sep 2021 05:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhKhtm32LcEgWkjl3X4v4Wu0VKN7KkWyfSQxdUPJRD/eW1BxpQQtgWjoFber1coF0YiWqYaA==
X-Received: by 2002:adf:df0c:: with SMTP id y12mr13034275wrl.155.1630929774260;
        Mon, 06 Sep 2021 05:02:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id p5sm8179521wrd.25.2021.09.06.05.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:02:53 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
Date:   Mon, 6 Sep 2021 14:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904091839.20270-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.21 11:18, Miaohe Lin wrote:
> If __isolate_free_page() failed, due to zone watermark check, the page is
> still on the free list. But this page will be put back to free list again
> via __putback_isolated_page() now. This may trigger page->flags checks in
> __free_one_page() if PageReported is set. Or we will corrupt the free list
> because list_add() will be called for pages already on another list.
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_isolation.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 9bb562d5d194..7d70d772525c 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>   			buddy_pfn = __find_buddy_pfn(pfn, order);
>   			buddy = page + (buddy_pfn - pfn);
>   
> -			if (!is_migrate_isolate_page(buddy)) {
> -				__isolate_free_page(page, order);
> -				isolated_page = true;
> -			}
> +			if (!is_migrate_isolate_page(buddy))
> +				isolated_page = !!__isolate_free_page(page, order);
>   		}
>   	}
>   
> 

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

