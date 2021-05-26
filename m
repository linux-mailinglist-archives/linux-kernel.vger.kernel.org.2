Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380203911B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEZH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbhEZH7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622015899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSudih5Glhc3IDRVV6/AAK4DVdYQCVQ1Wfr2YC2JZgo=;
        b=QUzPsJQQX1p+mkBtx22NYzfyOn7PqYhgkZaD/s5ovu+tl4OjBWTQ8Gpa+YmBtQ/x4bILF4
        o+owPRWRBsfakgIP2Xqbwf2XEfGWbjc+Psp1q5c07PMJwInzXr0MqNBirNDBOVf/QvPjiG
        wT1XcuwlrKlR3JuJUyhuk7LK6iLxk/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-XOKRAKMTN5uUk3OZDqBOFQ-1; Wed, 26 May 2021 03:58:17 -0400
X-MC-Unique: XOKRAKMTN5uUk3OZDqBOFQ-1
Received: by mail-wm1-f71.google.com with SMTP id l18-20020a05600c4f12b02901921c0f2098so316234wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oSudih5Glhc3IDRVV6/AAK4DVdYQCVQ1Wfr2YC2JZgo=;
        b=tf6z3uMqtjOqdockD0KiPCMdPO3nECcI6W8InAqPZahX2HgcrdXzj1sXo+TdMha6EG
         g93x0bSV5RQVo/eN4MyDcFkK4X598S2+z+ZGbFyZ03LD1K8d7EQaUUB6csKhoRMbP+IY
         vEb0YX4HbJWcFYo1sk83zAevcZCGjvCul6S3bOnFm0/tADKZr8R7qbT6P6LUfy719Pzm
         0++s0YrcoOjIUXA38fdy/lp4oCNUwaHdXJGqRDjCFf8pVYXAgERNeDKIysClBA+nXOJ+
         D7LkzvhE/vf02TB7Ax5TLKw+PxPvStPR8ZdUxpRoJu7mDTHo9SZSu2t4aGx/Geuf5N7h
         sPKQ==
X-Gm-Message-State: AOAM531RgpaaEamu2PPay8+Vfluqx0KBLceFys7vOM4CDoXwOg9yustJ
        1kdRM/78Q8q88sTTdHyeRSIv/kWnqnIUI/1h4bZ4kV4XNZFxraDDNOYpAsd+hfgU2pFZcq1fyPk
        N4XpZ+CMh/VHBE2I3uPf2yZDT
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr16080671wrr.427.1622015896485;
        Wed, 26 May 2021 00:58:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWq/zQ+MdDRb1N5tWNph5k+gxjZHEF4mcUnwelIjhEij9mbJc0BjEGuMR+m/YCMoIdb2+icA==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr16080655wrr.427.1622015896169;
        Wed, 26 May 2021 00:58:16 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id r14sm18950309wrx.74.2021.05.26.00.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 00:58:15 -0700 (PDT)
Subject: Re: [PATCH v3] mm/page_alloc: fix counting of free pages after take
 off from buddy
To:     Ding Hui <dinghui@sangfor.com.cn>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210526075247.11130-1-dinghui@sangfor.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <301ec664-f153-7ed6-0231-8bbffb630a0d@redhat.com>
Date:   Wed, 26 May 2021 09:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526075247.11130-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.21 09:52, Ding Hui wrote:
> Recently we found that there is a lot MemFree left in /proc/meminfo
> after do a lot of pages soft offline, it's not quite correct.
> 
> Before Oscar rework soft offline for free pages [1], if we soft
> offline free pages, these pages are left in buddy with HWPoison
> flag, and NR_FREE_PAGES is not updated immediately. So the difference
> between NR_FREE_PAGES and real number of available free pages is
> also even big at the beginning.
> 
> However, with the workload running, when we catch HWPoison page in
> any alloc functions subsequently, we will remove it from buddy,
> meanwhile update the NR_FREE_PAGES and try again, so the NR_FREE_PAGES
> will get more and more closer to the real number of available free pages.
> (regardless of unpoison_memory())
> 
> Now, for offline free pages, after a successful call take_page_off_buddy(),
> the page is no longer belong to buddy allocator, and will not be
> used any more, but we missed accounting NR_FREE_PAGES in this situation,
> and there is no chance to be updated later.
> 
> Do update in take_page_off_buddy() like rmqueue() does, but avoid
> double counting if some one already set_migratetype_isolate() on the
> page.
> 
> [1]: commit 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
> 
> Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
> v3:
> - as Naoya Horiguchi suggested, do update only when
>    is_migrate_isolate(migratetype)) is false
> - updated patch description
> 
> v2:
> - https://lore.kernel.org/linux-mm/20210508035533.23222-1-dinghui@sangfor.com.cn/
> - use __mod_zone_freepage_state instead of __mod_zone_page_state
> 
>   mm/page_alloc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..d1f5de1c1283 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9158,6 +9158,8 @@ bool take_page_off_buddy(struct page *page)
>   			del_page_from_free_list(page_head, zone, page_order);
>   			break_down_buddy_pages(zone, page_head, page, 0,
>   						page_order, migratetype);
> +			if (!is_migrate_isolate(migratetype))
> +				__mod_zone_freepage_state(zone, -1, migratetype);
>   			ret = true;
>   			break;
>   		}
> 

I guess if we'd actually be removing a page from the buddy while it's 
currently isolated by someone else (i.e., alloc_contig_range()), we 
might be in bigger trouble.

I think we should actually skip isolated pages completely. 
take_page_off_buddy() should not touch them.

Anyhow, different problem, so

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

