Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6735CAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbhDLQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238937AbhDLQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618243332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78X0OYDfE/7+/Hlen2MBzJuZuksJMmznz4Te2YiIK6g=;
        b=M1aeNpe2wYHCAVXiXcUa2SahmZCC/nJbZdvzrjcbzmRKru22QWW7TNBUPfAQG5eb2U6JPp
        re80Pm+Q7tFg5pCsbgdiYZKbXqVPllLPD0cpoYCkTq88k0Hs7eq9rvOrnJPq5kOgkR/1oY
        dLgxZdfFri/eZDYTwVHewMnLHAqKhw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-cvzrOsxKNyWkf_7cRZAm1A-1; Mon, 12 Apr 2021 12:02:10 -0400
X-MC-Unique: cvzrOsxKNyWkf_7cRZAm1A-1
Received: by mail-wr1-f72.google.com with SMTP id x18so6209483wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=78X0OYDfE/7+/Hlen2MBzJuZuksJMmznz4Te2YiIK6g=;
        b=CdCONWQtlAZjLCcWVKIrnQUdVrjgQLXqgkonHpxdWvwZqRD222x1Bng7Ud/EXJjakc
         92IgjoH7S7OrnAcMsh4gXLqvWVUOQ2lypospsphjMXbjQWADFyuLiORlS6XdZ+fzupxr
         5NKjllVt2mTVWmAfpqWQW8hG3Dvzsh4A+TZ/Gh3xNszqRjy7rNlNvBU8adgh8Pb2HYzO
         gbU7bfIFrQixhYu1mwyspwKlkLzt00sJZaVLk7/B2GB82SHaIoCWhvl0NYCybx+VHI0z
         3oj+WYxg7KZ9xjr8zIVVAr88UxDJPaQP/Fi5OpiYcfU+CbPqfcrD82uIIAe5upTcHOlz
         1f3g==
X-Gm-Message-State: AOAM531p1+t2/oqANb9J5jTtHw6c78ll9dKa2jfyvnCei4xt5KJQEuOA
        wB3l3tBOWI2I81/zGcSd/d5JPUSvPnLAfIxf7Mb5EZTQE8OS/4EsNrB0J0GLP0EaDHlzp2ktH0d
        gET50Ogxeo8EG7DA4E14yizlf0GcAH/x9j23SbS1v17EktiLl5bsJaxytuLwtzuJ6D+mA0VFo
X-Received: by 2002:a5d:4584:: with SMTP id p4mr3809789wrq.383.1618243329120;
        Mon, 12 Apr 2021 09:02:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS9w1z1n9yjWbp5Jp8RHXvNAVH1prig0Za5BI1pIb58C3NvGBrdnTP1V5Unu8Jv0gTQySv9g==
X-Received: by 2002:a5d:4584:: with SMTP id p4mr3809750wrq.383.1618243328840;
        Mon, 12 Apr 2021 09:02:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id v7sm16331006wrs.2.2021.04.12.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:02:08 -0700 (PDT)
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
 <a0d73ce0-b2bd-1928-539d-39cb9da9bf1f@redhat.com>
 <20210412152737.GB3697@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9ecdd427-8eee-c3c8-414f-501f62245585@redhat.com>
Date:   Mon, 12 Apr 2021 18:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412152737.GB3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.21 17:27, Mel Gorman wrote:
> On Mon, Apr 12, 2021 at 04:12:11PM +0200, David Hildenbrand wrote:
>>> After v1 of the patch, the race was reduced to the point between the
>>> zone watermark check and the rmqueue_pcplist but yes, it still existed.
>>> Closing it completely was either complex or expensive. Setting
>>> zone->pageset = &boot_pageset before the free would shrink the race
>>> further but that still leaves a potential memory ordering issue.
>>>
>>> While fixable, it's either complex, expensive or both so yes, just leaving
>>> the pageset structures in place would be much more straight-forward
>>> assuming the structures were not allocated in the zone that is being
>>> hot-removed. As things stand, I had trouble even testing zone hot-remove
>>> as there was always a few pages left behind and I did not chase down
>>> why.
>>
>> Can you elaborate? I can reliably trigger zone present pages going to 0 by
>> just hotplugging a DIMM, onlining the memory block devices to the MOVABLE
>> zone, followed by offlining the memory block again.
>>
> 
> For the machine I was testing on, I tried offlining all memory within
> a zone on a NUMA machine. Even if I used movable_zone to create a zone
> or numa=fake to create multiple fake nodes and zones, there was always
> either reserved or pinned pages preventing the full zone being removed.

What can happen is that memblock allocations are still placed into the 
MOVABLE zone -- even with "movablenode" IIRC.

Memory hot(un)plug is usually best tested in QEMU via pc-dimm devices.

-- 
Thanks,

David / dhildenb

