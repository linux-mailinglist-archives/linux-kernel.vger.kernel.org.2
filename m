Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0335C5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhDLMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237718AbhDLMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618229525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FRzHQeGmtY+XVUG66yYZyx5FvjaCGGmC0HzyI2rdPI=;
        b=bDWVKZcsde2MBqrwJuFwgyMJmNMUB/SWmYDTmP4dNg6gnxsYusXr3a/FrqIbN2QIER3Nux
        ezqlX5VTB00+4htWPZSF97itE1RajQyEI24w73g2WpPCtPDQBoRJo1+9ye3/+ialUN1H07
        lXVY9e/ANhfYqCBoOdtHRCNO3BEq84c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ca5EtTAQNA2aKMqE9bvH5w-1; Mon, 12 Apr 2021 08:12:03 -0400
X-MC-Unique: ca5EtTAQNA2aKMqE9bvH5w-1
Received: by mail-wr1-f71.google.com with SMTP id n16so514568wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0FRzHQeGmtY+XVUG66yYZyx5FvjaCGGmC0HzyI2rdPI=;
        b=OD1H39m7eYh/9yy5THFiay5vLp9eVwE3ghh2QRIWn0gv2l9JnK52DhNIhxG4nd+S0Y
         bd/TgzaaJo3mcLsfqgebkf85o9Lcz+Fc9mSHzMgvdaouwZe+9Ilx1WMvdCEI+RXg12HI
         9m0/6ufMKTjL4A8NqXte1/Tx1X5aXC7tZ91Cx8nJnHBzZuCGc3/4OtsDr66ygV1hE3qz
         6UXNdYrVa2v4kCcmIBjWRK4hOSMLgW2ubc58q1WoUF9HV3FMSGFQ6R/4UAYUg9pAwxCQ
         ZcwrPNSSilP1FPUAVDZAIMGTSkliGZAVUGvzGgqNI8pnFRvv/nELQHAjQ4UCWfEgBaMz
         grew==
X-Gm-Message-State: AOAM531oqSLUyaZ5O/aNIcx9bJHfGs3bY6ZzF+OCAGZRZHw3amoUPHCm
        e26gKEL+YD8nyxmw2Tv+HVqbMt85f+jS9Mjd9LF0HDH/YTsyUKJsm1rxzDyXvrmckjYTIUYk1De
        vOhigrKm75tmAoeIY8/zvOYbXjnyg7lVu7Ea8rpb88QeE8RqM0Sp9nqQ6nKewNQhaIiCItR58
X-Received: by 2002:a7b:c399:: with SMTP id s25mr13435848wmj.97.1618229522170;
        Mon, 12 Apr 2021 05:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYZAtdTsObf6yw+wYcFlQHOUQ+18hDCXWnhJGBtobevOjPB+PEmrF69HFwFDCNdrLVtjorow==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr13435816wmj.97.1618229521866;
        Mon, 12 Apr 2021 05:12:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id n9sm7053945wmo.27.2021.04.12.05.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:12:01 -0700 (PDT)
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412120842.GY3697@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b2696b77-9fe0-714f-6bdd-efc267974cfa@redhat.com>
Date:   Mon, 12 Apr 2021 14:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412120842.GY3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.21 14:08, Mel Gorman wrote:
> zone_pcp_reset allegedly protects against a race with drain_pages
> using local_irq_save but this is bogus. local_irq_save only operates
> on the local CPU. If memory hotplug is running on CPU A and drain_pages
> is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> offers no protection.
> 
> This patch deletes IRQ disable/enable on the grounds that IRQs protect
> nothing and assumes the existing hotplug paths guarantees the PCP cannot be
> used after zone_pcp_enable(). That should be the case already because all
> the pages have been freed and there is no page to put on the PCP lists.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> Resending for email address correction and adding lists
> 
> Changelog since v1
> o Minimal fix
> 
>   mm/page_alloc.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5e8aedb64b57..9bf0db982f14 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8952,12 +8952,9 @@ void zone_pcp_enable(struct zone *zone)
>   
>   void zone_pcp_reset(struct zone *zone)
>   {
> -	unsigned long flags;
>   	int cpu;
>   	struct per_cpu_pageset *pset;
>   
> -	/* avoid races with drain_pages()  */
> -	local_irq_save(flags);
>   	if (zone->pageset != &boot_pageset) {
>   		for_each_online_cpu(cpu) {
>   			pset = per_cpu_ptr(zone->pageset, cpu);
> @@ -8966,7 +8963,6 @@ void zone_pcp_reset(struct zone *zone)
>   		free_percpu(zone->pageset);
>   		zone->pageset = &boot_pageset;
>   	}
> -	local_irq_restore(flags);
>   }
>   
>   #ifdef CONFIG_MEMORY_HOTREMOVE
> 

This was originally introduced by 340175b7d14d ("mm/hotplug: free 
zone->pageset when a zone becomes empty").

I wonder why it was ever added. Could it be that drain_pages() could 
have been called from an interrupt handler (e.g., on concurrent CPU 
hotunplug of the current CPU?) back then while we are just about to 
remove it ourselves?

Anyhow, if we need some protection after setting the zone unpopulated 
(setting present_pages = 0), it doesn't seem like disabling local IRQs 
is the right thing to do.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

