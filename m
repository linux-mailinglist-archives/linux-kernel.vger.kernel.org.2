Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF43419D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCSKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhCSKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616149232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8kAG0vAoEScN6HgfByPE/mJNj1/V2eSrzV6xD3nOfw=;
        b=HayC1Ynvxvr/U65x2zTDJA4GxIxfsnuLvd7fEnrwusRYxAfYOp2lOFpwaKEqqoF4tVJnSs
        f7AwbnNkZ9rYspurATiqHTWa/u7PgJVR/krhVNZP9cvkkB635zWS5KmqIPgdgO2Kw/Jq7a
        EdZjjoZo3md6NpwUoc0uxjMOYe/QFIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-Vi3UI16ZOkCtDWnXKUGS4w-1; Fri, 19 Mar 2021 06:20:23 -0400
X-MC-Unique: Vi3UI16ZOkCtDWnXKUGS4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BBA0108BD15;
        Fri, 19 Mar 2021 10:20:22 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87BCA5D9C6;
        Fri, 19 Mar 2021 10:20:20 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c41ea8ac-e99d-6d23-c7b9-5ca25ffb72bb@redhat.com>
Date:   Fri, 19 Mar 2021 11:20:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319092635.6214-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tow NITs

> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
> +	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> +	unsigned long remaining_size = size - vmemmap_size;
> +
> +	/*
> +	 * Besides having arch support and the feature enabled at runtime, we
> +	 * need a few more assumptions to hold true:
> +	 *
> +	 * a) We span a single memory block: memory onlining/offlinin;g happens

s/offlinin;g/offlining;/

> +	 *    in memory block granularity. We don't want the vmemmap of online
> +	 *    memory blocks to reside on offline memory blocks. In the future,
> +	 *    we might want to support variable-sized memory blocks to make the
> +	 *    feature more versatile.
> +	 *
> +	 * b) The vmemmap pages span complete PMDs: We don't want vmemmap code
> +	 *    to populate memory from the altmap for unrelated parts (i.e.,
> +	 *    other memory blocks)
> +	 *
> +	 * c) The vmemmap pages (and thereby the pages that will be exposed to
> +	 *    the buddy) have to cover full pageblocks: memory onlining/offlining
> +	 *    code requires applicable ranges to be page-aligned, for example, to
> +	 *    set the migratetypes properly.
> +	 *
> +	 * TODO: Although we have a check here to make sure that vmemmap pages
> +	 *	 fully populate a PMD, it is not the right place to check for
> +	 *	 this. A much better solution involves improving vmemmap code
> +	 *	 to fallback to base pages when trying to populate vmemmap using
> +	 *	 altmap as an alternative source of memory, and we do not exactly
> +	 *	 populate a single PMD.
> +	 */
> +	return memmap_on_memory &&
> +	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> +	       size == memory_block_size_bytes() &&
> +	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> +	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));

IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);

LGTM, thanks!

(another pair of eyes certainly wouldn't hurt :) )

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

