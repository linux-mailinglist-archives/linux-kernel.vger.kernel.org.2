Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED4535C866
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhDLOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241159AbhDLOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618236735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyi96NyD+D+WfuS5i0V0sBLczlKBBvqVl8O4Fn9CDhU=;
        b=VLxngrE2XwSivaLCU5tc1Vj1sfkAeXlt+Cfu9P822tcsqFX415S10ba5L1F5gV2a+sv3cP
        FmlZpkVXB7MpQocVswTXg5aB75I6bwOlT3GT/fuz9kaxEQaQbu/cDV2gV7/WKhivaR5fQJ
        Bo0tHy3EXB/tAyQi7uAVdzoUnvv1eZs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-flPrcfj_MZ6_2MwJ-bb42g-1; Mon, 12 Apr 2021 10:12:13 -0400
X-MC-Unique: flPrcfj_MZ6_2MwJ-bb42g-1
Received: by mail-wm1-f72.google.com with SMTP id h10-20020a05600c350ab029010cff8d09edso2164343wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lyi96NyD+D+WfuS5i0V0sBLczlKBBvqVl8O4Fn9CDhU=;
        b=QP8dcjnXOdli4balfqRtUoB75ilGcJBxX2ccHMMC8WpW51cjhnHWOg33jsU8nFF/b3
         ysY7fdt7asJXZeXEsGFEoTTW/3VZiU4cNuwsEyr2BPV37rYC7dyaq1XXvAdNJc/S+uoU
         4G+UVstMDJCxD9764twZNjhiuGcIEOh9eYy9oQRw55gEwgtRfGPX4W04906BNV4tYr04
         CHW2O7Ygj7hoFINKompbrmPEJ2zRPL/2a5NSn2DU6hk99njZ9EK3C2nWI7gYPhnC4obT
         qNDtRh68wDobXkWxGxO7jZQL3hQ+6WvISpmKwgVFniktLjN9jP9n7BGI+CBf93bH+rRz
         XwTA==
X-Gm-Message-State: AOAM530Q6hdbAUUwfnvrS8+bOtkcfupC/7QTKImNl6NuWxoAhHgw+8lI
        d8ZEXRZ6NMqbAwVUcMkODwSGE6nq0zd+5XFDkJ8tRxG37Tof+5Cz63QHWrBiZA3r/RI0h6UUP8r
        3si7kZ1zbXrquinSy4NiRVpmOg12TZ9lbfnc/2NDtbH68KT/AfrAFPM61OzuQtKw0/nwAfjkC
X-Received: by 2002:adf:f14b:: with SMTP id y11mr30921908wro.79.1618236732763;
        Mon, 12 Apr 2021 07:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxANxA+uBgwsvkXeVvSUMO/GTY7oQqczZlRKrWC3N/pmo2Ecge8ErYByv50q+ApvHfKVv79Qg==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr30921880wro.79.1618236732532;
        Mon, 12 Apr 2021 07:12:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id a3sm18045233wru.40.2021.04.12.07.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 07:12:12 -0700 (PDT)
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a0d73ce0-b2bd-1928-539d-39cb9da9bf1f@redhat.com>
Date:   Mon, 12 Apr 2021 16:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412140852.GZ3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.21 16:08, Mel Gorman wrote:
> On Mon, Apr 12, 2021 at 02:40:18PM +0200, Vlastimil Babka wrote:
>> On 4/12/21 2:08 PM, Mel Gorman wrote:
>>> zone_pcp_reset allegedly protects against a race with drain_pages
>>> using local_irq_save but this is bogus. local_irq_save only operates
>>> on the local CPU. If memory hotplug is running on CPU A and drain_pages
>>> is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
>>> offers no protection.
>>>
>>> This patch deletes IRQ disable/enable on the grounds that IRQs protect
>>> nothing and assumes the existing hotplug paths guarantees the PCP cannot be
>>> used after zone_pcp_enable(). That should be the case already because all
>>> the pages have been freed and there is no page to put on the PCP lists.
>>>
>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>
>> Yeah the irq disabling here is clearly bogus, so:
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
> 
> Thanks!
> 
>> But I think Michal has a point that we might best leave the pagesets around, by
>> a future change. I'm have some doubts that even with your reordering of the
>> reset/destroy after zonelist rebuild in v1 they cant't be reachable. We have no
>> protection between zonelist rebuild and zonelist traversal, and that's why we
>> just leave pgdats around.
>>
>> So I can imagine a task racing with memory hotremove might see watermarks as ok
>> in get_page_from_freelist() for the zone and proceeds to try_this_zone:, then
>> gets stalled/scheduled out while hotremove rebuilds the zonelist and destroys
>> the pcplists, then the first task is resumed and proceeds with rmqueue_pcplist().
>>
>> So that's very rare thus not urgent, and this patch doesn't make it less rare so
>> not a reason to block it.
>>
> 
> After v1 of the patch, the race was reduced to the point between the
> zone watermark check and the rmqueue_pcplist but yes, it still existed.
> Closing it completely was either complex or expensive. Setting
> zone->pageset = &boot_pageset before the free would shrink the race
> further but that still leaves a potential memory ordering issue.
> 
> While fixable, it's either complex, expensive or both so yes, just leaving
> the pageset structures in place would be much more straight-forward
> assuming the structures were not allocated in the zone that is being
> hot-removed. As things stand, I had trouble even testing zone hot-remove
> as there was always a few pages left behind and I did not chase down
> why.
Can you elaborate? I can reliably trigger zone present pages going to 0 
by just hotplugging a DIMM, onlining the memory block devices to the 
MOVABLE zone, followed by offlining the memory block again.

-- 
Thanks,

David / dhildenb

