Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107EC373F79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhEEQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhEEQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:21:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:20:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so3208949ljf.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1Ws7hM1g3rNgVo1qWsRwG/a83biuh7qtkH5oZYDPSU=;
        b=OZ0sPHITT95pix7g1f4tFO1QvbWd0iotKP+cq6CWiQWL34gkkhfHldPGcumua4eEzy
         1dmAGmAc88gWo0TyqBornHH+r5ZmjBm3SwOPeZoXlijBszxa34EOcQU8abehFvOcHxrW
         9dRP1+b0FpMGKci3bfm9EpKePM6RfHMOPNNRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Ws7hM1g3rNgVo1qWsRwG/a83biuh7qtkH5oZYDPSU=;
        b=FW+F7ab24/O57D9hQso4aihayazymHIaFuMAjf9irRUyFxv45z4UuKVP+5JdEpI3Do
         3LhfEooknaFdmegw5WccMXb60A1hgnRBffChYKuLQptyVr2S2pRu9RDYxrO/1O7dKcQJ
         JZ8PYc3hfgtSs5F040yhA//0RpoY9bBeY6cXhD9u1NzgI8Fq7rwohN7/QMoumUTXxcdD
         DIc6X4NzMAmLAUx2sIFaZqQ/RuPLbDGuqhvWZIReRkvDVF6pJ/FO4+mEO2oR8LF6XaA0
         JKH5L+/z9boY6g2+8zf0mxTKRnckdcFqTZuotB5kgRHLcxYUKp7CaOVrjJ0Rjqe3/r07
         6XZw==
X-Gm-Message-State: AOAM5314QcTYIJAsOJHjX/iWjb5STUeCXo+Tt8dAiWnZZYLuzHOxXQCD
        EwOr6CD8uZ4IoJIUCjyb0A6E2fYnTYjca7qE6klBlg==
X-Google-Smtp-Source: ABdhPJwY7XL1YMMiuzL4xxfdLqpToW4DgoXwsuvb9sT2O/23Zox3v0QUIDcVcZsxwLlmLD/PUEix07h1Ubr1p9rkYuA=
X-Received: by 2002:a2e:a373:: with SMTP id i19mr14169965ljn.49.1620231649796;
 Wed, 05 May 2021 09:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
 <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com> <YJD56sBCGviSDOTK@hirez.programming.kicks-ass.net>
In-Reply-To: <YJD56sBCGviSDOTK@hirez.programming.kicks-ass.net>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Wed, 5 May 2021 09:20:38 -0700
Message-ID: <CAOY2Wowj-EEARi7b4X2wvaJExj_yQ1w5tgBRdnXX5BYJY0U15g@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Aubrey Li <aubrey.intel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 12:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 29, 2021 at 01:39:54PM -0700, Josh Don wrote:
>
> > > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > > +{
> > > > +       lockdep_assert_irqs_disabled();
> > > > +
> > > > +       if (rq1->cpu > rq2->cpu)
> > >
> > > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > > can't guarantee the sequence of locking when coresched is enabled.
> > >
> > > - cpu1 and cpu7 shares lockA
> > > - cpu2 and cpu8 shares lockB
> > >
> > > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > > double_rq_lock(7,2) leads to lock(B) and lock(A)
>
> Good one!

Hi Peter,

I've been running the same set-cookie tests on your latest repo for
the last 24 hours and haven't had a single lockup. Thank you very
much!

don
