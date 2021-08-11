Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7C3E97CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhHKSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhHKSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628707296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCRvG0nT8eYow76GIS0OaHgCKSzTjyOv3zg2eLrvx08=;
        b=gKdUru/B+roffLYcmfmmdV9fvGmHg44Q/YD/upF914mGmeTWU17QRgp2j2y3fmj1Dn5/Y2
        WS8HQLod6eh+IYvHMr1caTAifzuplxF17mnxqt2hFzsryhorzwe/mI4ADFsDSXrROfHWnc
        ZRBCOZIAYud9bh1sIGD6WsDxoFXUI5k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-LryYfJ8VM3-8k9jEBJFg8g-1; Wed, 11 Aug 2021 14:41:35 -0400
X-MC-Unique: LryYfJ8VM3-8k9jEBJFg8g-1
Received: by mail-wm1-f69.google.com with SMTP id e21-20020a05600c4b95b029025b007a168dso2356947wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WCRvG0nT8eYow76GIS0OaHgCKSzTjyOv3zg2eLrvx08=;
        b=TqZO+SFlN+PNDtaGTvDVOC3j8hI7s3PkaEYfJFVZYojk5wgO95IWAwYC5Q+mJ625z2
         s6eWKokWuAKCVgH6HKNn4FJeZB9QyvA2L2v8VdgQJ9ufFXbdy00r80mDbl7Ma8hj053k
         a8l+825k3xH5UpNaaGSWMuvhPXBUzEzc/isZGKCYF6OyTImDzmd7rzAgE6n40kSogOH7
         NRV3wP7O2/pNMDKp5F4MaqkWdDAAbtkYgikLJzReVNAcEu1ZL+JfY9v1366DMM4ul+WF
         nV7f48O1m/VGoeu3DXvuyVpGgC7UrsQAY2pmTb4Hl+xoaOUrYC2Y7yyR7x5FccHRUnn4
         uCCw==
X-Gm-Message-State: AOAM530vF/IaI37g150uiDlQ4bKf41BdwJirNZe15rQsDfFuE76O3VgP
        I0FSbe/Y5q8p6oEUlUMFdUZHx24QXDqmZiKmUr8xFIJa0oAM+nnAI5eqH4kpe3mwUsqgOolsBuW
        YG4qwFZ8IkwkRcJahOP9pihS5
X-Received: by 2002:adf:f809:: with SMTP id s9mr15372728wrp.370.1628707294122;
        Wed, 11 Aug 2021 11:41:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7wrpBeaVSdpk1ugNUDz3E+k+d0gSiok+JgAMK0Drg4isHn2j/Vx/tUMwB8MNipqDJBnMefA==
X-Received: by 2002:adf:f809:: with SMTP id s9mr15372696wrp.370.1628707293804;
        Wed, 11 Aug 2021 11:41:33 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id c9sm143103wrm.43.2021.08.11.11.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:41:33 -0700 (PDT)
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
 <YRQWMIBwkdBK12Z3@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <253e7067-1c62-19bd-d395-d5c0495610d7@redhat.com>
Date:   Wed, 11 Aug 2021 20:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQWMIBwkdBK12Z3@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 20:25, Peter Xu wrote:
> On Wed, Aug 11, 2021 at 06:15:37PM +0200, David Hildenbrand wrote:
>> On 04.08.21 21:17, Peter Xu wrote:
>>> On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
>>>> TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
>>>> any state information regarding shared memory in per-process page tables: it
>>>> just doesn't make too much sense.
>>>>
>>>> And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
>>>> belongs to the shared file ("did *someone* write to this page", "is
>>>> *someone* interested into changes to that page", "is there something"). I
>>>> know, that screams for a completely different design in respect to these
>>>> features.
>>>>
>>>> I guess we start learning the hard way that shared memory is just different
>>>> and requires different interfaces than per-process page table interfaces we
>>>> have (pagemap, userfaultfd).
>>>>
>>>> I didn't have time to explore any alternatives yet, but I wonder if tracking
>>>> such stuff per an actual fd/memfd and not via process page tables is
>>>> actually the right and clean approach. There are certainly many issues to
>>>> solve, but conceptually to me it feels more natural to have these shared
>>>> memory features not mangled into process page tables.
>>>
>>> Yes, we can explore all the possibilities, I'm totally fine with it.
>>>
>>> I just want to say I still don't think when there's page cache then we must put
>>> all the page-relevant things into the page cache.
>>
>> [sorry for the late reply]
>>
>> Right, but for the case of shared, swapped out pages, the information is
>> already there, in the page cache :)
>>
>>>
>>> They're shared by processes, but process can still have its own way to describe
>>> the relationship to that page in the cache, to me it's as simple as "we allow
>>> process A to write to page cache P", while "we don't allow process B to write
>>> to the same page" like the write bit.
>>
>> The issue I'm having uffd-wp as it was proposed for shared memory is that
>> there is hardly a sane use case where we would *want* it to work that way.
>>
>> A UFFD-WP flag in a page table for shared memory means "please notify once
>> this process modifies the shared memory (via page tables, not via any other
>> fd modification)". Do we have an example application where these semantics
>> makes sense and don't over-complicate the whole approach? I don't know any,
>> thus I'm asking dumb questions :)
>>
>>
>> For background snapshots in QEMU the flow would currently be like this,
>> assuming all processes have the shared guest memory mapped.
>>
>> 1. Background snapshot preparation: QEMU requests all processes
>>     to uffd-wp the range
>> a) All processes register a uffd handler on guest RAM
> 
> To be explicit: not a handler; just register with uffd-wp and pass over the fd
> to the main process.

