Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615773AFFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFVJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVJDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:03:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B26C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:01:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20596376otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3vujFtQzQ6HHb36nCRkPnI6sILbeapGxmxAb4EfnkI=;
        b=CB752prxx4dAwLiJh978X4UEniRLciLoj78ygr06BhzO9Zg7gd4UEFbVgZXdlVMHDt
         p2vaKWQ1OJcHnvkvP5Tu45vm8+XZy0OhLLxui1fAfHsP5/d4JeU6Idj+wyDXEF93AVl6
         SUMEwVJYMziAOsHVQ9vDsGCZHT873ntwOguGUK2ALiLzW6WBKUyUDKWOrMmyiu0C17s5
         RP8HZEa2qe1olyrZy6gNVC1IJ3jJ58ILo6TsaqFcAlBXYK6PmUJPOyIpNV8Jpwvgvlut
         xYAdLL+t/fKOXk9CaBN/ZTnLpMInTCxfXCSoqiVG3oc34ZJ6Q5DFL97vyZEHdqRQCBpJ
         kOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3vujFtQzQ6HHb36nCRkPnI6sILbeapGxmxAb4EfnkI=;
        b=l/26PRj2m9M3EgKJbTzbeENqvTeNM5DUXsV0uQ9JtGl+9mgs24s16viHn5uGeym3X3
         nKq2EgA9pSMWo40tHxtEnkQAIusAwkIOhsBwXMmo4iZ4yWFnv16dB3Nr6uRfMmDnyOTx
         JMHWevFAS3k67RNCXo7osfmtTe0BwCW2+8OYxSgBce2+6p0EAqwLg3K9+ZcQ5CYBJJmw
         /9Hmd7VmBMNe6tnJy6o7ukLeFqPiMV8hzEYPtoe+0F+6F5dp5SDoxI4RUYVBe/ZRnxBt
         3s6CD6ldNQrD7poLK3bECYflmqYwPXWWsLMNlM9YP+pPgJC1XjoHpPjfn8qE1wfriziE
         7sUg==
X-Gm-Message-State: AOAM532jBSV3vb8n9SAhqnUQ39nnSUH3sbUtb2F4i17aqyMmrPSph8MC
        dbhXBObAW5I9Bm13qzAQ7G47DFZEUMwB0coqwaaNJw==
X-Google-Smtp-Source: ABdhPJz6x9ikQTihlpl50ySejohRlYsuuYzk1020DWbzWFDGxvVI6FgPvghPiE/lufEm9zK+hYyHAKWDluvyY14hCZw=
X-Received: by 2002:a05:6830:1bcb:: with SMTP id v11mr2292496ota.251.1624352492722;
 Tue, 22 Jun 2021 02:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210622084723.27637-1-yee.lee@mediatek.com>
In-Reply-To: <20210622084723.27637-1-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Jun 2021 11:01:21 +0200
Message-ID: <CANpmjNPyP2-oULXuO9ZdC=yj_XSiC2TWKNBp0RL_h3k-XvpFsA@mail.gmail.com>
Subject: Re: [PATCH] kasan: [v2]unpoison use memzero to init unaligned object
To:     yee.lee@mediatek.com
Cc:     andreyknvl@gmail.com, wsd_upstream@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 at 10:48, <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> Follows the discussion: https://patchwork.kernel.org/project/linux-mediatek/list/?series=504439

The info about the percentage of how frequent this is could have been
provided as a simple reply to the discussion.

> This patch Add memzero_explict to initialize unaligned object.

This patch does not apply to anything (I see it depends on the previous patch).

What you need to do is modify the original patch, and then send a
[PATCH v2] (git helps with that by passing --reroll-count or -v) that
applies cleanly to your base kernel tree.

The commit message will usually end with '---' and then briefly denote
what changed since the last version.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

> Based on the integrateion of initialization in kasan_unpoison(). The hwtag instructions, constrained with its granularity, has to overwrite the data btyes in unaligned objects. This would cause issue when it works with SLUB debug redzoning.
>
> In this patch, an additional initalizaing path is added for the unaligned objects. It contains memzero_explict() to clear out the data and disables its init flag for the following hwtag actions.
>
> In lab test, this path is executed about 1.1%(941/80854) within the overall kasan_unpoison during a non-debug booting process.

Nice, thanks for the data. If it is somehow doable, however, I'd still
recommend to additionally guard the new code path by a check if
debug-support was requested. Ideally with an IS_ENABLED() config check
so that if it's a production kernel the branch is simply optimized out
by the compiler.

> Lab test: QEMU5.2 (+mte) / linux kernel 5.13-rc7
>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  mm/kasan/kasan.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d8faa64614b7..edc11bcc3ff3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -389,7 +389,7 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
>                 return;
>         if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
>                 init = false;
> -               memset((void *)addr, 0, size);
> +               memzero_explicit((void *)addr, size);
>         }
>         size = round_up(size, KASAN_GRANULE_SIZE);
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210622084723.27637-1-yee.lee%40mediatek.com.
