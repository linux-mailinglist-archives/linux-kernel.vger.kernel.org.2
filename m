Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4D41835B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbhIYQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhIYQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 12:14:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E9C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 09:12:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s16so12872184ybe.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0crdlBe2JFxj7vLeLWC6SazKmqX6D7h0wPvd1YoWPhc=;
        b=r3STl/EiBhjcGJAGxvBGIMaNrasQNOdY/xVtRaHvAhQZbIMdJXsQjx/pPZjU6xU17R
         dZ/FukG0qiUMnckvTSocZ6Wg+54ENNYoPmikaBCvyiB5Jy3XtsIUYan+1yxllyCO60yP
         bV8zzlgXOewTi8q/qFOg1RogQEuQR8ep610K4+HNg3YSSy/VpZWuN0f0TVO8+WMaoa9v
         ooOeL57U2EzTBWEhJoAoJ24GAqUE4z4nGueGqLaYadnn4VuQeFTiU2MElx3vnd2NlYsT
         FFK8sBNX0n7P8a0MoYA7E0e0pNvSTzvXri3L5WrDWPb2od9lrLthTTAOf+/hRhrplhNg
         4yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0crdlBe2JFxj7vLeLWC6SazKmqX6D7h0wPvd1YoWPhc=;
        b=aaLf2qaQ8uc7Zc1gOwfEOIxQ9XIFlXHVJZkx/EcTYHdsWS1k6ST/V7vnzRbPOjg6mo
         4pdw8i2TPcFB5Wq75SLof1+K4NqZDo0jLJMZHrqtW3hzlkAyjbBoNu3GVzxDmtkfwae1
         zCQ4I/b9yusxUCpD6CbkHIHi2OOJqXFed1jYD85xHunvQwVgUh95NgU/gIji/JrxgmMt
         muRA3Lmd7Hj1uklGifFJttgeQIqRimTIfnZz3eRkRCmQX07DRGHQLjEaw7W7QA1gu6/U
         3WuwJ9Pp59xGSxPacnrW1Te2dUV7TcP/CHd8EDletza503GOIPIPMOvIWx4bDQsY38EC
         fScA==
X-Gm-Message-State: AOAM532T4yyTJBS7gMH36hc5IUC0skGooVz9G6/F+mMzwZGAyaeOuR3A
        1hcXxyQl6OxYjcKq91PYccqOi3fKC7VvBw7KfvugsA==
X-Google-Smtp-Source: ABdhPJzgp7GyFbz86FYBHCTkAjVtj0qur4YgbYnxykYReL1Q5+FA29T2xUxChkjhyxGDxuG9LwOMVN/PCpiXxalUCWI=
X-Received: by 2002:a25:c011:: with SMTP id c17mr18572046ybf.291.1632586366402;
 Sat, 25 Sep 2021 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210925142733.24293-1-liumh1@shanghaitech.edu.cn>
In-Reply-To: <20210925142733.24293-1-liumh1@shanghaitech.edu.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 25 Sep 2021 09:12:35 -0700
Message-ID: <CANn89iKcMRNnuN4Vq-En_wjc19Qj8Ufv3kQ7DpCSqAg9T1ud4w@mail.gmail.com>
Subject: Re: [PATCH -next] net/ipv4/tcp_metrics.c: remove superfluous header
 files from tcp_metrics.c
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 7:27 AM Mianhan Liu <liumh1@shanghaitech.edu.cn> wrote:
>
> tcp_metrics.c hasn't use any macro or function declared in rcupdate.h
> spinlock.h, module.h, cache.h, hash.h and vmalloc.h. Thus, these files
> can be removed from tcp_metrics.c safely without affecting the compilation
> of the net module.

This seems pretty much relying on other includes.
(eg #include <linux/tcp.h> brings many things already)

We do not generally do this.


>
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
>
> ---
>  net/ipv4/tcp_metrics.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 0588b004d..7b819530d 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -1,15 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/rcupdate.h>

We do use rcu stuff in this file.

> -#include <linux/spinlock.h>

We do use spinlocks in tcp_metrics.c

>  #include <linux/jiffies.h>
> -#include <linux/module.h>
> -#include <linux/cache.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/tcp.h>
> -#include <linux/hash.h>
>  #include <linux/tcp_metrics.h>
> -#include <linux/vmalloc.h>

Not sure why kvzalloc() is not in linux/vmalloc.h

Honestly I do not even know why we spend time trying to reduce list of includes.
