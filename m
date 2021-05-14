Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3964F381158
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhENUF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:05:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhENUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:05:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621022652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9YNoc2u4aHJVAwRc8IfbePnnshaE6hk3km7pg3eMWE=;
        b=pSoyUe5BgY9RPZs4kiNns56WDgqEeJKV43FsAYITJ0CFP27R8C5r+YwXsPjRed42XP0xWT
        13agdBDWMo/274PxHWpJOkhWFN8qVXaFRlpBzIpvhKId8vb/wX3h6ll5niVzL6rdpUJJlm
        1rH7UC83Dythl5B9j85Ah6FF+Gp4rZw1x1yCkEpxCmUbI+r8PyB6sHPeTNkbcYLxdng+Q6
        U4x4B0dzVEHU7ttzztNkqa/mvQ6YXILf2sYBbbiazXiyyJcdvgs9h6ndsuDmQVXpLLHGU4
        p27LSbVZUxW7X8K8nnpRmvbbH92cex7XN2scBjN8nLi750ih7HtIHRsAIwVeTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621022652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9YNoc2u4aHJVAwRc8IfbePnnshaE6hk3km7pg3eMWE=;
        b=V3zHiKzMoWd1KNGnMRPJRdgO4tIZV26Y7W+thUxrvHwdUwTNI1l73bKhyvY807licquTcl
        bq0U2uSNwuzqTBDw==
To:     Yiyuan guo <yguoaz@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: A possible divide by zero bug in alloc_nodes_vectors
In-Reply-To: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
References: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
Date:   Fri, 14 May 2021 22:04:12 +0200
Message-ID: <87zgwx2ibn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14 2021 at 19:31, Yiyuan guo wrote:

> In kernel/irq/affinity.c, the function alloc_nodes_vectors has the
> following code:
>
> static void alloc_nodes_vectors(unsigned int numvecs,
>                 cpumask_var_t *node_to_cpumask,
>                 const struct cpumask *cpu_mask,
>                 const nodemask_t nodemsk,
>                 struct cpumask *nmsk,
>                 struct node_vectors *node_vectors) {
>     unsigned n, remaining_ncpus = 0;
>     ...
>     for_each_node_mask(n, nodemsk) {
>         ...
>         ncpus = cpumask_weight(nmsk);
>
>         if (!ncpus)
>             continue;
>         remaining_ncpus += ncpus;
>         ...
>     }
>
>     numvecs = min_t(unsigned, remaining_ncpus, numvecs);
>     ...
>     for (n = 0; n < nr_node_ids; n++) {
>         ...
>         WARN_ON_ONCE(numvecs == 0);
>         ...
>         nvectors = max_t(unsigned, 1,
>                        numvecs * ncpus / remaining_ncpus);
>     }
> }
>
> The variable remaining_ncpus may remain 0 if cpumask_weight(nmsk)
> keeps returning 0 in the for loop. However, remaining_ncpus is used as
> a divisor, leading to a potential divide by zero problem.

How so? It's guaranteed that there is at least ONE node which is not
empty. So remaining_ncpus cannot be 0.

Thanks,

        tglx



