Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C5405940
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhIIOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345692AbhIIOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:40:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD7C1A2712
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:57:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c6so4033164ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EkCohunn/+mC/jSWBz15+/M/vV581iWFTVnfu3rN0g=;
        b=MaQiTjjd6tqU3Ygf6YiUkneCJu9l9HASHDJr/IZplqp1CZptLIuTvRROIdruxn5843
         X94MoAbD3WPlQNNgfYuEvRpczID3Vk8dezuz9z2zNzB0+o9sttFoqSLIfIzhKwGozY+G
         PyxnuguAW5x+vyYHtsniBudhen0erbyHZ6jQB+nhi0TUkDtRxMdxnnktwstX9+rZ0MDp
         SnCiZDEZ0oSiIUz1h6PYgVmv8R1VALwNlX7PRnAJIgctRnIAMhx+RktvtmDWUGwU7K0Q
         Iz1RVDw094MizPepF88Ow/mwqV/dkOCXYmO1iWiplHzMo68pPt5JX0AcK9cDbbzW8WM5
         unmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EkCohunn/+mC/jSWBz15+/M/vV581iWFTVnfu3rN0g=;
        b=nCinvk42vO43FKb12NUfHRSnsaUCXkB6dRmdgsAdysD2Re1wUoNnHnMs63AcYNpQRy
         XIKUAezxqB+3oIg6xaJ+j63y27ZXDLCSAhrYjgB5dLineeZ1XvSB94hC3hBeaxFUTw3u
         wpUom7poNFIJYYAVfPlJDiUjUaIXSiaIowhfTUtvHbtn1+GHP/+d9Kwl90R5/dl83io0
         mlGWOQpwi99IaB6Y5j3LweGEv85tePdbaOPD1Qzzan4dl/19IoBbrxPE6x+AutsSbN5m
         i2EuyJVujWcKrw7cmzw3mkzlc83wq8Gi0F1kCb7fhhwF4CUX4tjMpE/a3ZwcbIJfuq3t
         F0Cg==
X-Gm-Message-State: AOAM531G4pO6bRu5Xo4h5E55C9d3XNoCQyz2JTgsx1HJ5EdSXCw14LtU
        qXNa/g9jD96w1i+r+YO6fQFbedtRKiY1rLk14zOZJQ==
X-Google-Smtp-Source: ABdhPJwmx4mQgaDIpCS7abNgp+sVKS+DgAcvz59709nJwhMGU/y8N9IFYCwJS/hWTYCY8xMynKjIwx3nCh48RIZJ6BA=
X-Received: by 2002:a25:5645:: with SMTP id k66mr3973824ybb.259.1631195868590;
 Thu, 09 Sep 2021 06:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-2-mkoutny@suse.com>
In-Reply-To: <20210819175034.4577-2-mkoutny@suse.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Sep 2021 15:57:37 +0200
Message-ID: <CAKfTPtDkOcAwQtfHhQ_OZH7UZ0fDuhqoNrGLPFO3ikkWMPuSFw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] sched/fair: Add ancestors of unthrottled
 undecayed cfs_rq
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 at 19:50, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Since commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to
> list on unthrottle") we add cfs_rqs with no runnable tasks but not fully
> decayed into the load (leaf) list. We may ignore adding some ancestors
> and therefore breaking tmp_alone_branch invariant. This broke LTP test
> cfs_bandwidth01 and it was partially fixed in commit fdaba61ef8a2
> ("sched/fair: Ensure that the CFS parent is added after unthrottling").
>
> I noticed the named test still fails even with the fix (but with low
> probability, 1 in ~1000 executions of the test). The reason is when
> bailing out of unthrottle_cfs_rq early, we may miss adding ancestors of
> the unthrottled cfs_rq, thus, not joining tmp_alone_branch properly.
>
> Fix this by adding ancestors if we notice the unthrottled cfs_rq was
> added to the load list.
>
> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on un=
throttle")
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/sched/fair.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 44c452072a1b..2c41a9007928 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4898,8 +4898,16 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         /* update hierarchical throttle state */
>         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)r=
q);
>
> -       if (!cfs_rq->load.weight)
> +       if (!cfs_rq->load.weight) {
> +               /* Nothing to run but something to decay? Complete the br=
anch */
> +               if (cfs_rq->on_list)

Could you use !cfs_rq_is decayed(cfs_rq) ?

> +                       for_each_sched_entity(se) {
> +                               if (list_add_leaf_cfs_rq(group_cfs_rq(se)=
))
> +                                       break;
> +                       }
> +               assert_list_leaf_cfs_rq(rq);

Instead of adding  a loop here you should better jump to unthrottle_throttl=
e ?

>                 return;
> +       }
>
>         task_delta =3D cfs_rq->h_nr_running;
>         idle_task_delta =3D cfs_rq->idle_h_nr_running;
> --
> 2.32.0
>
