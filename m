Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D23B066E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFVOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhFVOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:06:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5967C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:04:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c7so22892645edn.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPbarU+l9m1KwGWUNyzhJZ595uUBAZXAe0wQ6HeHGxQ=;
        b=fZ5quJ/GoR3vzQSaVgMyRterjrZrpqo9hDF73so2ArtYbScuKnpfg7SJpZLlOeJRP3
         gHIrQh6r2s7lxRe0jZfBM3LGiife/yusjkB2dfeDAKLJDltmFw71IvK22ZM2yulR8Gqt
         lUbJlqPikmDnu9MU6YfZERpi/kGM8dteQcDU4iAYgqoxjNX4cNxG8I0Z9GkAt4LvZnRT
         1bdwtlbpmVBitmLQKdNwsM9mNUJ9uQf5FTai6gabf9yOPNikyYwD+FpS62jc9QvPwLbA
         smcPdUZucZZvzUBhYSMb27+LXgIv+ehd09ATJAp5W2ztoZDoWKXMu8WjiHQ1s3W7OOQu
         /WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPbarU+l9m1KwGWUNyzhJZ595uUBAZXAe0wQ6HeHGxQ=;
        b=DFojduuH6DeeUsq1s4FrhWwSxs8Kv/qJ7e9rJIpyj0/O0HZVjl9pBsMxex0IcI0Ans
         f2HbAtUFPDnWyxis8TrHggV7GvxMhdfcvQaOMv7vWoDH0sFlIedK7/NXwWAVnqSLML8P
         7HyBlgZLeX5wf3mYMZ69NqDUy7ZotD+bf0XjJ3wNyJ2ZK3TdMaCW8n3qAp5V5V26ZviJ
         1EKv7eyFVXjid9fpprKnGgiNy0YTbd5RLRy0q/2gNpUyTxufIA/fa/8AKHrtyOIFg4X5
         AWH6tBEmyC2aE77eGLaHleYELRgdewj4ZPpS8XgnMTBWTNuqN1SaNsaQYg9sLa6XmDui
         8omQ==
X-Gm-Message-State: AOAM533nvQb6Xi805vw4qB2Mi1D5porhjK38LjBjvNu0GGdjAnsJk3fp
        vZ4lqDT0JIjur0yWXZX2V0BiexmRSB0iLM3OZE8=
X-Google-Smtp-Source: ABdhPJyy8TmTF93FpLorqiyKQWA81gkRh7uJHO1hw4kf4OWfe0s6Kp5ze7cRnhKGAvUyoA9bAQOE4/Bt8SXdzX+GsFI=
X-Received: by 2002:a50:fd83:: with SMTP id o3mr5199829edt.95.1624370642532;
 Tue, 22 Jun 2021 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210621154442.18463-1-yee.lee@mediatek.com>
In-Reply-To: <20210621154442.18463-1-yee.lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Jun 2021 17:03:42 +0300
Message-ID: <CA+fCnZdPwKZ9GfhTYPpWGVEO7bS6sSrh8cioZmRJet2maUjSVQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: unpoison use memset to init unaligned object size
To:     yee.lee@mediatek.com
Cc:     wsd_upstream@mediatek.com,
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
        <linux-mediatek@lists.infradead.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 6:45 PM <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> This patch adds a memset to initialize object of unaligned size.
> Duing to the MTE granulrity, the integrated initialization using
> hwtag instruction will force clearing out bytes in granular size,
> which may cause undesired effect, such as overwriting to the redzone
> of SLUB debug. In this patch, for the unaligned object size, function
> uses memset to initailize context instead of the hwtag instruction.
>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  mm/kasan/kasan.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..d8faa64614b7 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -387,8 +387,11 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
>
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
> +       if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> +               init = false;
> +               memset((void *)addr, 0, size);
> +       }

With this implementation, we loose the benefit of setting tags and
initializing memory with the same instructions.

Perhaps a better implementation would be to call
hw_set_mem_tag_range() with the size rounded down, and then separately
deal with the leftover memory.

>         size = round_up(size, KASAN_GRANULE_SIZE);
> -
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
>  }
>
> --
> 2.18.0
>
