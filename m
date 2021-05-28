Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFB393EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhE1Ivr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232832AbhE1Ivq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622191811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XZKPsGw6GrAtOCDzNONwgIiPoDYBZOFsZ8oGll8uo0=;
        b=HV7O3cHlKsBws7Qin351b4VDYB6TfM+a3MisL+5iQMT0Z204bpnrTH5UF+LDryboMuUQ1s
        Es1gCE2k5HjwKns+5H7JLgERbAHNazZSMLVdJYN0mprhKPheaXaG5d99eW3NItKhf2OSKa
        Y18D7i50JbWwMZHXhVTzd2N17PY80E4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ZyN5oSMbMB-zHwEd19sPzg-1; Fri, 28 May 2021 04:50:09 -0400
X-MC-Unique: ZyN5oSMbMB-zHwEd19sPzg-1
Received: by mail-wr1-f70.google.com with SMTP id j1-20020adff0010000b0290114b7cf4e83so753017wro.15
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0XZKPsGw6GrAtOCDzNONwgIiPoDYBZOFsZ8oGll8uo0=;
        b=IEYhTrqzdcps5HB2XwbJg4Trr29suKDmg06QvYS59+zbbLWg0VDML0q89OeupnVknD
         oPltb8uRYhN4VuUwVBcja8P1873pCRBfZQOzrqoyQaJz0Y2lbT6EVbGgN6CuJ8kdV+2u
         kx6+F73PgmDyRxt1qk9yEjMy5AletdCB0026g1e2nTJmVXjX9tJTlAAli0U4qDQqvcwO
         af9D6aAhbS5k3ls3u6lcwcI4HUqZdMFCk1j8HwBkI6ymwrbOR+Mnf3W0LobZCCTwbSg7
         NGXasFvW7gj4EMbsMB0s0omJ5u8yv9dIkxh4g0ZkLdCyU0OvL6eXPq8jTctFrhl6GLX2
         QWSg==
X-Gm-Message-State: AOAM532heO52hB5AAGiR9B3qLBO8Sc/+GWVWcD+zR+NvvURLalIffqWy
        eQ0ds9yEEEkKubTPRf48TA2yQ9EXRD/nbIw0ZEn/K7qKeRV57uHfbXt/ToTNf14LpUhhM8YyA0y
        JnfZZKXh+P9jOq6F8qwwsixRiUpL2FhoZXjNltpDeVznez4tkVguKPAyoqTMtwq/rDG/2+Wc/
X-Received: by 2002:a05:6000:1b8f:: with SMTP id r15mr7322023wru.119.1622191808414;
        Fri, 28 May 2021 01:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFZL0q+0JcPk4npjBSe+kUXDGPvMOjcmIpNxnzx2+BmPbZA9u8srUPS5pgO8zRey8hxOQ3dg==
X-Received: by 2002:a05:6000:1b8f:: with SMTP id r15mr7321984wru.119.1622191808061;
        Fri, 28 May 2021 01:50:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id g6sm6119515wmg.10.2021.05.28.01.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 01:50:07 -0700 (PDT)
Subject: Re: [PATCH RFC] mm,memory_hotplug: Drop unneeded locking
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210528075155.358-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b2883fb1-2712-9d65-bb1b-fc009f4bde09@redhat.com>
Date:   Fri, 28 May 2021 10:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528075155.358-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 09:51, Oscar Salvador wrote:
> Currently, memory-hotplug code takes zone's span_writelock
> and pgdat's resize_lock when resizing the node/zone's spanned
> pages via {move_pfn_range_to_zone(),remove_pfn_range_from_zone()}
> and when resizing node and zone's present pages via
> adjust_present_page_count().
> 
> These locks are also taken during the initialization of the system
> at boot time, where it protects parallel struct page initialization,
> but they should not really be needed in memory-hotplug where all
> operations are a) synchronized on device level and b) serialized by
> the mem_hotplug_lock lock.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> During the review of [1], it was brought up that we might need to revisit
> the locking scheme in memory-hotplug code wrt. node and zone locks.
> Given that memory-hotplug is serialized and synchronized by memory-hotplug lock
> and the device, I do not think we need to hold zone/node's resize lock anymore.
> After the system has been brought up, memory-hotplug is the only code allow to
> touch {spanned,present}_pages, so it cannot really go off when serialized by its
> own lock. Or am I missing something?
> The only think I am not really sure is: if the from remove_pfn_range_from_zone,
> shrink_zone_span, update_pgdat_span and move_pfn_range_to_zone can really go
> (because those functions are already serialized by the memory-hotplug lock),
> what about mhp_(de)init_memmap_on_memory that calls those functions?
> Those are not protected by the lock. I have to confess that when it comes to locking
> in this code, I always have to scratch my head.
> 

Whenever onlining/offlining memory blocks we're holding the device 
hotplug lock. So memory hot(un)plug code is completely synchronized.

If necessary at some point, we could pull the memory hotplug lock 
further out. But I doubt it is necessary at this point.

AFAIK, memory hot(un)plug isn't possible while we're still initializing 
the memmap, so this should be fine.


> [1] https://patchwork.kernel.org/project/linux-mm/patch/20210416112411.9826-4-osalvador@suse.de/
> 
>   mm/memory_hotplug.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 075b34803fec..6edd7e267cad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -329,7 +329,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>   	unsigned long pfn;
>   	int nid = zone_to_nid(zone);
>   
> -	zone_span_writelock(zone);
>   	if (zone->zone_start_pfn == start_pfn) {
>   		/*
>   		 * If the section is smallest section in the zone, it need
> @@ -362,7 +361,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>   			zone->spanned_pages = 0;
>   		}
>   	}
> -	zone_span_writeunlock(zone);
>   }
>   
>   static void update_pgdat_span(struct pglist_data *pgdat)
> @@ -424,10 +422,8 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
>   
>   	clear_zone_contiguous(zone);
>   
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
>   	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
>   	update_pgdat_span(pgdat);
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>   
>   	set_zone_contiguous(zone);
>   }
> @@ -639,14 +635,10 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>   	clear_zone_contiguous(zone);
>   
>   	/* TODO Huh pgdat is irqsave while zone is not. It used to be like that before */

I think you can drop this comment now as well.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

