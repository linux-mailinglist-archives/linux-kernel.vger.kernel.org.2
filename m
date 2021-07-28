Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180A53D85F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 04:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhG1CuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1CuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:50:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 19:50:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f11so1223296ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgxaUtehHNXIz2IjW0e0Qx7jP8f1BeBvQhIRUK5iZZk=;
        b=A6tQHWYybwTVn4uxVkZlSTDj3Iqv29ah/h1AA+rc4FRtLMW+QjbBKfBfA0cZDF9Xdi
         VHi6fqRbGBc/XdQoUydVGnfc/iziUrfNLcZoNqKtGyk9PSnK8Q7q1wVSsNsw8taQSbU8
         VhgSiqpNFGk+aCVRXWH5gsjAe1lgZ+w0bOQx7yaluewMEpn92P14FYkXVWf0Rtbs9kTa
         bGxO4AOriSAt4K/Q2SjbtMAdFkvQMrOVw+XKgIvgFamCT3264zoVkfHfnDehkDCvwAFd
         ti2io40w5nPiCUWdJOXwDdAMZtUhGTNMru0+dJY6uTD/M/7WFDDhFCg5lymMVcJ7vChf
         U1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgxaUtehHNXIz2IjW0e0Qx7jP8f1BeBvQhIRUK5iZZk=;
        b=RAFwpiszudj8sIsHz0+GA+whWvSPg/3NcyKA7ujzCJBgFgQO/Nq8XEV9vdXH3zSd/i
         zR1i1VCa0XCXCNnVRt0winY5D0ImvUq/1ghKfNLwFKsIfV4WCkXkgpGYaPW79aoacEJH
         sWs4k0BjugsD7nNqu1HonwD3ZK5Sr41lqSsUFilGaAfrh6h3bpdTws2r28Ug8PP+G/eE
         2AuPuwnwp3qPuXsr21XOhuCAXBIDuLFJMS+u0i/TE4YOw8ULu4LkWuRYdLy/GUu9Wd+v
         bMXycR4Wiqt9QtUXPQ6mFZbL6ElEIhWZMZPivyw90graIg9DJIDIWad+sCfix3OBRLAh
         2iiw==
X-Gm-Message-State: AOAM5317qMVk3o2F8zVlrgIr9zmw4T0mIBnpmri4E+d3MIWJ+Wt+/Iqb
        BQMQD3qKGv9oEtOeUkazrtRFIlQoPoO2hN1K+OQ=
X-Google-Smtp-Source: ABdhPJzS1DbmwHDkDQyZuJ1ge2qE2/h1BIrQbgSq6Qh6kgBDmgO4P0B9b7LIvRNVpIKodDSiCCgDi9vH/FaoH2Upm6Q=
X-Received: by 2002:a02:ad08:: with SMTP id s8mr24445683jan.40.1627440613760;
 Tue, 27 Jul 2021 19:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210722030352.3966-1-thunder.leizhen@huawei.com> <20210722030352.3966-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210722030352.3966-2-thunder.leizhen@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 28 Jul 2021 10:50:02 +0800
Message-ID: <CAJhGHyDtcxtc1NPXB7rt88vEXyVHE0c=QWDuA2UWpXeJqzCQHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] workqueue: Fix possible memory leaks in wq_numa_init()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

On Thu, Jul 22, 2021 at 11:04 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> In error handling branch "if (WARN_ON(node == NUMA_NO_NODE))", the
> previously allocated memories are not released. Doing this before
> allocating memory eliminates memory leaks.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/workqueue.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 50142fc08902..79cc470bd9ce 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5896,6 +5896,13 @@ static void __init wq_numa_init(void)
>                 return;
>         }
>
> +       for_each_possible_cpu(cpu) {
> +               if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
> +                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> +                       return;
> +               }
> +       }
> +
>         wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
>         BUG_ON(!wq_update_unbound_numa_attrs_buf);
>
> @@ -5913,11 +5920,6 @@ static void __init wq_numa_init(void)
>
>         for_each_possible_cpu(cpu) {
>                 node = cpu_to_node(cpu);
> -               if (WARN_ON(node == NUMA_NO_NODE)) {
> -                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> -                       /* happens iff arch is bonkers, let's just proceed */
> -                       return;
> -               }
>                 cpumask_set_cpu(cpu, tbl[node]);
>         }
>
> --
> 2.25.1
>
