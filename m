Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED33B083E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFVPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:10:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:07:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c5so3990189pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SI166qr6HueDNoTy9ydevVzqvTJI8FKVXkBcOgX/an4=;
        b=lq8Xv5RAYOJ9v0jUsUz5zBb6e1WyfaJp8diGrsGE+vJhZiTAuvS2aeCNmdrgESECBs
         HupHSvGV1OQIKBkdZySBOeyP9s05bMvs8ZfwVuRUGIOB9clvHLegaIzoBKwkNxmgJINT
         o0qNg6dO7Mgnap/OGgXKNHuZKN8gocwjp4ZQx8zsEmhDeF46MwomuRZ+RQPENJX/yqOl
         QB5UyXas6ZmizWIXBSUSMwpe92hf8XUzMMtsshff5xhzzhG1i4YPUZixHPzomOOEZv31
         35RRY+oTQXPnqoH8sLHOio7Ixg+TkZT50DRj0iNCnM28aGpKMFmB2+GH80YmZn7SsTzN
         3y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SI166qr6HueDNoTy9ydevVzqvTJI8FKVXkBcOgX/an4=;
        b=o1lWeYZClBfc/ckWS77bsDWn4RkZSH6uso8okEjvYB3wYpy4ZtcjtE9YrNIzG/teGJ
         3kcaKKmifvzbXPWAv+MqO8UsbYjTU93mZPgCxaeoY7vq0S3KiR/09+JBA/o7ut0VxNO7
         W2tzYlCHg2mh7lVUUuapKOoAtN+l/w8VVJvzAu6nPu2ikv55Pgiw6v/W1s/JIvJDpu0N
         gCCBCm5HXfqTpD82Y+pl6L1WE2zUa3XBOEmiobR5hQy4qvfW50PrV0TjHCF3n3QOr9N5
         wswrH6n3TeR+YbFVew4/YZOJh1CK/8Sv5fAnttgAF44Wiu4Kffj7YpZWQ6FWTfiM/k/3
         XCHQ==
X-Gm-Message-State: AOAM5319qsh5aqAQP9nBN7Au6PuIKJ4F9v89uOkzkiawGcbLV4RFF67I
        Z3OhOv85nRwo5rOhDfkRV/0nTA==
X-Google-Smtp-Source: ABdhPJwm0JFMXAlFLUyQwhmXF6OYeDIQmhHBekmUlHzikepo9746iaBZX8vYFkWNhAA1HeUIagS7Zg==
X-Received: by 2002:a63:5b21:: with SMTP id p33mr4225420pgb.402.1624374476642;
        Tue, 22 Jun 2021 08:07:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ebf0])
        by smtp.gmail.com with ESMTPSA id t14sm1271570pfe.45.2021.06.22.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:07:54 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:07:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, matthias.bgg@gmail.com,
        minchan@google.com, timmurray@google.com, yt.chang@mediatek.com,
        wenju.xu@mediatek.com, jonathan.jmchen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YNH8x9HRyfvF53Pl@cmpxchg.org>
References: <20210617212654.1529125-1-surenb@google.com>
 <YNHr81D/fPD2Q8kM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHr81D/fPD2Q8kM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:56:03PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 02:26:54PM -0700, Suren Baghdasaryan wrote:
> > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
> > Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> > Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> > Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> Johannes?

Looks generally good to me, I'd just want to get to the bottom of the
memory ordering before acking...

> > -/* Schedule polling if it's not already scheduled. */
> > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > +/* Schedule polling if it's not already scheduled or forced. */
> > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > +				   bool force)
> >  {
> >  	struct task_struct *task;
> >  
> > -	/*
> > -	 * Do not reschedule if already scheduled.
> > -	 * Possible race with a timer scheduled after this check but before
> > -	 * mod_timer below can be tolerated because group->polling_next_update
> > -	 * will keep updates on schedule.
> > -	 */
> > -	if (timer_pending(&group->poll_timer))
> > +	/* cmpxchg should be called even when !force to set poll_scheduled */
> > +	if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) != 0 && !force)
> 
> Do you care about memory ordering here? Afaict the whole thing is
> supposed to be ordered by ->trigger_lock, so you don't.

It's not always held when we get here.

The worker holds it when it reschedules itself, to serialize against
userspace destroying the trigger itself. But the scheduler doesn't
hold it when it kicks the worker on an actionable task change.

That said, I think the ordering we care about there is that when the
scheduler side sees the worker still queued, the worker must see the
scheduler's updates to the percpu states and process them correctly.
But that should be ensured already by the ordering implied by the
seqcount sections around both the writer and the reader side.

Is there another possible race that I'm missing?
