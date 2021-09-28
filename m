Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2970341AB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbhI1Iyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239664AbhI1Iyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632819190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPVHVUzJLA0xC63do/dT2ftZ20sbk+pplCA5Sb9RB6w=;
        b=YhDmT5U6WaF18qV2E9Gf2trYHlktb4r+hwjdAJQLPkY4hYIJYrrfcRXPkj6B1qQnUTpFYY
        QUF790xmnKBRAiCgFjp4pMU3Ih2l1408RfMmiZ6XLhcK0GEc45t0+n/aBGFj8oZkmnVCbC
        6KpvQQXNghDcGBpyvH4K/CRjhb9YnJ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224--HMB24j1NBSvPJQA5wwNtw-1; Tue, 28 Sep 2021 04:53:08 -0400
X-MC-Unique: -HMB24j1NBSvPJQA5wwNtw-1
Received: by mail-wm1-f71.google.com with SMTP id c77-20020a1c9a50000000b0030d06638a56so407532wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wPVHVUzJLA0xC63do/dT2ftZ20sbk+pplCA5Sb9RB6w=;
        b=ZdzgJaFO7Bb/PnqnT0e/ogZL+QpCxDVOHfqZro2llBLegPBONiiEQTn221sc2m4+4N
         dLJwzVosDwzmG1G/gJaPzIJDwzBBTENr+Y84tGiowI49GxLBL1yy5Mg3o7ujaGT1pbkZ
         VfTceEVphcM89yN6/r08ER+29UJ+LUfT4jWk/LozH8PBNycGHHA6F8muzFHbd/KlMviF
         EqVOYhcykALTnR5uAMXMg0DuXJQVr9udp20GIxCE4iSDkwpdVzK1f//WWS/iCcgqglyu
         u5Az9jkK17GfrhrlCJMMVFoFdv4EM5sXhC6vI47+hVeRVdO/g1McoX/acbaPyHMNz88C
         lMdg==
X-Gm-Message-State: AOAM5305vdcwO2cE6RqBjQllw85Iuz542w5VZ5YNPZa+rh1KIFtcsz84
        7d1rF9n8xBkF6zx5kyp1m943FwaQ+JG3JRBGsmm9DzQJsFGTbd0U0JkvLT2SvXHgP9IGaygyC+S
        dm3/uyRdKPoo/V8fLOZdKfTqM
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr3443944wmq.97.1632819187486;
        Tue, 28 Sep 2021 01:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCT0rAZ4AUZznug4gSIQ/PFmsFmPvDMgEYCRI3IQxCnfiSdWN7tLcC1Z3Oj/kaulHUkRBu9w==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr3443918wmq.97.1632819187189;
        Tue, 28 Sep 2021 01:53:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aaf.dip0.t-ipconnect.de. [79.242.58.175])
        by smtp.gmail.com with ESMTPSA id n186sm2008424wme.31.2021.09.28.01.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 01:53:06 -0700 (PDT)
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
 <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
Date:   Tue, 28 Sep 2021 10:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Again, thanks for the details. I guess this should basically work, although it involves a lot of complexity (read: all flavors of uffd on other processes). And I am no so sure about performance aspects. "Performance is not as bad as you think" doesn't sound like the words you would want to hear from a car dealer ;) So there has to be another big benefit to do such user space swapping.
> 
> There is some complexity, indeed. Worse, there are some quirks of UFFD
> that make life hard for no reason and some uffd and iouring bugs.
> 
> As for my sales pitch - I agree that I am not the best car dealer… :(

:)

> When I say performance is not bad, I mean that the core operations of
> page-fault handling, prefetch and reclaim do not induce high overhead
> *after* the improvements I sent or mentioned.
> 
> The benefit of doing so from userspace is that you have full control
> over the reclaim/prefetch policies, so you may be able to make better
> decisions.
> 
> Some workloads have predictable access patterns (see for instance "MAGE:
> Nearly Zero-Cost Virtual Memory for Secure Computation”, OSDI’21). You may
> be handle such access patterns without requiring intrusive changes to the
> workload.

Thanks for the pointer.

And my question would be if something like DAMON would actually be what 
you want.

> 
> 
>>
>>> I am aware that there are some caveats, as zapping the memory does not
>>> guarantee that the memory would be freed since it might be pinned for a
>>> variety of reasons. That's the reason I mentioned the processes have "some
>>> level of cooperation" with the manager. It is not intended to deal with
>>> adversaries or uncommon corner cases (e.g., processes that use UFFD for
>>> their own reasons).
>>
>> It's not only long-term pinnings. Pages could have been de-duplicated (COW after fork, KSM, shared zeropage). Further, you'll most probably lose any kind of "aging" ("accessed") information on pages, or how would you track that?
> 
> I know it’s not just long-term pinnings. That’s what “variety of reasons”
> stood for. ;-)
> 
> Aging is a tool for certain types of reclamation policies. Some do not
> require it (e.g., random). You can also have compiler/application-guided
> reclamation policies. If you are really into “aging”, you may be able
> to use PEBS or other CPU facilities to track it.
> 
> Anyhow, the access-bit by itself not such a great solution to track
> aging. Setting it can induce overheads of >500 cycles from my (and
> others) experience.

