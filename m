Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDA45EA33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbhKZJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353065AbhKZJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637918222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3CdXWc1SZaICoTk9b5MrvXGDxRWiBZQIkDS68EgmRQ=;
        b=LyBJaDSVz+NO/8fxk6A0NoAi5Pvt5tDn0ezpnXznY4e+IUBAx/oKl0m3N2/0Y+IY/02Gfx
        o62A3TWwqkYTIiXf3LX4aAM1hrXa/4SP43fEsB8AncMotmXdRhkqOZZq9q6Qwu7n9lwPTy
        SBu4sPDplBUZ13eIiweHmQXmKOrQhpo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-1WuQ7IeYMcur5mW_AXcWOw-1; Fri, 26 Nov 2021 04:17:01 -0500
X-MC-Unique: 1WuQ7IeYMcur5mW_AXcWOw-1
Received: by mail-wm1-f69.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so5026348wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=v3CdXWc1SZaICoTk9b5MrvXGDxRWiBZQIkDS68EgmRQ=;
        b=60Oj8x1ZJi6QXVJqa0TG7jWg3TzXopvllKF/j5SmIDtKB+vo/0/ng5WJwtz5d/MCHQ
         5dxrdNw8SU5zOIh+5GKV1CDf0MIPz0QBrViE7RaZsvf6uwkJzcoLdhCAE56QBykxdnHM
         +iU9aaT3RMbTYsJNb59HqpLnVOMrMUyqXGqaw84xo+Xa1c8P6hed8SM/v/6otIiwHb49
         MsTsCW8+fglDZOulnffk1UKF/nAi4BXXMfnDpbb8IXPDyrB66eym+aagSMasVqfUYTTN
         3cht+tma+NDDGlQjyOILv2iMlCYrJakOqyO9scq7M2/lh5ernpxHRmFBu/oGFU55WR2/
         qaxA==
X-Gm-Message-State: AOAM5316XAFpujJhho7U8iNkvmcjv2BxEHNzA/MrFdCRoWaTFw4Z7/+w
        SnWr7NNm3B4sO7/N9RVaJVwxkTwsMwhDtHUwPrL1KiOaaFERkH/EeL5x3K5FcquTNsOy3n9OloZ
        0d6WAEq79mlnuVfXFuJJqpyE9
X-Received: by 2002:a5d:6dab:: with SMTP id u11mr12716361wrs.46.1637918220335;
        Fri, 26 Nov 2021 01:17:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Xs4/dvseMjQSCGAu8v5sW1hnGyhvEhMdCBtyjW6s4Rl5ZE978y0sOrNpmxY1pUPNudYfyw==
X-Received: by 2002:a5d:6dab:: with SMTP id u11mr12716341wrs.46.1637918220137;
        Fri, 26 Nov 2021 01:17:00 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
        by smtp.gmail.com with ESMTPSA id w7sm4989545wru.51.2021.11.26.01.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 01:16:59 -0800 (PST)
Message-ID: <f464115b-f332-9f13-89c4-81bf6b282975@redhat.com>
Date:   Fri, 26 Nov 2021 10:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
 <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
 <YaBevbuNuR+ToJ1o@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <YaBevbuNuR+ToJ1o@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Thanks for making me rerun this and yes indeed I had a very silly bug in the
>> benchmark code (i.e. madvise the same page for the whole loop) and this is
>> indeed several times slower than without the patch (sorry David for misleading
>> you).

No worries, BUGs happen :)

>>
>> To better understand what is happening, I profiled the benchmark:
>>
>> -   31.27%     0.01%  dontneed  [kernel.kallsyms]  [k] zap_page_range_sync
>>    - 31.27% zap_page_range_sync
>>       - 30.25% split_local_deferred_list
>>          - 30.16% split_huge_page_to_list
>>             - 21.05% try_to_migrate
>>                + rmap_walk_anon
>>             - 7.47% remove_migration_ptes
>>                + 7.34% rmap_walk_locked
>>       + 1.02% zap_page_range_details
> 
> Makes sense, thanks for verifying it, Shakeel.  I forgot it'll also walk
> itself.
> 
> I believe this effect will be exaggerated when the mapping is shared,
> e.g. shmem file thp between processes.  What's worse is that when one process
> DONTNEED one 4k page, all the rest mms will need to split the huge pmd without
> even being noticed, so that's a direct suffer from perf degrade.

Would this really apply to MADV_DONTNEED on shmem, and would deferred
splitting apply on shmem? I'm constantly confused about shmem vs. anon,
but I would have assumed that shmem is fd-based and we wouldn't end up
in rmap_walk_anon. For shmem, the pagecache would contain the THP which
would stick around and deferred splits don't even apply.

But again, I'm constantly confused so I'd love to be enlighted.

> 
>>
>> The overhead is not due to copying page flags but rather due to two rmap walks.
>> I don't think this much overhead is justified for current users of MADV_DONTNEED
>> and munmap. I have to rethink the approach.

Most probably not.

> 
> Some side notes: I digged out the old MADV_COLLAPSE proposal right after I
> thought about MADV_SPLIT (or any of its variance):
> 
> https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> 
> My memory was that there's some issue to be solved so that was blocked, however
> when I read the thread it sounds like the list was mostly reaching a consensus
> on considering MADV_COLLAPSE being beneficial.  Still copying DavidR in case I
> missed something important.
> 
> If we think MADV_COLLAPSE can help to implement an userspace (and more
> importantly, data-aware) khugepaged, then MADV_SPLIT can be the other side of
> kcompactd, perhaps.
> 
> That's probably a bit off topic of this specific discussion on the specific use
> case, but so far it seems all reasonable and discussable.

User space can trigger a split manually using some MADV hackery. But it
can only be used for the use case here, where we actually want to zap a
page.

1. MADV_FREE a single 4k page in the range. This will split the PMD->PTE
   and the compound page.
2. MADV_DONTNEED either the complete range or the single 4k page.

-- 
Thanks,

David / dhildenb

