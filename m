Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8F444A99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhKCWGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:06:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33178C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 15:04:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so3814755plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FnZqO1IMdzq8wU1zijNxLzNNlvhO9ROCDZLIn5F7WXw=;
        b=NALeNLaEj0q+lTNaFwxNx2kr8N37bLX5zH9LG3K7M25vhaZwyiajWu90PZiJL6Q4FC
         D/43UvnUOijdw0VUg/kBc4bHcSqAFwB5BwEtD2ihZXTk335DdXiJoyqIzH9WTJzI6nAl
         dekrVuubnwYq0zsRGvuUbCalBwxJaU8xadLAfXb6q0VRYufyguyC2MO0vT4fD4DlMxm5
         BmsuipEoCeTvAdDe4xJCGhwcwtrpj9dk6AGFEPuon+AzqHIy6o7VbcjAXderjJBMTwbe
         5sca01hUKIENXVX0YIHdB7AXBeL7n+rDit13fl6dwhybEOR7W18NSnO4R9uUaBqtvRAT
         D56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=FnZqO1IMdzq8wU1zijNxLzNNlvhO9ROCDZLIn5F7WXw=;
        b=ZELU3VB0Cg6fUioDhBMKLP1G7F+0jZuDpwmmclaB0/GDZ/HE4MHDwnozRXL+bO81Er
         3IZemdmCPd1endNftHN+5ib/YN4sS4LMasBbttRvmD70mchgAQng2qu7LKDWO/g7lWQK
         IC4J5jRxpEfkovxRwEsKTn/2OLKKUnOIoxQoouBgSx0EW2YdUWHectXN/LprqlVLLevi
         xF2P2rWaI4gkOthqVXofPX1aGSLQ4T+UJsUGZaTgqq/13gUDIlxBlKY/9ljURAiw6DEp
         y90d6SlfxIThjA4CtVEFVuWtlTIAvXRDL1AGN/yoBbSj0hwfaq4MWRNfB2bFQGkRFwDh
         mBUg==
X-Gm-Message-State: AOAM533I/88LpeChjr6Hotlr0ZPsn9zedIH+BSZmy8/X7TR1hhwwDUMU
        t/1Pu3B6nfR90PGIVysVgq+QsQ==
X-Google-Smtp-Source: ABdhPJz3mrAC2mwCEy/rB6zdhdeZ6JyHQHkaPx4nDb9raM0fNnEUccmjASdKN0jD9kJu8dGejkxXPw==
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr17173700pjs.133.1635977049546;
        Wed, 03 Nov 2021 15:04:09 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id j8sm3575719pfu.27.2021.11.03.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 15:04:08 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
        <20211103190613.3595047-1-minipli@grsecurity.net>
Date:   Wed, 03 Nov 2021 15:03:58 -0700
In-Reply-To: <20211103190613.3595047-1-minipli@grsecurity.net> (Mathias
        Krause's message of "Wed, 3 Nov 2021 20:06:13 +0100")
Message-ID: <xm26ilx86gmp.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> Kevin is reporting crashes which point to a use-after-free of a cfs_rq
> in update_blocked_averages(). Initial debugging revealed that we've live
> cfs_rq's (on_list=3D1) in an about to be kfree()'d task group in
> free_fair_sched_group(). However, it was unclear how that can happen.
> [...]
> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on un=
throttle")
> Cc: Odin Ugedal <odin@uged.al>
> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
> Suggested-by: Brad Spengler <spender@grsecurity.net>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  kernel/sched/core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 978460f891a1..60125a6c9d1b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *tg)
>  {
>  	unsigned long flags;
>=20=20
> -	/* End participation in shares distribution: */
> -	unregister_fair_sched_group(tg);
> -
> +	/*
> +	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
> +	 * sched_cfs_period_timer()).
> +	 */
>  	spin_lock_irqsave(&task_group_lock, flags);
>  	list_del_rcu(&tg->list);
>  	list_del_rcu(&tg->siblings);
>  	spin_unlock_irqrestore(&task_group_lock, flags);
> +
> +	/*
> +	 * Wait for all pending users of this task group to leave their RCU
> +	 * critical section to ensure no new user will see our dying task
> +	 * group any more. Specifically ensure that tg_unthrottle_up() won't
> +	 * add decayed cfs_rq's to it.
> +	 */
> +	synchronize_rcu();

I was going to suggest that we could just clear all of avg.load_sum/etc, but
that breaks the speculative on_list read. Currently the final avg update
just races, but that's not good enough if we wanted to rely on it to
prevent UAF. synchronize_rcu() doesn't look so bad if the alternative is
taking every rqlock anyways.

I do wonder if we can move the relevant part of
unregister_fair_sched_group into sched_free_group_rcu. After all
for_each_leaf_cfs_rq_safe is not _rcu and update_blocked_averages does
in fact hold the rqlock (though print_cfs_stats thinks it is _rcu and
should be updated).=20


> +
> +	/* End participation in shares distribution: */
> +	unregister_fair_sched_group(tg);
>  }
>=20=20
>  static void sched_change_group(struct task_struct *tsk, int type)
