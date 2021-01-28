Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F269307921
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhA1PH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231793AbhA1PEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611846201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChbOkEgbATFM37SwTaCF7y0/gcttE6lmGqqCimF4GA8=;
        b=NakydoJ9h1ceN5CE7BYMNXJyGgNZ2zTJUZU2q07QU+GQYwZH6geO6/Dl5MOOlUdcjXbzQ/
        wAkz3zxVpyu5VfbsFrw8xBRGr/IdxqadoSIcgxNJemO4wTMY4Q2kTKhn6HGKx7NvYYUnLW
        PHaIwAerF7vdWJFev7rQtzelOf7i52c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-h47oyd7PPFO5_XSp3oVzYw-1; Thu, 28 Jan 2021 10:03:16 -0500
X-MC-Unique: h47oyd7PPFO5_XSp3oVzYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21BC210052FE;
        Thu, 28 Jan 2021 15:03:13 +0000 (UTC)
Received: from [10.36.113.207] (ovpn-113-207.ams2.redhat.com [10.36.113.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1845D720;
        Thu, 28 Jan 2021 15:03:08 +0000 (UTC)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
 <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com>
 <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: dax alignment problem on arm64 (and other achitectures)
Message-ID: <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com>
Date:   Thu, 28 Jan 2021 16:03:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> One issue usually is that often firmware can allocate from available
>> system RAM and/or modify/initialize it. I assume you're running some
>> custom firmware :)
> 
> We have a special firmware that does not touch the last 2G of physical
> memory for its allocations :)
> 

Fancy :)

[...]

>> Personally, I think the future is 4k, especially for smaller machines.
>> (also, imagine right now how many 512MB THP you can actually use in your
>> 8GB VM ..., simply not suitable for small machines).
> 
> Um, this is not really about 512THP. Yes, this is smaller machine, but
> performance is very important to us. Boot budget for the kernel is
> under half a second. With 64K we save 0.2s  0.35s vs 0.55s. This is
> because fewer struct pages need to be initialized. Also, fewer TLB
> misses, and 3-level page tables add up as performance benefits. >
> For larger servers 64K pages make total sense: Less memory is wasted as metdata.

Yes, indeed, for very large servers it might make sense in that regard. 
However, once we can eventually free vmemmap of hugetlbfs things could 
change; assuming user space will be consuming huge pages (which large 
machines better be doing ... databases, hypervisors ... ).

Also, some hypervisors try allocating the memmap completely ... but I 
consider that rather a special case.

Personally, I consider being able to use THP/huge pages more important 
than having 64k base pages and saving some TLB space there. Also, with 
64k you have other drawbacks: for example, each stack, each TLS for 
threads in applications suddenly consumes 16 times more memory as "minimum".

Optimizing boot time/memmap initialization further is certainly an 
interesting topic.

Anyhow, you know your use case best, just sharing my thoughts :)

[...]

>>>
>>> Right, but I do not think it is possible to do for dax devices (as of
>>> right now). I assume, it contains information about what kind of
>>> device it is: devdax, fsdax, sector, uuid etc.
>>> See [1] namespaces tabel. It contains summary of pmem devices types,
>>> and which of them have label (all except for raw).
>>
>> Interesting, I wonder if the label is really required to get this
>> special use case running. I mean, all you want is to have dax/kmem
>> expose the whole thing as system RAM. You don't want to lose even 2MB if
>> it's just for the sake of unnecessary metadata - this is not a real
>> device, it's "fake" already.
> 
> Hm, would not it essentially  mean allowing memory hot-plug for raw
> pmem devices? Something like create mmap, and hot-add raw pmem?

Theoretically yes, but I have no idea if that would make sense for real 
"raw pmem" as well. Hope some of the pmem/nvdimm experts can clarify 
what's possible and what's not :)


-- 
Thanks,

David / dhildenb

