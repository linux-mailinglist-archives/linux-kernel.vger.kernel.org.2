Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7963ACA89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhFRMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhFRMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:05:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:03:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j62so10246596qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS3omeOppyoShd1+LwrhmXqufv0Lv657lMEmOyaYMYw=;
        b=Gb36UT4iH8mrlI9grJsKcZc/6dVSCOhopbItrzJzkGDG4s2ViSK6ACPCaNiqfdqkr5
         HC5mPohZzo+oDK0ll4HXl/ANn4FMqgbGZRDTtzDK7E9nS01pkQh0mPiGuW9YRXGw6xvc
         yfuQheWzKELjxip6d2MHYymQOp0pD1K8UJEcmGHd6Ttk2jeaRscoDYk7/mSbFQQDZ7v1
         uVhgAkjx/Qe5xVT0A1jsn34L8DOFMtIapGd3TLcDlxSPFForVq1BkRYm9NjNnQ1PcACn
         PpNj6AlCXFm/o2vfe4DqLu6mNzIiMKUS2KvUnRzTSCCX0di7tZfd3QjkgeWhazjKHqeu
         9HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS3omeOppyoShd1+LwrhmXqufv0Lv657lMEmOyaYMYw=;
        b=Oi6fRNDV9q0+ibUYD3ojY5ZDyRMK5CJyZhsWjCtXe7RMFItu1tNCuK+/Ao80z83+mk
         +am0+S9od090KfK2VOrHtMz68YSDU2FemXlx+QBK8Gqsx6vHxD6iv8UNmyH1KgLOhSmh
         igKE4DREQ7wi+UVY07HY7A87vkV9uHH3XzHuj/ulNFrfywH3Sn9USA2QQE3JwfG+PxGv
         s0uKk+9xuKwnbiOdBluhRndn0xvQxUMAAeEhoc84xYpx6gHGq6HLSJfXJrdH+Ct5RY9y
         csGqf461X7/JlMVSHqRF+/wFcoxccydy68X6rda5uVL/lndMoyvTSrVkORO/IcalHPeI
         pQkw==
X-Gm-Message-State: AOAM53098wEpI75sylN0qCMXBMa1Pnk/D56TJEaIYi3iG0+8eCPt5TJF
        hVPEeOt8OpDKVsvfEFsMnMBkcJcUIJE0Ym8BSatbZF7uuv8=
X-Google-Smtp-Source: ABdhPJyaW3LQ7JA4frN3NrxC7GNRRn2U+0+ejV4K1ngurOjopIl45bLG8ZC+1e2MRhAhle/GNmEL74X2oQVMrsafgNo=
X-Received: by 2002:a25:8b86:: with SMTP id j6mr12009074ybl.470.1624017791766;
 Fri, 18 Jun 2021 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <1624013943-13935-1-git-send-email-gumingtao@xiaomi.com>
In-Reply-To: <1624013943-13935-1-git-send-email-gumingtao@xiaomi.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 18 Jun 2021 14:03:04 +0200
Message-ID: <CAKXUXMxyDaEnWeGNZpCmAFG-5OG0JVrHz0RPk18n_z+ZDKQ-cQ@mail.gmail.com>
Subject: Re: [PATCH] slab: Use %s instead of function name
To:     gumingtao <gumingtao1225@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        gumingtao <gumingtao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:59 PM gumingtao <gumingtao1225@gmail.com> wrote:
>
> It is better to replace the function name with %s.
>
> Signed-off-by: gumingtao <gumingtao@xiaomi.com>
> ---
>  mm/slab_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a5714..36127dc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -381,8 +381,8 @@ kmem_cache_create_usercopy(const char *name,
>                         panic("kmem_cache_create: Failed to create slab '%s'. Error %d\n",

I am just wondering:

Can you also make that refactoring change for the panic() call as well?

How about checking the whole file for such patterns and doing that
change for all occurrences?


>                                 name, err);
>                 else {
> -                       pr_warn("kmem_cache_create(%s) failed with error %d\n",
> -                               name, err);
> +                       pr_warn("%s(%s) failed with error %d\n",
> +                               __func__, name, err);
>                         dump_stack();
>                 }
>                 return NULL;
> --
> 2.7.4
>
