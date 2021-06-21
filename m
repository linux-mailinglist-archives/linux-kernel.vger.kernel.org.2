Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450503AE5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhFUJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFUJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:19:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:17:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so4417443ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/sPeos/C5F1U494DWZt/eYjG4B+Gq4D4knUrPa6L6o=;
        b=WmCweXRLsmPL+YPcYBzgOGYAJSaVIPt35+R/Y9LiTX0W8JNUDE+Ka0GYFDyEgXs2Jz
         n+4QHyAgnYuupit8ckQCM9D5jmDl84ZJB1f5nIrTur45+LtcGHPdX9UGN7zW0vvE4++t
         mBgr9X3KCD5ZY2+bqbDlRSppgP9E2rCjAq0ogQW1CO5uMggwCS9TlLo8V3KFaMTX6fRB
         4MVBNxZNktsCbXIlB8dfzyMcw5vH0BCoTAMkagHxN44nkAMnxNFtSPID9Wqs4vN3o3yH
         c+46ZVzFb6vX9YIgt5LDE+Jxhby4DTn1IQOx2UfCnmO7tizdjzjKyCvOBMp3PkezodIZ
         KBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/sPeos/C5F1U494DWZt/eYjG4B+Gq4D4knUrPa6L6o=;
        b=kz5pTfI0HjYwmirh6V8YLIAdSoRJq3maJKIfD1qtn5Dur+72TlB/UKmhB9+GmJZg/k
         YNC1qoeLTrkIZl3wtPfQXCN4zHeGgTgYD5Zvb3pq1UTyoQxwGD/D6ELp1F2NLdbT6Eoa
         CZJQjho6QWGK5bUAT0G5sHPCTlcptssquVpDgHigb+fQ6wG8iZlR/E638IZ1cuABO1Nh
         SQi32C6XNhZHr70myU+46anPEjNspAutJuvgRC3Mlkz971X3xBgc+Xyoy9mRuUhNTUyf
         fNkehh8gwtMqEkP7joty0lkPrudSIhRHOtZHxrVyW6ll5vQIXNy18F06uU6TZJeruuh6
         6T5A==
X-Gm-Message-State: AOAM532eo4I/d5lLtc7v7gDSha/C+Qn8172m4Y8PSDr95KvLX4XnNnq0
        F0cNZa41EpMTrPN4psgNu8IVEh1XDo2X22g/hoTf9w==
X-Google-Smtp-Source: ABdhPJxPDega/DBfjIwTHMbbh7+x5sJNgNudhYP0oJ9eAexzjsnjFMBcWB/qgqQaaHeARVWuncLMCDMoUPghXh+tlfg=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr1330213ljq.176.1624267032016;
 Mon, 21 Jun 2021 02:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
 <CAKfTPtDgLRYdFNY_A3=yXk-LXi-eH21xApAaYfYk_RbG4k61EQ@mail.gmail.com> <20210621090312.GA193194@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210621090312.GA193194@e120877-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 11:17:00 +0200
Message-ID: <CAKfTPtDjFqWBubop-Vnr4B+PXoO3Omu6kW_0LCPqxryx=QydVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/rt: Fix RT utilization tracking during policy change
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 at 11:03, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > >         /*
> > > -        * If we are already running, then there's nothing
> > > -        * that needs to be done. But if we are not running
> > > -        * we may need to preempt the current running task.
> > > -        * If that current running task is also an RT task
> > > +        * If we are not running we may need to preempt the current
> > > +        * running task. If that current running task is also an RT task
> > >          * then see if we can move to another run queue.
> > >          */
> > >         if (task_on_rq_queued(p) && rq->curr != p) {
> > > @@ -2355,6 +2353,13 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
> > >                 if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
> > >                         resched_curr(rq);
> > >         }
> > > +
> > > +       /*
> > > +        * If we are running, update the avg_rt tracking, as the running time
> > > +        * will now on be accounted into the latter.
> > > +        */
> > > +       if (task_current(rq, p))
> >
> > task_current(rq,p) equals the "rq->curr != p" above. Having 2
> > different ways to get the same value in the function is a bit
> > confusing.
> >
> > And call it once
> >
> > Otherwise, the fix looks good to me
>
> I can change it to something like:
>
> if (task_current(rq, p)) {
>     update_rt_rq_load_avg()
>     return;
> }
>
> if (task_on_rq_queued(p) {
>         ...
>         if (p->prio ...)
>                 resched_curr(rq);
> }
>
> ?

yes, looks good to me


>
> >
> > > +               update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.7.4
> > >
