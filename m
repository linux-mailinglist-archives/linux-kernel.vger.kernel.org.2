Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB942AD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhJLTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJLTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:47:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:45:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g6so1045267ybb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vD7FJ1ydlYC1IM4/HhgrveOKWM0Mobtkyxgs+mO+hzU=;
        b=pE8V9KlHyJeJU/IxPDbxSChUWjX/h4mLADnFcPzYx9ZWZbMz2gutTt/qAjRMrsRjX5
         QJFYumwrgLG6e19Fj1Io/xBvZBGXNbspxMyHAfdRe5g3cEX3o5CFoia4T/Q5gpWXuE1I
         GTYAcaFecE40j7VLCeM+5nddDR+uRhcBiOfPCpI0eis5epjxHTt6Dr0Vcdx88U6yHwLK
         B972hTQF0LiJIQJGAbfPmwEexIaySfuTmuUb/3P4HuJHYLceFEcgZcnYnV9nhyT3Psk+
         00rjW13YP9u98v/P8cjDjwtwMfxgiw7rB2X31kDnWMIENRhpO1we8REZLRCFRBQNQwuy
         SqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD7FJ1ydlYC1IM4/HhgrveOKWM0Mobtkyxgs+mO+hzU=;
        b=WdiV9bdTONMhWU3Axa8JiFtwFyQl1xlVIeXTIoL1vkpsxG/y65xXPRkEdrWYCJ12Pv
         Y1Tytk/LlQFeJLElDmET1ZTbWDaSr6hUwfWEbs/caVvmODOUJkhKlFvWGFQKs/7Po6mu
         RUnGvmkaa+0ancW/sj887l0ae0gHkl+TKejXOA2/FjcZAYfjy/In8+mQStTmTKHdQr5I
         9HhPeKhbuVSDy/kEoEuCSJBjxdFyv0N8YnCK9jXgk/t3fGZeLK2k490iW1WuAj1hXnt9
         dFlwZ+KiRr286YmmhEWSroC+3iGdqebIwJJIcRBuu58Yqj7eELT6xqNw+koLU1yjr+rV
         ImPQ==
X-Gm-Message-State: AOAM532RJtx4bQJYzPrTIPqfxUfUj5QLYk9Ne48GXIrqwDirs5MBXl7l
        OXpN0wxpvV9TCxwvsdMpyEHV9b9v2TNKHxQ9iTvYXQ==
X-Google-Smtp-Source: ABdhPJxk+e5Ku0rCcnzTTEXYLNKKI9QkE2tuOkbIgt284meu9pfLnMAGjn/1/H/e5zbvD44u7C2OgUFAwbCIp5tTD9s=
X-Received: by 2002:a25:cf07:: with SMTP id f7mr30461040ybg.100.1634067939279;
 Tue, 12 Oct 2021 12:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <20211009155435.GW174703@worktop.programming.kicks-ass.net>
 <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com> <YWV/HNDJaIAOLdrt@hirez.programming.kicks-ass.net>
In-Reply-To: <YWV/HNDJaIAOLdrt@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 12 Oct 2021 12:45:28 -0700
Message-ID: <CABk29NucE__6r3P64Ts3Nbf4sUy5Zkw1sbNNnab9KZ=68ydy=w@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 11, 2021 at 05:12:43PM -0700, Josh Don wrote:
>
> > > > +             if (WARN_ON_ONCE(!nr_running)) {
> > > > +                     /* can't be forced idle without a running task */
> > > > +             } else {
> > > > +                     delta *= nr_forced_idle;
> > > > +                     delta /= nr_running;
> > > > +             }
> > >
> > > Now the comment sayeth:
> > >
> > > > +     /*
> > > > +      * For larger SMT configurations, we need to scale the charged
> > > > +      * forced idle amount since there can be more than one forced idle
> > > > +      * sibling and more than one running cookied task.
> > > > +      */
> > >
> > > But why?
> >
> > We scale by the number of cpus actually forced idle, since we don't
> > want to falsely over or under charge forced idle time (defined
> > strictly as time where we have a runnable task but idle the cpu). The
> > more important scaling here though is the division over the number of
> > running entities. This is done so that the aggregate amount of forced
> > idle over some group of threads makes sense. Ie if we have a cpu with
> > SMT8, and a group of 7 threads sharing a cookie, we don't want to
> > accrue 7 units of forced idle time per unit time while the 8th SMT is
> > forced idle.
>
> So why not simply compute the strict per-cpu force-idle time and let
> userspace sort out the rest?

Do you mean to compute force idle solely as a per-cpu value? I think
that would be fine in addition to the per-thread field, but a
desirable property here is proper attribution to the cause of the
force idle. That lets system management understand which jobs are the
most antagonistic from a coresched perspective, and is a signal
(albeit noisy, due to system state and load balancing decisions) for
scaling their capacity requirements.
