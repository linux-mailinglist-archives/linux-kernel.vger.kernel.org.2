Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538BF34E418
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhC3JOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhC3JNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617095622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb1xwTXO+Z1eRBnmRJEtGYdnn0qi6F4dPoEkpoQRveo=;
        b=VFqJRJItgHdLxQEoYaagKJ4+dtSKq8JE9OH+A6WEIZofNh7xwmpeM5pCK9FSPwJbAqX3KY
        iwPLm7IMNDpdHoyZWcJcp2j8/uN7VtHjl9Jn3npo9jStbx7zG5AWcOH4HRnqIWK5U5jOJk
        je/Nva0BWAFV7M2+8dsCX75ix55/qXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-JcCj9s0CM46WVe9KeVsZuQ-1; Tue, 30 Mar 2021 05:13:38 -0400
X-MC-Unique: JcCj9s0CM46WVe9KeVsZuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42BFF1009458;
        Tue, 30 Mar 2021 09:13:36 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 953E66F978;
        Tue, 30 Mar 2021 09:13:33 +0000 (UTC)
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, linux-mm@kvack.org
References: <20210326012035.3853-1-apopple@nvidia.com>
 <9eef1283-28a3-845e-0e3e-80b763c9ec59@redhat.com>
 <3158185.bARUjMUeyn@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
Message-ID: <e910441c-73a7-b57e-1330-ead65c4ff412@redhat.com>
Date:   Tue, 30 Mar 2021 11:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3158185.bARUjMUeyn@nvdebian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.21 03:37, Alistair Popple wrote:
> On Friday, 26 March 2021 7:57:51 PM AEDT David Hildenbrand wrote:
>> On 26.03.21 02:20, Alistair Popple wrote:
>>> request_free_mem_region() is used to find an empty range of physical
>>> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
>>> over the range of possible addresses using region_intersects() to see if
>>> the range is free.
>>
>> Just a high-level question: how does this iteract with memory
>> hot(un)plug? IOW, how defines and manages the "range of possible
>> addresses" ?
> 
> Both the driver and the maximum physical address bits available define the
> range of possible addresses for device private memory. From
> __request_free_mem_region():
> 
> end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
> addr = end - size + 1UL;
> 
> There is no lower address range bound here so it is effectively zero. The code
> will try to allocate the highest possible physical address first and continue
> searching down for a free block. Does that answer your question?

Oh, sorry, the fist time I had a look I got it wrong - I thought (1UL << 
MAX_PHYSMEM_BITS) would be the lower address limit. That looks indeed 
problematic to me.

You might end up reserving an iomem region that could be used e.g., by 
memory hotplug code later. If someone plugs a DIMM or adds memory via 
different approaches (virtio-mem), memory hotplug (via add_memory()) 
would fail.

You never should be touching physical memory area reserved for memory 
hotplug, i.e., via SRAT.

What is the expectation here?

-- 
Thanks,

David / dhildenb