Well, I'm certainly no expert on that; I would assume it's relevant in 
corner cases only: if you're application accesses all it's memory 
permanently a swap setup is already "broken". If you have plenty of old 
memory (VMs, databases, ...) it should work reasonably well. But yeah, 
detecting the working set size is a problematic problem, and "access"
bits can be sub-optimal.

After all, that's what the Linux kernel has been relying on for a long 
time ... and IIRC it might be extended by multiple "aging" queues soon.

> 
>>
>> Although I can see that this might work, I do wonder if it's a use case worth supporting. As Michal correctly raised, we already have other infrastructure in place to trigger swapin/swapout. I recall that also damon wants to let you write advanced policies for that by monitoring actual access characteristics.
> 
> Hints, as those that Michal mentioned, prevent the efficient use of
> userfaultfd. Using MADV_PAGEOUT will not trigger another uffd event
> when the page is brought back from swap. So using
> MADV_PAGEOUT/MADV_WILLNEED does not allow you to have a custom
> prefetch policy, for instance. It would also require you to live
> with the kernel reclamation/IO stack for better and worse.

Would more uffd (or similar) events help?

> 
> As for DAMON, I am not very familiar with it, but from what I remember
> it seemed to look on a similar direction. IMHO it is more intrusive
> and less configurable (although it can have the advantage of better
> integration with various kernel mechanism). I was wondering for a
> second why you give me such a hard time for a pretty straight-forward
> extension for process_madvise(), but then I remembered that DAMON got
> into the kernel after >30 versions, so I’ll shut up about that. ;-)

It took ... quite a long time, indeed :)

> 
>>
>>> Putting aside my use-case (which I am sure people would be glad to criticize),
>>> I can imagine debuggers or emulators may also find use for similar schemes
>>> (although I do not have concrete use-cases for them).
>>
>> I'd be curious about use cases for debuggers/emulators. Especially for emulators I'd guess it makes more sense to just do it within the process. And for debuggers, I'm having a hard time why it would make sense to throw away a page instead of just overwriting it with $PATTERN (e.g., 0). But I'm sure people can be creative :)
> 
> I have some more vague ideas, but I am afraid that you will keep
> saying that it makes more sense to handle such events from within
> a process. I am not sure that this is true. Even for the emulators
> that we discuss, the emulated program might run in a different
> address space (for sandboxing). You may be able to avoid the need
> for remote-UFFD and get away with the current non-cooperative
> UFFD, but zapping the memory (for atomic updates) would still
> require process_madvise(MADV_DONTNEED) [putting aside various
> ptrace solutions].
> 
> Anyhow, David, I really appreciate your feedback. And you make
> strong points about issues I encounter. Yet, eventually, I think
> that the main question in this discussion is whether enabling
> process_madvise(MADV_DONTNEED) is any different - from security
> point of view - than process_vm_writev(), not to mention ptrace.
> If not, then the same security guards should suffice, I would
> argue.
> 

You raise a very excellent point (and it should have been part of your 
initial sales pitch): how does it differ to process_vm_writev().

I can say that it differs in a way that you can break applications in 
more extreme ways. Let me give you two examples:

1. longterm pinnings: you raised this yourself; this can break an 
application silently and there is barely a safe way your tooling could 
handle it.

2. pagemap: applications can depend on the populated(present |swap) 
information in the pagemap for correctness. For example, there was 
recently a discussion to use pagemap information to speed up live 
migration of VMs, by skipping migration of !populated pages. There is 
currently no way your tooling can fake that. In comparison, ordinary 
swapping in the kernel can handle it.

Is it easy to break an application with process_vm_writev()? Yes. When 
talking about dynamic debugging, it's expected that you break the target 
already -- or the target is already broken. Is it easier to break an 
application with process_madvise(MADV_DONTNEED)? I'd say yes, especially 
when implementing something way beyond debugging as you describe.


I'm giving you "a hard time" for the reason Michal raised: we discussed 
this in the past already at least two times IIRC and "it is a free 
ticket to all sorts of hard to debug problem" in our opinion; especially 
when we mess around in other process address spaces besides for debugging.

I'm not the person to ack/nack this, I'm just asking the questions :)

-- 
Thanks,

David / dhildenb

