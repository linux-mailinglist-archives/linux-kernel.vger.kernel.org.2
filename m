Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215A83DF67B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhHCUiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHCUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:38:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF8C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:38:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s48so705721ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuRg1UGNyV+RBEtF5tM68H/wFCuD+JvN3OsDF2572Zw=;
        b=SK56O/IBjM+iRrpnhmyc5sov7T+9sC8FfOKGetLWEDONCI7KvrCIwUBqhYUlrVEJnB
         9u+242ccM9dwgecSnvM4RiQQkOTw4jW+tkEjWY3tK1hwFFqiGRvtQ1+5ntV2X49D+Dqc
         wIeHLwXkxdYSaGRbwZQObTXNrGRT5ZElQ4s/bQ9ETI+8S8rQR9UYMs5lTugH24yPI0mr
         ihZBCxL1H8WlS45sAyrp3I9tQxowjS0hgF9VIlUdPb4zPo5CL2R/LSzpmBeeC9f3yiT5
         HMgrMsVHciKyIZCjlW2TgTUd0KT2b812QmPOl4DGp3b1gY+5il+38vRCzUp+keYWgR/B
         Dxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuRg1UGNyV+RBEtF5tM68H/wFCuD+JvN3OsDF2572Zw=;
        b=RV1Mkmq8AiGX8ed79URzrG+najjOuZsZaHbN9rF3MUCOfejL4zyL0KwQxBImuK4xON
         hH9KH5bPBoalPno03EPl3lh6qqotIhqtxlsKPnnXaTLpus+I67POzAYRwbJcM2/zcJm2
         zNli3Gx9MOQIYM7//xhkeP+N132QqvvWHLLQka+mRu2Hw9gft/IVeQcJjZGoGvWcD2nm
         qkY4pR7yTfUO/soEt3eC1qysqE7uA3W1+Zu4Qc14rhqKhdH9g6su0U+c1KSK9Et3ky4i
         iNATvXcbAoBf7yOCIGtmFxWPBTsDCz+KyQ+ieKh7ZYqDl/43DBgiiCIL6WtQMnc+PSm7
         SUUQ==
X-Gm-Message-State: AOAM530LzXC2ro/iuIa2kiNmWmsKW9vMwsl2T5wthyx0FZY9NKQvBQTu
        dXGLhOfL/f7+OlY4XkpU/zMC8t66/lJkFJMvZlm12Q==
X-Google-Smtp-Source: ABdhPJwpIcCp4uMCvtBcSpYYBaswbxQIcU8EecGvfY2mpTFQ8gDKp5S9yfWRmTAjmdCXHYbXo062TurTlGQmRGHHfgk=
X-Received: by 2002:a5b:d45:: with SMTP id f5mr30821527ybr.179.1628023081479;
 Tue, 03 Aug 2021 13:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-2-joshdon@google.com>
 <CAKc596LT=zntozT6D2kPyfSiqdt1KfbrAX8PSvHxCPKRNuq1pA@mail.gmail.com>
In-Reply-To: <CAKc596LT=zntozT6D2kPyfSiqdt1KfbrAX8PSvHxCPKRNuq1pA@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 3 Aug 2021 13:37:50 -0700
Message-ID: <CABk29Nvf4RemeBxvvzHey2QQJdW9XTUh5hNq=ZU-OCQYrVBWzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched: cgroup SCHED_IDLE support
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

> > @@ -7123,8 +7178,21 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >                 return;
> >
> >         find_matching_se(&se, &pse);
> > -       update_curr(cfs_rq_of(se));
> >         BUG_ON(!pse);
> > +
> > +       cse_is_idle = se_is_idle(se);
> > +       pse_is_idle = se_is_idle(pse);
> > +
> > +       /*
> > +        * Preempt an idle group in favor of a non-idle group (and don't preempt
> > +        * in the inverse case).
> > +        */
> > +       if (cse_is_idle && !pse_is_idle)
> > +               goto preempt;
>
> In the next schedule, it will pick next entity, How do we ensure that
> the entity selected next time will not be an idle
> entity. So I think we need to do something to idle group when picking
> next entity, For example, when we pick next
> entity, we try to choose normal group as much as possible.

Yep, exactly, this is achieved by adjusting the weight of idle
entities to the minimum value (see sched_group_set_idle()).

> Do we need to do something in the sched tick for the situation with
> idle entities?

check_preempt_tick() should already be sufficient, given that vruntime
for idle entities  will advance quickly, and in patch 2/2 I adjusted
the sched_slice for idle entities to allow for smaller than
min_granularity. Did you have a more specific concern?

Best,
Josh
