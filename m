Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6DB4258E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbhJGRJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243028AbhJGRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633626449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwpfyQTtaeMehGGt8WXqpg7XbUlOAwGjEWSFfCq+LBk=;
        b=SjPkACBUKhLJ7v8M5DL0zf2v6zZX22+dadpMfzJlrGWvoyE84hugRnFhJC7hEHhVSis5B5
        wOrzcFZnImB7MCxWRqawnmjkMbYBVWclo3qMvWKuwUgwi28sTEfzzGbpgyn4Kp3rNufwYP
        lmfkWweTkmzmzvD5K3jW7ZMKtBayhhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-lkJpAHoNNYOWXe0IKxU_Gg-1; Thu, 07 Oct 2021 13:07:27 -0400
X-MC-Unique: lkJpAHoNNYOWXe0IKxU_Gg-1
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so5245859wrg.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vwpfyQTtaeMehGGt8WXqpg7XbUlOAwGjEWSFfCq+LBk=;
        b=3uYc9W7UMoDnm96uuKr1XnOPgeeOLy2G8YdngIrWDRaTpX31e7a9yV+MQKznvgckeH
         IHeU14izLqmqn7ZCwBQcEFSZhyGxehRGuV+SoKiwcHbyCPSwShUxph4roOB30TddLZJm
         r75N0zdQenOVydnOjYp6iFRCX6X/SBWiwudI2/I4pE09s9a01ZuqQhe+AepNAIi+1Ldf
         Fm4LuKrDEru5FzbQMNvf8g4nCHbqI6s7l7arVfi4yoaAyPl6G2qa43gjE6q/vf4vFyAN
         HWrqQMyln6Ipx79Rt0iqUJgYvkzML6u0bouGsrQ2P+/RGSnTLrwVAZB6q1OMc3j29tcy
         lDug==
X-Gm-Message-State: AOAM533iEm/JbUYqyBhQFriKjOpcLF9TEoldG1VFBQfR4h3KAYfzWYuS
        hFzjH0nhlSUe+rGOSl2/n4FdwmzVfnGB4p+zrUslP3TDNCZ8lwxEYxjWElLMMHLEy6xYd9ngp2G
        /aMZ2VEzvGaS+DjwCN1aCHan3
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr6922570wrw.192.1633626446399;
        Thu, 07 Oct 2021 10:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygc3VADN1g1Myu/7uOiT5xksaiWSHEIY4sCoNmOoTd1avEjs9XTndvBXFpkeGLZj+Y1QyBzQ==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr6922531wrw.192.1633626446145;
        Thu, 07 Oct 2021 10:07:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id t11sm175959wrz.65.2021.10.07.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 10:07:25 -0700 (PDT)
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-3-namit@vmware.com>
 <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
 <5356D62E-1900-4E92-AF23-AA5625EFFD92@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Message-ID: <1952fc7c-fb21-7d0e-661b-afa59b4580e5@redhat.com>
Date:   Thu, 7 Oct 2021 19:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5356D62E-1900-4E92-AF23-AA5625EFFD92@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.21 18:16, Nadav Amit wrote:
> 
>> On Oct 7, 2021, at 5:13 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.09.21 22:54, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>> Currently, using mprotect() to unprotect a memory region or uffd to
>>> unprotect a memory region causes a TLB flush. At least on x86, as
>>> protection is promoted, no TLB flush is needed.
>>> Add an arch-specific pte_may_need_flush() which tells whether a TLB
>>> flush is needed based on the old PTE and the new one. Implement an x86
>>> pte_may_need_flush().
>>> For x86, PTE protection promotion or changes of software bits does
>>> require a flush, also add logic that considers the dirty-bit. Changes to
>>> the access-bit do not trigger a TLB flush, although architecturally they
>>> should, as Linux considers the access-bit as a hint.
>>
>> Is the added LOC worth the benefit? IOW, do we have some benchmark that really benefits from that?
> 
> So you ask whether the added ~10 LOC (net) worth the benefit?

I read  "3 files changed, 46 insertions(+), 1 deletion(-)" to optimize 
something without proof, so I naturally have to ask. So this is just a 
"usually we optimize and show numbers to proof" comment.

> 
> Let’s start with the cost of this patch.
> 
> If you ask about complexity, I think that it is a rather simple
> patch and documented as needed. Please be more concrete if you
> think otherwise.

It is most certainly added complexity, although documented cleanly.

> 
> If you ask about the runtime overhead, my experience is that
> such code, which mostly does bit operations, has negligible cost.
> The execution time of mprotect code, and other similar pieces of
> code, is mostly dominated by walking the page-tables & getting
> the pages (which might require cold or random memory accesses),
> acquiring the locks, and of course the TLB flushes that this
> patch tries to eliminate.

I'm absolutely not concerned about runtime overhead :)

> 
> As for the benefit: TLB flush on x86 of a single PTE has an
> overhead of ~200 cycles. If a TLB shootdown is needed, for instance
> on multithreaded applications, this overhead can grow to few
> microseconds or even more, depending on the number of sockets,
> whether the workload runs in a VM (and worse if CPUs are
> overcommitted) and so on.
> 
> This overhead is completely unnecessary on many occasions. If
> you run mprotect() to add permissions, or as I noted in my case,
> to do something similar using userfaultfd. Note that the
> potentially unnecessary TLB flush/shootdown takes place while
> you hold the mmap-lock for write in the case of mprotect(),
> thereby potentially preventing other threads from making
> progress during that time.
> 
> On my in-development workload it was a considerable overhead
> (I didn’t collect numbers though). Basically, I track dirty
> pages using uffd, and every page-fault that can be easily
> resolved by unprotecting cause a TLB flush/shootdown.

Any numbers would be helpful.

> 
> If you want, I will write a microbenchmarks and give you numbers.
> If you look for further optimizations (although you did not indicate
> so), such as doing the TLB batching from do_mprotect_key(),
> (i.e. batching across VMAs), we can discuss it and apply it on
> top of these patches.

I think this patch itself is sufficient if we can show a benefit; I do 
wonder if existing benchmarks could already show a benefit, I feel like 
they should if this makes a difference. Excessive mprotect() usage 
(protect<>unprotect) isn't something unusual.

-- 
Thanks,

David / dhildenb

