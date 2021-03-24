Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3834786A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhCXMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhCXMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGTuM/6dwW8oPW7JX32HRs4SmM+PHWXQq1cuJEp3pks=;
        b=T+8DSqA9ZvSD+O+65d2aoAyDf6vRoTMsVg7p+UeHgG+CQrXWhVEv0qsu0886Ol4dh9IAFM
        Sn5nbcL6mQTiXQ4RvUSpDXgDcql+dBb4xVMvRKhdhSidanZQDs+I+RX9GAe2sRf98a4m99
        bq5WZ4FZ8RNqYbk8BZsOykSkKpa81Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-93jokzXmO5KEzIkXUWxVOw-1; Wed, 24 Mar 2021 08:23:59 -0400
X-MC-Unique: 93jokzXmO5KEzIkXUWxVOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527C51005D55;
        Wed, 24 Mar 2021 12:23:58 +0000 (UTC)
Received: from [10.36.115.66] (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 071FC19D80;
        Wed, 24 Mar 2021 12:23:50 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de> <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux> <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFssRr7gZEPfHieA@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c3ff7038-a694-d311-c246-b881a2f55be7@redhat.com>
Date:   Wed, 24 Mar 2021 13:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFssRr7gZEPfHieA@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 13:10, Michal Hocko wrote:
> On Wed 24-03-21 13:03:29, Michal Hocko wrote:
>> On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
> [...]
> 
> an additional remark
> 
>>> - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
>>> - online_pages()->zone->present_pages += nr_pages;
> 
> I am pretty sure you shouldn't account vmmemmap pages to the target zone
> in some cases - e.g. vmemmap cannot be part of the movable zone, can it?
> So this would be yet another special casing. This patch has got it wrong
> unless I have missed some special casing.
> 

It's a bit unfortunate that we have to discuss the very basic design 
decisions again.

@Oscar, maybe you can share the links where we discussed all this and 
add some of it to the patch description.

I think what we have right here is good enough for an initial version, 
from where on we can improve things without having to modify calling code.

-- 
Thanks,

David / dhildenb

