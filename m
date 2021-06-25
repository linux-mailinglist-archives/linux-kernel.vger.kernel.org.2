Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D523B453B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFYOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhFYOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:06:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE43C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:03:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n2so4168509eju.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCBPWXjUtJqDX481tplGmByedXmi+6SSSYQlopDVlm8=;
        b=g2xI4G+YbXPOBweU0Dfhxgv8sAgTFjbLRxRY9HnhBIJ7t5750aZ2AnfPNLCZChITxz
         e9Yo/swOJ5U1cF9kBUv8dI/7589kD4AZiZBgJwj+exGZnoVksbjpyl7e0/BN5vAQfWv6
         /VXekcwiU8mYzSd1XvznpHZOiHKkHaZiSiQ+oCpAVQCWkYKQs79Xt0o7EPj4sXlIUNO3
         1WhKzAfHJucTboztqcpWrkg3AIrya5Bjw25wWjYqzOZSch6BNQkAuqg7m1wQhDCzFOTI
         V2Ulu0v2PpcsdfkXJBJ29grL9PL7XZ9xga6QgiyEoU5CU3O4wWbre7BvkL66xvJL9OiJ
         UNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCBPWXjUtJqDX481tplGmByedXmi+6SSSYQlopDVlm8=;
        b=n+ukTLneJxaIeVGC/O75n9lxNJZ4JK1cu07hqlR01RocEuhsTRX72BRYswQypPOJNF
         dUH2Yd/UgKchZ/ieREY/DulzuK46HEv6EpaeFJOdxB2Du7vAUZYeHrZVMWebm0llr5y1
         7+653Le1dXCdGAZXxhhSROHatTzc4SOIH76dpIeMFpe6YEFyGDBEL8Tv58MfGVZUa/bL
         QX1tIccq7a/tzQQQzN47ltp0C98nzyQB+ZEx0+8Jpg+wJKY6K7P5MFr9z8SangWeNw8W
         tIlCmGvbmeF/L3DiKE8ZSqMuzmPKvNzVYYM+IJkfprhWs3mxr+BI8ar8UT4Gb4zfQ0SB
         UKJw==
X-Gm-Message-State: AOAM5333oJUywMeC+uT1mBn7XMLHnswG53qK+Jp9cQbeLNoqwrq/lhEr
        o9KFi+/nhkCM+oxgW4p/eD6fVLO1IZq8Txx31AA=
X-Google-Smtp-Source: ABdhPJwRxAwp1s4YjTUqcX/AAdgKGNstFB5jd3lyos+3LPa3ijtjUuFxbmNzJUzvo6qSGiT+GSa9ZkA6wg579vc/N0Q=
X-Received: by 2002:a17:906:6d16:: with SMTP id m22mr11315367ejr.333.1624629824272;
 Fri, 25 Jun 2021 07:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210624112624.31215-1-yee.lee@mediatek.com> <20210624112624.31215-2-yee.lee@mediatek.com>
In-Reply-To: <20210624112624.31215-2-yee.lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 25 Jun 2021 17:03:21 +0300
Message-ID: <CA+fCnZe0fng4-53U1=5MiYszCMi97twKut3eQNaNHgPV2HOVug@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kasan: Add memzero init for unaligned size under
 SLUB debug
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
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 2:26 PM <yee.lee@mediatek.com> wrote:
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

Is this an issue only with SLUB? SLAB also uses redzones.

> +       if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {

This needs a comment along the lines of:

/* Explicitly initialize the memory with the precise object size to
avoid overwriting the SLAB redzone. This disables initialization in
the arch code and may thus lead to performance penalty. The penalty is
accepted since SLAB redzones aren't enabled in production builds. */

> +               init = false;
> +               memzero_explicit((void *)addr, size);
> +       }
> +#endif
>         size = round_up(size, KASAN_GRANULE_SIZE);
>
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
> --
> 2.18.0
>
