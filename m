Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3033F2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhCQOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231853AbhCQOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615991802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1YSVXIuTP5IDLrl9kvhzbh3ZoDOoFqS9Tf6asQUzWE=;
        b=M50NY5QGXFUOm0bPhLygkmUV26DXcKz3wubMphIx0n9dT1JSDz/tfsY/A8VvpBse9shKJR
        fz8uS2AEN9TBbyYx1lTdCYWw2OUCAI9CPXCC2M66mcOX5Yeu+kpkRQ1uhrCDs7Fuq64Cxa
        w2aBYFwprHQc9fhxqFO2eaNOKdcXWPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-Qjvio2wlPbWv5ytRuI7ptg-1; Wed, 17 Mar 2021 10:36:40 -0400
X-MC-Unique: Qjvio2wlPbWv5ytRuI7ptg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB8F107B7C5;
        Wed, 17 Mar 2021 14:36:38 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C06415C1CF;
        Wed, 17 Mar 2021 14:36:36 +0000 (UTC)
Subject: Re: [PATCH v5 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-6-osalvador@suse.de> <YFISpUUxusP4T1xw@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ef5560a4-8633-39bd-e433-6aa8f6ea4bfc@redhat.com>
Date:   Wed, 17 Mar 2021 15:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFISpUUxusP4T1xw@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 15:31, Michal Hocko wrote:
> On Wed 17-03-21 12:12:51, Oscar Salvador wrote:
>> pfn_range_valid_contig() bails out when it finds an in-use page or a
>> hugetlb page, among other things.
>> We can drop the in-use page check since __alloc_contig_pages can migrate
>> away those pages, and the hugetlb page check can go too since
>> isolate_migratepages_range is now capable of dealing with hugetlb pages.
>> Either way, those checks are racy so let the end function handle it
>> when the time comes.
> 
> I haven't realized PageHuge check is done this early. This means that
> previous patches are not actually active until now which is not really
> greate for bisectability. Can we remove the HugePage check earlier?

alloc_contig_pages() vs. alloc_contig_range(). The patches are active 
for virtio-mem and CMA AFAIKS.

-- 
Thanks,

David / dhildenb

