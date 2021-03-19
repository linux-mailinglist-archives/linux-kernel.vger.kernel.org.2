Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA34341BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhCSME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616155499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6CCPDgcLcbLhDwCP+gFTh4MdVQoXL38fJm2umFnFB0=;
        b=QeOEq4GnpkururfJHVqxQxNL/U3yjv62RMiwOUNRFR6rOMyY3TKCkjk2d5wvCvbGrvExX5
        IG/JpooqyENmKITbFHppYbs6tsZXPhLllTCr7LEzaT+97n9gTVm90Vvoz1cC7m1xjt0eKI
        +yzU+EYj6NGrtpgs+WLqv2VVYfk6lHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-RiWssT2kPzSc4w_2wS9oow-1; Fri, 19 Mar 2021 08:04:57 -0400
X-MC-Unique: RiWssT2kPzSc4w_2wS9oow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E961A1084C8C;
        Fri, 19 Mar 2021 12:04:54 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5092B60BF1;
        Fri, 19 Mar 2021 12:04:53 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <c41ea8ac-e99d-6d23-c7b9-5ca25ffb72bb@redhat.com>
 <20210319103120.GB6868@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <19e41d69-0464-64aa-cb1b-e1a51244864b@redhat.com>
Date:   Fri, 19 Mar 2021 13:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319103120.GB6868@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hopefully Andrew can amend these two nits?
> 
>> (another pair of eyes certainly wouldn't hurt :) )
> 
> definitely, but those are pricy as you may know :-D

Even worse, they are even hard to find! :)

-- 
Thanks,

David / dhildenb

