Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD27B3E95C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhHKQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhHKQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628698635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbPmmnKi/MdclSZPycD32Y/2euWfOzjLukbxHGukuxM=;
        b=AZIi290UCsnJ/NyhCT71Hj/9CPOU/i/yDquSuGAGa6xV2oVEe+zOlvj9Y5pxJtWCQ4GBEy
        /odW1CcUBSSoAUlHJQd0n9teC5NQHWMGLJfZ1LCIMzVL5c1o4GEV5EG+X/MLm9qZEGE4fi
        H/rbuNQ69Ny6AA/xLLn1oTBoliVbPBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-N4AmAJ-cNbmUjJYwI5wFZg-1; Wed, 11 Aug 2021 12:17:14 -0400
X-MC-Unique: N4AmAJ-cNbmUjJYwI5wFZg-1
Received: by mail-wr1-f71.google.com with SMTP id n6-20020a5d67c60000b0290153b1422916so929754wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KbPmmnKi/MdclSZPycD32Y/2euWfOzjLukbxHGukuxM=;
        b=QQzozpUB1qQzw3Um+GQi8SwDkFViwKgIUusp7AnBTEjoE7qOAATHnQbOrp4ulPOmQ8
         PpwjDlE6/vUV3x9CNvJVnuxPq+VKJjc2oyM7DvUTZxsk3Zuig5ad2a1PNfzPdZfpX6vX
         LFoh+5mDYExj0OdxkrB4xsOUNKUadc73cC9lHIrasfaZ3qD/IYCaBOw0FoKLtw7e9Zmh
         xDfeZ0aoUL9qudbcLsr+Z6r6XBBPd78kTCXYdiOftOEbRV0hFJhed86NY+GuFUgqZ/xL
         D2tB/K/NskruO9unzagUuZHZkMg16z96eylCPwjaNhdkCPVePBZRrpQ0c+qNuf7KkhND
         /qwQ==
X-Gm-Message-State: AOAM5317xN4D7QHfe6a5ddYdn6d4IIbIG3aKl6kl14IJgaOIvPLSFQuc
        vQYYoArCmkdlGCjWhhHLjQABEJtd6wb4mSHYJ0Ui0bGnvahBmgDs5uigRh2M60PZJ7J1YKuLHtz
        yNTTk6aRA2TpdUiDxch9HY5by
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr9155686wmd.160.1628698632947;
        Wed, 11 Aug 2021 09:17:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza0e8GuoOdy4XqhKEXnglKaZzx0VUKls9M0hy/X//jR9bKk6lYivtGRFB5xhYG0ciLOU11Hg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr9155655wmd.160.1628698632694;
        Wed, 11 Aug 2021 09:17:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id t16sm27629034wmi.13.2021.08.11.09.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 09:17:12 -0700 (PDT)
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
From:   David Hildenbrand <david@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s> <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
 <YQrn33pOlpdl662i@t490s> <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
Organization: Red Hat
Message-ID: <32fd63ef-3a8f-a037-28dc-a63dc11087a3@redhat.com>
Date:   Wed, 11 Aug 2021 18:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 18:15, David Hildenbrand wrote:
> On 04.08.21 21:17, Peter Xu wrote:
>> On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
>>> TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
>>> any state information regarding shared memory in per-process page tables: it
>>> just doesn't make too much sense.
>>>
>>> And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
>>> belongs to the shared file ("did *someone* write to this page", "is
>>> *someone* interested into changes to that page", "is there something"). I
>>> know, that screams for a completely different design in respect to these
>>> features.
>>>
>>> I guess we start learning the hard way that shared memory is just different
>>> and requires different interfaces than per-process page table interfaces we
>>> have (pagemap, userfaultfd).
>>>
>>> I didn't have time to explore any alternatives yet, but I wonder if tracking
>>> such stuff per an actual fd/memfd and not via process page tables is
>>> actually the right and clean approach. There are certainly many issues to
>>> solve, but conceptually to me it feels more natural to have these shared
>>> memory features not mangled into process page tables.
>>
>> Yes, we can explore all the possibilities, I'm totally fine with it.
>>
>> I just want to say I still don't think when there's page cache then we must put
>> all the page-relevant things into the page cache.
> 
> [sorry for the late reply]
> 
> Right, but for the case of shared, swapped out pages, the information is
> already there, in the page cache :)
> 
>>
>> They're shared by processes, but process can still have its own way to describe
>> the relationship to that page in the cache, to me it's as simple as "we allow
>> process A to write to page cache P", while "we don't allow process B to write
>> to the same page" like the write bit.
> 
> The issue I'm having uffd-wp as it was proposed for shared memory is
> that there is hardly a sane use case where we would *want* it to work
> that way.
> 
> A UFFD-WP flag in a page table for shared memory means "please notify
> once this process modifies the shared memory (via page tables, not via
> any other fd modification)". Do we have an example application where
> these semantics makes sense and don't over-complicate the whole
> approach? I don't know any, thus I'm asking dumb questions :)
> 
> 
> For background snapshots in QEMU the flow would currently be like this,
> assuming all processes have the shared guest memory mapped.
> 
> 1. Background snapshot preparation: QEMU requests all processes
>      to uffd-wp the range
> a) All processes register a uffd handler on guest RAM
> b) All processes fault in all guest memory (essentially populating all
>      memory): with a uffd-WP extensions we might be able to get rid of
>      that, I remember you were working on that.
> c) All processes uffd-WP the range to set the bit in their page table
> 
> 2. Background snapshot runs:
> a) A process either receives a UFFD-WP event and forwards it to QEMU or
>      QEMU polls all other processes for UFFD events.
> b) QEMU writes the to-be-changed page to the migration stream.
> c) QEMU triggers all processes to un-protect the page and wake up any
>      waiters. All processes clear the uffd-WP bit in their page tables.

Oh, and I forgot, whenever we save any page to the migration stream, we 
have to trigger all processes to un-protect.


-- 
Thanks,

David / dhildenb

