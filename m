Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00D3CCFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhGSISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:18:50 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38409 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhGSISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:18:49 -0400
Received: by mail-pf1-f173.google.com with SMTP id i14so3849330pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lh5yfJTwW2Ls9T8jpfvHQ8eVuVCUEhB3yXGocbuj9ag=;
        b=jp8jBIjZt/lyXYrROHiRW7JfeaO3sAE855D0klTxv5F+SSEE0XfBTiGKdU8ifKsnTu
         RYxX96QdhNyNr5NogGmn6Zv1iePK1gilyOjexb5+qFleU4l+hoHDv819lq0XCmoOUiMd
         /SBwYUF8hlk/SV5iE3Saq8rkAAubkOx/BNAT953i2LUjHCEkpKZIVXXj5Xrv3HZHDvRQ
         fU7+diOvGthVCD7raFHJ3RimAInM+9uHt6QTCDprjqEBzQjEphf3cQerSXL4fHJAUJC3
         Cp7p4eoBZicqgSA4Ize/mtNes+PRdwTHSNDArfvGj1Cd5zdRWwfAcM/44gv0PMaMNrKO
         9x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lh5yfJTwW2Ls9T8jpfvHQ8eVuVCUEhB3yXGocbuj9ag=;
        b=Xn5hqGgO1FY530/vasTeD/0dtkWRILu7Tw8Jw+xFYYAZW06ANpTmuHpyKVnNUkX5Yb
         9lapkx1lxoBJEyuNpeqqkk21QUK/sDEVfoAmv9fCKms0JfS9KR8H4RifPQ0tYHkg+odU
         ekB7RsxKI9N3gDrsHz0PFNrvTW1X8rXWOTc3y6umKcPO0fLw37ySiVNSfRSvHgrthGnu
         L5FfNeTublZAGklCqvyDWT3JNM2JEt8YPULX6AlOADw8b3JpU1rqlkyiIV9i2UTOAWFO
         wAitDLIkD9wMdn51F4AGbCK6zMwD9gQu2DbzhrE82P2TIlPNFL2vxEjjFZ3cgI4KwStv
         nOXg==
X-Gm-Message-State: AOAM5330kiVMZFjGJuybAWMuFdkx5YzgilFbiTgqm6vGZZFB5OP+BOSj
        uqMTW6Pnmj5jUF/fxGRDqHkKjFBWzfDBsQ3mNdCzgkJj3rdZOg==
X-Google-Smtp-Source: ABdhPJxoL3STP8Cr+QIko8xTGwvLqJtJIQlNOPSySrusLPm/67OMsa0fU/1hZWfG3VHJbcGrAYJZX1MIEQt1C5jwtIs=
X-Received: by 2002:a6b:7c07:: with SMTP id m7mr18059838iok.47.1626684557348;
 Mon, 19 Jul 2021 01:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210719065914.3801-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210719065914.3801-1-thunder.leizhen@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 19 Jul 2021 16:49:05 +0800
Message-ID: <CAJhGHyC-PzzjSmtEnvOkXNJkn5p2oejk8ctyan3r5AxP-G+O-A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix possible memory leaks in wq_numa_init()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tejun

I think it would be better to fix it.
There have been several tries, sorted by date:

https://lore.kernel.org/lkml/1418379595-6281-2-git-send-email-laijs@cn.fujitsu.com/
https://lore.kernel.org/lkml/1442457835-24238-1-git-send-email-xlpang@126.com/
https://lore.kernel.org/lkml/1452170339-26748-3-git-send-email-wanghaibin.wang@huawei.com/
https://lore.kernel.org/lkml/1533518439-3982-1-git-send-email-wang.yi59@zte.com.cn/

And this one.

Thanks
Lai


On Mon, Jul 19, 2021 at 3:00 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> In error handling branch "if (WARN_ON(node == NUMA_NO_NODE))", the
> previously allocated memories are not released. Doing this before
> allocating memory eliminates memory leaks.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/workqueue.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 50142fc08902..6aa0ba582d15 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5896,6 +5896,14 @@ static void __init wq_numa_init(void)
>                 return;
>         }
>
> +       for_each_possible_cpu(cpu) {
> +               if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
> +                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> +                       /* happens iff arch is bonkers, let's just proceed */
> +                       return;
> +               }
> +       }
> +
>         wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
>         BUG_ON(!wq_update_unbound_numa_attrs_buf);
>
> @@ -5907,18 +5915,11 @@ static void __init wq_numa_init(void)
>         tbl = kcalloc(nr_node_ids, sizeof(tbl[0]), GFP_KERNEL);
>         BUG_ON(!tbl);
>
> -       for_each_node(node)
> +       for_each_node(node) {
>                 BUG_ON(!zalloc_cpumask_var_node(&tbl[node], GFP_KERNEL,
>                                 node_online(node) ? node : NUMA_NO_NODE));
>
> -       for_each_possible_cpu(cpu) {
> -               node = cpu_to_node(cpu);
> -               if (WARN_ON(node == NUMA_NO_NODE)) {
> -                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> -                       /* happens iff arch is bonkers, let's just proceed */
> -                       return;
> -               }
> -               cpumask_set_cpu(cpu, tbl[node]);
> +               cpumask_copy(tbl[node], cpumask_of_node(node));
>         }
>
>         wq_numa_possible_cpumask = tbl;
> --
> 2.25.1
>
