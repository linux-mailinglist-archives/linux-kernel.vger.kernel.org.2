Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C63AF236
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFURpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhFURpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:45:18 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:43:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso5616379otb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWdKmgG81sJBpjzyn6TSXwSeeJGUkRqGGWlo4fqoDn8=;
        b=CiXJ6n5GdF+RiiNqGBO8F/j8UT/qhrN72JVb6QaRtPts6IKnis1CFRapxq7H+wy4y1
         GWFo9rcHlHpgxkBuLl4FS+8nlfkbFdEK030ZBhpN6qPJyMdUafOT0hCU6NEZg+/cJrRf
         pfUzmq6g8hNiBVMMQmi5KfoIWhoTK5CYmbo4zeZ/tHEV5+AmXckA3wZ3WT3BZXuMYZhj
         NVF9LE5CuIVcXNVCX2rJkKM0UTagmKMDidAkcc234Ig0n0BY3qwZzxSC3tO838vQVzra
         HPm27NoxKSHr5adMk4M2O98++8T2eFSxAVl/o/Ma4PEiSFCcZeTUZXl2qx5wnX0IoVAk
         IjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWdKmgG81sJBpjzyn6TSXwSeeJGUkRqGGWlo4fqoDn8=;
        b=CTSPVmC0rcbyfIOM0z1iK2NNY9zyBLvn/Ag0EsjaKy2052/yqROyl6zvjDeJBZKemO
         SNsNw+WvXO+qgmlHKQnhaFJcTRrsoGab/mR1tgEm8XohZhcQDydVdfifHGw2TyNSbs0S
         cmj/KNDK60HCXKSRVFJnn0gwT/6+FQ0mi0ZbVp6nJcuHyOd8rs/ON8MEfu2i/RL9wbcq
         RK3nvL0ox6AtW0SlS2gCnIlr3hxCp6lp5KHrVlG27uzdY6D+mtD2ZK2SVGC+MAEQwJQ5
         ly43bcYOkW90OhlfiHFbkulevMyafyYkZqtqN2xc8st55XkDk6YEbIvFiCqfbNGx6vu8
         K6YQ==
X-Gm-Message-State: AOAM533N6D5JnMTTsGPmjg7wGoSjgqJSaSaxFWYep7FWHKaOTpdq8r0S
        jZGIQon5PWuNHOYFfPsJMUtxxjdObvmMVmQeYGIH9w==
X-Google-Smtp-Source: ABdhPJzVuQD0App46op5EoLAsOExo04ZFgTkfdf4n29jaNNRdc+/25Vd8YBFUCL3ENliNFYA0wncLG3zEOaXjjN0y5I=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr22053479oto.17.1624297381993;
 Mon, 21 Jun 2021 10:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210621154442.18463-1-yee.lee@mediatek.com>
In-Reply-To: <20210621154442.18463-1-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Jun 2021 19:42:50 +0200
Message-ID: <CANpmjNPYSVgmNU0gCobSb67WZ74-8s48LyN7N+sBtH15teVN3A@mail.gmail.com>
Subject: Re: [PATCH] kasan: unpoison use memset to init unaligned object size
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

On Mon, 21 Jun 2021 at 17:45, <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> This patch adds a memset to initialize object of unaligned size.

s/This patch adds/Add/

> Duing to the MTE granulrity, the integrated initialization using

s/Duing/Doing/
s/granulrity/granularity/

> hwtag instruction will force clearing out bytes in granular size,
> which may cause undesired effect, such as overwriting to the redzone
> of SLUB debug. In this patch, for the unaligned object size, function

Did you encounter a crash due to this? Was it only SLUB debug that
caused the problem?

Do you have data on what the percentage of allocations are that would
now be treated differently? E.g. what's the percentage of such
odd-sized allocations during a normal boot with SLUB debug off?

We need to know if this change would pessimize a non-debug kernel, and
if so, we'd have to make the below behave differently.

> uses memset to initailize context instead of the hwtag instruction.

s/initailize/initialize/

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

Should use memzero_explicit().

> +       }
>         size = round_up(size, KASAN_GRANULE_SIZE);
> -

Remove whitespace change.

>         hw_set_mem_tag_range((void *)addr, size, tag, init);
>  }

Thanks,
-- Marco
