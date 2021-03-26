Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5C34A839
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhCZNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616765796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3gpFQKgjHtuiCQHwXaw41b8dNjFrCUF0CIAt2id5HA=;
        b=L1Vc8n6r289QDw2icmLAge3iN52iRCkUJ5sjY9zm/LNWgu9H8PnlR+oygndShJPur3Jo9R
        5uIde07v63hy6/V7E/ND4l+WXFFw8Q4/jPnl0xmE5qRNYElly9tFcgoVsApM7LMO3ExUXW
        apqycga87AEDai5iyJOJxtXlr5PjRY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-CdlsreH5O3S6QpBD8krjHg-1; Fri, 26 Mar 2021 09:36:32 -0400
X-MC-Unique: CdlsreH5O3S6QpBD8krjHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D88F180FCA4;
        Fri, 26 Mar 2021 13:36:30 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40B286BC2D;
        Fri, 26 Mar 2021 13:36:28 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz> <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain> <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
 <YF2iBxueewnKIG3V@localhost.localdomain>
 <YF3QcJ2Hd8LNMEgU@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <c11ef594-fe9b-cacf-726f-03f00c62c294@redhat.com>
Date:   Fri, 26 Mar 2021 14:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YF3QcJ2Hd8LNMEgU@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> Further a locking rework might be necessary. We hold the device hotplug
>>> lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
>>> have to move that out online_pages.
> 
> That is a good point.
> I yet have to think about it further, but what about moving those
> mem_hotplug_{begin,done} to memory_block_{offline,online}.
> 
> Something like:
> 
>   static int memory_block_online(...)
>   {
>           int ret;
>   
>           mem_hotplug_begin();
>   
>           if (nr_vmemmap_pages)
>                   vmemmap_hotplug_init();
>   
>           ret = online_pages(...);
>           if (ret)
>   	/*
>   	 * Cleanup stuff
>   	 */
>   
>           mem_hotplug_done();
>   }
> 	
> As you said, you finished cleaning up those users who were calling
> {online,offline}_pages() directly, but is this something that we will
> forbidden in the future too?

Well, I cannot tell what will happen in the future. But at least as long 
as we have memory blocks, I doubt that there are valid use cases for 
online_pages()/offline_pages(). Especially once we have things like 
memmap_on_memory that need special care.

> My question falls within "Are we sure we will not need that locking back
> in those functions because that is something we will not allow to
> happen?"

Who has access to online_pages()/offline_pages() also has access to 
mem_hotplug_begin()/mem_hotplug_done(). It would be nice if we could 
only use online_pages()/offline_pages() internally -- or at least add a 
comment that this is for internal purposes only / requires that locking.

-- 
Thanks,

David / dhildenb

