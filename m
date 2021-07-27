Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084353D700F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhG0HLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhG0HLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:11:04 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E24C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:11:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so11579730ott.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4jXR1i3kQRbLOtYJPUwTyuXvag/F8LgWkncG8JS3kw=;
        b=ez4vH2iSyB0oa1ojnnUH/oppE2vInZw2DCUOsIJMczkkbCo0ZS4HOfnR+wwt08JB1/
         7q1jjUTru/9XpQaSTbBlRwAZtowDWooKcMqnfiEfIf1Dr8CKgwrQCM/qlxXAhd7KKXkf
         rU7MWbV7FnnRDNoOH5oR5N8n5zhUCreFiQaVQaR+w5K5l34zgfnqfD8MBJGoWoqZfyfM
         Nu7zTgE2WC5ZGRr6Pevcop7KacBGQyqippbdLEG86KFE9yVcfj4cdhkbsSXLb+YuJG6O
         AfhzUPokeRZQcTgonnXM/FDIkMgo7udEpWmVphlhnRQSPhM0vZsM21fHWLj//wG5unao
         Tukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4jXR1i3kQRbLOtYJPUwTyuXvag/F8LgWkncG8JS3kw=;
        b=sYsH9UMjVRfE76rAT4DyKpwh4LL6NTkAVHOHcoxclnm45/TCwMr7i5gNVQpavzhRmz
         luIxDkF0HEyh18FQytLLydSH0+c5X6kBRkuSH0SDmGiA9hBdadNJAZYwXCjgSgiTxMNg
         QQFtP6cngP7/ZtBpTzDgiishZ7Z3EaFNXPprVIKSEi3oog3Nw82ktLJ6JLI//Rl4W5vQ
         xq5kl2q8dV62N4iMPceETSBmKFvtGbfy3xxg9nvPVlx63iN+KZ8kcKtQzIHsRyuIlBci
         OeEDv7HTyeqK/y9H8ToI+rJcucFhrTQ3rYpnT8CkVSqgYfaU9TivcopNRSDpvv7tKMK4
         SBJg==
X-Gm-Message-State: AOAM531bUI27ljCkRv/PttSRriJ1xYonimg8b1x/HwOAakbrkDokI7EP
        ESw1hsN3smpo77RMNrWA1jqtStv+44BOr60EM5O89Q==
X-Google-Smtp-Source: ABdhPJzcx3FBzoI6gvI0bU/P3mLzZFisd8fyRX2ATyO+zv46x7mk7zcvY5u+dCccKFE1pqsqiD0miKrhnqQkq6ZE20Q=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr15077003oti.251.1627369862852;
 Tue, 27 Jul 2021 00:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com> <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Jul 2021 09:10:51 +0200
Message-ID: <CANpmjNM03Pag9OvBBVnWnSBePRxsT+BvZtBwrh_61Qzmvp+dvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan, mm: reset tag when access metadata
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Catalin

On Tue, 27 Jul 2021 at 06:00, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> Hardware tag-based KASAN doesn't use compiler instrumentation, we
> can not use kasan_disable_current() to ignore tag check.
>
> Thus, we need to reset tags when accessing metadata.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

This looks reasonable, but the patch title is not saying this is
kmemleak, nor does the description say what the problem is. What
problem did you encounter? Was it a false positive?

Perhaps this should have been "kmemleak, kasan: reset pointer tags to
avoid false positives" ?

> ---
>  mm/kmemleak.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 228a2fbe0657..73d46d16d575 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -290,7 +290,7 @@ static void hex_dump_object(struct seq_file *seq,
>         warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
>         kasan_disable_current();
>         warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
> -                            HEX_GROUP_SIZE, ptr, len, HEX_ASCII);
> +                            HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
>         kasan_enable_current();
>  }
>
> @@ -1171,7 +1171,7 @@ static bool update_checksum(struct kmemleak_object *object)
>
>         kasan_disable_current();
>         kcsan_disable_current();
> -       object->checksum = crc32(0, (void *)object->pointer, object->size);
> +       object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
>         kasan_enable_current();
>         kcsan_enable_current();
>
> @@ -1246,7 +1246,7 @@ static void scan_block(void *_start, void *_end,
>                         break;
>
>                 kasan_disable_current();
> -               pointer = *ptr;
> +               pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
>                 kasan_enable_current();
>
>                 untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210727040021.21371-2-Kuan-Ying.Lee%40mediatek.com.
