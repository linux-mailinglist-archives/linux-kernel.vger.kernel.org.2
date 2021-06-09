Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661843A0D97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhFIHUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbhFIHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:20:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BDC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 00:18:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so30344803ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6S6WSbvDAoIJSjQSu5bdy/8b+fKOvHIFk4YfVLW+HA=;
        b=HnZPZ+s+dU/dci5HNYB8E6pWlysvJhl+GZ6qiZe/VbSjT2OuxiGzdoGryfJ0uOeZT7
         sSRpIA7VW8YLF5/veAupn2tAQ3P0ZfW3ZRGQxs1bTN2EMBxt3/q8i8wJUtRvADKmtw8Z
         y+Ma4xiAeQjp+dLPf/NmIq5KxPGwr02ekUQL6AjCwWOO/sfceCu5qQcBs8mb3YCFrOsz
         WOqxMCsB67ixHQneiO37V/8RaBx47YEvi+VzIaJorJzzE3cYjSCHE62z6VAGGEY416/H
         cLSipYcNndWabH2Fn/PCDVDY1UKOv7jsYxrHsJZHdDi6IrG785ty8qGKPawcAjJ5mZrB
         YMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6S6WSbvDAoIJSjQSu5bdy/8b+fKOvHIFk4YfVLW+HA=;
        b=aUKEmEXj33s3g/bMWkKuNSwvacXxcSGIxvEVfDd2t3Ongn7M+BoVgksRSEFFL3ExWS
         BTciDwMPWZXAQeq1KSgbcXzZ7by/g7Q0WgsnlLFJN2flfgIZkTrDfDaertdStilSG0eW
         eZs6060cyj4U5B8/yNY2HPHiZMc7HbitpE6CGJJ9309me1fmL4JuNmdAmZLzmddZ+NKw
         sJzBkUWxG1fF33K/uvAq5mcr2/fMrz5NtXu0Smxyq0TldJ7WxXpLulBWXUXMM6nMDzR5
         rKT0/ETLm4sas1bQy3WeCxJikd9NJtWGxBapTSeU+c0E0wEJ+sWLQq3aX6Eeit9F0mYD
         2DhA==
X-Gm-Message-State: AOAM533HLCcaGRyj4jhSJxk/9thVuulj9Zp9hpAHTfB9fSdvOVcHF0Lr
        taKFSPwrQpJ/sSIhaBi8iSFROtlvzL6V+pldEG22Ig==
X-Google-Smtp-Source: ABdhPJwN7YJIUVMxZApkKAad9gmiyYbfJWBzLP6ls9LNwude42v+J9POiYEHh860CnHuGwDHTn2GfD63ADK4BflRmq8=
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr20571859ljk.176.1623223123606;
 Wed, 09 Jun 2021 00:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2106082138350.16734@hadrien> <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net>
In-Reply-To: <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jun 2021 09:18:32 +0200
Message-ID: <CAKfTPtAbPg=4os6F0QKMhDnP4gYE+5hWCkA365xG79acRTYWyg@mail.gmail.com>
Subject: Re: find_new_ilb
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 09:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 08, 2021 at 09:51:30PM +0200, Julia Lawall wrote:
> > Starting from the following commit:
> >
> > commit 45da7a2b0af8fa29dff2e6ba8926322068350fce
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Tue Aug 18 10:48:17 2020 +0200
> >
> >     sched/fair: Exclude the current CPU from find_new_ilb()
> >
> > up through Linux 5.12, I observed that often when most of the machine was
> > idle, there could be many (thousands) of sched_wake_idle_without_ipi
> > events, typically between cores 0 and 1.  I don't see this any more in
> > Linux v5.13-rc1.  I looked through the patches to fair.c and core.c
> > subsequent to v5.12, and I didn't see anything that explicitly addresses
> > this issue.  Before I plunge into another set of rounds of bisecting, I
> > wonder if anyone knows whether and how this problem was resolved?
>
> Hurmph.. that patch was preparation for a later change that never seems
> to have happened. If it is causing trouble for you, I think you can
> savely revert it.
>
> At the time I thought it was very strange that new_idle would select
> itself as idle-balancer, doubly so, because the only way to get there
> would be with NEED_RESCHED already set, so the IPI wouldn't in fact do
> anything.
>
> Looking again, the difference is ofcourse that previously we'd select
> self and NO-OP, but now we'll potentially select another CPU and
> actually do something.
>
> This is arguably an improvement, because we did want to do something.
>
>  I can't quite remember what would've change here since, Vincent, can
>  you remember?

c6f886546cb8 ("sched/fair: Trigger the update of blocked load on newly
idle cpu") could be the one which fixes it.
We don't kick_ilb from newilde_balance() since this commit

>
> Anyway, is this actually causing you trouble, or are you just going on
> the increased number of events?