Good point.

> 
>> b) All processes fault in all guest memory (essentially populating all
>>     memory): with a uffd-WP extensions we might be able to get rid of
>>     that, I remember you were working on that.
>> c) All processes uffd-WP the range to set the bit in their page table
>>
>> 2. Background snapshot runs:
>> a) A process either receives a UFFD-WP event and forwards it to QEMU or
>>     QEMU polls all other processes for UFFD events.
>> b) QEMU writes the to-be-changed page to the migration stream.
>> c) QEMU triggers all processes to un-protect the page and wake up any
>>     waiters. All processes clear the uffd-WP bit in their page tables.
>>
>> 3. Background snapshot completes:
>> a) All processes unregister the uffd handler
>>
>>
>> Now imagine something like this:
>>
>> 1. Background snapshot preparation:
>> a) QEMU registers a UFFD-WP handler on a *memfd file* that corresponds
>>     to guest memory.
>> b) QEMU uffd-wp's the whole file
>>
>> 2. Background snapshot runs:
>> a) QEMU receives a UFFD-WP event.
>> b) QEMU writes the to-be-changed page to the migration stream.
>> c) QEMU un-protect the page and wake up any waiters.
>>
>> 3. Background snapshot completes:
>> a) QEMU unregister the uffd handler
>>
>>
>> Wouldn't that be much nicer and much easier to handle? Yes, it is much
>> harder to implement because such an infrastructure does not exist yet, and
>> it most probably wouldn't be called uffd anymore, because we are dealing
>> with file access. But this way, it would actually be super easy to use the
>> feature across multiple processes and eventually to even catch other file
>> modifications.
> 
> I can totally understand how you see this.  We've discussed about that, isn't
> it? About the ideal worlds. :)

Well, let's dream big :)

> 
> It would be great if this can work out, I hope so.  So far I'm not that
> ambicious, and as I said, I don't know whether there will be other concerns
> when it goes into the page cache layer, and when it's a behavior of multiple
> processes where one of them can rule others without others being notice of it.
> 
> Even if we want to go that way, I think we should first come up with some way
> to describe the domains that one uffd-wp registered file should behave upon.
> It shouldn't be "any process touching this file".
> 
> One quick example in my mind is when a malicious process wants to stop another
> daemon process, it'll be easier as long as the malicious process can delete a
> file that the daemon used to read/write, replace it with a shmem with uffd-wp
> registered (or maybe just a regular file on file systems, if your proposal will
> naturally work on them).  The problem is, is it really "legal" to be able to
> stop the daemon running like that?

Good question, I'd imagine e.g., file sealing could forbid uffd (or 
however it is called) registration on a file, and there would have to be 
a way to reject files that have uffd registered. But it's certainly a 
valid concern - and it raises the question to *what* we actually want to 
apply such a concept. Random files? random memfd? most probably not. 
Special memfds created with an ALLOW_UFFD flag? sounds like a good idea.

> 
> I also don't know the initial concept when uffd is designed and why it's
> designed at pte level.  Avoid vma manipulation should be a major factor, but I
> can't say I understand all of them.  Not sure whether Andrea has any input here.

AFAIU originally a) avoid signal handler madness and b) avoid VMA 
modifications and c) avoid taking the mmap lock in write (well, that 
didn't work out completely for uffd-wp for now IIRC).

> 
> That's why I think current uffd can still make sense with per-process concepts
> and keep it that way.  When register uffd-wp yes we need to do that for
> multiple processes, but it also means each process is fully aware that this is
> happening so it's kind of verified that this is wanted behavior for that
> process.  It'll happen with less "surprises", and smells safer.
> 
> I don't think that will not work out.  It may require all the process to
> support uffd-wp apis and cooperate, but that's so far how it should work for me
> in a safe and self-contained way.  Say, every process should be aware of what's
> going to happen on blocked page faults.

That's a valid concern, although I wonder if it can just be handled via 
specially marked memfds ("this memfd might get a uffd handler registered 
later").

>>
>> Again, I am not sure if uffd-wp or softdirty make too much sense in general
>> when applied to shmem. But I'm happy to learn more.
> 
> Me too, I'm more than glad to know whether the page cache idea could be
> welcomed or am I just wrong about it.  Before I understand more things around
> this, so far I still think the per-process based and fd-based solution of uffd
> still makes sense.

I'd be curious about applications where the per-process approach would 
actually solve something a per-fd approach couldn't solve. Maybe there 
are some that I just can't envision.

(using shmem for a single process only isn't a use case I consider 
important :) )

-- 
Thanks,

David / dhildenb

