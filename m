Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3512A4018D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhIFJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241166AbhIFJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630920457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=du5+MWHNJRiFPKbEWCYhk7n44eQiBu+Va5fyewgDdh8=;
        b=Diy9hW0a9xm4brfnwo26CLT5D+T9Cg8SxzuR0L3YivYi431iFVYZyODzrmdeiQ9nMZ3UIM
        y39K266rJ9q16UTvR8xeb+PsklMfaaL/FrvCpM1+QMdG+QCkJvRDTMhjpEE7lYSb0Oeg8/
        zYiDcvNQNpjMLSTLpBWfplqfbcZmhiM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-EkfHvsV1OxGlqt7z-8le5A-1; Mon, 06 Sep 2021 05:27:36 -0400
X-MC-Unique: EkfHvsV1OxGlqt7z-8le5A-1
Received: by mail-wr1-f72.google.com with SMTP id 102-20020adf82ef000000b001576e345169so1031377wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=du5+MWHNJRiFPKbEWCYhk7n44eQiBu+Va5fyewgDdh8=;
        b=KVPQMaE93ssmjWaDYFfTOMEBnB7cBvv7TuPk91h1ujuoNDiugFqRJdF3y0QzEAoWMT
         AcuDUwDwkJYoZ4q2Ov1FHaLLTto5mZ2MAi3nZBGhQBuwJzTYTOfFVYVEGV2Z1KrHnSDB
         G4VyevkFjUDZ6vE9k3Czv7MNrgQs0IboBjDnv+7HQm+kezepWWaDLHnV4qnoDOAyvK86
         0P1ps4REqsdFRW1wgN81AQHbpjfzAURwe0GylPFK4JKl6NXoGl1FyagCe5knJ8Fndmt1
         DjHN8e8OmK9T2mbLA6DpAxvihExX245+x495/yvqKUJTRt7Q9CZarUf3pcR77XjDXMjI
         F9+w==
X-Gm-Message-State: AOAM533nzlhcobpVzpb5rW3aY4q0ToCInbLn4kGciJDcia5e5B5ovfjK
        AhkbTv4s6i07tpjDCFCB5dE9W4CqjFXZRqyV2JKLgSOBt4DleFlA7CxsNYEOfJxl0ZXq/GOXEjY
        d8YtdBrVZzwh3ONtb9LcErzW0Dupphgr8CLt/8B4B0BN8eCyGwsjGCwtfRH7SWtAQPVMzr1yT
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr10529810wmi.50.1630920455326;
        Mon, 06 Sep 2021 02:27:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSR6l5ptjWuJgZ1oIqJLgVcl6v4mMvW4Lgd/4oIupYUDe2HgDw+mPpQH8PjfEhe+qv5gTfCg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr10529773wmi.50.1630920455036;
        Mon, 06 Sep 2021 02:27:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id u16sm7611474wmc.41.2021.09.06.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 02:27:34 -0700 (PDT)
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904092053.33037-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <dcfcacf2-0018-3b91-6da5-2420bad889c1@redhat.com>
Date:   Mon, 6 Sep 2021 11:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904092053.33037-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.21 11:20, Miaohe Lin wrote:
> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
> the first pfn in a pageblock while __first_valid_page() will traverse the
> pageblock until the first online pfn is found. So we may miss the call to
> unset_migratetype_isolate() in undo path and pages will remain isolated
> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
> also help to remove some duplicated codes.
> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")

While that is true, we shouldn't ever trigger, neither via cma, 
virtio-mem nor memory offlining, because essentially all operate on 
MAX_ORDER -1 -aligned ranges without memory holes.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_isolation.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 471e3a13b541..9bb562d5d194 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -202,14 +202,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   	}
>   	return 0;
>   undo:
> -	for (pfn = start_pfn;
> -	     pfn < undo_pfn;
> -	     pfn += pageblock_nr_pages) {
> -		struct page *page = pfn_to_online_page(pfn);
> -		if (!page)
> -			continue;
> -		unset_migratetype_isolate(page, migratetype);
> -	}
> +	undo_isolate_page_range(start_pfn, undo_pfn, migratetype);
>   

It'd be even cleaner to drop the label completely and call it from the 
single callsite. We can even avoid undo_pfn ...

if (page && set_migratetype_isolate(page, migratetype, flags)) {
	undo_isolate_page_range(start_pfn, pfn, migratetype);
	return -EBUSY;
}

If pfn == start_pfn, undo_isolate_page_range() will simply do nothing.

>   	return -EBUSY;
>   }
> 

-- 
Thanks,

David / dhildenb

