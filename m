Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7F3ACBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhFRNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhFRNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:19:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B801C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:17:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so16708639lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJblJ74TTklvoFnfadsBOoaZefbWdJ5ucMdB1rLtJlA=;
        b=q8Qzhgp9v98ILMXTSeLDJvcsqB/Dz83eAR9lg/7wVXZ2uYMCERR0Dwu2gQbClPrSAz
         JEHxfe4qKxY5sEcg/mlqMef/OUyjQatVWM27DVQ4O6CAkMSGZiEBVpDgKat7okcI+gri
         XLjgSmM/bdbRBtptiTML8eSz6VixV5MOLhZKf2wqjtFPXriYp6ZxyYG7IoSor6fbwReG
         xVDEkveWJwekilXx3nephC95XGPE8weMKn/9gKvPXFRXd2HIDX6Jl4m+zQg48hSGFolS
         NDIfetiZ/OYLoLOjwh+Nuhv83ILP06sIQa1EfqTv3vVSFonmY/lMCBj6xqMBOHUNsf7V
         DJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJblJ74TTklvoFnfadsBOoaZefbWdJ5ucMdB1rLtJlA=;
        b=fUDiK1rQsZJvsM/xwXfEc00oB/7uryqj0XrJcJO9eUNIXMzr5POwHRlAJb+WWAd4Ne
         ufSGRvCk77XBNPnWdlv1E4h11SH03oCGPMe1rxThOUct6WSQjTlLycDHfR4cRt65svPQ
         INJbODV/S0GByPO9Wgzpg5+AuuQtiPBassdKnJvOCDrmStfx6dNwJArVa14e5qzlj0EQ
         D7606OH1odUHcySf/D8DkdzPe4INtQ7oGufSXCJMvMtvnCBnpDIOBxWDXKBbX6ySaUnP
         TVssyUq7DmX3jNBZWW0GcQ+2nD2+Aw6TntYssT/Hjgq0D1e4JyA1RJiXIebadJtOuHET
         QCuA==
X-Gm-Message-State: AOAM531Yk3SD8Alg6tNfoVS/VvFkrNjlpuv/W9800H+V5VAU6WlTzNf3
        Gt4E+NScrQHwOsA9Ga/q+l7O2p8HPmhB84TgH3E=
X-Google-Smtp-Source: ABdhPJwZ7v4NwsYzXeAh5f4OfP8slBFuvKnxQxdVfkym+WxyszxsVH4wXdOc+PT3sReY+V9ZotsvRr7nqCkf7WuEuAo=
X-Received: by 2002:a19:6515:: with SMTP id z21mr3123022lfb.641.1624022225635;
 Fri, 18 Jun 2021 06:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210618130230.123249-1-sxwjean@me.com>
In-Reply-To: <20210618130230.123249-1-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 18 Jun 2021 21:16:15 +0800
Message-ID: <CAEVVKH-h4fK0WobzfKUBs9d2t+XPmUQQCYJQmacPPVymFrntrA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Correct the description error for check_redundant()
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 9:02 PM Xiongwei Song <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> If there is no matched result, check_redundant() will return BFS_RNOMATCH.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/locking/lockdep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cfe0f4374594..1f126ca7fbd7 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2726,7 +2726,7 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
>   * <target> or not. If it can, <src> -> <target> dependency is already
>   * in the graph.
>   *
> - * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
> + * Return BFS_RMATCH if it does, or BFS_RNOMATCH if it does not, return BFS_E* if
>   * any error appears in the bfs search.
>   */
>  static noinline enum bfs_result

Sorry I forgot to add version info, this is v2.
Regarding v1 please see https://lkml.org/lkml/2021/6/17/1156.

Regards,
Xiongwei

> --
> 2.30.2
>
