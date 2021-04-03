Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B30353585
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhDCUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhDCUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 16:40:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB24C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 13:40:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z136so8458409iof.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HC30Rj8ifwDBRABz3lITE7mW/dkra4pLBJwwtutOkI=;
        b=tcVmHAa7SH1b1VBI6CzuInfKn47/sPo9VqybZJp/Ma45DcYm8Xz84l3Nk3DxC9PpfL
         GpH1OzTLg57H6Znm80P9ChSX/4O7Pt5urIJuvdsEPROtv/+izG4/7ZdRzuuPemVGSlDo
         KsHPD6mWLXVqmLmpUD3Nyx6a5Y0pF4fDgV6h0F6WCkY4q+BpXzl2Y6pcokUEefZr66On
         gmdxLtY14r9A/AfVh7gMeN7+eO3MicKyzZSr2G6Q8ogmAmUJwKmo+Tul+Wb2Ydk1YKgc
         5YqSAjzYyuYWq/029VbDJtTt0dvV0r7zRaZJuXKfvJaRkS8JxyEEwT7oJ/JBv3WbYfPM
         t+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HC30Rj8ifwDBRABz3lITE7mW/dkra4pLBJwwtutOkI=;
        b=aTLM3tc7rGxaAibu7vD+HChNLoefgMJGOsitahFnwFiUF2ZSsxoQtL6Nw8wVppjpIH
         hbdFcskTy63tM/zCmyh1QvOaMfCV1WN5sp4oSgU8eYFS4FKbOCMDccb9nIdhS8oaqCQu
         shU4+JVeTOZav0wigFC87hYVFT69U/4WqoKZXg+DQQZKmVF3nRM+9Hw9T8IQhu+J7x86
         GfnUmSuHgY+a6og4SijAL/ClgbhTRYERZjag+wWY5qPumGfZjrNCcHwSXScEpdUZkLit
         a6hqKPxIs2dQQi86Um9Kp4sWs9tvSNwiLaNMGi+8xLiUS2PIvaQ+/rB0C64szhynY312
         HDJg==
X-Gm-Message-State: AOAM532VaBKz5KvpHZNGjbHVA0bvsFNgFb1TpZJJ1KYnbwZgurikKfDR
        NQtmlt+5s027R1mMdzYQRuO8ISC0pKE79cBrNgVfWg==
X-Google-Smtp-Source: ABdhPJwUtiG/axUocvdwW1yHt6nZ3+SDSbLk1W8dg0rN9ZW2ii/D5EVIUPtI4SYoJseLa9PFMO8r1MiaRy2oqw6Zhzo=
X-Received: by 2002:a05:6602:1353:: with SMTP id i19mr15343857iov.202.1617482434702;
 Sat, 03 Apr 2021 13:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
In-Reply-To: <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Sat, 3 Apr 2021 13:40:23 -0700
Message-ID: <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Marco Elver <elver@google.com>
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

On Sat, Apr 3, 2021 at 3:03 AM Marco Elver <elver@google.com> wrote:
>
> On Sat, 3 Apr 2021 at 07:13, Peter Collingbourne <pcc@google.com> wrote:
> > If the memory region allocated by KFENCE had previously been poisoned,
> > any validity checks done using kasan_byte_accessible() will fail. Fix
> > it by unpoisoning the memory before using it as the pool region.
> >
> > Link: https://linux-review.googlesource.com/id/I0af99e9f1c25eaf7e1ec295836b5d148d76940c5
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
>
> Thanks, at a high level this seems reasonable, because we always want
> to ensure that KFENCE memory remains unpoisoned with KASAN on. FWIW I
> subjected a config with KFENCE+KASAN (generic, SW_TAGS, and HW_TAGS)
> to syzkaller testing and ran kfence_test:
>
>   Tested-by: Marco Elver <elver@google.com>
>
>
> However, it is unclear to me under which circumstances we actually
> need this, i.e. something would grab some memblock memory, somehow
> poison it, and then release the memory back during early boot (note,
> kfence_alloc_pool() is called before slab setup). If we can somehow
> understand what actually did this, perhaps it'd help tell us if this
> actually needs fixing in KFENCE or it's the other thing that needs a
> fix.
>
> Given all this is happening during really early boot, I'd expect no or
> very few calls to kasan_poison() until kfence_alloc_pool() is called.
> We can probably debug it more by having kasan_poison() do a "if
> (!__kfence_pool) dump_stack();" somewhere. Can you try this on the
> system where you can repro the problem? I tried this just now on the
> latest mainline kernel, and saw 0 calls until kfence_alloc_pool().

I looked into the issue some more, and it turned out that the memory
wasn't getting poisoned by kasan_poison() but rather by the calls to
kasan_map_populate() in kasan_init_shadow(). Starting with the patch
"kasan: initialize shadow to TAG_INVALID for SW_TAGS",
KASAN_SHADOW_INIT is set to 0xFE rather than 0xFF, which caused the
failure. The Android kernel branch for 5.10 (and the downstream kernel
I was working with) already have this patch, but it isn't in the
mainline kernel yet.

Now that I understand the cause of the issue, I can reproduce it using
the KFENCE unit tests on a db845c board, using both the Android 5.10
and mainline branches if I cherry-pick that change. Here's an example
crash from the unit tests (the failure was originally also observed
from ksize in the downstream kernel):

[   46.692195][  T175] BUG: KASAN: invalid-access in test_krealloc+0x1c4/0xf98
[   46.699282][  T175] Read of size 1 at addr ffffff80e9e7b000 by task
kunit_try_catch/175
[   46.707400][  T175] Pointer tag: [ff], memory tag: [fe]
[   46.712710][  T175]
[   46.714955][  T175] CPU: 4 PID: 175 Comm: kunit_try_catch Tainted:
G    B             5.12.0-rc5-mainline-09505-ga2ab5b26d445-dirty #1
[   46.727193][  T175] Hardware name: Thundercomm Dragonboard 845c (DT)
[   46.733636][  T175] Call trace:
[   46.736841][  T175]  dump_backtrace+0x0/0x2f8
[   46.741295][  T175]  show_stack+0x2c/0x3c
[   46.745388][  T175]  dump_stack+0x124/0x1bc
[   46.749668][  T175]  print_address_description+0x7c/0x308
[   46.755178][  T175]  __kasan_report+0x1a8/0x398
[   46.759816][  T175]  kasan_report+0x50/0x7c
[   46.764103][  T175]  __kasan_check_byte+0x3c/0x54
[   46.768916][  T175]  ksize+0x4c/0x94
[   46.772573][  T175]  test_krealloc+0x1c4/0xf98
[   46.777108][  T175]  kunit_try_run_case+0x94/0x1c4
[   46.781990][  T175]  kunit_generic_run_threadfn_adapter+0x30/0x44
[   46.788196][  T175]  kthread+0x20c/0x234
[   46.792213][  T175]  ret_from_fork+0x10/0x30

Since "kasan: initialize shadow to TAG_INVALID for SW_TAGS" hasn't
landed in mainline yet, it seems like we should insert this patch
before that one rather than adding a Fixes: tag.

Peter
