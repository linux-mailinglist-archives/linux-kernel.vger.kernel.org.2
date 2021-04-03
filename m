Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F6C3535B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhDCWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhDCWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 18:31:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93222C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 15:31:00 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i3so8276294oik.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYlLWj8+FRi0P0GcdiqidMl/NInsj6MKpCJaKoSPEY0=;
        b=rqsXs8aP3fYPJwOH2fhm1Blh4CveNCXGCuSgUiGWM2SeJFPoC0tbffTR1v6kyATH3c
         xuhCqoqfXIpkzjbMEFjCGNDGAXOEEiInHeieMRl3ZNNc2qFuGd44dAZh0gKKadU3DD4/
         8vn0tHDGJ7ToZTZJOBTStfrGGfgF6mHK+/J14mcjUrac8NseUMmRRdJwuYi/kl1o0KBH
         MVoh7DjniO6PwmXOSmnoJfF/PUWKysUnzLBmtBtNquQOi6shPUa7Cz5X1ZQ2Zub8LCoI
         NL/2vls7Uix24Jq+OmzaI/hXQXfxdrOIRwo/16J7zXVOP1w8f71wnrt57tsKg6cyhfTQ
         n5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYlLWj8+FRi0P0GcdiqidMl/NInsj6MKpCJaKoSPEY0=;
        b=Snh7Z+Hy/G+h6SABeZD/0NgbwXF6FH0LGUwRXgUasHlt3uQBAP4nlIdo0kqrQEGOCm
         NNpwziHLYXUbR1pYEDnfONJUBms2bNPoFCdfDsMbtGsZi2yQE6KrD4aaYFPRa2IGBonV
         I1wggkuFz6bjhBKdOB4c6gH8bC3jYUC49fn0nFuETPYo3+CmuCSw+jKipkgBFU8QsqpZ
         v9EFsTe9sR7cDC1wx3Uy5e3zXs6SfWXt9l22+XRXEHsDbSTWVuYlKyNePKn6BagzEXyB
         yPVQ6iyf2SGY8xyUZ15v9amL36ynt5hixoQzknJcYIvoQ6wreXD+xTBu/mZ/dmC5zyVe
         dJVA==
X-Gm-Message-State: AOAM533E2LZKTDhQ6T+iFHMLgC6UPeoUVa9cgvd8eyJ+dmYV9UO9Cjn2
        2NK2JcXpGZpNSjzjbU1NlJX8GCE01G2I6oc0QUqTeQ==
X-Google-Smtp-Source: ABdhPJz69mE4fC5KMXNgLh70gdGilr0Djrsb2GOXBb4adjwQ0uGbT0bHr1nRf3/xA/sdKnNMxXT5HDGkN7l4m0VVxEc=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr13785004oif.121.1617489059403;
 Sat, 03 Apr 2021 15:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
 <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com>
