Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605C93B68A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhF1Sog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhF1Sod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:44:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:42:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k206so4212174oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGZGjPN7zJUyktr/g4knlZGNk67FduIZ8wWgBMyrHK8=;
        b=vfK499WWN0RN0+aNfv40Ss48p8O7oyXyekRGgjGLgvESsOLtJsfv/nTxXucuXl/5+j
         5xmsS3V52nf3qx3GjTm9KWyAo17IpbR1SSSXQ12oFpJBA1Cn/7ZbzGw8g/Uv1zKFmiFw
         ssBnRiGSw7gNhHGAVXqnqYfFboORp62t7dKkygt8wHzENgoYpGVvu5HF+A7aeBEWPrUX
         mZKia3FgocxKXGiclhYu6DTlDUQWj0IFQo2jz0zO77yeW+qvpmTClekIbW/QKHfHQ/VV
         zaD+2UCc15DFyNuquakS2AgKuzVQtx/mkQcKSdmaTkDa/s/jIPOPANa7XnRSWWV7sTC0
         x8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGZGjPN7zJUyktr/g4knlZGNk67FduIZ8wWgBMyrHK8=;
        b=eypNd4cS8UGdExZ4lRPGyf9/SVbOsVxq9PLuZgAgxySDtBWdo241syCtnxhk6WRleD
         zrNUM7saWFnzd5eismYEGI/u0BI2FRNVln3Lq9YfrQrdUYlsq6gC9xFOREfCIqSBRo7+
         FgIerc3d9MmPUEsQ6xvRfVpEM2RK/Q1bjD6lLdEFcGVfcqlcYfvSyosyC35p4d+At+GS
         mMpmmXfIxVPmmxywtp01lX2wj+T0B97allZru2+ZPYvzPlz2zAOHERjkfy8/9JeLL3Hb
         jG4I8nqRutqDDNDGtxEXvuUKb2mmy9VPClP3hmcAo9+xebf38hViBRkJDgNAbGQQkrkQ
         WXyw==
X-Gm-Message-State: AOAM533MSh60+ltLH4RhsGXU+yzJrGffq292bOa728iY2FIE8GURBtFr
        Wj6qBRWrXxAq854/oXgMyLZAW0Ct5JG9Jvikt+86dQ==
X-Google-Smtp-Source: ABdhPJwXH+qlDq1Ccbwh0SDU8S40lYUQh7EdnnpUvf36P4mj6in5L6ehZiQWwGjkfwAvK3KRSkAJC4PBV3oNg6meIK8=
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr6642152oij.121.1624905726971;
 Mon, 28 Jun 2021 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210624112624.31215-1-yee.lee@mediatek.com> <20210624112624.31215-2-yee.lee@mediatek.com>
In-Reply-To: <20210624112624.31215-2-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Jun 2021 20:41:55 +0200
Message-ID: <CANpmjNPSh4NephPOm08H_etX_FbDAebowE4rW3VJK_Fgb9auHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kasan: Add memzero init for unaligned size under
 SLUB debug
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

On Thu, 24 Jun 2021 at 13:27, <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> Issue: when SLUB debug is on, hwtag kasan_unpoison() would overwrite
> the redzone of object with unaligned size.
>
> An additional memzero_explicit() path is added to replacing init by
> hwtag instruction for those unaligned size at SLUB debug mode.
>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  mm/kasan/kasan.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..d1054f35838f 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -387,6 +387,12 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
>
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
> +#if IS_ENABLED(CONFIG_SLUB_DEBUG)

Avoid the #if. I think none of the stuff referenced here is only
available if CONFIG_SLUB_DEBUG. In that case, please just write:

if (IS_ENABLED(CONFIG_SLUB_DEBUG) && init && .........) {

The compiler will correctly optimize out the branch if the config
option is not enabled. But the benefit is we compile-test this code
with all configs.

> +       if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> +               init = false;
> +               memzero_explicit((void *)addr, size);
> +       }
> +#endif

Thanks,
-- Marco
