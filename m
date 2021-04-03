Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DA353358
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhDCKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhDCKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:03:36 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C901C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 03:03:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6982362otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzznQH22yWtsRp0zpmbNBDOhjWliTmLsMaUUCDRZqWU=;
        b=WsTuNkJiHYcunUHGy+BKwjRs4cQUzngNneyv1SE4xitILHumSeFd48R4Bz7uuG7kFz
         DqxlJADmyBJBgt1ShL1HFTGJVotJm5LG/VeDlNbJbuPAolpb3XPPNjhF477Rrcet7S6W
         Ve8YVhoPyX6JIEuoGQUyQVlhiz4UVrM7FpS8poNuuMexsAKOdQ6jzJFwypHag/eSLTtI
         A7Mtmt3H+Lu5yWU6HtGNUIqFd40t1GiJG6VhPJUGEEOPo0TQQZpaHGPJUwkvO3wN9U0i
         50dmzUNDoH2rIoTRkfZkV0AkY/rVcZvDY4a8iUQPvA14oapHOytndQHkUKqXCLvxhmP9
         DSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzznQH22yWtsRp0zpmbNBDOhjWliTmLsMaUUCDRZqWU=;
        b=BupH8aqxS1gbToRKzPK2Q8Le98/P9A3dPHyY4D7Bur/bWukj/K1L/ddOU/XEhRfN/v
         im5HwtulUsMLPTlf69+7wJNpJalUaVineXzSPbSmz5Oi1e0VJ5N6iGzNSiDpfBZuxKER
         0kusWhdBee+j5dWdVgpaX/4we2tbCzZLLLHRoHAIrOJltc7dg5qtqmZ+7o+cDqhC6FFV
         Dg83sbzI+2nIpq2I3ehTtoi+JNSxsWCzt/P1xQSS2PQvtn7t3UaaeFg2MAWUJ5UEEscB
         JcALAy+15km42F06k2tcMxhDiaXBwBB+3vCHU2XSoXv3kocL3hPQqmzsQDm3Fd06MKPH
         4eDw==
X-Gm-Message-State: AOAM533RH/1yd3P5zp10/+VtJEYIdu9+IRpw/It9pHeaLd2YalqDgl0x
        YgS9V1VrX+oIvIf5tnwXBXiTNUtF4FJ8PAKosWOExQ==
X-Google-Smtp-Source: ABdhPJy9nRdJ1mOeryQNUqr84sASHWKsEkAqJ7k0iPlWW2IpEfJl7corCGDkV20S9TIdZ5xk8CMxWRvPS9Qhi0IiFiE=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr15142475otq.251.1617444211171;
 Sat, 03 Apr 2021 03:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com>
In-Reply-To: <20210403051325.683071-1-pcc@google.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 3 Apr 2021 12:03:19 +0200
Message-ID: <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
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

On Sat, 3 Apr 2021 at 07:13, Peter Collingbourne <pcc@google.com> wrote:
> If the memory region allocated by KFENCE had previously been poisoned,
> any validity checks done using kasan_byte_accessible() will fail. Fix
> it by unpoisoning the memory before using it as the pool region.
>
> Link: https://linux-review.googlesource.com/id/I0af99e9f1c25eaf7e1ec295836b5d148d76940c5
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Thanks, at a high level this seems reasonable, because we always want
to ensure that KFENCE memory remains unpoisoned with KASAN on. FWIW I
subjected a config with KFENCE+KASAN (generic, SW_TAGS, and HW_TAGS)
to syzkaller testing and ran kfence_test:

  Tested-by: Marco Elver <elver@google.com>


However, it is unclear to me under which circumstances we actually
need this, i.e. something would grab some memblock memory, somehow
poison it, and then release the memory back during early boot (note,
kfence_alloc_pool() is called before slab setup). If we can somehow
understand what actually did this, perhaps it'd help tell us if this
actually needs fixing in KFENCE or it's the other thing that needs a
fix.

Given all this is happening during really early boot, I'd expect no or
very few calls to kasan_poison() until kfence_alloc_pool() is called.
We can probably debug it more by having kasan_poison() do a "if
(!__kfence_pool) dump_stack();" somewhere. Can you try this on the
system where you can repro the problem? I tried this just now on the
latest mainline kernel, and saw 0 calls until kfence_alloc_pool().

Thanks,
-- Marco

> ---
>  mm/kfence/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index d53c91f881a4..bb22b0cf77aa 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -633,13 +633,19 @@ static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
>
>  void __init kfence_alloc_pool(void)
>  {
> +       void *pool;
> +
>         if (!kfence_sample_interval)
>                 return;
>
> -       __kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> -
> -       if (!__kfence_pool)
> +       pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> +       if (!pool) {
>                 pr_err("failed to allocate pool\n");
> +               return;
> +       }
> +
> +       kasan_unpoison_range(pool, KFENCE_POOL_SIZE);
> +       __kfence_pool = pool;
>  }
>
>  void __init kfence_init(void)
> --
> 2.31.0.208.g409f899ff0-goog
>
