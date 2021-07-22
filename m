Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E991D3D1B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhGVBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVBPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:15:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62991C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:55:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j5so4038215ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPKuXquYyocd+sRZHEo1fNN0/vWVNwngkN7fA7iFP1s=;
        b=jRM7MRBHRacJ2ZA0d9TDAbW/m4G11TFqBdLcZAZu8Huqv5whUyaXDNIGqMMyeHjdTi
         RarKWoiuTUWcbdv6gf5Yo4dMf76pGIIZv1Z+8l3CHG0aIVtfIghoVTNSu/284GcRWJU4
         8iTmn+RQvlxJH4+41CNYQPsJPWy0bXuxPOb0dXZDuI+ceoO7Ge6jLZXDji+9wrG5dp/I
         kDBS8/6Vqtym+PSes4teFTr8wVNrmdJUqczfYHrGK2h3ly8BE9eIF9RhwwC3njsT2ziP
         l60FEwIdQ4FOOVd/Q8hiReq/QUFaVQ5pN6BwkfW30KC3gV8+NdpDJDGabb4g3qJS5PPx
         BteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPKuXquYyocd+sRZHEo1fNN0/vWVNwngkN7fA7iFP1s=;
        b=Qkp7nVEJXGaYIXO242gDJWpdWHQsZ11sxkd0KYiosCwr/jYraHib8EpUE22WZ87JA9
         QA/gMKkzvm22UJK0bniDsF3NTTfPVoYQO5uiy9TOF7lbuY8G934X9rlbo6D7Ac1NtrWs
         zZSedY/sob1knD/XkGUtKGMF8YQtHdxu90KDSHF6F3cDHo4vGbOjwYk609u0oL7mul+k
         VWykOD5PUYzZOdQ/tl6V8qQP+WmpWsVbpZhRmEwoNll2D3juma+MWq+ZLvEmEcPyq1+M
         mqrwGD+DomsaWQ15CKLaScB6Hdadht2MkU9B08fdWlxB98VH9dnOZ55wLJGbKKeDCa7u
         WJLA==
X-Gm-Message-State: AOAM531bdhJiGAaZ06EsJWgZb51qJ2KTpVjKPOGEj6XaqvPWOSWSpUu+
        ZuugYco9exCvaSu2r7L+FOlBGtNbpbgkQQelZ8Y=
X-Google-Smtp-Source: ABdhPJz3nFbbgIEcV/5YIlscpmu5lA1dsTkVZvCaGYpSbUNbnSU0njB7tRu0l4h4FqIL935O2AzaGWAXFmi4hKIpcI0=
X-Received: by 2002:a92:c0cc:: with SMTP id t12mr25686533ilf.47.1626918933798;
 Wed, 21 Jul 2021 18:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210719065914.3801-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210719065914.3801-1-thunder.leizhen@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 22 Jul 2021 09:55:22 +0800
Message-ID: <CAJhGHyDv38=n--13-CWgVpcc1ZPyFu_vYi4bfSuLCGp7iHCCDw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix possible memory leaks in wq_numa_init()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It is incorrect.  cpumask_of_node(node) is the online cpumask of the node, not
the possible cpumask of the node that we are interested in.

If the NUMA subsystem provided something like cpumask_possible_of_node(node),
we wouldn't need wq_numa_possible_cpumask.

Please keep "cpumask_copy(tbl[node], cpumask_of_node(node));" as before.

>         }
>
>         wq_numa_possible_cpumask = tbl;
> --
> 2.25.1
>
