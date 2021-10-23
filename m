Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6B4384CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJWStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJWStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 14:49:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D454C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 11:47:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n63so9460356oif.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7m875e4gGbT9nJQnt7puIjT90v2deLXARSSVrDwAsaE=;
        b=bVOldoUU4d+XYS7ZXqGjEpYtcTgLqY3fYHMsip6uOlcF7SYeUcFRH6tgFJdBZmPiSh
         OcojrSdVXwWgQp9LhJA63RZ9hxearsZf3qIXnViUFkWxaVH0mHMfsPab1NkUDd0P0OKY
         42pf0Es8q4Yhw2bv8fdwYemPmJPHOaKjoYBrjOeYACcO+UeOOCFhr9kvkHljD+Y4BHZM
         /f4HcpZ55kIE20b+RsNjhnjxEdk8VPRQfS9xyokwhuxGwEiChafOwcs+bt6g3exx/ucB
         4Lo3Lg8dw+R5CtFegZlOShxkE5cUNPurfnwnvMRnTVC84f5R9wQBeuwGyLB9u8WS3Pxl
         Q6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7m875e4gGbT9nJQnt7puIjT90v2deLXARSSVrDwAsaE=;
        b=FsUOw+gYYWvgyrrPfSplMD6NaEFaWXqvVQ3v+ovnyX2YOYZo7YE/UzcLNu2cx1/o+f
         D0vLRsf7ddMtx1D93bmukHCoGzb3p70Z099KTGQZE8zMvmLxcXFAozfVAIa4lJnF+vS3
         SEtg5386GlIqPk6jzX2HhacPsJ/fYepoSDr7U0Kbwi5yz1ldtDo6OhzEMn55bvtsvc0P
         FZQOBiDQBtE41OrgCTU+mDxVFZalReXyxXpT/A2NksGoZ6eYcsvs0LVrmgTM5rW2G/aD
         qQdN5mmc2XOXBtk84jSRrtfd/mqOVm96g2aMQbAbuJcdVImyM7H0IOMpYrmsVDAqmNHQ
         W8Pg==
X-Gm-Message-State: AOAM533SjFLGMmlILF8vF5xuJRJtTRKooCVHWwxIw5zVwthsAXtwy5QM
        sXjf7wCZBl9nsxauXnYIK2LY/q2miaysYsTUgt2wyA==
X-Google-Smtp-Source: ABdhPJwGfrrU38MT0H8XVlAmIc0nlnxPYap1OdIzl3RCYp07Xzqjq5mtzlS1kkf4ZWdBZm0w0npP2Z7LzGvOgmjC01g=
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr5291817oih.134.1635014848757;
 Sat, 23 Oct 2021 11:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211023171802.4693-1-cyeaa@connect.ust.hk>
In-Reply-To: <20211023171802.4693-1-cyeaa@connect.ust.hk>
From:   Marco Elver <elver@google.com>
Date:   Sat, 23 Oct 2021 20:47:17 +0200
Message-ID: <CANpmjNP8uAexEZ3Qa-GfBfX6V8tAd7NK0vt3T3Xjh4CkzxfS-g@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: fix null pointer dereference on pointer meta
To:     Chengfeng Ye <cyeaa@connect.ust.hk>
Cc:     glider@google.com, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 at 19:20, Chengfeng Ye <cyeaa@connect.ust.hk> wrote:
> The pointer meta return from addr_to_metadata could be null, so
> there is a potential null pointer dereference issue. Fix this
> by adding a null check before dereference.
>
> Fixes: 0ce20dd8 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> ---
>  mm/kfence/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 7a97db8bc8e7..7d2ec787e921 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -811,7 +811,7 @@ void __kfence_free(void *addr)
>          * objects once it has been freed. meta->cache may be NULL if the cache
>          * was destroyed.
>          */
> -       if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
> +       if (unlikely(meta && meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
>                 call_rcu(&meta->rcu_head, rcu_guarded_free);
>         else
>                 kfence_guarded_free(addr, meta, false);

Sorry -- Nack. What bug did you encounter?

Please see [1], and I'm afraid this attempt makes even less sense
because if it were (hypothetically) NULL like you say we just call
kfence_guarded_free() and crash there.

[1] https://lkml.kernel.org/r/CANpmjNMcgUsdvXrvQHn+-y1w-z-6QAS+WJ27RB2DCnVxORRcuw@mail.gmail.com

However, what I wrote in [1] equally applies here:

> [...]
> Adding a check like this could also hide genuine bugs, as meta should
> never be NULL in __kfence_free(). If it is, we'd like to see a crash.
>
> Did you read kfence_free() in include/linux/kfence.h? It already
> prevents __kfence_free() being called with a non-KFENCE address.
>
> Without a more thorough explanation, Nack.

May I ask which static analysis tool keeps flagging this?

Thanks,
-- Marco
