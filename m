Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C665F340525
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCRMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhCRMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616069148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xveODCKicquk1mCJcnO2rTTzMf/rWshKRdhXeN4fxg=;
        b=hIOLXdeUJe/6HwxqQ7K+jEDDMsG0PyYSywAocuOq9H+dgabXxTJ5tourKMJ6myNW+C5Zg5
        ISkdefFxqHdCTdwTPunvq5A0XBZK3o2vAgcleLyRRbeiVi+L+9OtBJ0B7LXPlkGiwfjNda
        3fgrLmLLNT6spX7i+TAPcy+LX6YtJ1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-OsMGj_RlPkGMJNRT4kHWKA-1; Thu, 18 Mar 2021 08:05:46 -0400
X-MC-Unique: OsMGj_RlPkGMJNRT4kHWKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA7D107B7C3;
        Thu, 18 Mar 2021 12:05:44 +0000 (UTC)
Received: from [10.36.113.61] (ovpn-113-61.ams2.redhat.com [10.36.113.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1A0B10016FC;
        Thu, 18 Mar 2021 12:05:40 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
 <20210317140847.GA20407@linux>
 <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
 <YFMPBFSJPq2VEOk9@localhost.localdomain>
 <YFMtuKZ8Ho66D8hN@localhost.localdomain>
 <51c645b3-1220-80c4-e44c-4c0411222148@redhat.com>
 <YFNBrzNFpyKLORfe@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d1c59c27-6ca7-01df-8134-c896bbe7af85@redhat.com>
Date:   Thu, 18 Mar 2021 13:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFNBrzNFpyKLORfe@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.21 13:03, Oscar Salvador wrote:
> On Thu, Mar 18, 2021 at 12:24:16PM +0100, David Hildenbrand wrote:
>> I don't follow. 2MB == 2MB. And if there would be difference then we would
>> be in the problem I brought up: vmemmap code allocating too much via the
>> altmap, which can be very bad because might be populating more vmemmap than
>> we actually need.
> 
> Yes, I meant to say nr_vmemmap_pages won't match, or IOW, won't have the
> same meaning.
> The end result is the same.
> 
>> vmemmap_size = 512 * 4KiB = 2 MiB.
>>
>> That calculation wasn't very useful (/ PAGE_SIZE * PAGE_SIZE)?
> 
> Yeah, somewhat redundant.
> 
>>
>>>           unsigned long remaining_size = size - vmemmap_size;
>>
>> And here we could get something like
>>
>> remaining_size = 2 GiB - 2 MiB
> 
> Yes, vmemmap_size would need to scale with nr_sections to be relative to
> size.
> 
> Just wanted to bring it up, because somene might wonder
> "ok, why do we have altmap->nr_pfns = X, and here nr_vmemmap_pages
>   is Y"
> 
> It was an effort to make it consistent, although I see it would bring
> more confusion other than anything, so disregard.

I am also unhappy that we have to replicate the same computation at two 
places, but I don't see an easy way to avoid that ... we have to trust 
on vmemmap code to do the right thing either way :(

-- 
Thanks,

David / dhildenb

