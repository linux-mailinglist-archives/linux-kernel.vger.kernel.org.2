Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FE33AFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCOK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229766AbhCOK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615804144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwF8RAl+1g43eoJOxovVcbsfQd2fGWQqousfI+ksZ8M=;
        b=YmEtO55DZHpkWWJQp0TUIVA7HmH5QX1qigsWEWxtYoC+NZwIxqSvQobVSSNoROpc163S4i
        EF+i5Sljd+RU3dwB+oLHzvELwP1txzGwnTk3MMCHBwHm1Ipj8CF0UIUqJ50jBeKhzBxCZC
        pc6HqEeRzqRSDzqeF6xqTJRYGmh9U+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-q0NtpvIGMNeTAY-3RMkoag-1; Mon, 15 Mar 2021 06:29:02 -0400
X-MC-Unique: q0NtpvIGMNeTAY-3RMkoag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93EA081A281;
        Mon, 15 Mar 2021 10:29:00 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 339991048100;
        Mon, 15 Mar 2021 10:28:57 +0000 (UTC)
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
 <20210315102740.GB25101@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a6b47162-d975-afef-473f-dccb677fefe6@redhat.com>
Date:   Mon, 15 Mar 2021 11:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315102740.GB25101@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.21 11:27, Oscar Salvador wrote:
> On Mon, Mar 15, 2021 at 10:06:40AM +0100, David Hildenbrand wrote:
>>
>> BTW, I stumbled yesterday over
>>
>> alloc_contig_pages()->pfn_range_valid_contig():
>>
>> 	if (page_count(page) > 0)
>> 		rerurn false;
>> 	if (PageHuge(page))
>> 		return false;
>>
>> As used by memtrace and for gigantic pages. We can now
>>
>> a) Drop these check completely, as it's best-effort only and racy.
>> alloc_contig_pages()/alloc_contig_range() will handle it properly.
>>
>> b) Similarly, check for gigantic pages and/or movability/migratability.
>>
>> Dropping both checks might be the right thing to do: might significantly
>> increase allocation chances -- as we actually end up migrating busy pages
>> ...
> 
> Oh, sorry David, my mail client tricked me and I did not see this till now.
> 
> I will have a look, but I would like to collect some more feedback from all
> pieces before going any further and write a new version.
> Vlastimil patch#1 and patch#2 and he was ok with them, but let see what others
> think as well.

Planning on having a detailed look at the patches. Fairly busy though 
... :(

-- 
Thanks,

David / dhildenb

