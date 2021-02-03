Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552D830E2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBCSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhBCShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:37:51 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:37:11 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d15so412130qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDZ4zUQUathmSBgUmBJagf1rz4sZemelNGHYxm7Q/As=;
        b=Q9vdUdD8SuC4ZiOIYkqQtcgxvQSmnFNLtp6sWeqmXGJjejm+JHNtmXtp9Hk5PISr21
         ExrLy1YTqwVXhWqBZGUkzi2TGE8ZKr3YfBtt6Cs1YvBjmpUSMC0xqivr0rbdVGDmnNrq
         8gwfSbzVHHHXabnWhk/JXLTLg6yW4g+iuvE10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDZ4zUQUathmSBgUmBJagf1rz4sZemelNGHYxm7Q/As=;
        b=G8HVSqXGPmKnhVAC/b7rLLBnZ0nfzZ0XtaTMQF+mM6qy94JgRbCjqpaNW8HYiHmqb2
         KiABEzXbfyUlXI1IZUUxku5+waROwhgmEfi7YfsITuBzWDPXkseU1AX8Z6rZH2fLy2tx
         exXpa9QX1XDK8idJlGt4ater0//kmjtcv55LsX5/sogO9l9DMpjgvF/5evZQQ4nPzCi1
         CjoDzf6BmraRLTiFKry4E4KnZAIbpE9D8WpeY1X+jc0sr2BglOO5uBcW0kKywwzVAb6C
         f0R8cI5epFrRumjFAGWz5X5A/kfKpqAb9RapXElfZc/g3Q0yhhZnpGNZTXC1dME2AaEj
         ytIw==
X-Gm-Message-State: AOAM5318t/wPSrnQMJ7rj0SM5WmMDLyre31Wh0013HzNWwGuDYq+/Jhc
        NWloJnRzaJXxV7nRn/M8gK2Qs9aV2Wlrvw==
X-Google-Smtp-Source: ABdhPJw2jDuYXiMTuojE4ebOuFAhCpi1Uuip8+UukOKdvhE1KDD9AJB5B7OB9K21gVmZ+9eEfiOFtA==
X-Received: by 2002:ac8:4c90:: with SMTP id j16mr3632028qtv.121.1612377429538;
        Wed, 03 Feb 2021 10:37:09 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t6sm2070313qti.2.2021.02.03.10.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:37:09 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id y128so531242ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:37:08 -0800 (PST)
X-Received: by 2002:a25:4fc3:: with SMTP id d186mr5919863ybb.343.1612377428338;
 Wed, 03 Feb 2021 10:37:08 -0800 (PST)
MIME-Version: 1.0
References: <1611555637-7688-1-git-send-email-mkshah@codeaurora.org> <1611555637-7688-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1611555637-7688-3-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Feb 2021 10:36:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WwufqMRRpT6Kk4=d9+S7xHLnNqH4+vOrRK2eW+y1ht-w@mail.gmail.com>
Message-ID: <CAD=FV=WwufqMRRpT6Kk4=d9+S7xHLnNqH4+vOrRK2eW+y1ht-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] soc: qcom: rpmh: Conditionally check lockdep_assert_irqs_disabled()
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>, Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 24, 2021 at 10:21 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> @@ -136,6 +136,6 @@ void rpmh_rsc_invalidate(struct rsc_drv *drv);
>  int rpmh_rsc_mode_solver_set(struct rsc_drv *drv, bool enable);
>
>  void rpmh_tx_done(const struct tcs_request *msg, int r);
> -int rpmh_flush(struct rpmh_ctrlr *ctrlr);
> +int rpmh_flush(struct rpmh_ctrlr *ctrlr, bool from_last_cpu);

Given that you're touching this code, why not do the cleanup you
promised Stephen you'd do in April of 2020 [1].  Specifically rename
this function to something other than rpmh_flush().

[1] https://lore.kernel.org/r/11c37c89-aa1f-7297-9ecf-4d77a20deebd@codeaurora.org/


> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 1c1f5b0..a67bcd6 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -841,7 +841,8 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
>          * CPU.
>          */
>         if (spin_trylock(&drv->lock)) {
> -               if (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client))
> +               if (rpmh_rsc_ctrlr_is_busy(drv) ||
> +                   rpmh_flush(&drv->client, true))

I'll channel the spirit of Bjorn and say that it's better to blow over
the 80 column limit here and avoid wrapping to a new line.


> @@ -458,22 +458,33 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
>   * rpmh_flush() - Flushes the buffered sleep and wake sets to TCSes
>   *
>   * @ctrlr: Controller making request to flush cached data
> + * @from_last_cpu: Set if invoked from last cpu with irqs disabled
>   *
>   * Return:
>   * * 0          - Success
>   * * Error code - Otherwise
>   */
> -int rpmh_flush(struct rpmh_ctrlr *ctrlr)
> +int rpmh_flush(struct rpmh_ctrlr *ctrlr, bool from_last_cpu)
>  {
>         struct cache_req *p;
>         int ret = 0;
>
> -       lockdep_assert_irqs_disabled();
> +       /*
> +        * rpmh_flush() can be called when we think we're running
> +        * on the last CPU with irqs_disabled or when RPMH client
> +        * explicitly requests to write sleep and wake data.
> +        * (for e.g. when in solver mode clients can requests to flush)
> +        *
> +        * Conditionally check for irqs_disabled only when called
> +        * from last cpu.
> +        */
> +
> +       if (from_last_cpu)
> +               lockdep_assert_irqs_disabled();
>
>         /*
> -        * Currently rpmh_flush() is only called when we think we're running
> -        * on the last processor.  If the lock is busy it means another
> -        * processor is up and it's better to abort than spin.
> +        * If the lock is busy it means another transaction is on going,
> +        * in such case it's better to abort than spin.
>          */
>         if (!spin_trylock(&ctrlr->cache_lock))
>                 return -EBUSY;

I think logically here you should only do the trylock if
"from_last_cpu".  If you're not called "from_last_cpu" you should do a
normal spinlock.

Also: if you're not "from_last_cpu" you need to use the "irq" or
"irqsave" variants of the spinlock.

Also: if you're not "from_last_cpu" I think you somehow confirm that
we're in solver mode.  The only time it's legal to call this when not
"from_last_cpu" is when we've previously set solver mode, right?
That's the thing that makes everything OK and fulfills all the
requirements talked about in rpmh-rsc.c like in the comments for
rpmh_rsc_write_ctrl_data() where we say:

 * The caller must ensure that no other RPMH actions are happening and the
 * controller is idle when this function is called since it runs lockless.

I know I told you in patch #1 that we shouldn't have two copies of the
"in_solver_mode" state variable and, on the surface, it seems like the
check I'm requesting would be hard to do.  I _think_ the right thing
to do is actually to combine your rpmh_write_sleep_and_wake() and
rpmh_mode_solver_set() functions.  One way to do this would be to just
have rpmh_write_sleep_and_wake() implicitly enter solver mode.  Then
you could change rpmh_mode_solver_set() to just
rpmh_mode_solver_exit() and have it only used to exit solver mode.

-Doug
