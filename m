Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C439031DB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBQOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233319AbhBQOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613570892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8RxsF8J5nDa+mgXtHAOtJY50kcCIvzbpkGeCGDBzqw=;
        b=AKCuvn/0gcVrqQvRMbJ43BAaLhdTwqv73mVLPtmwYPCv4zfJKWOkr2qf9YywumHB850SVd
        B0EUNHlTlVIK3cEsVSuz8Q9LPXm8wocXh6cvGFQOu5fitjiUNwdS+trCsc2voUhha9MjkG
        FOXG5UHf8dL1TuA72gn8tSmWWyBliYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-OmuYUHRBNk-It2J9Wo7O9g-1; Wed, 17 Feb 2021 09:08:08 -0500
X-MC-Unique: OmuYUHRBNk-It2J9Wo7O9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4C46D4F7;
        Wed, 17 Feb 2021 14:08:06 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5911719C46;
        Wed, 17 Feb 2021 14:08:05 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de> <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
 <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
 <YC0fIhEHRDOVzK8U@dhcp22.suse.cz>
 <5f50c810-3f49-a162-6d1d-cf621c515f45@redhat.com>
 <YC0gzBX8ubV6x5NK@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <5d70b340-2db0-ef1f-1564-e5d39354c11c@redhat.com>
Date:   Wed, 17 Feb 2021 15:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC0gzBX8ubV6x5NK@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 14:59, Michal Hocko wrote:
> On Wed 17-02-21 14:53:37, David Hildenbrand wrote:
>> On 17.02.21 14:50, Michal Hocko wrote:
> [...]
>>> Do we have any real life examples? Or does this fall more into, let's
>>> optimize an existing implementation category.
>>>
>>
>> It's a big TODO item I have on my list and I am happy that Oscar is looking
>> into it. So yes, I noticed it while working on virtio-mem. It's real.
> 
> Do not take me wrong, I am not opposing to the functionality. I am
> asking for the specific usecase.

Makes sense, and a proper motivation should be included in the 
patches/cover letter. So here comes a quick-n-dirty example:


Start a VM with 4G. Hotplug 1G via virtio-mem and online it to 
ZONE_MOVABLE. Allocate 512 huge pages.

[root@localhost ~]# cat /proc/meminfo
MemTotal:        5061512 kB
MemFree:         3319396 kB
MemAvailable:    3457144 kB
...
HugePages_Total:     512
HugePages_Free:      512
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB


The huge pages get partially allocate from ZONE_MOVABLE. Try unplugging 
1G via virtio-mem (remember, all ZONE_MOVABLE). Inside the guest:

[  180.058992] alloc_contig_range: [1b8000, 1c0000) PFNs busy
[  180.060531] alloc_contig_range: [1b8000, 1c0000) PFNs busy
[  180.061972] alloc_contig_range: [1b8000, 1c0000) PFNs busy
[  180.063413] alloc_contig_range: [1b8000, 1c0000) PFNs busy
[  180.064838] alloc_contig_range: [1b8000, 1c0000) PFNs busy
[  180.065848] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
[  180.066794] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
[  180.067738] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
[  180.068669] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
[  180.069598] alloc_contig_range: [1bfc00, 1c0000) PFNs busy


I succeed in unplugging 540MB - 484 MB remain blocked by huge pages 
("which did not end up there by pure luck"). These pages are movable 
(and even free!) and can easily be reallocated.

-- 
Thanks,

David / dhildenb

