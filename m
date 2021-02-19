Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9031F343
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBSAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBSAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:10:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:10:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q20so2616019pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mNeKDWUCPWRjksxHsm0Sl4Ar+FMbcH9wO3bpUG9+dU=;
        b=BC6tuzv20jq0nQ0piEbqyLgRX7rhaCxUkZrHw37Vmfz/7XgquLlxAHC/1EohAiv3Rb
         fcb9rMYbpw48pogIU8JjxT55d1pYGBnmAnG7gQxNn/iMBEPtPCmTje74BGwi1zKsRzg9
         KpIkMLTiypUKUGiP+kFemDmsIhQPV/cv1vkfKC5otpQ9WG646Y6RnI7vok74axJFpJuD
         CY4yJXp9tVBiUZHmuTBt9v6tHNhKTqSSm1KXcDWbUSRtkvSv4ygeYzD4jaaf4NorfdD7
         jowW5zj0AzpS1zbka09mozIdiyO7yP1MUfgSIutoXIUCSEqrkXrI2WzWRAV+F41StTg+
         mL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mNeKDWUCPWRjksxHsm0Sl4Ar+FMbcH9wO3bpUG9+dU=;
        b=MMQDegmgIr1hIOfVSNtjqCTpqKFXs9DZBZmitScnUA2xMKRVBtHDgKboEKHEcLi/d7
         1zuBhORN97zjBuX3U+VvRmjAhMu6gR5sCw8d+wNsiVLXM0sfx6GYYiIAdA3a/fWvx+8O
         m+dOVd7UOFB2q/B9nXV/PiM4CyJEGzeCgxW7SiVTEoLeX4LSwXytkjtuyeUjftpQyJVq
         wLklVxzSIPSLmGeqKiEpIkbb/tkVz/oS5kbuVasxNybVnlPK8hXLnHUEtocQLjlRvdDo
         y8SJ9JqUzEUCR9SlHv7IrTGNj5s5IM3xbFzF7WZKz3Z6Mu17FGB3hT2REkPCrOV7skxm
         iKDA==
X-Gm-Message-State: AOAM533JJuc75fo6WqG8YXLZr0+o6n07r7gE0r87piUBv4cS9dL9mb37
        6k2S/jdTKs5wU6W5fp2y5OsRIUVPQn2M6u7BQWqbfg==
X-Google-Smtp-Source: ABdhPJx/0Kfxw/jydMgdKkoVJGQ9Mem1OgH2yeF1tAZyCD1927v/1Bq1MDPv64DdN//p27FkkBMA80WqL4Ci3Ou7p0I=
X-Received: by 2002:a62:7c55:0:b029:1dd:8c65:1ed8 with SMTP id
 x82-20020a627c550000b02901dd8c651ed8mr6639950pfc.24.1613693400570; Thu, 18
 Feb 2021 16:10:00 -0800 (PST)
MIME-Version: 1.0
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com> <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
In-Reply-To: <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 19 Feb 2021 01:09:49 +0100
Message-ID: <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 1:06 AM George Kennedy
<george.kennedy@oracle.com> wrote:
>
>
>
> On 2/18/2021 3:55 AM, David Hildenbrand wrote:
> > On 17.02.21 21:56, Andrey Konovalov wrote:
> >> During boot, all non-reserved memblock memory is exposed to the buddy
> >> allocator. Poisoning all that memory with KASAN lengthens boot time,
> >> especially on systems with large amount of RAM. This patch makes
> >> page_alloc to not call kasan_free_pages() on all new memory.
> >>
> >> __free_pages_core() is used when exposing fresh memory during system
> >> boot and when onlining memory during hotplug. This patch adds a new
> >> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
> >> free_pages_prepare() from __free_pages_core().
> >>
> >> This has little impact on KASAN memory tracking.
> >>
> >> Assuming that there are no references to newly exposed pages before they
> >> are ever allocated, there won't be any intended (but buggy) accesses to
> >> that memory that KASAN would normally detect.
> >>
> >> However, with this patch, KASAN stops detecting wild and large
> >> out-of-bounds accesses that happen to land on a fresh memory page that
> >> was never allocated. This is taken as an acceptable trade-off.
> >>
> >> All memory allocated normally when the boot is over keeps getting
> >> poisoned as usual.
> >>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
> >
> > Not sure this is the right thing to do, see
> >
> > https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
> >
> > Reversing the order in which memory gets allocated + used during boot
> > (in a patch by me) might have revealed an invalid memory access during
> > boot.
> >
> > I suspect that that issue would no longer get detected with your
> > patch, as the invalid memory access would simply not get detected.
> > Now, I cannot prove that :)
>
> Since David's patch we're having trouble with the iBFT ACPI table, which
> is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c". KASAN
> detects that it is being used after free when ibft_init() accesses the
> iBFT table, but as of yet we can't find where it get's freed (we've
> instrumented calls to kunmap()).

Maybe it doesn't get freed, but what you see is a wild or a large
out-of-bounds access. Since KASAN marks all memory as freed during the
memblock->page_alloc transition, such bugs can manifest as
use-after-frees.
