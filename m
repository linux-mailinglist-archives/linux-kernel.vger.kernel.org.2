Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764F3992AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhFBSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622659026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktmy9OPHs7EKpTut0wBFjcJ9rL9I98RB0SACOwd6rGU=;
        b=EgsPupvcMmDxAcyrhVH+Da4b8fT9F7okFryY/fEhMClhB4UN01q4CVKIeDMkc5u8m6VZcQ
        q++Z3r7Ag6hDRL3t/NOaXEYlEuTi0w+k5P6ocOQJVbBpr8jHdDQqWVaSivuKrQ6HlBolwL
        lPB6X8LfaSZ6AREl0cm5MdYct9EbfW0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-UsnF-M4LO9aaJprBQPlqGg-1; Wed, 02 Jun 2021 14:37:04 -0400
X-MC-Unique: UsnF-M4LO9aaJprBQPlqGg-1
Received: by mail-wm1-f72.google.com with SMTP id i13-20020a05600c354db029019c437c377eso253554wmq.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ktmy9OPHs7EKpTut0wBFjcJ9rL9I98RB0SACOwd6rGU=;
        b=YdQB6+qhFduWr/EAiSi6rgRcyCQuEb+gIval4xrpFF55rzDRM2cVw8MNm2mn2H/Pi0
         ts1In2DGECqQvmGnvdctixww9BJOiA03BNLMuHjkGvAtw9uQajUYhZZylJX5iQx+99zR
         N7lWxh/8RhRZYR/+tlXHzHFYWA/LMXLTvqmZ8TvcppQ9hMPLEnL1v8LxXbpa1SmbyHFa
         PILr9xP/JjmPOW3xLcOKpt8dC37Ijn4MA41GUtHcRoLy9zVdWRMcGqn5f3+ZsQIZDMoz
         kcB/S+j2pFGsXAOyEc7s58hcMFN8Fe4fwQgyulHb1QXq18njxSLKWUWD0VyL7svhsM5t
         UEZQ==
X-Gm-Message-State: AOAM533gWN+C9XD9dBDaTgFsBf2YArApiYos8+qx2diIWzh6JZt+iZZe
        bjH8fcFgQACKrZQBsBN+pVrXROuCf+vS3MlPDSa3DzHc+F4XjRQ23ePovTu43LRkgue5KpsCi4j
        TXRm2J6aqhprQXPqCcN7RC8XCQ1CRsVcbZiwhyMK8+iu9zYL69yNMRRsjKxIcGc3YULWOu0iO
X-Received: by 2002:a5d:638b:: with SMTP id p11mr34423235wru.90.1622659023519;
        Wed, 02 Jun 2021 11:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBuZOl6CTO6xLJEMDKsbIrEohcw7mAJ1hiJmAPcx8wm+2snvnOfx9z+oQgLtu61Q7rte0ThA==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr34423216wru.90.1622659023253;
        Wed, 02 Jun 2021 11:37:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id 30sm851918wrl.37.2021.06.02.11.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 11:37:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
Date:   Wed, 2 Jun 2021 20:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602091457.17772-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 11:14, Oscar Salvador wrote:
> Currently, page_outside_zone_boundaries() takes zone's span_seqlock
> when reading zone_start_pfn and spanned_pages so those values are
> stable vs memory hotplug operations.
> move_pfn_range_to_zone() and remove_pfn_range_from_zone(), which are
> the functions that can change zone's values are serialized by
> mem_hotplug_lock by mem_hotplug_{begin,done}, so we can just use
> {get,put}_online_mems() on the readers.
> 
> This will allow us to completely kill span_seqlock lock as no users
> will remain after this series.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/page_alloc.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..296cb00802b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -582,17 +582,15 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
>   static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>   {
>   	int ret = 0;
> -	unsigned seq;
>   	unsigned long pfn = page_to_pfn(page);
>   	unsigned long sp, start_pfn;
>   
> -	do {
> -		seq = zone_span_seqbegin(zone);
> -		start_pfn = zone->zone_start_pfn;
> -		sp = zone->spanned_pages;
> -		if (!zone_spans_pfn(zone, pfn))
> -			ret = 1;
> -	} while (zone_span_seqretry(zone, seq));
> +	get_online_mems();
> +	start_pfn = zone->zone_start_pfn;
> +	sp = zone->spanned_pages;
> +	if (!zone_spans_pfn(zone, pfn))
> +		ret = 1;
> +	put_online_mems();
>   
>   	if (ret)
>   		pr_err("page 0x%lx outside node %d zone %s [ 0x%lx - 0x%lx ]\n",
> 

It's worth noting that memory offlining might hold the memory hotplug 
lock for quite some time. It's not a lightweight lock, compared to the 
seqlock we have here.

I can see that page_outside_zone_boundaries() is only called from 
bad_range(). bad_range() is only called under VM_BUG_ON_PAGE(). Still, 
are you sure that it's even valid to block e.g., __free_one_page() and 
others for eventually all eternity? And I think that we might just call 
it from atomic context where we cannot even sleep.

Long story short, using get_online_mems() looks wrong.

Maybe the current lightweight reader/writer protection does serve a purpose?

-- 
Thanks,

David / dhildenb

