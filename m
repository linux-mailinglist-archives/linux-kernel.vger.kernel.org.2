Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E893ED8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhHPOLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhHPOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629123032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtEw9oJqR1u9FpBUyNw8cDLhgtMuacfPHoXopx0aC28=;
        b=F5kCBwf59QL+2byPDE759HtU+VNNSNW+DTiegDpzYDODT44AgaLvlrQUQYu9nfxCua5tXV
        Hh4CpqEDzUjJgNZYwlFh6AskA2bQHNhO1i2PSUBuCE//ts9f4MbyKpL79/+iiE7qNyW06J
        MQQA39v1N32sa3I6AsGP8cfu3g1lCmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-e4rx7R_CMNKKblndqpHROQ-1; Mon, 16 Aug 2021 10:10:31 -0400
X-MC-Unique: e4rx7R_CMNKKblndqpHROQ-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so4175253wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LtEw9oJqR1u9FpBUyNw8cDLhgtMuacfPHoXopx0aC28=;
        b=iG0I4Acj6RBbw71xSYiqucnFG5RkH6Wa0/8qHLaACUE58ZvdSMUGumAcQqtpGZkiX9
         dRds5StHb/LsrK5/EWC59e7OsmvinGXibSMBrmhHQ5lIElCETXB4CQ52YqrmcYRoMg2Q
         l4ImnIoMndpzS0qS/99xNmaqW+gGCxzJaCFmEv/IcDLO2y07sTG8l8SgGKb1UuU2XMT+
         HZ+810QNd7SxjL9fN5t/Tw8jkPryoF58eL8V3BHlVCKocdmAhfewewqJ0zDBXW6qFwMt
         QzsqkqdmN/Hz9FoI2Ww1rh65r+StLOXyFgPe3kB1uDBqxs2fuC3jKZiRjFiGCtlfyxWE
         ix8w==
X-Gm-Message-State: AOAM530gKmHMUFVfovYYSKZ+ArKRWM0GxL1Hg+IqMmJvJKCaJow9iJZb
        X0WQUvcHkwbXTPzYDgXunZ9schhF/OxaobL2+CWNqfLXwiWas9ebR1gtsBKGBdribtXPz5BMV+9
        A0YhheAzXlB+ZNmqPyg0DvXLh
X-Received: by 2002:adf:c549:: with SMTP id s9mr18927911wrf.344.1629123030234;
        Mon, 16 Aug 2021 07:10:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyh478LnIv/W9hNY+Cgrjtfa9Spn+4MIEAiJ4nAUbO5MjC2/AaMd/NhxgBSuBZoZyqMR0e+Q==
X-Received: by 2002:adf:c549:: with SMTP id s9mr18927876wrf.344.1629123030004;
        Mon, 16 Aug 2021 07:10:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id 129sm10573715wmz.26.2021.08.16.07.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 07:10:29 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
Date:   Mon, 16 Aug 2021 16:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRpo4EAJSkY7hI7Q@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
>>> still have customers using that generation of CPUs.  2MB pages perform
>>> better than 1GB pages on the previous generation of hardware, and I
>>> haven't seen numbers for the next generation yet.
>>
>> I read that somewhere else before, yet we have heavy 1 GiB page users,
>> especially in the context of VMs and DPDK.
> 
> I wonder if those users actually benchmarked.  Or whether the memory
> savings worked out so well for them that the loss of TLB performance
> didn't matter.

These applications are extremely performance sensitive (i.e., RT 
workloads), that's why I'm wondering. I recall that they are most 
certainly using more than 4 GiB memory in real applications.

E.g., the doc [1] even has a note that "For 64-bit applications, it is 
recommended to use 1 GB hugepages if the platform supports them."


[1] https://doc.dpdk.org/guides-16.04/linux_gsg/sys_reqs.html

> 
>> So, it only works for hugetlbfs in case uffd is not in place (-> no
>> per-process data in the page table) and we have an actual shared mappings.
>> When unsharing, we zap the PUD entry, which will result in allocating a
>> per-process page table on next fault.
> 
> I think uffd was a huge mistake.  It should have been a filesystem
> instead of a hack on the side of anonymous memory.

Yes it was. Especially, looking at all the special-casing, for example, 
even in mm/pagewalk.c.

> 
>> I will rephrase my previous statement "hugetlbfs just doesn't raise these
>> problems because we are special casing it all over the place already". For
>> example, not allowing to swap such pages. Disallowing MADV_DONTNEED. Special
>> hugetlbfs locking.
> 
> Sure, that's why I want to drag this feature out of "oh this is a
> hugetlb special case" and into "this is something Linux supports".

I would have understood the move to optimize SHMEM internally - similar 
to how we seem to optimize hugetlbfs SHMEM right now internally. 
(although sharing page tables for shmem can still be quite tricky)

I did not follow why we have to play games with MAP_PRIVATE, and having 
private anonymous pages shared between processes that don't COW, 
introducing new syscalls etc.

-- 
Thanks,

David / dhildenb

