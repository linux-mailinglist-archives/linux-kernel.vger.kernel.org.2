Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9669F361BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbhDPIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239093AbhDPIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618562166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAIh4WsVS/ayzhp5HjJe99OkPRqXPu6YrMhzHKnuu4E=;
        b=WN/DN/lFgtSz2MQF9gvZefpOfOtoSiqDggFsEuNIJHlJzjj3HcwyR+Rgizimoz8dBV1M7y
        Za08/gB5l5TTJHzxSu5sr6bx/uigrWMac4spP1sJXW77+M9OmkUT0iIAcHWfyq1YajwMGz
        v8rooabi5h/F/DagGAxm7DoucbuoKvY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-u1nZd45cOEqySIFYD54USQ-1; Fri, 16 Apr 2021 04:36:04 -0400
X-MC-Unique: u1nZd45cOEqySIFYD54USQ-1
Received: by mail-ed1-f72.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so6593331edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gAIh4WsVS/ayzhp5HjJe99OkPRqXPu6YrMhzHKnuu4E=;
        b=BE1+CdI2rh3iv+xslQWpUVDudMPyuVmnI4BsBTRzSzJOyOqv3rlPXTKta/8NfmrvrE
         gklOn7SLFrW07omdBpSSKKHOHQz5PaBwtLCjEBTg5IO2wnKMP0NPRWjtuYZVg1+NKuPX
         BK0MdjsWAnrRaKsM7ts1mvf2+JtX1Oa+XMz2XKWcviLGogB1xpdljB7rIXASJbOD/tQC
         YcftBM8GbwmP5PW5s6fB1P9SYFi7sE2G1FfhQdyQN1QN8duyXydBBehX2S7OHMGqikDJ
         RZmlwRCr7RSPiDC1eJAa8mEGUPJ1nm/shmZuNMlGzPKxoKNE+0yPJdumoQo5da1sKbxH
         BKHA==
X-Gm-Message-State: AOAM530Z+cKcVjBi+yl+/rVAiCybeEF/nxKbj6H+6DkkdByiegGYxMNJ
        wttw+yYbQZW+eQd1t4kOUkVjU6/HbwoPDyIyVeudEJO2gDiHMpCyf8aueDrddjieoKvcl9yolDp
        4Zrhk74hDJej6oMUkN3DOoI85
X-Received: by 2002:a17:906:2b03:: with SMTP id a3mr7529694ejg.481.1618562162786;
        Fri, 16 Apr 2021 01:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgAusKooTgufLR2oxQaNZJSdVLxPdce8E3XlDxu6rxKUOMWItS6xghBQPlz5lFNQCfdDw8FQ==
X-Received: by 2002:a17:906:2b03:: with SMTP id a3mr7529674ejg.481.1618562162630;
        Fri, 16 Apr 2021 01:36:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id k16sm3764251ejv.37.2021.04.16.01.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:36:02 -0700 (PDT)
Subject: Re: [PATCH v9 6/7] mm: Make alloc_contig_range handle in-use hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
References: <20210416070023.4742-1-osalvador@suse.de>
 <20210416070023.4742-7-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <02de399f-1ecf-98d6-6a78-1301f9a97d5a@redhat.com>
Date:   Fri, 16 Apr 2021 10:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416070023.4742-7-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -int isolate_or_dissolve_huge_page(struct page *page)
> +int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>   {
>   	struct hstate *h;
>   	struct page *head;
> +	int ret = -EBUSY;
>   
>   	/*
>   	 * The page might have been dissolved from under our feet, so make sure
> @@ -2373,13 +2380,18 @@ int isolate_or_dissolve_huge_page(struct page *page)
>   
>   	/*
>   	 * Fence off gigantic pages as there is a cyclic dependency between
> -	 * alloc_contig_range and them. Return -ENOME as this has the effect
> +	 * alloc_contig_range and them. Return -ENOMEM as this has the effect

Nit: belongs into previous patch.

>   	 * of bailing out right away without further retrying.
>   	 */
>   	if (hstate_is_gigantic(h))
>   		return -ENOMEM;
>   
> -	return alloc_and_dissolve_huge_page(h, head);
> +	if (page_count(head) && isolate_huge_page(head, list))
> +		ret = 0;
> +	else if (!page_count(head))
> +		ret = alloc_and_dissolve_huge_page(h, head, list);
> +
> +	return ret;
>   }
>   
>   struct page *alloc_huge_page(struct vm_area_struct *vma,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bb8321026c0c..5199b9696bab 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1703,8 +1703,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   	LIST_HEAD(clean_pages);
>   
>   	list_for_each_entry_safe(page, next, page_list, lru) {
> -		if (page_is_file_lru(page) && !PageDirty(page) &&
> -		    !__PageMovable(page) && !PageUnevictable(page)) {
> +		if (!PageHuge(page) && page_is_file_lru(page) &&
> +		    !PageDirty(page) && !__PageMovable(page) &&
> +		    !PageUnevictable(page)) {

Nit: adding to the end of the list would require less modifications ;)

>   			ClearPageActive(page);
>   			list_move(&page->lru, &clean_pages);
>   		}
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

