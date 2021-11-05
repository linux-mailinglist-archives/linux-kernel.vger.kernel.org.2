Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721FA4463C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhKENFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhKENFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636117381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLgQ5EmaL+DmQgkfnA8r6Au7OZ5a7gYy6SmBrNd2Jg0=;
        b=PJc/6qYSApEyjgJDY7YvtHbCgROxfxt37spj59Cut4M5+WgR2ybGYihD3NoMqqhRuPypoA
        a33YR74OsyDzaWmBjjYgg5to0vfHCLzKOoPz2YU49FPX0aChopP6a1cbfX3HwiCDsXm8Zs
        HZtA4quMMvEd/Bh/zJ2rv7OpBHzi/Wo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-u3KXltpJMq-Kf2TADMEB_w-1; Fri, 05 Nov 2021 09:02:58 -0400
X-MC-Unique: u3KXltpJMq-Kf2TADMEB_w-1
Received: by mail-wr1-f72.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso2302479wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 06:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iLgQ5EmaL+DmQgkfnA8r6Au7OZ5a7gYy6SmBrNd2Jg0=;
        b=U5a4JdaTzehkklmd4yp5uYi4CV9QX7reabKnlJUKK/WX7ypgAXnZPr5jHo6upvgxwA
         3ruXOA3nSz1ooG3iDcVb534lob8DCZFMkqvUZAXR8IdnL9oDID3+vpbNjZ/FwLFynCgM
         0hg/gA1xoxwZuRMGerb93K1L01SyTXxZnfqBVQuD3nXK6JZXxhil32BefAXVSsar/kaX
         KJ7Zt9b8dqP/+J6RqSniS1CUE4olGWbb40E/omp8HnZ0vTs355X3mKNivBURFZpsvGMV
         y0sdx0QhLbNtT+idJzDVPIzIm6lIdO0rsVqENKooj4d3GZJUwb9dz6qqt5jSMBr8z3No
         9LPg==
X-Gm-Message-State: AOAM5322xfa19tVYUMO8919y9/1rCsTshngJtdWWFfI0disMQzsN64VA
        yrxnrP4EAMM4B5v6Z9c5Xg83eDTVxF9qS4j820p58bRyeEM11RizGwlm3JT5Bn67MxCD9UskXoW
        bvD5TSnSJ9nvP2g6wogy05bEb
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr8894824wrd.369.1636117377156;
        Fri, 05 Nov 2021 06:02:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4FNkl2pJ0RVTR1lono1DFLFCRUFCJzXmJtOSdgDG0W+NMxHGOW8KGvf14VSf7b8sSj83Bvw==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr8894791wrd.369.1636117376914;
        Fri, 05 Nov 2021 06:02:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:a000:3f25:9662:b5cf:73f9? (p200300d82f0ca0003f259662b5cf73f9.dip0.t-ipconnect.de. [2003:d8:2f0c:a000:3f25:9662:b5cf:73f9])
        by smtp.gmail.com with ESMTPSA id o1sm8061186wru.91.2021.11.05.06.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 06:02:56 -0700 (PDT)
Message-ID: <3b675cb9-3002-b1a7-1b24-fdd38b55d73b@redhat.com>
Date:   Fri, 5 Nov 2021 14:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20211105114954.GA3163106@u2004>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/3] mm/hwpoison: fix unpoison_memory()
In-Reply-To: <20211105114954.GA3163106@u2004>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.21 12:49, Naoya Horiguchi wrote:
> On Fri, Nov 05, 2021 at 11:58:15AM +0100, David Hildenbrand wrote:
>> On 05.11.21 06:50, Naoya Horiguchi wrote:
>>> Hi,
>>>
>>> I updated the unpoison patchset based ou discussions over v2.
>>> Please see individual patches for details of updates.
>>>
>>> ----- (cover letter copied from v2) -----
>>> Main purpose of this series is to sync unpoison code to recent changes
>>> around how hwpoison code takes page refcount.  Unpoison should work or
>>> simply fail (without crash) if impossible.
>>>
>>> The recent works of keeping hwpoison pages in shmem pagecache introduce
>>> a new state of hwpoisoned pages, but unpoison for such pages is not
>>> supported yet with this series.
>>>
>>> It seems that soft-offline and unpoison can be used as general purpose
>>> page offline/online mechanism (not in the context of memory error).
>>
>> I'm not sure what the target use case would be TBH ... for proper memory
>> offlining/memory hotunplug we have to offline whole memory blocks. For
>> memory ballooning based mechanisms we simply allocate random free pages
>> and eventually trigger reclaim to make more random free pages available.
>> For memory hotunplug via virtio-mem we're using alloc_contig_range() to
>> allocate ranges of interest we logically unplug.
> 
> I heard about it from two people independently and I think that that's maybe
> a rough idea, so if no one shows the clear use case or someone logically
> shows that we don't need it, I do not head for it.

I'd love to learn about use cases!

> 
>>
>> The only benefit compared to alloc_contig_range() might be that we can
>> offline smaller chunks -- alloc_contig_range() isn't optimized for
>> sub-MAX_ORDER granularity yet. But then, alloc_contig_range() should
>> much rather be extended.
> 
> If alloc_contig_range() supports memory offline in arbitrary size of
> granurality (including a single page), maybe soft offline can be (partially
> I guess) unified to it.

Conceptually, memory offlining, alloc_contig_range(), soft-offlining all
perform roughly the same thing just with different flavors: evacuate a
given PFN area and decide what shall happen with it.

After memory offlining, memory cannot get reused (e.g., allocated via
the buddy) before re-onlining that memory. It's some kind of "fake
allocation" + advanced magic to actually remove the memory from the system.

alloc_contig_range() is just a "real" allocation, and can be used (e.g.,
by virtio-mem) for fake offlining by some additional magic on top.

soft-offlining is just another special type of "special allocation",
however, focused on individual page.


The biggest difference between soft-offlining and
alloc_contig_range()+memory offlining is right now the granularity.
While alloc_contig_range() can be used to allocate individual pages on
ZONE_MOVABLE and MIGRATE_CMA, it cannot deal with other zones with such
small granularity yet -- too many false negatives, meaning an allocation
might fail although the single page actually could get allocated.

-- 
Thanks,

David / dhildenb

