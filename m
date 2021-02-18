Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40DE31F09A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhBRT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhBRTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:41:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:40:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cl8so1969181pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wz58CA+xdym2cUyo64XiGmMsVDmP1Ip6ib85/PA+8zo=;
        b=W4TbLg8qMWfsuB1AB1fMJ0DQTaFAcUQPoq+MCDUEp7V6Ciiq+emO4o0yMc0LUcQVGk
         S40PUiaXN2LyLfo1ylNkspdEEFpE0/hgXez5mBHFrPqWj49PStiPKrJWCNlddVIR4S4y
         JJAZA3udWx4+/ZhZg4XxsRnz+APo8EZEu+2ay55Dr1HLzkYwmnbeRNgFPUZiLLlDOayP
         fuYr65h6/T/GhF3hcPGcmyns/NTU7L6GS+bD1W4r5YYwUDff5ENC7jCx5iDLSLfEf8jm
         6JWIu9r+O/an6lGfFBSinzW5B1JyjGz9cFZnSwPTT5dSUDpCNH3qYYubCax/srCVhYYO
         7NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz58CA+xdym2cUyo64XiGmMsVDmP1Ip6ib85/PA+8zo=;
        b=eEYYCjAdvZE2UNalWrRPjWIffl5te5XNCmHKVS0wP7KGwIdF7m+QiKMCbwL/BrG3KH
         NlxDHBedEeBd1M8W6gIMLIXX1vUM7GSobTuxsnmxBwlwjlLz10gdiQ4g6O9l1FpT57T5
         Kh331n13XS+ySeEWRPl1oc0pHLOcn+1pATdMicE89irOuGK+xeY3/dfBRR2u9zAFxaKr
         dlZT8X7T/YrcKTlLTDTDvVWlPP8rXB84BRwKPTDlFCahllr+3tT1Fk3Tk7LO11X4mcM4
         uucd8WNXTIp2Qz/Yea1DNmnWyrp05K1UH2EUjG32izfvRq0rHyG1cXVEhToI9HRGLVe8
         d8pA==
X-Gm-Message-State: AOAM532Y4ASXztD+3DdtqFKdPLkvkNq67yrYxFUz5OHlpFwthLeFEUfA
        5LP9k5zmRm1qZw2h/HoXKbs6PqFHXfH8FS5GWbjtbw==
X-Google-Smtp-Source: ABdhPJy9k7NKXFpkZ4tUscvI5SLYhmK/yqXevEwIsjaCtaGMW1qKDUD84zrMdLrxIty2E/geWLG9vutH6l1No/0DJBU=
X-Received: by 2002:a17:90a:64cc:: with SMTP id i12mr6170pjm.41.1613677253685;
 Thu, 18 Feb 2021 11:40:53 -0800 (PST)
MIME-Version: 1.0
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
In-Reply-To: <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Feb 2021 20:40:42 +0100
Message-ID: <CAAeHK+x2OwXXR-ci9Z+g=O6ZivM+LegxwkrpTqJLy2AZ9iW7-g@mail.gmail.com>
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 9:55 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.02.21 21:56, Andrey Konovalov wrote:
> > During boot, all non-reserved memblock memory is exposed to the buddy
> > allocator. Poisoning all that memory with KASAN lengthens boot time,
> > especially on systems with large amount of RAM. This patch makes
> > page_alloc to not call kasan_free_pages() on all new memory.
> >
> > __free_pages_core() is used when exposing fresh memory during system
> > boot and when onlining memory during hotplug. This patch adds a new
> > FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
> > free_pages_prepare() from __free_pages_core().
> >
> > This has little impact on KASAN memory tracking.
> >
> > Assuming that there are no references to newly exposed pages before they
> > are ever allocated, there won't be any intended (but buggy) accesses to
> > that memory that KASAN would normally detect.
> >
> > However, with this patch, KASAN stops detecting wild and large
> > out-of-bounds accesses that happen to land on a fresh memory page that
> > was never allocated. This is taken as an acceptable trade-off.
> >
> > All memory allocated normally when the boot is over keeps getting
> > poisoned as usual.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>
> Not sure this is the right thing to do, see
>
> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
>
> Reversing the order in which memory gets allocated + used during boot
> (in a patch by me) might have revealed an invalid memory access during boot.
>
> I suspect that that issue would no longer get detected with your patch,
> as the invalid memory access would simply not get detected. Now, I
> cannot prove that :)

This looks like a good example.

Ok, what we can do is:

1. For KASAN_GENERIC: leave everything as is to be able to detect
these boot-time bugs.

2. For KASAN_SW_TAGS: remove boot-time poisoning via
kasan_free_pages(), but use the "invalid" tag as the default shadow
value. The end result should be the same: bad accesses will be
detected. For unallocated memory as it has the default "invalid" tag,
and for allocated memory as it's poisoned properly when
allocated/freed.

3. For KASAN_HW_TAGS: just remove boot-time poisoning via
kasan_free_pages(). As the memory tags have a random unspecified
value, we'll still have a 15/16 chance to detect a memory corruption.

This also makes sense from the performance perspective: KASAN_GENERIC
isn't meant to be running in production, so having a larger perf
impact is acceptable. The other two modes will be faster.
