Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAC36AFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhDZIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232184AbhDZIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619426249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVK0IPAL1uPYo6BCuSzx6+CPPnrHCxq19TPjpGS3x4Y=;
        b=gf5BTqTGOIRzg94FHWLiwJRVpqeXHvRGQmzrpXxR0TIIfM2Uy/gcp/kuTAZcYujYstUk3E
        WEayJVN5GKUnLvcK0AWHKFCFP5khz6zFWP7NnRlhyvAIRFdCwzEd9x43SRdUNzKpjpk2xn
        YeLJQ7CHVOEU2UL5ySnC4cjr0QTehWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-bis9sw2_O1St-pwguCDq5Q-1; Mon, 26 Apr 2021 04:37:26 -0400
X-MC-Unique: bis9sw2_O1St-pwguCDq5Q-1
Received: by mail-wr1-f70.google.com with SMTP id d15-20020a5d538f0000b02901027c18c581so18475610wrv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TVK0IPAL1uPYo6BCuSzx6+CPPnrHCxq19TPjpGS3x4Y=;
        b=MT/UFUATWiZP20KnMp3PAU/7xIXp2E5jkzW6oCZ3QHkUP9VQgL/vL2UD5IlnwcG/1I
         rWj1IK4zUHW5WZdsUS88JkwABbfig5mSBVgJmkLGEN/lif9CNpsKtAbhPgg79BIrIjlo
         M8jvXQzBq63EmePOH+sc1jILnekhDjy4hYmuWOP0QbA62fxaOEBEs/c5dFRqtdZsWh63
         et3L38uj6JJ7dynlaiew+Fm8/0uAKTdM7POe/JucF3hQj/ua7O43hEuBJjKoirxExGzF
         iedXComvi+i2x5HsqToc7w8L9GA0s3YNxtIk4Z+uGrcYcGKcSrfzNfasx2Gkf25Wj67x
         ONeA==
X-Gm-Message-State: AOAM533i/4PG1c1vpx05ncxk0kLWRh2kE8zO9aSpgAyxeRZoLt+rGy4P
        9EvwQrHb/D5rOIj9s7AxgeGhZ/mzyQWcFS/CJvEZKLRmoqNoVJsuTV8xhHN529tPPiZnYY2oHwS
        0TZ4xsKAkleSJoXfImeho/xp7
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr733943wrq.102.1619426245013;
        Mon, 26 Apr 2021 01:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzveJEJgPS8uJcPeDtRzMtd4yu2f4jgK70PX1DUHn1wSnFqh6X3/NpXTd7BIXqmfq0SNhe1Ig==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr733914wrq.102.1619426244734;
        Mon, 26 Apr 2021 01:37:24 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6206.dip0.t-ipconnect.de. [91.12.98.6])
        by smtp.gmail.com with ESMTPSA id 3sm6752968wms.30.2021.04.26.01.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 01:37:24 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>,
        zhangshiming <zhangshiming@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>,
        guoweichao <guoweichao@oppo.com>, guojian <guojian@oppo.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <c289b9dc-1259-c829-8ee4-1bee94d7d73d@redhat.com>
 <2021042611194631963076@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <7dcc87f5-9ae5-613a-0cf4-820334592b90@redhat.com>
Date:   Mon, 26 Apr 2021 10:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2021042611194631963076@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.21 05:19, lipeifeng@oppo.com wrote:
> 
>  >> Let's consider part 3 only and ignore the 1) multi freearea (which might
>  >> be problematic with sparcity) and 2) the modified allocation scheme
>  >> (which doesn't yet quite sense to me yet, e.g., because we group by
>  >> mobility and have compaction in place; I assume this really only helps
>  >> in some special cases -- like the test case you are giving; I might be
>  >> wrong)
>  >> Right now, we decide whether to but to head or tail based on how likely
>  >> it is that we might merge to a higher-order page (buddy_merge_likely())
>  >> in the future. So we only consider the current "neighborhood" of the
>  >> page we're freeing. As we restrict our neighborhood to MAX_ORDER - 1
>  >> pages (what we can actually merge). Of course, we can easily be wrong
>  >> here. Grouping by movability and compaction only helps to some degree I
>  >> guess.
>  >> AFAIK, what you propose is basing the decisions where to place a page
>  >> (in addition?) on a median_pfn. Without 1) and 2) I cannot completely
>  >> understand if 3) itself would help at all (and how to set the
>  >> median_pfn). But it would certainly be interesting if we can tweak the
>  >> current logic to better identify merge targets simply by tweaking
>  >> buddy_merge_likely() or the assumptions it is making.
> 
> 
> 
> Hi David Hildenbrand，Vlastimil Babka:
>      Thank you very much indeed for advices.
> 
>>> 2) the modified allocation scheme
>  >> (which doesn't yet quite sense to me yet, e.g., because we group by
>  >> mobility and have compaction in place; I assume this really only helps
>  >> in some special cases -- like the test case you are giving;
>   ---------------------------------------------------------------------------------
> 1) Divide memory into several segments by pages-PFN
> 2) Select the corresponding freearea to alloc-pages
>      These two parts art for the same purpose:
> low-order-pages allocation will be concentrated in the front area of 
> physical memory
> so that few memory-pollution in the back area of memory, the sussessful 
> probablity
> of high-order allocation would be improved.
> 
>      I think that it would help in almost all cases of high-oder-pages 
> allocation, instead
>      of special case, because it can let more high-order free-pages in 
> buddy, example:

See, and I am not convinced that this is the case, because you really 
only report one example (Monkey) and I have to assume it is a special 
case then.

> 
>   * when user alloc 64K bytes, if the unit is page(4K bytes) and it
>     needs to 16 times. 
> 
> if the unit is 64Kbytes, it only takes once.
> 
>   * if there are more free-high-order-pages in buddy that few
>     compact-stall in
> 
> alloction-process, the allocstall-time would be shortened.
> 
>      We tested the speed of the high-orders-pages(order=4 and order = 8) 
> allocation
> after monkey and found that it increased by more than 18%.
> 

And you don't mention what the baseline configuration was. For example, 
how was compaction configured?

Just to clarify, what is monkey?

Monkey HTTP server? MonkeyTest disk benchmark? UI/Application Exerciser 
Monkey?

> 3) Adjust the location of free-pages in the free_list
>>>Without 1) and 2) I cannot completely
>  >>understand if 3) itself would help at all (and how to set the median_pfn)
> -----------------------------------------------------------------------------------------------------
>      Median_pfn is set by the range of pages-PFN of free_area. if part 
> 3) would be tried separately
>      without 1) and 2), the simple setting is the median of the entire 
> memory. But i think it will play the
> better role in optimization based on the 1) and 2).
> 
> 
> 
>  >> Last but not least, there have to be more benchmarks and test cases that
>  >> proof that other workload won't be degraded to a degree that people
>  >> care; as one example, this includes runtime overhead when
>>> allocating/freeing pages.
> ---------------------------------------------
> 1. For modification of buddy: the modified allocation scheme 1)+2)
>      Is thers any standard detailed test-list  of the modified 
> allocation in the community? like benchmarks
> or any other tests? if  i pass the test required by communiry that can 
> proof the patch will not degraded
> to a degree that people care and can merge it in the baseline?

IIRC, there are plenty. One example is will-it-scale.

Have a look at https://github.com/intel/lkp-tests.git


-- 
Thanks,

David / dhildenb

