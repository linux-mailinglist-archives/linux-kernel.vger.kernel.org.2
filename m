Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D523666B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDUIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhDUIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618992397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oK3rihUx7OjIP8MnUHMJzvDGc/eOqRPG2UhKmsMq4M0=;
        b=UZW5Khe6lh5gHHWlcAUDR38ItYn3AvecgEQoiZ4scT//QAD74YgSv7MrqSUL+9pKVcK6/C
        UH+kcBVDPLhM4ArAmtLjGW+a7D90FgJbo4foxS11T8Lm+qFmVyY6x/EkbDaOMdDq5To6tx
        fyI2pD7tGt6epiqN+4H3X6NZjz4pNz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-A8yo4FyyP7CYbUocy3WK1w-1; Wed, 21 Apr 2021 04:06:36 -0400
X-MC-Unique: A8yo4FyyP7CYbUocy3WK1w-1
Received: by mail-wm1-f72.google.com with SMTP id k26-20020a7bc41a0000b0290125f388fcfbso118071wmi.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oK3rihUx7OjIP8MnUHMJzvDGc/eOqRPG2UhKmsMq4M0=;
        b=nzeKLWAgLhE1WnUGCw8MC7mk3V/GyDnFRp5BUB5dXdnlkj0MvKhwCPBw08+W7srX1C
         J+ZLi2sXeQmSfB8qfU7ua1ADgB71lEflaZEtJJQlEVoruebMYy+08aNWOHPF40CdGrzq
         pSEyBC0TFvoaLlNOmH3xqmhDX92jZSXF2Vq0uvAHQEOKzqqs6Ah8nPSOkVKLU0NITPFV
         y0RgrK/gwZXfkfnU3F5NZxBd7voWrieQj1BdVWXq3IOU0ArwCvza+t4n7KNLrhhQs5el
         Px+k/Iadmft0oQBIOko0lbie9lQuN7itZ9R6DRcCuA1CSJvPqxAXuiaWdAwgxPbiRVKA
         4YsQ==
X-Gm-Message-State: AOAM530+OH/W6KG34o4BLtA+wh2Uv6CwmSwgMedyPcxiBhSuHUxfzfJq
        z7MXiMtxxLqTp9Ujr2wITA4pX6DpelDIR4efJddQE4T9/oDqiWzlbYojFrsvD0UKOclgK9IZD3T
        CP8iGABunwB+P5n2CmPbhBy/26B3uhknrELZnzCT/ZE2Qj8bQPbv+5uJ7u6SXyXhgWi/MQhUl
X-Received: by 2002:a5d:424a:: with SMTP id s10mr26464906wrr.70.1618992394862;
        Wed, 21 Apr 2021 01:06:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh933TlcjPpXOPqkAVaIRzTS8Z39NS8E9+o0Sn0mgvIQuFp76UNqwReiF9Ybvlt4h+OULlSQ==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr26464883wrr.70.1618992394632;
        Wed, 21 Apr 2021 01:06:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b8.dip0.t-ipconnect.de. [91.12.100.184])
        by smtp.gmail.com with ESMTPSA id h81sm1747260wmf.41.2021.04.21.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 01:06:34 -0700 (PDT)
Subject: Re: [PATCH v9 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-4-osalvador@suse.de> <YH6i09ieDte+xog8@dhcp22.suse.cz>
 <20210421080036.GC22456@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c352a62a-3369-01a9-10b0-c76f5c2dc038@redhat.com>
Date:   Wed, 21 Apr 2021 10:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421080036.GC22456@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 10:00, Oscar Salvador wrote:
> On Tue, Apr 20, 2021 at 11:45:55AM +0200, Michal Hocko wrote:
>> On Fri 16-04-21 13:24:06, Oscar Salvador wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> Let's have a single place (inspired by adjust_managed_page_count()) where
>>> we adjust present pages.
>>> In contrast to adjust_managed_page_count(), only memory onlining/offlining
>>> is allowed to modify the number of present pages.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>
>> Not sure self review counts ;)
> 
> Uhm, the original author is David, I just added my signed-off-by as a deliverer.
> I thought that in that case was ok to stick my Reviewed-by.
> Or maybe my signed-off-by carries that implicitly.
> 
>> Acked-by: Michal Hocko <mhocko@suse.com>
>>
>> Btw. I strongly suspect the resize lock is quite pointless here.
>> Something for a follow up patch.
> 
> What makes you think that?
> I have been thinking about this, let us ignore this patch for a moment.
> 
> If I poked the code correctly, node_size_lock is taken in:
> 
> remove_pfn_range_from_zone()
> move_pfn_range_to_zone()
> 
> both of them handling {zone,node}->spanned_pages
> 
> Then we take it in {offline,online}_pages() for {zone,node}->present_pages.
> 
> The other places where we take it are __init functions, so not of interest.
> 
> Given that {offline,online}_pages() is serialized by the memory_hotplug lock,
> I would say that {node,zone}->{spanned,present}_pages is, at any time, stable?
> So, no need for the lock even without considering this patch?
> 
> Now, getting back to this patch.
> adjust_present_page_count() will be called from memory_block_online(), which
> is not holding the memory_hotplug lock yet.
> But, we only fiddle with present pages out of {online,offline}_pages() if
> we have vmemmap pages, and since that operates on the same memory block,
> its lock should serialize that.
> 
> I think I went down a rabbit hole, I am slightly confused now.

We always hold the device hotplug lock when onlining/offlining memory.

I agree that the lock might be unnecessary (had the same thoughts a 
while ago), we can look into that in the future.

-- 
Thanks,

David / dhildenb

