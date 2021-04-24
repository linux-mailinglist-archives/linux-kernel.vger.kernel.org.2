Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75400369E60
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 03:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhDXBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 21:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhDXBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 21:24:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 18:23:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s4so9945236qtw.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1dtGHCCWZvvr6CUZxSFYg4ycltQtDMhB55xHyddT1U=;
        b=iPzgLMbqNidTWALjuay0axgZy8gCv7UEhtPJQltTbuSoObd5x9zd1vKuc8IhZgpO8p
         IWCLl//lvaWrBEx/ATyPLwfx5gEByi606E4QKANTfdiEyg74Y7LNZp+g5uJQ458spFTJ
         Bl9rmukBGpJmzdIaVwV+UhqH1onrbm2bRZnYAvUAA0m75SkbApOe/ZBH7MEupfF1/IyW
         iFfGFl/GSpfK/DuX8RUXf2Dlj//+T3qCp/q/wlQmIiJIncWn0qx7f7rHhRFWNFppuAK4
         XqA5TxuiW3uSTMpND1F24sAX0S9XMr39yEZkPeCfNYu6mQIjSHiWL+oP1E4map+0jm05
         NnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1dtGHCCWZvvr6CUZxSFYg4ycltQtDMhB55xHyddT1U=;
        b=BXgBnH0V4vCfejg35dqXssu8gi5zFo4bGY/QtbtNLL4ttrTmttc7GOPvs8yZ1JShvq
         eNxIBQP6PW25OZaBUcL9pucpPWR6lAiVK/tsyvU3x0PeRXgBl6HD4tTKGBiSgaeZjRDU
         oOmKIg5MEqrYmuQ8YigYJcbofxNbE/3BZ6Brurx3hN5U6K2nBBePo0TjLXCLmJathqHK
         e+eale7c6BRudAxQGSbw4jx5bx8wKR4P2kth+GW6ivHR7hD20Kz5BeIXLaUJw46aTlAt
         k+e0P5i2Fsiv2oR7tsghPeoSoSAOhPQiU+yl6TpL7L78CIJSXkHnlbQgLJJibjTeeIOI
         wokQ==
X-Gm-Message-State: AOAM533i6zEfcB4j0eBc/IDQnDaTYelJbugGnmbuv7DDDq4ZypT9Mvjn
        1N9Bx3jyB6eLl8UhC6sy39ARySY6ajqIeXj/q5tPaw==
X-Google-Smtp-Source: ABdhPJx93J/4VFwNJBe7TbrHDN/vekXXuyX5e7MHnFJJ5sLxOsvTVWjFY+y+2vzfaTEJgdpjpdunXWK9g7C1/uaoy5s=
X-Received: by 2002:a05:622a:3c8:: with SMTP id k8mr6422988qtx.101.1619227383594;
 Fri, 23 Apr 2021 18:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
In-Reply-To: <20210422123308.196692074@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 23 Apr 2021 18:22:52 -0700
Message-ID: <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
>
>  void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  {
> -       raw_spin_lock_nested(rq_lockp(rq), subclass);
> +       raw_spinlock_t *lock;
> +
> +       if (sched_core_disabled()) {

Nothing to stop sched_core from being enabled right here? Leading to
us potentially taking the wrong lock.

> +               raw_spin_lock_nested(&rq->__lock, subclass);
> +               return;
> +       }
> +
> +       for (;;) {
> +               lock = rq_lockp(rq);
> +               raw_spin_lock_nested(lock, subclass);
> +               if (likely(lock == rq_lockp(rq)))
> +                       return;
> +               raw_spin_unlock(lock);
> +       }
>  }
