Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D778835974C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhDIILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhDIILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617955868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDb25HnzFYZMsv90ZIL4i1OMSodG24vPFDy2iRMOYvM=;
        b=Bjo0hNTsDTXyFj8n0ztMl8CFE09U9D10xNDscRdPI/lBabOJBJL2kZroFs6WQQkIS9bVjn
        AnwD0iVnpoaOH5O9ExNkfbUAK+6Hc2YODhyzJpBlYXllHG+qTHeRM2rLagNdTg9muoawQM
        Yiyy2+DcQe52OjvrFIlTy/kTUjutp+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-PUBtIAL0OEeItYB_-iHA1w-1; Fri, 09 Apr 2021 04:11:05 -0400
X-MC-Unique: PUBtIAL0OEeItYB_-iHA1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF7C189C440;
        Fri,  9 Apr 2021 08:11:04 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE75D5D9C0;
        Fri,  9 Apr 2021 08:11:00 +0000 (UTC)
Subject: Re: [PATCH v6 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-5-osalvador@suse.de>
 <YGzEe1XH0kGgwsxp@localhost.localdomain>
 <89dcbcd749f1993303749f2c46220144@suse.de>
 <20210408220518.ea64131255e1b5732a05e57a@linux-foundation.org>
 <YG/h0v2Kqd+xdlz3@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c567f1c3-f9f6-cd16-f013-23faac33dcd1@redhat.com>
Date:   Fri, 9 Apr 2021 10:10:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG/h0v2Kqd+xdlz3@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.21 07:10, Oscar Salvador wrote:
> On Thu, Apr 08, 2021 at 10:05:18PM -0700, Andrew Morton wrote:
>> Yes please.
> 
> I just sent v7 with that yesterday [1]
> 
> Hope David/Michal finds some time to review patch#4 as that is the only
> missing piece atm.

I will have a look next week. Still have to wrap my head around the 
present_pages stuff and if that couldn't be handled in a cleaner way.

-- 
Thanks,

David / dhildenb

