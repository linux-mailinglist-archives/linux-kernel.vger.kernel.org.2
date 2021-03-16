Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB833D051
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhCPJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbhCPJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615885699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idVxam08guerYh+UThY49AnOxjbt8HD2ng1AgsclHwY=;
        b=CTxtvsAOm+Aqn8zO1ftigNlJdA960cgB6PUZu6SKwmKn9G5s0fYt6HrFfkHbBy/G9Y8SUZ
        eOCnQT0FtttCr55xrZ+5n9cX7HX3zU3cJ87l+mPFrpykRo4Y3PwZuzqHKoyYCna8ol05YE
        v8G5gVh3G30QqtKgCpZ2KzITa1Gq48Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-GmrAuuLsOJOt73oh5waFgw-1; Tue, 16 Mar 2021 05:08:16 -0400
X-MC-Unique: GmrAuuLsOJOt73oh5waFgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30D2A1084D68;
        Tue, 16 Mar 2021 09:08:14 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E34D21F453;
        Tue, 16 Mar 2021 09:08:11 +0000 (UTC)
To:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
 <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
Date:   Tue, 16 Mar 2021 10:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 09:58, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi David,
> 
> root@scbu-Chachani:~# cat /proc/mtrr
> reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
> reg01: base=0x0ffe00000 ( 4094MB), size=    2MB, count=1: write-protect
> reg02: base=0x100000000 ( 4096MB), size=   16MB, count=1: write-protect

^ there it is

https://wiki.osdev.org/MTRR

"Reads allocate cache lines on a cache miss. All writes update main memory.

Cache lines are not allocated on a write miss. Write hits invalidate the 
cache line and update main memory. "

AFAIU, writes completely bypass caches and store directly to main 
mamory. If there are cache lines from a previous read, they are 
invalidated. So I think especially slow will be read(addr), write(addr), 
read(addr), ... which is what we have in the kstream benchmark.


The question is:

who sets this up without owning the memory?
Is the memory actually special/slow or is that setting wrong?
Buggy firmware/BIOS?
Buggy device driver?


> reg03: base=0x0ffde0000 ( 4093MB), size=  128KB, count=1: write-protect
> reg04: base=0x0ff000000 ( 4080MB), size=  512KB, count=1: write-protect


-- 
Thanks,

David / dhildenb

