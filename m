Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55048393F66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhE1JKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbhE1JJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622192885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4+d8v/qkCpPOmJXEAWQ9CljZYiiDXo4O63BP6isPck=;
        b=HLMkz+C3AvccMkVUsqkQMcfu7Qri36Dw84kk9vjW88jkTb4cp992Yt2hdcZXT5y9aGtFxI
        0THM5fiBFnLzK6TeQPz5E5BBLdsgjIOqq8xg09lJjGlwNKeyeta2qD6kzUjOul6Bhy3o6o
        4r21XXe5v6sykNI9aMFTFeLY4jxu+00=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-ZVi_zlj9M_ugqqBRiV06lg-1; Fri, 28 May 2021 05:08:03 -0400
X-MC-Unique: ZVi_zlj9M_ugqqBRiV06lg-1
Received: by mail-wr1-f72.google.com with SMTP id z13-20020adfec8d0000b0290114cc6b21c4so377915wrn.22
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t4+d8v/qkCpPOmJXEAWQ9CljZYiiDXo4O63BP6isPck=;
        b=R3Mf6rCKccwGvwseGB3ReGwcQ4/ted2amzYAqWEtt7UUI5jiBLIGdu3p1SJWkjM2ty
         Mi41kY/zSZtypdEIa7z2eHEw9Ogr5BV23GVl6iNZP7vSGweILmm+CG3gdrtwXPjl8e2Y
         xsMwzo/hv/GNW9+GzBdFQ0RH5foOgqw2p+bihfZGRSbFEN/ky+TErsYD41Eq/fQH15Iu
         U0PAedMWaru8aUIXfg9qSMD1ur0SLV2rTN8tXbZx7tPw9YBSODyznoDqHkT4AiVQawj1
         VTWdY1BHdaZ/cEqbCBfKzg/LrcdifPZwot88gNqVCa6STrgd3CgYxS+LQ4RkMyRuIpyl
         rGmQ==
X-Gm-Message-State: AOAM5334F/E8b6kvwWlleH7RC4367ovMk90rDtIek7WpqwgZEAgeVgBd
        Rzq4GpVJA2Be0Y6mAdNwJQIDT11LO2RRcNYU4m/YMMgzfFBSWDQ1JPzWUyq05LqEvlzEjR+ykuO
        fqcrRRpyrY5CHJ4baWOjvCbC3
X-Received: by 2002:a1c:7d13:: with SMTP id y19mr7412756wmc.41.1622192882687;
        Fri, 28 May 2021 02:08:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwStphUgOtrZgsXGu3HMG2jWcUMSuKIuhUwPBTShPcCPhJAw9GQpEe/8M8+3RQysprF6UZVkg==
X-Received: by 2002:a1c:7d13:: with SMTP id y19mr7412742wmc.41.1622192882490;
        Fri, 28 May 2021 02:08:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id c64sm14091213wma.15.2021.05.28.02.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 02:08:02 -0700 (PDT)
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active
 CPUs
From:   David Hildenbrand <david@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Organization: Red Hat
Message-ID: <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
Date:   Fri, 28 May 2021 11:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 11:03, David Hildenbrand wrote:
> On 28.05.21 10:55, Mel Gorman wrote:
>> On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
>>> Hi Mel,
>>>
>>> Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
>>> ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
>>> use" mode and being managed via the buddy just like the normal RAM.
>>>
>>> The PMEM zones are big ones:
>>>
>>>           present  65011712 = 248 G
>>>           high       134595 = 525 M
>>>
>>> The PMEM nodes, of course, don't have any CPUs in them.
>>>
>>> With your series, the pcp->high value per-cpu is 69584 pages or about
>>> 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
>>> worst-case memory in the pcps per zone, or roughly 10% of the size of
>>> the zone.
> 
> When I read about having such big amounts of free memory theoretically
> stuck in PCP lists, I guess we really want to start draining the PCP in
> alloc_contig_range(), just as we do with memory hotunplug when offlining.
> 

Correction: we already drain the pcp, we just don't temporarily disable 
it, so a race as described in offline_pages() could apply:

"Disable pcplists so that page isolation cannot race with freeing
  in a way that pages from isolated pageblock are left on pcplists."

Guess we'd then want to move the draining before 
start_isolate_page_range() in alloc_contig_range().

-- 
Thanks,

David / dhildenb

