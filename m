Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3675030618F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhA0RGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhA0RGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:06:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:05:36 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p72so2548485iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0goQWs4+DmXgEXiv+l4y3STA+LL1AfBlAySKkIGcjyA=;
        b=OeezA6zrAWyzulvVxN+dai62VqmDDY2/g4PzREPmsu11zjf7/Ti7Vm0MF3x2U7Z4C8
         ZF3jwZJdQcs6yUmA3Sh+NsLBwPY2JAgYxXS5XBpcd6OuQethH8pdn58Fi8Cppeq0Ppnn
         ugF8idVw3ZPVj/qtFhLcNlHU0EcbRJS19sly3KNY8sa4zK6y8K3QlJSH6nPTraSwhUIh
         zbrkOpU30SSniPmV3EdDbAf4M6/wMX0U6otzoVDxrSzGZ/UROwx9juvwQtuSW9ne//q2
         M5GOJr/Jz9WNXjOuBIVBLfPJZpDDf+ZHRk0oAX7LTQhOAKRdB1Mb6vI58NQEe5gL8f1B
         A8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0goQWs4+DmXgEXiv+l4y3STA+LL1AfBlAySKkIGcjyA=;
        b=YGDgyvaUWdymqtVHP+a+T0A9IyOpD8OS/fBk7Gyq9P29TJu7KOBm+pHYkUwwX6yrq0
         ll74wxORMCU270iwTSppAlwu11gR1f7lFt/3lnP3I8s3f+cys5YYidI34IE0I/TqkCA7
         u206tUhWFAeAK7Xz5EMUQj8v1Cl2Qk3vCjOecvlkryYbcCYvZWdAKjVNcnBa/fzjgppB
         7fBcJIZKW9Eb2MtRuby4oBmVjhLuV1ebqZ7HwrxiY3vPcinOIpl7ZmswV/ADRpVMYvbT
         NzU3dp1WG+IeU0M00dR2TOvzG7n+r5PvIo+29lNe2IbigKtsEHNd1t1BuVGXFq8+uZzL
         5+gg==
X-Gm-Message-State: AOAM533cyVHMeGNqIuTjBhDf9JifhTxwYdnv1DHkY3K3+sWUaOLBTDJA
        5PFbfzN9Odrk/XZWJ1BbUTETy8AHv1HJbuYbXmxmcA==
X-Google-Smtp-Source: ABdhPJzrSXZMko4QY12Q/ItpYG2HVKmGvKX934wjrLXsKYyzHWb/EyS5iH6Y6AMvV+Yh0uEEQjPrdWVJODx1AmpLH1I=
X-Received: by 2002:a02:c550:: with SMTP id g16mr9856698jaj.6.1611767135779;
 Wed, 27 Jan 2021 09:05:35 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iJF_LOMDj9RZAe0QDkkJwCs7CgFA4KMijs5siz904DSzg@mail.gmail.com>
 <20210127165246.53673-1-kuniyu@amazon.co.jp>
In-Reply-To: <20210127165246.53673-1-kuniyu@amazon.co.jp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 Jan 2021 18:05:24 +0100
Message-ID: <CANn89iK2cd6rRFfNL-vp_Dy4xvtuk_5vA-xg=MbbWb-ybzHheg@mail.gmail.com>
Subject: Re: [PATCH net] net: Remove redundant calls of sk_tx_queue_clear().
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Amit Shah <aams@amazon.de>, Boris Pismenny <borisp@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 5:52 PM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
>
> From:   Eric Dumazet <edumazet@google.com>
> Date:   Wed, 27 Jan 2021 15:54:32 +0100
> > On Wed, Jan 27, 2021 at 1:50 PM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
> > >
> > > The commit 41b14fb8724d ("net: Do not clear the sock TX queue in
> > > sk_set_socket()") removes sk_tx_queue_clear() from sk_set_socket() and adds
> > > it instead in sk_alloc() and sk_clone_lock() to fix an issue introduced in
> > > the commit e022f0b4a03f ("net: Introduce sk_tx_queue_mapping"). However,
> > > the original commit had already put sk_tx_queue_clear() in sk_prot_alloc():
> > > the callee of sk_alloc() and sk_clone_lock(). Thus sk_tx_queue_clear() is
> > > called twice in each path currently.
> >
> > Are you sure ?
> >
> > I do not clearly see the sk_tx_queue_clear() call from the cloning part.
> >
> > Please elaborate.
>
> If sk is not NULL in sk_prot_alloc(), sk_tx_queue_clear() is called [1].
> Also the callers of sk_prot_alloc() are only sk_alloc() and sk_clone_lock().
> If they finally return not NULL pointer, sk_tx_queue_clear() is called in
> each function [2][3].
>
> In the cloning part, sock_copy() is called after sk_prot_alloc(), but
> skc_tx_queue_mapping is defined between skc_dontcopy_begin and
> skc_dontcopy_end in struct sock_common [4]. So, sock_copy() does not
> overwrite skc_tx_queue_mapping, and thus we can initialize it in
> sk_prot_alloc().

That is a lot of assumptions.

What guarantees do we have that skc_tx_queue_mapping will never be
moved out of this section ?
AFAIK it was there by accident, for cache locality reasons, that might
change in the future as we add more stuff in socket.

I feel this optimization is risky for future changes, for a code path
that is spending thousands of cycles anyway.

>
> [1] sk_prot_alloc
> https://github.com/torvalds/linux/blob/master/net/core/sock.c#L1693
>
> [2] sk_alloc
> https://github.com/torvalds/linux/blob/master/net/core/sock.c#L1762
>
> [3] sk_clone_lock
> https://github.com/torvalds/linux/blob/master/net/core/sock.c#L1986
>
> [4] struct sock_common
> https://github.com/torvalds/linux/blob/master/include/net/sock.h#L218-L240
>
>
> > In any case, this seems to be a candidate for net-next, this is not
> > fixing a bug,
> > this would be an optimization at most, and potentially adding a bug.
> >
> > So if you resend this patch, you can mention the old commit in the changelog,
> > but do not add a dubious Fixes: tag
>
> I see.
>
> I will remove the tag and resend this as a net-next candidate.
>
> Thank you,
> Kuniyuki
>
>
> > >
> > > This patch removes the redundant calls of sk_tx_queue_clear() in sk_alloc()
> > > and sk_clone_lock().
> > >
> > > Fixes: 41b14fb8724d ("net: Do not clear the sock TX queue in sk_set_socket()")
> > > CC: Tariq Toukan <tariqt@mellanox.com>
> > > CC: Boris Pismenny <borisp@mellanox.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > > Reviewed-by: Amit Shah <aams@amazon.de>
> > > ---
> > >  net/core/sock.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index bbcd4b97eddd..5c665ee14159 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1759,7 +1759,6 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
> > >                 cgroup_sk_alloc(&sk->sk_cgrp_data);
> > >                 sock_update_classid(&sk->sk_cgrp_data);
> > >                 sock_update_netprioidx(&sk->sk_cgrp_data);
> > > -               sk_tx_queue_clear(sk);
> > >         }
> > >
> > >         return sk;
> > > @@ -1983,7 +1982,6 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
> > >                  */
> > >                 sk_refcnt_debug_inc(newsk);
> > >                 sk_set_socket(newsk, NULL);
> > > -               sk_tx_queue_clear(newsk);
> > >                 RCU_INIT_POINTER(newsk->sk_wq, NULL);
> > >
> > >                 if (newsk->sk_prot->sockets_allocated)
> > > --
> > > 2.17.2 (Apple Git-113)
> > >
