Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF50D412F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhIUHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhIUHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:22:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:21:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b65so695082qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mENWrzcGfeMwf5j5uGdfYDPIoh6DlftAgO7UGIzezHc=;
        b=tus4NAuSDitqrgdq0BunDysH8J0/tKmbv+tr3dlRXk8BatIYPuNAiLMPk3bZ/XK0HX
         tCldiQYqv0dLn56zKVswF6WmEcPoufeHSFVgM5pD0zh5tWfuPZbM+bpNpQ7s4ekSTVrV
         Dhjb8bdnHZ7+xzMVIP5krjvT3yrCaIwswR7kGfcvITPLyyNJG1MZiYqQXxilXSoh4HSa
         Vo6bO2Qc11durkc8Ha0jBoDxcb/p/uuqJ5YgY9KGTvO8Rdl/KNes34IOj1Y2Qh/e91Rj
         aRUslJ690i/OBBtjruHmvqi9bTxTxHve7+CdOlLx84rDfYO+fPbYfERZ21WFiByxuseQ
         y3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mENWrzcGfeMwf5j5uGdfYDPIoh6DlftAgO7UGIzezHc=;
        b=l1yzSel5x9/mLVCQx9hGmB1WtzHOV1Bg4E5g9/MB80Bz9DR9lKIiIc03GaeiY1GU88
         MNN6tOtAQENzBX7KNdRH+TPdOWNmESE/JBs0Rhvj+WezdiZa77co60Vq0WaQFTvLAH51
         zWy3+ZpHBSJ2ySToRJgIpXyRu7I32MXLg4hgVXHtjI6Kshq5YXnRzritXcJKsWUkzShD
         QmR7cV/XVoIpJ1XC9ddfYfDSm+8EsT+mZ22Ev0yYfvYZYXWsgiN44yN5oLJTs5eLL0gp
         elSzFZs/nsNGWM5eo3TDDlRF/DJHKi1Jh5mU5V5jwdGeqMCI/eRo9zNziS5Cxduh9yOM
         tO9Q==
X-Gm-Message-State: AOAM531Rwr0uOy33OhY3xnMArh6JIEpa/bNwAoi1ofkgMnj44GKfRcmp
        g70yCpLKcWCRlGfevR7F4i6AkUcBezN1ZVzqOGh3qQ==
X-Google-Smtp-Source: ABdhPJzDXF3tY9LIAG9DeZVJyeipFMUVynSY9u/J0EiIizzCMIJcC0Vt+u448Z+B+SXsytl6FFhYaxMk/ctKp0EiJPI=
X-Received: by 2002:a25:94e:: with SMTP id u14mr11986829ybm.425.1632208887664;
 Tue, 21 Sep 2021 00:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net> <20210920142614.4891-2-mgorman@techsingularity.net>
In-Reply-To: <20210920142614.4891-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Sep 2021 09:21:16 +0200
Message-ID: <CAKfTPtBTL+KTJdEWv=-6OF8mFvnWUQ1PWKufzhKOASzMcUbnww@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Remove redundant lookup of rq in check_preempt_wakeup
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The rq for curr is read during the function preamble, remove the
> redundant lookup.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..038edfaaae9e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7190,7 +7190,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>         if (cse_is_idle != pse_is_idle)
>                 return;
>
> -       update_curr(cfs_rq_of(se));
> +       update_curr(cfs_rq);

se can have been modified by find_matching_se(&se, &pse)

>         if (wakeup_preempt_entity(se, pse) == 1) {
>                 /*
>                  * Bias pick_next to pick the sched entity that is
> --
> 2.31.1
>