In-Reply-To: <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 4 Apr 2021 00:30:47 +0200
Message-ID: <CANpmjNM__Dk_MVd-9fPT=TbPw=a1giicUcFS+RwCfQ7yue8Xdw@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Peter Collingbourne <pcc@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2021 at 22:40, Peter Collingbourne <pcc@google.com> wrote:
> On Sat, Apr 3, 2021 at 3:03 AM Marco Elver <elver@google.com> wrote:
> > On Sat, 3 Apr 2021 at 07:13, Peter Collingbourne <pcc@google.com> wrote:
> > > If the memory region allocated by KFENCE had previously been poisoned,
> > > any validity checks done using kasan_byte_accessible() will fail. Fix
> > > it by unpoisoning the memory before using it as the pool region.
> > >
> > > Link: https://linux-review.googlesource.com/id/I0af99e9f1c25eaf7e1ec295836b5d148d76940c5
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> >
> > Thanks, at a high level this seems reasonable, because we always want
> > to ensure that KFENCE memory remains unpoisoned with KASAN on. FWIW I
> > subjected a config with KFENCE+KASAN (generic, SW_TAGS, and HW_TAGS)
> > to syzkaller testing and ran kfence_test:
> >
> >   Tested-by: Marco Elver <elver@google.com>
> >
> >
> > However, it is unclear to me under which circumstances we actually
> > need this, i.e. something would grab some memblock memory, somehow
> > poison it, and then release the memory back during early boot (note,
> > kfence_alloc_pool() is called before slab setup). If we can somehow
> > understand what actually did this, perhaps it'd help tell us if this
> > actually needs fixing in KFENCE or it's the other thing that needs a
> > fix.
> >
> > Given all this is happening during really early boot, I'd expect no or
> > very few calls to kasan_poison() until kfence_alloc_pool() is called.
> > We can probably debug it more by having kasan_poison() do a "if
> > (!__kfence_pool) dump_stack();" somewhere. Can you try this on the
> > system where you can repro the problem? I tried this just now on the
> > latest mainline kernel, and saw 0 calls until kfence_alloc_pool().
>
> I looked into the issue some more, and it turned out that the memory
> wasn't getting poisoned by kasan_poison() but rather by the calls to
> kasan_map_populate() in kasan_init_shadow(). Starting with the patch
> "kasan: initialize shadow to TAG_INVALID for SW_TAGS",
> KASAN_SHADOW_INIT is set to 0xFE rather than 0xFF, which caused the
> failure. The Android kernel branch for 5.10 (and the downstream kernel
> I was working with) already have this patch, but it isn't in the
> mainline kernel yet.
>
> Now that I understand the cause of the issue, I can reproduce it using
> the KFENCE unit tests on a db845c board, using both the Android 5.10
> and mainline branches if I cherry-pick that change. Here's an example
> crash from the unit tests (the failure was originally also observed
> from ksize in the downstream kernel):
>
> [   46.692195][  T175] BUG: KASAN: invalid-access in test_krealloc+0x1c4/0xf98
> [   46.699282][  T175] Read of size 1 at addr ffffff80e9e7b000 by task
> kunit_try_catch/175
> [   46.707400][  T175] Pointer tag: [ff], memory tag: [fe]
> [   46.712710][  T175]
> [   46.714955][  T175] CPU: 4 PID: 175 Comm: kunit_try_catch Tainted:
> G    B             5.12.0-rc5-mainline-09505-ga2ab5b26d445-dirty #1
> [   46.727193][  T175] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   46.733636][  T175] Call trace:
> [   46.736841][  T175]  dump_backtrace+0x0/0x2f8
> [   46.741295][  T175]  show_stack+0x2c/0x3c
> [   46.745388][  T175]  dump_stack+0x124/0x1bc
> [   46.749668][  T175]  print_address_description+0x7c/0x308
> [   46.755178][  T175]  __kasan_report+0x1a8/0x398
> [   46.759816][  T175]  kasan_report+0x50/0x7c
> [   46.764103][  T175]  __kasan_check_byte+0x3c/0x54
> [   46.768916][  T175]  ksize+0x4c/0x94
> [   46.772573][  T175]  test_krealloc+0x1c4/0xf98
> [   46.777108][  T175]  kunit_try_run_case+0x94/0x1c4
> [   46.781990][  T175]  kunit_generic_run_threadfn_adapter+0x30/0x44
> [   46.788196][  T175]  kthread+0x20c/0x234
> [   46.792213][  T175]  ret_from_fork+0x10/0x30
>
> Since "kasan: initialize shadow to TAG_INVALID for SW_TAGS" hasn't
> landed in mainline yet, it seems like we should insert this patch
> before that one rather than adding a Fixes: tag.

Thanks for getting to the bottom of it.

However, given the above, I think we need to explain this in the
commit message (which also makes the dependency between these 2
patches clear) and add a comment above the new kasan_unpoison_range().
That is, if we still think this is the right fix -- I'm not entirely
sure it is.

Because what I gather from "kasan: initialize shadow to TAG_INVALID
for SW_TAGS", is the requirement that "0xFF pointer tag is a match-all
tag, it doesn't matter what tag the accessed memory has".

While KFENCE memory is accessible through the slab API, and in this
case ksize() calling kasan_check_byte() leading to a failure, the
kasan_check_byte() call is part of the public KASAN API. Which means
that if some subsystem decides to memblock_alloc() some memory, and
wishes to use kasan_check_byte() on that memory but with an untagged
pointer, will get the same problem as KFENCE: with generic and HW_TAGS
mode everything is fine, but with SW_TAGS mode things break.

To me this indicates the fix is not with KFENCE, but should be in
mm/kasan/sw_tags.c:kasan_byte_accessible(), which should not load the
shadow when the pointer is untagged.

Thanks,
-- Marco
