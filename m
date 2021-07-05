Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDA3BB99F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhGEIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGEIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:53:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15FFC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 01:50:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso11392136pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvrjfH1l3R1Ny9FwdhcW/69zM1+NBkCbF2wgXmSb3LI=;
        b=qJEV7ygJ2Rr9BGE7vIYAqeyKleB50VSm0HUS/QeMwZMrj4bmPFM/G+8yNd6XbvboUx
         iz5v8lY/b9ZI/Z6T/CfmZouo/4R5MuLgXVJQ0ipqj/8j/sALIM3ddicZlXLxeJIZblYP
         Q1vfnc0MZoeXoHB/nzThc+knJBtkYfsAdufJiIgYAtIXzs5IyJFxblXOjvI/LK6Ti+vQ
         bRAbtkhhv3PnntqB/Y7FQ/vY3vLgrteJHjZShOMo8W8mveST5bi+aPRLyC8Olhj8fDQx
         +V71N+BLPH7Na3YFdk8V30HBS2fRkPSmjLAx7ieRaEX9RHwABQZJhE2ZfoQ7Acxc3FtH
         zQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvrjfH1l3R1Ny9FwdhcW/69zM1+NBkCbF2wgXmSb3LI=;
        b=dXeFFgQdA3bBRZp22U4OjAg3OpTk1Q25uzSsFbCqDqbUWYkKw1Bh1RWZnaX3BZDULX
         Ezcp6twBmYr0FGx5/osKBx3KilXZ4RM56Jg0cO37kb/CBNOoOxThyJHBd5GGE/AeFy/V
         Ts2oaqGVtm73ZKTUgGVUEpu2OLFL377Pvru6apF/ppU7xEdANv4UDb8amWIxQGuRxETN
         NwLNqSsnPOjOPmC5MZmr3ewd7YRNgzf6NrX9wS7V+y6xT+sa1Wi5nyRRh/s3O6/0H0EG
         u4sXVt1gurEWvlCjtBwHChuacfewv6S44E5DMZNW4RceypWR5rPfwdQKt5ruVUsG6ODW
         qTdQ==
X-Gm-Message-State: AOAM530cToWxnoru9a1Ap64ZxYg5Pzb3SurFuxdytyXEGTyvmEY0k07c
        maezLpkuK+d4SaItsnrGEIcf22dz6a5P3TkbBVg=
X-Google-Smtp-Source: ABdhPJy3zChhJxUZY+QjM9YwE4sziAHHpMOu4pQtCOFZihCMThvZJMy3zPSyq7usy8cXj4ry6TWkFrFbhh4IrsOu/kE=
X-Received: by 2002:a17:902:e9c5:b029:128:d5ea:7ef5 with SMTP id
 5-20020a170902e9c5b0290128d5ea7ef5mr11777932plk.21.1625475034406; Mon, 05 Jul
 2021 01:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210705072716.2125074-1-elver@google.com>
In-Reply-To: <20210705072716.2125074-1-elver@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jul 2021 11:49:58 +0300
Message-ID: <CAHp75VeRosmsAdCD7W7o9upb+G-de-rwhjCnPtTra2FToEmytg@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix build by including kernel.h
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, pcc@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 10:28 AM Marco Elver <elver@google.com> wrote:
>
> The <linux/kasan.h> header relies on _RET_IP_ being defined, and had
> been receiving that definition via inclusion of bug.h which includes
> kernel.h. However, since f39650de687e that is no longer the case and get
> the following build error when building CONFIG_KASAN_HW_TAGS on arm64:
>
>   In file included from arch/arm64/mm/kasan_init.c:10:
>   ./include/linux/kasan.h: In function 'kasan_slab_free':
>   ./include/linux/kasan.h:230:39: error: '_RET_IP_' undeclared (first use in this function)
>     230 |   return __kasan_slab_free(s, object, _RET_IP_, init);
>
> Fix it by including kernel.h from kasan.h.

...which I would like to avoid in the long term, but for now it's
probably the best quick fix, otherwise it will require the real split
of _RET_IP or at least rethinking its location.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.org>
Thanks!

> Fixes: f39650de687e ("kernel.h: split out panic and oops helpers")

P.S. I have tested the initial patch against full build of x86_64, and
it was long time available for different CIs/build bots, none
complained so far.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kasan.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5310e217bd74..dd874a1ee862 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_KASAN_H
>
>  #include <linux/bug.h>
> +#include <linux/kernel.h>
>  #include <linux/static_key.h>
>  #include <linux/types.h>
>
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
With Best Regards,
Andy Shevchenko
