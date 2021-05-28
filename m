Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA103940D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhE1KXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235361AbhE1KW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622197284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRtLgByD3ejpQsxciFOP3GYk1lL3gyURmaecEKKGJtM=;
        b=XR8NZQvB8zg3Gw8qBR3dg5TJ1aBhwu91cYIcQ8oWJWjveFyEQZEu/lbhL2fSqNd4A6eSAw
        fqBsuYSNsFxkJVKmEzkuKVbM1a9zemhtOYV+4a12KsQubZ5q1DwJJu3N0ta1ZWlwRmgRbR
        IcDHksAHcyqdYXEi990kOdXOyPE3doQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-Xs-W9c1pPEacDLFtgQ7E4g-1; Fri, 28 May 2021 06:21:22 -0400
X-MC-Unique: Xs-W9c1pPEacDLFtgQ7E4g-1
Received: by mail-wr1-f71.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so838459wre.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oRtLgByD3ejpQsxciFOP3GYk1lL3gyURmaecEKKGJtM=;
        b=FEpbMS2VexzMNbdVP/AMtv7WGOFkPxghAo02PindY3bQJcPoCTbdaXkc0bquGjPTCg
         BSqQISHQrYISv1TwaHzmmqwaXBa1cDSyUxdIGBEalZpEcYEi28L8eUNu7GwG5hKboQJY
         /xBEquUQwJR1rH9DhYj4bv1xFQrSGFkWbSsOyiIt3a1xjQTqVcLSfYKV9aTA759eJdJu
         wElN9WQxWqKZWxZDBVCdVxmUuGmA/iUKoO9vdwCPY7jMiDdwZ2gd1e+bTp3LGo26rHXl
         SMXK1t6mxkY6w+6csGgbij2HpxmGgTqE2AsQqHkNmVwiktvL2q1m6dfc+JBsNZiG0KlD
         lQtA==
X-Gm-Message-State: AOAM531g/0L6gloJUzyvOxJOTs/ewonB8DQZ2VaXRtHWfXly7q3S4gDI
        biOMZUwd7sv+HkzYax0ux5xB3fySz7+fghED7mZJIskiuncPffNd0fDNrz9UZelTGDYCRnkji3M
        dXAjddQ/8JIdezeqNEd4vz0yO
X-Received: by 2002:a5d:534f:: with SMTP id t15mr7687182wrv.206.1622197281540;
        Fri, 28 May 2021 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2/Z2o0e07haEOrsooEHs87bLVJKGph3BWfu7UwTODy5CsgBcWMazSCki58gq4VcnKsmzLug==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr7687160wrv.206.1622197281325;
        Fri, 28 May 2021 03:21:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id m9sm6499072wrq.78.2021.05.28.03.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 03:21:21 -0700 (PDT)
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
 <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
 <20210528094949.GL30378@techsingularity.net>
 <6c189def-11cc-80db-0fde-56aa506cfdea@redhat.com>
 <20210528100918.GM30378@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active
 CPUs
Message-ID: <8d6dfad6-ae0b-fd47-1d83-23baf82921b4@redhat.com>
Date:   Fri, 28 May 2021 12:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528100918.GM30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 12:09, Mel Gorman wrote:
> On Fri, May 28, 2021 at 11:52:53AM +0200, David Hildenbrand wrote:
>>>> "Disable pcplists so that page isolation cannot race with freeing
>>>>    in a way that pages from isolated pageblock are left on pcplists."
>>>>
>>>> Guess we'd then want to move the draining before start_isolate_page_range()
>>>> in alloc_contig_range().
>>>>
>>>
>>> Or instead of draining, validate the PFN range in alloc_contig_range
>>> is within the same zone and if so, call zone_pcp_disable() before
>>> start_isolate_page_range and enable after __alloc_contig_migrate_range.
>>>
>>
>> We require the caller to only pass a range within a single zone, so that
>> should be fine.
>>
>> The only ugly thing about zone_pcp_disable() is
>> mutex_lock(&pcp_batch_high_lock) which would serialize all
>> alloc_contig_range() and even with offline_pages().
>>
> 
> True so it would have to be accessed if that is bad or not. If racing
> against offline_pages, memory is potentially being offlined in the
> target zone which may cause allocation failure. If racing with other
> alloc_contig_range calls, the two callers are potentially racing to
> isolate and allocate the same range. The arguement could be made that
> alloc_contig_ranges should be serialised within one zone to improve the
> allocation success rate at the potential cost of allocation latency.

We have 3 main users of alloc_contig_range():

1. CMA

CMA synchronizes allocation within a CMA area via the allocation bitmap. 
So parallel CMA is perfectly possible and avoids races by design.

2. alloc_contig_pages() / Gigantic pages

Gigantic page allocation could race with virtio-mem. CMA does not apply. 
Possible but unlikely to matter in practice. virtio-mem will retry later 
again.

3. virito-mem

A virtio-mem device only operates on its assigned memory region, so we 
cannot have alloc_contig_range() from different devices racing, even 
when within a single zone. It could only race with gigantic pages as CMA 
does not apply.


So serializing would mostly harm parallel CMA (possible and likely) and 
parallel virtio-mem operation (e.g., unplug memory of two virtio-mem 
devices -- unlikely but possible).


Memory offlining racing with CMA is not an issue (impossible). 
virtio-mem synchronizes with memory offlining via memory notifiers, 
there is only a tiny little race window that usually doesn't matter as 
virtio-mem is expected to usually triggers offlining itself, and not 
user space rancomly. Memory offlining can race with dynamic gigantic 
page allocation, wich is highly unreliable already.

I wonder if we could optimize locking in zone_pcp_disable() instead.

-- 
Thanks,

David / dhildenb

