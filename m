Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857D43D1B99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGVBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhGVBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:25:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:05:57 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j5so4055663ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1R6c86YfkUXVPDa9H5jJD+gdk/MneM1W6VpVOsxGgc=;
        b=j5nN6xCHG8nsa5HM+sieO9XcEPTbdNvy574BInuM913ps5w/lQiOcRohFh/Si14FdC
         LgoWXjGeQ/bJkvcy8rQ7wzldJ9u/Eh7gHWHFL+V4N9pYZC9+rkO6cky8M2IJYhfNHqIj
         hSe0J3Kx7j/umNfSAzR5aCCGfPar9tva2c0X7vdH6WzSV9K3IkN7ipb9E3CnpkZ5jrjc
         99jXDLRjDu9eGhrYrwdkCvnIcxu0/ZAc1nR9OX/OdnECap7uITRK0e6pRmF9TIRGEJr7
         E0dx3uKaP+JQUZJuF6c5Su/bIqw3syuWTq7JMDfWOvyqIJemwP44bKHfRRy1SH7qVwdA
         nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1R6c86YfkUXVPDa9H5jJD+gdk/MneM1W6VpVOsxGgc=;
        b=cVDPb+WmgtMxpicHgtzRsI/knv/IChm8RycpMLDbjOwxOYiJsGAl+t8Cg9kz0mpcGs
         GEURdQBnvcm12TufZs0Vw3ACEb/SzGodNrJAvy0OIRcnDD73y50ligRj4fVfA9DJbvdp
         nKmn6xQXkeNQrW3jp+OPvyTQHjOv/zY5lHlw7jSC7ukYnWmFJGgyMFct0lyyTD/sKxjC
         HsnpH5K2utE+rVTbnqY++gzoVOgQO1ZQpFF0eVwAza108rTDW7kXH32ZuuYFfh+WPqZe
         i3OCLJV9LWJXdqvpM0gRy6EFKcIiAylsDvulmB8kViOcftA82uQqMaeK54K5Zkb4LyQ4
         2e6A==
X-Gm-Message-State: AOAM532pWVAaRud5U5/rvrKzb70NiYFDQw6UPr9F9s/0AvoG89DJVbOX
        XQQPBv4an9Ua0sHjv6LIPOsFX3dyBU/EZcIEVec=
X-Google-Smtp-Source: ABdhPJw2WpX/AkXB1tBoDA1VqjBk38zRuX/dYfG36ZW6QZifMw+ASuhoMG5uQnQIrp+iJi/0GbKOHBQHmtIHefuGTZ4=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr26144876ilj.308.1626919556855;
 Wed, 21 Jul 2021 19:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210719065914.3801-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210719065914.3801-1-thunder.leizhen@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 22 Jul 2021 10:05:45 +0800
Message-ID: <CAJhGHyCnmgpZjSP6wFCtY8Vr75eMuV-ZFtvWRuvXHDxejOpK2w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix possible memory leaks in wq_numa_init()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore my previous email which included/copied a wrong line of code.

On Thu, Jul 22, 2021 at 12:23 AM Tejun Heo <tj@kernel.org> wrote:
> Yeah, idk. It's not an actual bug tho. Maybe we should just add a comment.
> Which version do you like the best?

I hope Zhen Lei continues to refine his version.  I think he is still
working on it.

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

I don't think this comment is still needed.

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

It is incorrect.  cpumask_of_node(node) is the online cpumask of the node, not
the possible cpumask of the node that we are interested in.

If the NUMA subsystem provided something like cpumask_possible_of_node(node),
we wouldn't need wq_numa_possible_cpumask.

Please keep "for_each_possible_cpu(cpu)" loop and
"cpumask_set_cpu(cpu, tbl[node]);"

>         }
>
>         wq_numa_possible_cpumask = tbl;
> --
> 2.25.1
>
