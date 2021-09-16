Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C840D670
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhIPJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhIPJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:43:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:42:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i6so14493241edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkYu1lw4ao2Pl7aRunbroKZzwvKLn6iaFbfPPpdwLXI=;
        b=lqbMPt6/yAVsatYtPBdMRBC+LT4XzqnLxdg2zU8Rphzg1GGLd2MBrUUThtz0PQpN1m
         ET4AzpklpakJ98ho+sYnJjyG7/Ku5wBhbg7C+9RoM4QGOuTUYY0SHjHj+YlYE+En6LTs
         42LTs4nYXrJLuvNYZ0mWk6ifs1rx2Z8L7ryCPftYNklzQvkUhx5lRzEqiULN5l9LUBBt
         RNcNBZlYUUBv0uSjNC0Ge6zRmjNgqG8p9hFmqs+GTQ91lMPxZbBteQ1FjHI9eBDpZU31
         vsuL7s/lSlNbE6x5ZjjMsl+UrhcfceIj6T/2rJ0Qp4oMDslgPivFa/Juh36FYMgYthlI
         m7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkYu1lw4ao2Pl7aRunbroKZzwvKLn6iaFbfPPpdwLXI=;
        b=mQgM714arxNEQNZyDJeNiO2KUY7wrrj9IENxT9g0jDeE0/z6amWo0pfZEJYkH99uih
         azHZX2wGq/MBJ9p/A/T+O6JIPszkzChpkodmE2WEKzNIXVXK/nu0uv4GGerSy9OW2bW+
         kAOnsyeI5Q94A31AvDWbMol6duEaIGT4OhygH/ZPbT/qG9MpjF9AypvCn56OsFedJb+T
         fbeH7VSto//7GGH4PjIm+8qlLbXu3MTwsIbEH4UKpfZfkhzcI8EPTFtnWNFs/5nJXBqk
         8mdj6cJkgzuYG/yv4XdP5odvTVvc7C+nLT3XoHqD9dbFEPN0EQrG/ShGs7sjvVqSvAJE
         XqAg==
X-Gm-Message-State: AOAM530idnWDP2boDW4UbosWwdKRobjhamlnEWpVwoo5vKRVtNhU4CTI
        MQDFLF5cZM2Kni+Bt+llf4lt1SKttwkPYr7s/mY=
X-Google-Smtp-Source: ABdhPJynf9YplaEZENmJ+c/7fRQOdh5/aTNlJtpRhORMcAk7ComFGbh0eDedBuOsY7C6Kcg+0XPwFFdypKBWsM/p+MY=
X-Received: by 2002:a17:906:3383:: with SMTP id v3mr5441461eja.213.1631785352959;
 Thu, 16 Sep 2021 02:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210915063158.80639-1-yangyicong@hisilicon.com>
In-Reply-To: <20210915063158.80639-1-yangyicong@hisilicon.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 16 Sep 2021 21:42:21 +1200
Message-ID: <CAGsJ_4yR+GNFsc=NDkb=-9j1EQmk4vip5kTMte3gHB+i=B9NcQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] sched/topology: Remove unused numa_distance in cpu_attach_domain()
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>, prime.zeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 9:55 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
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

I have double checked this patch and it is quite right.

When I removed the code of WARN_ON(numa_distance > 2), I forgot
to delete the numa_distance which became redundant.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  kernel/sched/topology.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4e8698e62f07..690bd1ab86f3 100644
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
> 2.33.0
>

Thanks
barry
