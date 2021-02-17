Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABCC31DAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhBQNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233086AbhBQNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613569013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsqsRzQuTI8SkrwnCgergr3XDM20I5ZCGaVDpJ6qkLQ=;
        b=DHMZ9vOOE767K1llZfKheP0a58fd+RV/6UbUWaYlRONJcIwYq3hp3Dmn1AIJL1bbWSNKn4
        p2gROdwaWr6my79KDUTNpXriag2ENK5a4ljz53T4cUJcYaL5GpaWrVRNRC0uMgIJFh0vVu
        pjf7Xo/pZe+zyqBNtdwR5Pt7+t9D6dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-ir5Es5WXMeivnoXWKTPXaQ-1; Wed, 17 Feb 2021 08:36:52 -0500
X-MC-Unique: ir5Es5WXMeivnoXWKTPXaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 577F980196C;
        Wed, 17 Feb 2021 13:36:50 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 539DD5C255;
        Wed, 17 Feb 2021 13:36:48 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de> <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
Date:   Wed, 17 Feb 2021 14:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 14:30, Michal Hocko wrote:
> On Wed 17-02-21 11:08:15, Oscar Salvador wrote:
>> Free hugetlb pages are tricky to handle so as to no userspace application
>> notices disruption, we need to replace the current free hugepage with
>> a new one.
>>
>> In order to do that, a new function called alloc_and_dissolve_huge_page
>> is introduced.
>> This function will first try to get a new fresh hugetlb page, and if it
>> succeeds, it will dissolve the old one.
>>
>> With regard to the allocation, since we do not know whether the old page
>> was allocated on a specific node on request, the node the old page belongs
>> to will be tried first, and then we will fallback to all nodes containing
>> memory (N_MEMORY).
> 
> I do not think fallback to a different zone is ok. If yes then this
> really requires a very good reasoning. alloc_contig_range is an
> optimistic allocation interface at best and it shouldn't break carefully
> node aware preallocation done by administrator.

What does memory offlining do when migrating in-use hugetlbfs pages? 
Does it always keep the node?

I think keeping the node is the easiest/simplest approach for now.

> 
>> Note that gigantic hugetlb pages are fenced off since there is a cyclic
>> dependency between them and alloc_contig_range.
> 
> Why do we need/want to do all this in the first place?

cma and virtio-mem (especially on ZONE_MOVABLE) really want to handle 
hugetlbfs pages.

-- 
Thanks,

David / dhildenb

