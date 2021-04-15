Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5B36099F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhDOMmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDOMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618490505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfTrVvYyr8Nd9g6k5o/4wByZB+cDMhMVOX5RhAUHIvE=;
        b=BeqTZbFGaGXfCs1xmqhuU65KQI0NctJcL3r1BLwxBwnswNkQ6fGvrmtAt+WuqaDKwGC1Tf
        J4yJGyWxabYbFlzxb8urQdEsKxbdxovzAmvqTCCA91n7jJUSQp6N9x274UO/sfuIz3PRbQ
        dJlYL3JzV6OCBo2hfkqvXj5sambSZuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-1FF_dtTwMt-Rzolq91KAkw-1; Thu, 15 Apr 2021 08:41:43 -0400
X-MC-Unique: 1FF_dtTwMt-Rzolq91KAkw-1
Received: by mail-wm1-f71.google.com with SMTP id w187-20020a1cdfc40000b029012e8682a12bso728302wmg.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lfTrVvYyr8Nd9g6k5o/4wByZB+cDMhMVOX5RhAUHIvE=;
        b=OTPIyAi1laQGER/6ZUVrpeP7SSh5czdT8p5WWJTmzPMGPvmRPH5XwkxFFaz3upcDtC
         2nHbbZZHP5kfXFInIitpzHa+5IHM8qhohmHE8uLTN4y2WEVNm9yz1XsSQ1cpi7echMbV
         CyoVWzH0tNv82NTp6Tvt/2lENfZ7VQxG+0jt0OIdy7KYTzSGsFgse7NhgZj1CYR5Ka0L
         vWB+ZRNro6dXPAWhQTTHvw+3qhIKNU8tpQ7odW1kk4U9j91JHgjZgVLW3r9cgsAuI0gP
         D3njMAurdbNfte5oVSFBBiGXSrfGx/uMNT5TVAqjaMCQ6q8TqjVtGhilqZDMZRqwbZ82
         wIEw==
X-Gm-Message-State: AOAM530HKRaNqKBiQe0ktu0gkdGktZAARw8F6ck3swSjvRgnNvRwCzMm
        Wufs0ZJYDuDYiC/i2AwvwJLnOcLQwN86+f7gB1hRr2FyuF7IhsyVoF0a50MW17htqCHvUYudmgi
        9636nYcfwPLUoqNZ3XBUi5X6cqBCI9Hml584duSuLq89HItN7cBcLuctYaKQp9JD8kYFy04kD
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr3000671wmg.148.1618490502287;
        Thu, 15 Apr 2021 05:41:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxo9Es1WG9Y5+1El0W1SGwghjzNenwwpYlqUfIAYpfTUQEtDPG44l1mf3ZMdy5LLRAArR7Zw==
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr3000648wmg.148.1618490502084;
        Thu, 15 Apr 2021 05:41:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id i21sm2488033wmh.21.2021.04.15.05.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 05:41:41 -0700 (PDT)
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-4-osalvador@suse.de> <YHgmgtJRadMB2c5k@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 3/7] mm,hugetlb: Drop clearing of flag from
 prep_new_huge_page
Message-ID: <cf4a3e6d-f69a-cf0b-dc66-b55ad06a1d1c@redhat.com>
Date:   Thu, 15 Apr 2021 14:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHgmgtJRadMB2c5k@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.21 13:41, Michal Hocko wrote:
> On Thu 15-04-21 12:35:40, Oscar Salvador wrote:
>> Pages allocated after boot get its private field cleared by means
>> of post_alloc_hook().
> 
> You surely meant to say s@boot@page/cma allocator@ here

I think this also includes allocating gigantic pages via 
alloc_contig_pages() directly. post_alloc_hook() covers both.

> 
>> Pages allocated during boot, that is directly from the memblock allocator,
>> get cleared by paging_init()->..->memmap_init_zone->..->__init_single_page()
>> before any memblock allocation.
>>
>> Based on this ground, let us remove the clearing of the flag from
>> prep_new_huge_page() as it is not needed.
> 
> I would also mention that this is a leftover from 6c0371490140
> ("hugetlb: convert PageHugeFreed to HPageFreed flag"). Previously the
> explicit clearing was necessary because compound allocations do not get
> this initialization (see prep_compound_page).
> 
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> with that
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

