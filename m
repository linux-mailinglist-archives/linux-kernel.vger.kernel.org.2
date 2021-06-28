Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731BB3B58E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhF1GDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhF1GDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:03:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA665C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:01:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 11so12624691oid.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eoMbUJoUpBqjeLK9yBay7/GW88cz7V1P5CryiYnRUc=;
        b=J8O8csduHCymdY8XfO0RVZLJRr4hRLUgwxNepl6Atq+rB0+W5XLcelj4QYEBXC1n9d
         GF0w2QcynCMaGY+VzxfLV4K8Uu/SqweIeov3c3s9iHIyee7wiZ0WDSJrpYUax6SDiQg+
         kLj+6ijATACxk6+1ulRD0hZL3G5VwYOGVQ07Mh19QqyolZpf/QwRj9FwW2cyqc+K2Nu9
         7x9TPZtuoivyd/9GsmW3q5uCut1l8StFHe5oHgix4JKmZsnOsFBaWIzkFccKukwiGi8U
         GNrLydbyjRXaBaIgo5GzNDp7lSxj2245oVXqbgmyNlXAq5qO7Zy+MUz7S3JbLdic6Vp7
         065Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eoMbUJoUpBqjeLK9yBay7/GW88cz7V1P5CryiYnRUc=;
        b=EDIW5vUGgRLK2pmS1Kc89jDc7cjmayMuW0JRM8gfuzOwkVjc/sWgA7kzCf0KUIMFBb
         qqV0s8zheikW5i1KxwzlzCCHbgmgNCdfoS/BnFUsAgRNjzUz2+eWcYfWvkrv7rFJKk80
         TiPioyGZiGKjeEE9Bq9fz37a6XnNg4P881L0AiCYW0bdE3Rxi7iwGdTMM1VYXfFnyrvx
         27ckAtL0bcsOo0crdy72Ks8aeABGjEgGjBsdhiquIZpehrtOy0lSiKPOycLDJeXnMyU8
         NnZzHL9T/BfJW32PQX2xnGlGWLnUoxb38vdDECjV1bIog7PE68D5Am0pCiX10Z/BqMqa
         uvhQ==
X-Gm-Message-State: AOAM530q5pXZLWeebNeGD/XdW2g5azwCRk0Qa/l5ugAcPeRCXvm5+wk0
        cR1p/XOh+aNhEpdMhEZwwX9mgvF0K1OyDGmEYrUTpg==
X-Google-Smtp-Source: ABdhPJzsU3jCobviaf98Fdqeq3OWjtnCAdAy7cMWzNILO5gKNRlbIaIlW8OeNQH7gdmWmGmtmuZWOcB52mJfeobr3Cs=
X-Received: by 2002:aca:ba06:: with SMTP id k6mr16233354oif.70.1624860084112;
 Sun, 27 Jun 2021 23:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com> <20210626100931.22794-4-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210626100931.22794-4-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Jun 2021 08:00:00 +0200
Message-ID: <CANpmjNMyHQuUF1KwGj7cMgWVL-TifC52uZu54GgtS9SziyuXdg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] kasan: add memory corruption identification
 support for hardware tag-based mode
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 at 12:09, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> Add memory corruption identification support for hardware tag-based
> mode. We store one old free pointer tag and free backtrace instead
> of five because hardware tag-based kasan only has 16 different tags.
>
> If we store as many stacks as SW tag-based kasan does(5 stacks),
> there is high probability to find the same tag in the stacks when
> out-of-bound issues happened and we will mistake out-of-bound
> issue for use-after-free.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/Kconfig.kasan | 2 +-
>  mm/kasan/kasan.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdb4a08dba83..1e2d10f86011 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -169,7 +169,7 @@ config KASAN_STACK
>
>  config KASAN_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
> -       depends on KASAN_SW_TAGS
> +       depends on KASAN_SW_TAGS || KASAN_HW_TAGS
>         help
>           This option enables best-effort identification of bug type
>           (use-after-free or out-of-bounds) at the cost of increased
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 952df2db7fdd..f58672f6029a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,7 +153,7 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
> --
> 2.18.0
