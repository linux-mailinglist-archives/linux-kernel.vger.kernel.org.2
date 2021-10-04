Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3848F4215C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhJDSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233615AbhJDSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633370312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxQQxvvGcqAWraIvuuYwyUrgNPDg6omqH/ZFVhZ6jGA=;
        b=d3xVe7O6oA8rHEfRjz0q3OYawLRbeDx3QIda+7i6rWOUd1Yd7F7gPD0tbDXfI5uGS8kafn
        pxETIGQOF7f3DKqJ5ATIaUjCxQLUcxb79CtnVdyVPsF2dVlVxRxTdl9FSmRCKfhMK2Kk7Q
        KLg2uks/dZu6R7J8Jh66W6e+O3R3+DQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-9_v_MvcpM2CQ5EmGcRQLxw-1; Mon, 04 Oct 2021 13:58:31 -0400
X-MC-Unique: 9_v_MvcpM2CQ5EmGcRQLxw-1
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so8451000wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FxQQxvvGcqAWraIvuuYwyUrgNPDg6omqH/ZFVhZ6jGA=;
        b=HDA9lcNxfTBZKUjv4FjX5p8ozeTZfvSGKqQBTPZf4kWxaBqTDOrqIdXsdz7z0iKesA
         ubBozwkqeSa6at2xeUKX2x+3NLeDVw9Yw6yJxxnN536/GJBxGvK0OrotMyrEDMPd7sHv
         O8nNMaT+QRvwL+g7FcdOp8IzShI0866RcWoIqe7zpUOFLxEFWUx9M5Tmqghfgw2GV+4d
         axQDMN+VyPqe0jf84BjZu7KAeoBdMCsrp9pFkEzqITjVmhza5Z9rZNjw8fqU/eicfvu3
         02kMsxuTmscnaXdNo//o8ZIt2BXrA5kGTShPdiJv9O+Y1V7N6+cvSuOQkctKkJOjPnom
         eAIw==
X-Gm-Message-State: AOAM530KT8Laul2Q5+3tBNXQaFfFr76Ebx6aNd4pZu1zS3I/QIaUFQCt
        mKe1TiVvzFwiu6jxmx40uc1jqr2sIRhnK6JoqetFN3RRfPFAZQ3SeMaBqjcOsHeo4QzA/yYy2qu
        iSDXF2AM4hVXQO99o+1HGvkc8
X-Received: by 2002:a7b:cf17:: with SMTP id l23mr8477232wmg.152.1633370310729;
        Mon, 04 Oct 2021 10:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd8ptk/toChuDvoXuiJScRuc2IZBxB2I/yMLx35rtCJMRxU4w3BpsifpFFOeWLODKAa24ZCw==
X-Received: by 2002:a7b:cf17:: with SMTP id l23mr8477210wmg.152.1633370310451;
        Mon, 04 Oct 2021 10:58:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6672.dip0.t-ipconnect.de. [91.12.102.114])
        by smtp.gmail.com with ESMTPSA id z17sm15175596wrr.49.2021.10.04.10.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 10:58:30 -0700 (PDT)
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
 <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
 <C533782D-9E4B-41F5-9120-A31A4782BCE5@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <a456a41d-c089-a639-b223-4412bad82e8d@redhat.com>
Date:   Mon, 4 Oct 2021 19:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <C533782D-9E4B-41F5-9120-A31A4782BCE5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Thanks for the pointer.
>>
>> And my question would be if something like DAMON would actually be what you want.
> 
> I looked into DAMON and even with the proposed future extensions it sounds
> as a different approach with certain benefits but with many limitations.
> 
> The major limitation of DAMON is that you need to predefine the logic you
> want for reclamation into the kernel. You can add programability through
> some API or even eBPF, but it would never be as easy or as versatile as
> what user manager can achieve. We already have pretty much all the
> facilities to do so from userspace, and the missing parts (at least for
> basic userspace manager) are almost already there. In contrast, see how
> many iterations are needed for the basic DAMON implementation.

I can see what you're saying when looking at optimizing a hand full of 
special applications. I yet fail to see how something like that could 
work as a full replacement for in kernel swapping. I'm happy to learn.

> 
> The second, also big, difference is that DAMON looks only on reclamation.
> If you want a custom prefetch scheme or different I/O stack for backing
> storage, you cannot have such one.

I do wonder if it could be extended for prefetching. But I am absolutely 
not a DAMON expert.

[...]

>>
>> You raise a very excellent point (and it should have been part of your initial sales pitch): how does it differ to process_vm_writev().
>>
>> I can say that it differs in a way that you can break applications in more extreme ways. Let me give you two examples:
>>
>> 1. longterm pinnings: you raised this yourself; this can break an application silently and there is barely a safe way your tooling could handle it.
>>
>> 2. pagemap: applications can depend on the populated(present |swap) information in the pagemap for correctness. For example, there was recently a discussion to use pagemap information to speed up live migration of VMs, by skipping migration of !populated pages. There is currently no way your tooling can fake that. In comparison, ordinary swapping in the kernel can handle it.
> 
> I understand (1). As for (2): the scenario that you mention sound
> very specific, and one can argue that ignoring UFFD-registered
> regions in such a case is either (1) wrong or (2) should trigger
> some UFFD event.
> 
>>
>> Is it easy to break an application with process_vm_writev()? Yes. When talking about dynamic debugging, it's expected that you break the target already -- or the target is already broken. Is it easier to break an application with process_madvise(MADV_DONTNEED)? I'd say yes, especially when implementing something way beyond debugging as you describe.
> 
> If you do not know what you are doing, you can easily break anything.
> Note that there are other APIs that can break your application even
> worse, specifically ptrace().
> 
>> I'm giving you "a hard time" for the reason Michal raised: we discussed this in the past already at least two times IIRC and "it is a free ticket to all sorts of hard to debug problem" in our opinion; especially when we mess around in other process address spaces besides for debugging.
>>
>> I'm not the person to ack/nack this, I'm just asking the questions :)
> 
> I see your points and I try to look for a path of least resistance.
> I thought that process_madvise() is a nice interface to hook into.

It would be the right interface -- iff the operation wouldn't have a bad 
smell to it. We don't really want applications to mess around in the 
page table layout of some other process: however, that is exactly what 
you require. By unlocking that interface for that use case we agree that 
what you are proposing is a "sane use case", but  ...

> 
> But if you are concerned it will be misused, how about adding instead
> an IOCTL that will zap pages but only in UFFD-registered regions?
> A separate IOCTL for this matter have an advantage of being more
> tailored for UFFD, not to notify UFFD upon “remove” and to be less
> likely to be misused.

... that won't change the fact that with your user-space swapping 
approach that requires this interface we can break some applications 
silently, and that's really the major concern I have.

I mean, there are more cases where you can just harm the target 
application I think, for example if the target application uses 
SOFTDIRTY tracking.


To judge if this is a sane use case we want to support, it would help a 
lot if there would be actual code+evaluation when actually implementing 
some of these advanced policies. Because you raise a lot of interesting 
points in your reply to Michal to back your use case, and naive me 
thinks "this sounds interesting but ... aren't we losing a lot of 
flexibility+features when doing this in user space? Does anyone actually 
want to do it like that?".

Again, I'm not the person to ack/nack this, I'm just questioning if the 
use case that requires this interface is actually something that will 
get used later in real life because it has real advantages, or if it's a 
pure research project that will get abandoned at some point and we ended 
up exposing an interface we really didn't want to expose so far 
(especially, because all other requests so far were bogus).

-- 
Thanks,

David / dhildenb

