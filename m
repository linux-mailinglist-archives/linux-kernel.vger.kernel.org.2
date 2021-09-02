Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537F13FF199
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346399AbhIBQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbhIBQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:39:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA42C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:38:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b10so3998809wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c816SkV8FnDof/RBZOEsj4R9F/1vQaYIIbLxE/VrZU=;
        b=mkpWaX7JdiIf1M/eyGSdnot5Dt2xWactgpUF2Mja1rBgvMD9QuMF9rVevkT7Dk3HbI
         41m8bMr0MP3pQxOrgyhxhlU4EpTaOz9kLgV60sU6qGrFvWX0aalEyvjkFLLGQ8yBZ8YA
         3E2XF1wju3RHK0yV8+pwgEJwEbjlk6kv2XRccGUj0CkzjOsTOI4u2ozhZUxzrKbaYfIR
         gm17m/qh5N2SShlBNkBXfWuJoaKA5Jkl7xsgAtobWBZaR6gzdaeQD8a+MV0N+HNkQx8B
         iJ2QnZPQL6BmTX7neOT4JBe1ZYef2r3ua5x7iyymFMfrEYNcjup7fsGbQskxJqpv850Q
         eflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c816SkV8FnDof/RBZOEsj4R9F/1vQaYIIbLxE/VrZU=;
        b=qek/Y8tNVnS5/rpcEZaeTSXaB95e5RIwnxtv/UgvI5ZYLCwpt55F+oWTG3Zt5YXFz2
         qKXdTeLMeHaYbDZ2Pwggq3nb2KsrRn59KwdKF7dcQsb7E26yQNPb0YOFH4APgGZ5YDHn
         Mlgn4Hi7EfvHRUUoU0iV/7AMOvOFnCJna/HdwbspEO27XTUqQvRtJWElOif9HYwQ8u/1
         1Vct9+o+EPrXwJxzy1HskO9Wkmvh45aeHUwQeaPFoslBoJqi65KpzTDitbLJe5nEj8vx
         TOp1ZOx/ITAZNx0Sn0GFQ8yzhFF8Uhn5tqHX2T6AXVJZT94kGMdfFMrWz5CYyi6lkTNb
         IUUg==
X-Gm-Message-State: AOAM532UH0x7vUaRDkLLfak9NzLRmtOwxwqyxSjujhX1p7BGpafxv3JM
        Eld/scc1D4ntt7nLxhSRC4UuES4FGTborjC3xLLD+Q==
X-Google-Smtp-Source: ABdhPJzzo4Fuh3YQsYULnyD+xTOcA3l7Ym3lo2CKiio6GwwapUe+wi9rCl2gH3JXUY5s56ELLazxVulNLoLfDsoT4+I=
X-Received: by 2002:adf:c442:: with SMTP id a2mr4944554wrg.228.1630600718699;
 Thu, 02 Sep 2021 09:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210902163205.17164-1-tim.gardner@canonical.com>
In-Reply-To: <20210902163205.17164-1-tim.gardner@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 2 Sep 2021 09:38:26 -0700
Message-ID: <CANn89i+ey++b=dBXUZjXYyVessr49yZJBagVJxP-mpcreYyjCA@mail.gmail.com>
Subject: Re: [PATCH linux-next] ipv4: Fix NULL deference in fnhe_remove_oldest()
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 9:32 AM Tim Gardner <tim.gardner@canonical.com> wrote:
>
> Coverity complains that linux-next commit 67d6d681e15b5 ("ipv4: make
> exception cache less predictible") neglected to check for NULL before
> dereferencing 'oldest'. It appears to be possible to fall through the for
> loop without ever setting 'oldest'.

Coverity is wrong.

 fnhe_remove_oldest() is only called when there are at least 6 items
in the list.

There is no way oldest could be NULL, or that oldest_p could contain garbage.

>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  net/ipv4/route.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d6899ab5fb39..e85026591a09 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -603,9 +603,11 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
>                         oldest_p = fnhe_p;
>                 }
>         }
> -       fnhe_flush_routes(oldest);
> -       *oldest_p = oldest->fnhe_next;
> -       kfree_rcu(oldest, rcu);
> +       if (oldest) {
> +               fnhe_flush_routes(oldest);
> +               *oldest_p = oldest->fnhe_next;
> +               kfree_rcu(oldest, rcu);
> +       }
>  }
>
>  static u32 fnhe_hashfun(__be32 daddr)
> --
> 2.33.0
>
