Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7644DFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 02:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKLBTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 20:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKLBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:19:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54CC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:16:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so12687755wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FZxmnv6EQnSVqw4e9OqpTw18qfRjsuoOXw2sn/II6o=;
        b=OUArigvqXfRajQDXkhTFxW1cfQqBwJdCVCRUa3YXGNy75cSJxnKidkX8yX0km8AlaW
         RDcQaKp5LdRROlr9TyAHVgvNi8hCufZWVvqnvO+qeHT7EGIknXwo3zThIL2ZlaqUZt1L
         XdwxS1w1Cf8WszwLUPjp5TDEBb/K1uUBbz5LFP8X5RksVt7Y7n2yXJlPecREdMsd7x4s
         TQbK93JGZT1sn182zughm3+Q+q9ph9fQu4MBJUh1YPx5nE+WJc0TBXhP0rqlmJNCXtGL
         HNLgP28ClbzS3yIswLPIjUI2IeS7c5UFLl+84iK2IHt8fhWfbqZ1xxuzcKrtg5zhsRqx
         hrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FZxmnv6EQnSVqw4e9OqpTw18qfRjsuoOXw2sn/II6o=;
        b=YJzcocPZm+IAfqLGUGONBPn7tkqQbwQbNOtgWOWBZT3ITxYXN7Wbq8JjUu79ECYr9I
         SCJiX6bQfXRkS2akmQZ8oWvgU6OQmuoZY0HY3doKGCc+PAz6PRunhxd/fpUkPQFZxVav
         w1HLvX771YwakU9cfdJIDmCN1bQgVCQYUFAXGYXyQcZOag9UuY7K2qCOyBFuiaiF9ZV3
         8u3+dH+IkXsGQb3UMtVe0yi+6CoD8oM8JAq6IfXyMXEQ3LimzdNBFwvwPNaqEUnvV+11
         Re1g1AHTlf0NpJGin2d6x5jmjBdsj2EvZ3XVBBvjhF/qE+WaOWy6xsJKYiQYnRdzZEZV
         ChRw==
X-Gm-Message-State: AOAM530yZf7xtcLfMqBLLu8hivNdr9ZNom/2XxqRS435rmNPB93uO4HA
        NMhSQ9Saa1/OFVBnzw9JXatYBkwBAXv0QS32RbBecA==
X-Google-Smtp-Source: ABdhPJxcgK3VeCmSnOHwr+ZkPD5VqUSPiBAhI3Adk7xs3gNtalZXGtM0hc+nRMgDgo9K6N7GnM48oHtq6nfRmqDx77c=
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr14654622wry.279.1636679804974;
 Thu, 11 Nov 2021 17:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20211111092346.159994-1-luo.penghao@zte.com.cn> <163667767064.21646.9365544142891525487.git-patchwork-notify@kernel.org>
In-Reply-To: <163667767064.21646.9365544142891525487.git-patchwork-notify@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Nov 2021 17:16:32 -0800
Message-ID: <CANn89iL7bO-vspoqTvyWZ22vp7qgiC+jC7fPm8XTtoiF8k+2EQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] ipv6: Remove assignment to 'newinet'
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     luo penghao <cgel.zte@gmail.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo.penghao@zte.com.cn, zealci@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 4:41 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (master)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Thu, 11 Nov 2021 09:23:46 +0000 you wrote:
> > From: luo penghao <luo.penghao@zte.com.cn>
> >
> > The same statement will overwrite it afterwards. meanwhile, the
> > assignment is in the if statement, the variable will not be used
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> >
> > [...]
>
> Here is the summary with links:
>   - [linux-next] ipv6: Remove assignment to 'newinet'
>     https://git.kernel.org/netdev/net-next/c/70bf363d7adb
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

But why ?


All these bots, trying to send the same patches to multiple trees....

commit 70bf363d7adb3a428773bc905011d0ff923ba747
Author: Nghia Le <nghialm78@gmail.com>
Date:   Thu Nov 4 21:37:40 2021 +0700

    ipv6: remove useless assignment to newinet in tcp_v6_syn_recv_sock()

    The newinet value is initialized with inet_sk() in a block code to
    handle sockets for the ETH_P_IP protocol. Along this code path,
    newinet is never read. Thus, assignment to newinet is needless and
    can be removed.

    Signed-off-by: Nghia Le <nghialm78@gmail.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Link: https://lore.kernel.org/r/20211104143740.32446-1-nghialm78@gmail.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2cc9b0e53ad1c8e2d35fc9c6dbd1e90fee40b632..551fce49841d7f53a111b0435855634cece2b40a
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1263,7 +1263,6 @@ static struct sock *tcp_v6_syn_recv_sock(const
struct sock *sk, struct sk_buff *

                inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);

-               newinet = inet_sk(newsk);
                newnp = tcp_inet6_sk(newsk);
                newtp = tcp_sk(newsk);
