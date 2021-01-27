Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DA305F04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhA0PCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhA0PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:00:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C650C061786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:54:45 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d6so2011254ilo.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTdyNYkze+hI+OFRZCPwqiZbewY8o758U81yg52mX4M=;
        b=q8pB9egRttgWsLnscO5G4bYRpXSZAEr3Czk7HDYKghXyYGkiR66u90ioZFw7tahaDB
         CRGEkXinK6SxoxNHkCZVsQBD9lx8K9iIfwCaFFI2JewouxfQOryXga8qneDuVLCvyMeh
         arIMCS6QW8H6wS49vnLZvbTB7u3t3Mhk5LAJtuxVabZRSEafRpP5DAE2ABVKbfqAhSIw
         Xh3Ro1U23HmvBdQsN9sAkGVktk4YcULQJndthgOAd5l6CIazx6bo6unngx1qigZFlvft
         OABmeGgEvmJAJFBTkgBVz4lUcIweqDeHE4Hclkon06Fyfy36GeiimnRdN+9yrwYyhaSd
         Yv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTdyNYkze+hI+OFRZCPwqiZbewY8o758U81yg52mX4M=;
        b=g3kIMPDv4RftVxZRSVqjYNdkcLzV918qsMx0X7wVMTA58ZXrwE6Ngxi3R48eu9yM22
         DZI3TGmT4HYZfqG4MxpkQ/okOKxbkSYG7QYM3wrAsCVn6JhzOFFUosDqgtCE5gNzq++Z
         kxUtSgl4Lz4CIjGi0hrxfB5cZcq932wzUGy5XlUsrR6kKTHkv1xnTV36AGqLJ1rvsJMU
         Ocmrh92V2aFTMDtEyjeUBs+/iNNU59vkRwjnSBmLjKENyo0XqiTl/YJSe1jFuROUAO22
         Bgi8ioFkxIFRwzEDepyWaYx45t6lwIJeMGXwJwlFXlq1kw7PZejsZN2IjswV6kuvD7Sj
         OzJg==
X-Gm-Message-State: AOAM533HAmSrDGidpi0JVLQIXn1Gv/pwbWOaLu7oQyosMJCS++OEfBG4
        SYViAFOFrDk2L6vzXvUr/CIWxheKEo6CyX4UoJXI4g==
X-Google-Smtp-Source: ABdhPJym5YHdk7S2GBOskLrJaJULn2+Xd5bDT5AbmWnQMa5r6J68lPTVZvdEBa+glr+j4eSggYZNORX6z7pePV/Rzf4=
X-Received: by 2002:a92:d8c2:: with SMTP id l2mr9200045ilo.216.1611759284256;
 Wed, 27 Jan 2021 06:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20210127125018.7059-1-kuniyu@amazon.co.jp>
In-Reply-To: <20210127125018.7059-1-kuniyu@amazon.co.jp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 Jan 2021 15:54:32 +0100
Message-ID: <CANn89iJF_LOMDj9RZAe0QDkkJwCs7CgFA4KMijs5siz904DSzg@mail.gmail.com>
Subject: Re: [PATCH net] net: Remove redundant calls of sk_tx_queue_clear().
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Amit Shah <aams@amazon.de>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:50 PM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
>
> The commit 41b14fb8724d ("net: Do not clear the sock TX queue in
> sk_set_socket()") removes sk_tx_queue_clear() from sk_set_socket() and adds
> it instead in sk_alloc() and sk_clone_lock() to fix an issue introduced in
> the commit e022f0b4a03f ("net: Introduce sk_tx_queue_mapping"). However,
> the original commit had already put sk_tx_queue_clear() in sk_prot_alloc():
> the callee of sk_alloc() and sk_clone_lock(). Thus sk_tx_queue_clear() is
> called twice in each path currently.

Are you sure ?

I do not clearly see the sk_tx_queue_clear() call from the cloning part.

Please elaborate.

In any case, this seems to be a candidate for net-next, this is not
fixing a bug,
this would be an optimization at most, and potentially adding a bug.

So if you resend this patch, you can mention the old commit in the changelog,
but do not add a dubious Fixes: tag


>
> This patch removes the redundant calls of sk_tx_queue_clear() in sk_alloc()
> and sk_clone_lock().
>
> Fixes: 41b14fb8724d ("net: Do not clear the sock TX queue in sk_set_socket()")
> CC: Tariq Toukan <tariqt@mellanox.com>
> CC: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> Reviewed-by: Amit Shah <aams@amazon.de>
> ---
>  net/core/sock.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index bbcd4b97eddd..5c665ee14159 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1759,7 +1759,6 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
>                 cgroup_sk_alloc(&sk->sk_cgrp_data);
>                 sock_update_classid(&sk->sk_cgrp_data);
>                 sock_update_netprioidx(&sk->sk_cgrp_data);
> -               sk_tx_queue_clear(sk);
>         }
>
>         return sk;
> @@ -1983,7 +1982,6 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
>                  */
>                 sk_refcnt_debug_inc(newsk);
>                 sk_set_socket(newsk, NULL);
> -               sk_tx_queue_clear(newsk);
>                 RCU_INIT_POINTER(newsk->sk_wq, NULL);
>
>                 if (newsk->sk_prot->sockets_allocated)
> --
> 2.17.2 (Apple Git-113)
>
