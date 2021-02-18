Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3959531F0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhBRUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233112AbhBRTr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613677590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZmGAzUC+8dwc8omdud3uVAWf0zcvuutIq5VHsAV4q0=;
        b=MK360Jwkvs8EQWcgmw7fj/uTTbYVdrRd28iq6u4x9NyveBgSV1sCp5fvmOo2tIZDHEAqDN
        nJqmRkyMYFmsdJN9YYLWzXh77SquoDBtJhhuXNEepLSpn4cMZupN0tdpEb08hqUlZbVDOp
        jAgIOFgPGZBIHsTMu6Lq4bkJQpMCue8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-55MMnnLmMF2NSFx3LYxoGg-1; Thu, 18 Feb 2021 14:46:25 -0500
X-MC-Unique: 55MMnnLmMF2NSFx3LYxoGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8721C297;
        Thu, 18 Feb 2021 19:46:22 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB0E410016DB;
        Thu, 18 Feb 2021 19:46:18 +0000 (UTC)
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <CAAeHK+x2OwXXR-ci9Z+g=O6ZivM+LegxwkrpTqJLy2AZ9iW7-g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <509c1c80-bb2c-0c5c-ffa3-939ca40d2646@redhat.com>
Date:   Thu, 18 Feb 2021 20:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+x2OwXXR-ci9Z+g=O6ZivM+LegxwkrpTqJLy2AZ9iW7-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.21 20:40, Andrey Konovalov wrote:
> On Thu, Feb 18, 2021 at 9:55 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.02.21 21:56, Andrey Konovalov wrote:
>>> During boot, all non-reserved memblock memory is exposed to the buddy
>>> allocator. Poisoning all that memory with KASAN lengthens boot time,
>>> especially on systems with large amount of RAM. This patch makes
>>> page_alloc to not call kasan_free_pages() on all new memory.
>>>
>>> __free_pages_core() is used when exposing fresh memory during system
>>> boot and when onlining memory during hotplug. This patch adds a new
>>> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
>>> free_pages_prepare() from __free_pages_core().
>>>
>>> This has little impact on KASAN memory tracking.
>>>
>>> Assuming that there are no references to newly exposed pages before they
>>> are ever allocated, there won't be any intended (but buggy) accesses to
>>> that memory that KASAN would normally detect.
>>>
>>> However, with this patch, KASAN stops detecting wild and large
>>> out-of-bounds accesses that happen to land on a fresh memory page that
>>> was never allocated. This is taken as an acceptable trade-off.
>>>
>>> All memory allocated normally when the boot is over keeps getting
>>> poisoned as usual.
>>>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>>
>> Not sure this is the right thing to do, see
>>
>> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
>>
>> Reversing the order in which memory gets allocated + used during boot
>> (in a patch by me) might have revealed an invalid memory access during boot.
>>
>> I suspect that that issue would no longer get detected with your patch,
>> as the invalid memory access would simply not get detected. Now, I
>> cannot prove that :)
> 
> This looks like a good example.
> 
> Ok, what we can do is:
> 
> 1. For KASAN_GENERIC: leave everything as is to be able to detect
> these boot-time bugs.
> 
> 2. For KASAN_SW_TAGS: remove boot-time poisoning via
> kasan_free_pages(), but use the "invalid" tag as the default shadow
> value. The end result should be the same: bad accesses will be
> detected. For unallocated memory as it has the default "invalid" tag,
> and for allocated memory as it's poisoned properly when
> allocated/freed.
> 
> 3. For KASAN_HW_TAGS: just remove boot-time poisoning via
> kasan_free_pages(). As the memory tags have a random unspecified
> value, we'll still have a 15/16 chance to detect a memory corruption.
> 
> This also makes sense from the performance perspective: KASAN_GENERIC
> isn't meant to be running in production, so having a larger perf
> impact is acceptable. The other two modes will be faster.

Sounds in principle sane to me.

Side note: I am not sure if anybody runs KASAN in production. Memory is 
expensive. Feel free to prove me wrong, I'd be very interest in actual 
users.

-- 
Thanks,

David / dhildenb

