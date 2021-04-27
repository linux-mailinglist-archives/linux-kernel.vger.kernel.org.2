Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB39436CF95
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhD0XgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhD0XgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:36:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8EFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:35:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g1so3823995qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFOg3FnuSukMzcXPafwCSs1Akz2Qsjm2Rc+MelOWc0o=;
        b=W6WOAxRakarGVDJMLzZYzYfp+pqBCba8m21BGC12moMJdca/FAJRez9U3l6IXxK5Jh
         sZzeRmLf91kfwpU7PuhLQDZuMhubs012rUwHH/v1sbR3TOaSQri31TCrYrZiKUuuuQcV
         ix8B58wFK1vggNidb6PtSdlC7XhOg9ggA4Y59NjGEiQAv2rxmb+CIcvBtKvTip6+g7wt
         vdOmcNUVr7pjYW2KseNKQdA74JwoXzjhEL6FrK2xIl7uJv2Puvb4rdB5SPyvfXaOY3uF
         AfuHZLoi7PXEuD0R31O6Qcv0VDLY+VRnU/sXUGhL1RxELPUnpVWHoXIbTLuArjFnvdZY
         LyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFOg3FnuSukMzcXPafwCSs1Akz2Qsjm2Rc+MelOWc0o=;
        b=czuZdC+Z6tLS2zlbr1RQ+2IJv7t1Kha/SYSXaoKUueW5FoVJrC3a5e4ijxE/PpDVX0
         2ZY8aaz0TmeGxJLuMTIPcvujGLozePi9K4TJ7ZNVuG5AirSSUQs9n7CXC2iFuQXqIhAa
         QBc8P4F4gx2jOvOo0aDKv4/1lrjYVU+fDdH5XFP7z4SHo4HvoCTbl4n5eRwr6XAh6pO7
         jxfpebw3SMmLn9DjuBPLsxoBT7RcBpBcvE6xxNzjLL/fE+XdS3ARr/jaWSzudPLBtb1C
         saxwitoYp9XIAVlF0ZmgltDZ9EebBup1sizhE6l00mlLu1y1Vw6TyyYw5hUSvqm+p4Rg
         m7ZA==
X-Gm-Message-State: AOAM5329+sFYrgSkMFf7Y5m/49izIzMxgSVwIojcLe8rE+VNZn27ubi2
        RvcMdm9OVNeAwHBnO8XWBtCWQzwxul2qN44bgEW0NQ==
X-Google-Smtp-Source: ABdhPJwRrc2rPalGj52Jf5yDesAex+/CFetYPvky0mbaLA5hRsvx47+00bTENNgLqOrKTT89bV9IuvONJ0Fk3JoWjOU=
X-Received: by 2002:ac8:675a:: with SMTP id n26mr11778931qtp.101.1619566519067;
 Tue, 27 Apr 2021 16:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
In-Reply-To: <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 27 Apr 2021 16:35:07 -0700
Message-ID: <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Don Hiatt <dhiatt@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
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

On Tue, Apr 27, 2021 at 10:10 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> Hi Josh and Peter,
>
> I've been running into soft lookups and hard lockups when running a script
> that just cycles setting the cookie of a group of processes over and over again.
>
> Unfortunately the only way I can reproduce this is by setting the cookies
> on qemu. I've tried sysbench, stress-ng but those seem to work just fine.
>
> I'm running Peter's branch and even tried the suggested changes here but
> still see the same behavior. I enabled panic on hard lockup and here below
> is a snippet of the log.
>
> Is there anything you'd like me to try or have any debugging you'd like me to
> do? I'd certainly like to get to the bottom of this.

Hi Don,

I tried to repro using qemu, but did not generate a lockup. Could you
provide more details on what your script is doing (or better yet,
share the script directly)? I would have expected you to potentially
hit a lockup if you were cycling sched_core being enabled and
disabled, but it sounds like you are just recreating the cookie for a
process group over and over?

Best,
Josh
