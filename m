Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9803F3C97
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhHUVw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhHUVwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 17:52:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5FC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 14:52:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r19so19508616eds.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FA15b3HaMrgohgqq79FKnNS7R8dZbz2wHzJGEeC4Ek=;
        b=YYmOMHPO2QxvO4Uwdb1qy5jqdc1fTmRIxv9nK4qdbWYKYKIElgJIqBH1aj/k4FJb9g
         OROyhFC+h91RenWHH4cy/9hendUziv61ErdHmh5ZxRKJSWivtIeoEeFRUf4vOum5MFoh
         +2AnkzBjyvp6ziZHStFF1lSToq6EBaBOaesJDf+T+R/IFRokC+wn1ltW39kin9oc8qYp
         +vjfptgip4xAi11JZVobtb33KMzyxPrJEbmayUuNp5oG2tqnDTAl2Be+JmeCO2Hz7xre
         /hvM/rXNPaS5iJLc8CHJuLqy+QbTi3Nnd4XFKs7dChcCBhPgGWbbxvMzsOtA60P2bOOt
         xdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FA15b3HaMrgohgqq79FKnNS7R8dZbz2wHzJGEeC4Ek=;
        b=Q5ajs1D+XZQU1PSrS6d8Sx2IJ5OeCVaNbswy7z4SmJ8zmomGGFz1I/pf52VN7dgy09
         VzTeJ5zIhwJJhwcHuO3stIfvJsBzAvrowF6hEFbahblWF4xalIO+VtP3Dc9qhJZsJRpf
         4l6+/VPnZzr1HHNTMCIpMF90fE3U3FCCAvbYjZFnYh2qOp74Cwi/M9riqgSwypZEmxDQ
         HSpHIFtb9CHR1pcFf/1Nw6f8k/3cJ5cgCRoCtugQ0iDWCPl6FnG5OFAoGKOaaoCJg50n
         qNUiq0mg/ZsOgEGfM7JH3/di2VYqwJ+WAta8u4pAb28OgXU5LnYHsQ3i/euUo+F7Uigq
         d4LQ==
X-Gm-Message-State: AOAM5304YTOPTqrJw3IOt3T7gIJUhIBnoz5TxJzy3s75Q4lC6/q8L9ht
        1Kaqr0acVPU1ciu4gpWcPGY1Das7dDWkbfgvosM=
X-Google-Smtp-Source: ABdhPJxFFwqpNn48q2+9vNJxu8tgZvrpsxY7ymzw3DXrxQ6eciEwtrA8V9zMESUlSxEsrgVssLV0ZqZecBoG/2nrDDI=
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr29757416edw.90.1629582734135;
 Sat, 21 Aug 2021 14:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210821054111.63181-1-yangyicong@hisilicon.com>
In-Reply-To: <20210821054111.63181-1-yangyicong@hisilicon.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 22 Aug 2021 09:52:03 +1200
Message-ID: <CAGsJ_4xoxPEGnyS2eQRhtci3dycmRhLL9N=dEqVWq4Zxb30kXQ@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Remove unused numa_distance in cpu_attach_domain()
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, prime.zeng@huawei.com,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 9:04 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> numa_distance in cpu_attach_domain() is introduced in
> commit b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")
> to warn user when NUMA diameter > 2 as we'll misrepresent
> the scheduler topology structures at that time. This is
> fixed by Barry in commit 585b6d2723dc ("sched/topology: fix the issue
> groups don't span domain->span for NUMA diameter > 2") and
> numa_distance is unused now. So remove it.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

looks good to me.

> ---
>  kernel/sched/topology.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b77ad49dc14f..ccbb141df8c8 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
>         struct sched_domain *tmp;
> -       int numa_distance = 0;
>
>         /* Remove the sched domains which do not contribute to scheduling. */
>         for (tmp = sd; tmp; ) {
> @@ -720,9 +719,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>                         sd->child = NULL;
>         }
>
> -       for (tmp = sd; tmp; tmp = tmp->parent)
> -               numa_distance += !!(tmp->flags & SD_NUMA);
> -
>         sched_domain_debug(sd, cpu);
>
>         rq_attach_root(rq, rd);
> --
> 2.17.1
>

Thanks
Barry
