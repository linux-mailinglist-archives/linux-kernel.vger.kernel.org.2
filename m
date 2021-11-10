Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228A44BCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhKJIRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhKJIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636532086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRNRQyUTnzlLVnEZtE2AkClya4QUFn8/IlNw/XyFTA0=;
        b=XqOptqSLZ/k6W4kLXIDH6RZKPKVV4P5MT5XLjAS0Ac5W93BF8sQpB+oJMV/DB6a7kRHU04
        +wqJGD+PifEcFEOQLbE7ChAddtIYAA29T3ZgmOpVXlkFmdW5kS9SJ1tReIhb8O9BUFPuvR
        Hu8CtC/asipBzWjNLwqijdjMWEnzvjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-xfgF3Xf3MNqE6bNxSp0I7g-1; Wed, 10 Nov 2021 03:14:45 -0500
X-MC-Unique: xfgF3Xf3MNqE6bNxSp0I7g-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so226557wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VRNRQyUTnzlLVnEZtE2AkClya4QUFn8/IlNw/XyFTA0=;
        b=khnCWANFs9KO+um6HsorkD2S1ivjRrUlI9S6Sg6y02S26gdjSME9YuMYpOf4OgsTRG
         QVOhzc8y90w4AZ++u1i6dAOirDT9Px22xBR1l20W373VeGUZ8+1kLY8r5coneulQaa6j
         RZeStZKUL+DgrBdi9Ph4ySBXpqIIU37NFnYyhnl5mESVOb2z/8JdQOpDppSlIrMivndI
         n7tbUjQT1YY6dCTSF+KOGQw6X7HVaG9NcnzO4Na2lIUrGJAX4UJ9oGIO6m5CKU52P3/i
         bgd4g1WmMuoXDfl6LBTPWZDGPUzRqeZvmMl58PvNLBzx8LYVo4XPtzyvD7PUPNmCbXF5
         TzrA==
X-Gm-Message-State: AOAM531h0mJlR0Rq6dHP8J4eIf0hCGCZ7KAEISw8hQiKmbSMMVfpjdZa
        6kYy3TwTSwRcSuD+guq3xUYtedTOsz6f80aW8I3hpi4MBNDG7wnkLs9+zautHpw68YPdGjtQPTk
        RMJszxyVH//LO3Mu8/gxdQMAb
X-Received: by 2002:a5d:584c:: with SMTP id i12mr17905131wrf.95.1636532084435;
        Wed, 10 Nov 2021 00:14:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4dpF+9h8LV87D9pZFz8cxyVWRVQUWPuD6s1mUnxonVBOGF7DYa06GNXlBIp4oI9oYiNDs+Q==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr17905107wrf.95.1636532084265;
        Wed, 10 Nov 2021 00:14:44 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id z6sm22659735wrm.93.2021.11.10.00.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:14:43 -0800 (PST)
Message-ID: <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
Date:   Wed, 10 Nov 2021 09:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Mina Almasry <almasrymina@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYtuqsnOSxA44AUX@t490s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.21 08:03, Peter Xu wrote:
> Hi, Mina,
> 
> Sorry to comment late.
> 
> On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>> index fdc19fbc10839..8a0f0064ff336 100644
>> --- a/Documentation/admin-guide/mm/pagemap.rst
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -23,7 +23,8 @@ There are four components to pagemap:
>>      * Bit  56    page exclusively mapped (since 4.2)
>>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
>> -    * Bits 57-60 zero
>> +    * Bit  58    page is a huge (PMD size) THP mapping
>> +    * Bits 59-60 zero
>>      * Bit  61    page is file-page or shared-anon (since 3.5)
>>      * Bit  62    page swapped
>>      * Bit  63    page present
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index ad667dbc96f5c..6f1403f83b310 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1302,6 +1302,7 @@ struct pagemapread {
>>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>>  #define PM_UFFD_WP		BIT_ULL(57)
>> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
> 
> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> "PM_HUGE" (as THP also means HUGE already)?
> 
> IMHO the core problem is about permission controls, and it seems to me we're
> actually trying to workaround it by duplicating some information we have.. so
> it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
> if it's the permission part that to be enhanced, rather than a new but slightly
> duplicated interface.

It's not a permission problem AFAIKS: even with permissions "changed",
any attempt to use /proc/kpageflags is just racy. Let's not go down that
path, it's really the wrong mechanism to export to random userspace.

We do have an interface to access this information from userspace
already: /proc/self/smaps IIRC. Mina commented that they are seeing
performance issues with that approach.

It would be valuable to add these details to the patch description,
including a performance difference when using both interfaces we have
available. As the patch description stands, there is no explanation
"why" we want this change.

-- 
Thanks,

David / dhildenb

