Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2973ED966
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhHPPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232467AbhHPPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629126108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVtrxiWdB8p21eCaSQrl/t87lJASYUwCcn6GOLpI4Do=;
        b=RihADVzFD1yNktFuyIH/t5gOys/CZwJibM8i+4STceMlrbxo+Nh0iukrXb4t40xESHdHeF
        Kk8oWSN/oOI0BpIcL6qYn5bqc+3H2NcF+luSEmzPWO4Wrf8Zn6ivhcvtRh01PSCAUmSyUc
        DXs8P7jcZSRUvopp7yNRCxKPgNaale8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-XmVHXO7fNd-na5CVeNE8fw-1; Mon, 16 Aug 2021 11:01:46 -0400
X-MC-Unique: XmVHXO7fNd-na5CVeNE8fw-1
Received: by mail-wr1-f70.google.com with SMTP id z10-20020a5d440a0000b0290154e0f00348so5604267wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JVtrxiWdB8p21eCaSQrl/t87lJASYUwCcn6GOLpI4Do=;
        b=ES/VadXQGsMFxbZWLYbHsPO1Dd8fcHcxJequ+5zZuHFseTdXCu8ArsXq5VqvgZqDkt
         Q2Sd2iL/K5o7lPCVoZp26ePSAummQgVOn95LAHvM5d0DI02BeWVsvJ2uFfNCXY99eou+
         oQB2ioj+SOJfrVnZIjuRDPYF3Zix4PR6SW7OwbVFAEMnoaPCBDEdSHuUp0MMsQDUZqCb
         3Blbvy7T6LX5pK+RLu0uEOVRJkRAaE3bSrFg3yAAWMy28QzpxeR0KmUg0x9lTJSNOtuM
         4BxrsMO3893yF2Z2pxazKO3QcCXj0ufHK9o1AFjO8OpsGtXBvOF4jU+93MYK++St7yIa
         bG5g==
X-Gm-Message-State: AOAM530NUU8V6gQSRjNKoD2y43kB5U0SR9WZLvGvt23wB5aK2GC7QbpY
        5L9L9eqvjegZZHQZEgHHx96dHkwsyR8rHjFGyEWGt8dpDO23JT7xNJI3pr35IuYZTIo+m5x4R8Q
        sT58O04QwMkZjaDfuOxIM18QG
X-Received: by 2002:a5d:674b:: with SMTP id l11mr17877163wrw.357.1629126105494;
        Mon, 16 Aug 2021 08:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdm7Cf1rb8lSN5vx8LmqxghsO7Jg0YPB5e1ppQkH+miodzACZ8lDSAFJcWjkLfzHMpaKlLRA==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr17877144wrw.357.1629126105297;
        Mon, 16 Aug 2021 08:01:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id e3sm12620176wrv.65.2021.08.16.08.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:01:44 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
 <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
 <YRp4+EmohNoxzv2x@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <e6a31927-8f93-22af-2d5a-9d80578e9317@redhat.com>
Date:   Mon, 16 Aug 2021 17:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRp4+EmohNoxzv2x@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 16:40, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 04:33:09PM +0200, David Hildenbrand wrote:
>>>> I did not follow why we have to play games with MAP_PRIVATE, and having
>>>> private anonymous pages shared between processes that don't COW, introducing
>>>> new syscalls etc.
>>>
>>> It's not about SHMEM, it's about file-backed pages on regular
>>> filesystems.  I don't want to have XFS, ext4 and btrfs all with their
>>> own implementations of ARCH_WANT_HUGE_PMD_SHARE.
>>
>> Let me ask this way: why do we have to play such games with MAP_PRIVATE?
> 
> Are you referring to this?

Yes

> 
> : Mappings within this address range behave as if they were shared
> : between threads, so a write to a MAP_PRIVATE mapping will create a
> : page which is shared between all the sharers.
> 
> If so, that's a misunderstanding, because there are no games being played.
> What Khalid's saying there is that because the page tables are already
> shared for that range of address space, the COW of a MAP_PRIVATE will
> create a new page, but that page will be shared between all the sharers.
> The second write to a MAP_PRIVATE page (by any of the sharers) will not
> create a COW situation.  Just like if all the sharers were threads of
> the same process.
> 

It actually seems to be just like I understood it. We'll have multiple 
processes share anonymous pages writable, even though they are not using 
shared memory.

IMHO, sharing page tables to optimize for something kernel-internal 
(page table consumption) should be completely transparent to user space. 
Just like ARCH_WANT_HUGE_PMD_SHARE currently is unless I am missing 
something important.

The VM_MAYSHARE check in want_pmd_share()->vma_shareable() makes me 
assume that we really only optimize for MAP_SHARED right now, never for 
MAP_PRIVATE.

-- 
Thanks,

David / dhildenb

