Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A809335A6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhDITFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234692AbhDITFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617995139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MD6fT2WmgURb9WkY36QJuynGDfPwVK4tcjKqqbkDs38=;
        b=YjWRvIITd4wtpba6j20YUet2BcP5nq+eQEsNGmL0p9gXsFtRck6LO/hfyDJz13iZA4XVAg
        53sLRa3DY901zQD5NXKDWwQ4CKEUuZCuax8np3D+wfHHQc/Qdhj/kXLAT9LgtdtACL9Z6V
        vuFZ0ZlFfIthxlq5KG3JVWt6OqjbDSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-0Ff2iCCONNi1oMX_ByaBPQ-1; Fri, 09 Apr 2021 15:05:35 -0400
X-MC-Unique: 0Ff2iCCONNi1oMX_ByaBPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EEF6801814;
        Fri,  9 Apr 2021 19:05:34 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2D32C01F;
        Fri,  9 Apr 2021 19:05:26 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: Make unpopulated zones PCP structures
 unreachable during hot remove
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
References: <20210409120957.GM3697@techsingularity.net>
 <YHBL0e8s+EesIyDl@dhcp22.suse.cz> <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
 <20210409134221.GO3697@techsingularity.net> <YHBmxwH41WEHuVJj@dhcp22.suse.cz>
 <20210409151259.GP3697@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9317b74e-f706-27eb-6e5c-3dc0f3ee98b8@redhat.com>
Date:   Fri, 9 Apr 2021 21:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409151259.GP3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> zone_pcp_reset still needs to exist to drain the remaining vmstats or
>>> it'll break 5a883813845a ("memory-hotplug: fix zone stat
>>> mismatch").
>>
>> Are you sure we are reseting vmstats in the hotremove. I do not see
>> anything like that. Maybe this was needed at the time. I will double
>> check.
> 
> zone_pcp_reset calls drain_zonestat to apply the per-cpu vmstat deltas
> to the atomic per-zone and global stats.
> 
> If anything, the minimal "fix" is to simply delete IRQ disable/enable on
> the grounds that IRQs protect nothing and assume the existing hotplug
> paths guarantees the PCP cannot be used after zone_pcp_enable(). That

^ that sounds sane to me

> should be the case already because all the pages have been freed and
> there is nothing to even put into the PCPs but I worried that the PCP
> structure itself might still be reachable even if it's useless which is
> why I freed the structure once they could not be reached via zonelists.
> 


-- 
Thanks,

David / dhildenb

