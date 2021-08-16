Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC63ED3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhHPMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhHPMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629116446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/l26ZOlW3xGU7zJl7RKCGpKoJ9rKEPFiPOxBz7+D6xk=;
        b=KMFX3Frb62PHIOS1bSGAXER/5KkHoPZGYYD0Oa5P/uaqvb4sY3+oV2lb9QoiXt+ZHQBdcT
        QHV+OgxTqSi5QkG5z51BnS5fxtqhkKFRCost4L5v6FTe6lKkNjvBWlBpQFmZYywz7wSez8
        NBS6kzxHz1bDraDMinoTh2SsXx/SOCk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Qk4Ae5PoPAm7yKbHXXwEYA-1; Mon, 16 Aug 2021 08:20:45 -0400
X-MC-Unique: Qk4Ae5PoPAm7yKbHXXwEYA-1
Received: by mail-wr1-f72.google.com with SMTP id m2-20020a0560000082b0290154f6e2e51fso5435552wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/l26ZOlW3xGU7zJl7RKCGpKoJ9rKEPFiPOxBz7+D6xk=;
        b=c5ouROWpLZ/D3LZDWH8Fyl+astIXFtP3YZCGDnv+kHVwzRMg8LbGATNgi4jDnz0ceE
         psyNMp9R3XjJ/A0z0WJIXfNPbrYIxTmx0d52NlKJdNA+jDcLMxZtmhI93Ww9Dz4qRenc
         AVcmwKygje83+IhFHPlnRLlRZl5Qiy+0LT4+7iqg/oGc0LKMthgNZzpNLNo4+vlbP8Si
         cMxpP8v4zBmtwQ+WHKMJ9x+xtYAONZWET9Bnp0i6nfEhUK8pXTkKmsNwpZ8Tus42o2dM
         fiYRG+OKY1TRzpeyP06kx/xSfQ5XzUDA0D49cKhMo/WoS1qMI4exLtq3ySb623f6IDCT
         Peqg==
X-Gm-Message-State: AOAM5309/S8aMJFfdJTldMjMKw7hJaZNLUsPUTkx0uydH3P9he1J/FqF
        Q3xqdzX0l93qLAKfN4CCSeK7pbSAxVv2F1etejYRFebfYIpFP3ZmwaQPxkjXNMKr9xEgFZC/USE
        F3gMV5/6rdgMK3PGc6D7X8myc
X-Received: by 2002:a5d:4983:: with SMTP id r3mr17992477wrq.232.1629116444377;
        Mon, 16 Aug 2021 05:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/A82vJRDUN2J0t1gWu8dYooJs99PDmbnNeV4RnsWYfwphmQuGFBHHk8sglXZmPztjmylbfw==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr17992467wrq.232.1629116444210;
        Mon, 16 Aug 2021 05:20:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id g12sm7293158wru.85.2021.08.16.05.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:20:43 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
Date:   Mon, 16 Aug 2021 14:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRpVHnr55LpQQvTb@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 14:07, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
>>> Mappings within this address range behave as if they were shared
>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>> page which is shared between all the sharers. The first process that
>>> declares an address range mshare'd can continue to map objects in the
>>> shared area. All other processes that want mshare'd access to this
>>> memory area can do so by calling mshare(). After this call, the
>>> address range given by mshare becomes a shared range in its address
>>> space. Anonymous mappings will be shared and not COWed.
>>
>> Did I understand correctly that you want to share actual page tables between
>> processes and consequently different MMs? That sounds like a very bad idea.
> 
> That is the entire point.  Consider a machine with 10,000 instances
> of an application running (process model, not thread model).  If each
> application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
> tables per process or 40GB of RAM for the whole machine.

What speaks against 1 GB pages then?

> 
> There's a reason hugetlbfs was enhanced to allow this page table sharing.
> I'm not a fan of the implementation as it gets some locks upside down,
> so this is an attempt to generalise the concept beyond hugetlbfs.

Who do we account the page tables to? What are MADV_DONTNEED semantics? 
Who cleans up the page tables? What happens during munmap? How does the 
rmap even work? How to we actually synchronize page table walkers?

See how hugetlbfs just doesn't raise these problems because we are 
sharing pages and not page tables?

TBH, I quite dislike just thinking about sharing page tables between 
processes.

> 
> Think of it like partial threading.  You get to share some parts, but not
> all, of your address space with your fellow processes.  Obviously you
> don't want to expose this to random other processes, only to other
> instances of yourself being run as the same user.

Sounds like a nice way to over-complicate MM to optimize for some 
special use cases. I know, I'm probably wrong. :)

-- 
Thanks,

David / dhildenb

