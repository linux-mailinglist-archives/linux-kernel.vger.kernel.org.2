Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB13BE48F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGGItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhGGItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625647628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xC52iUltU3WfDcC93OlrlUwk4UlGcvIsBeHwLS8jT0=;
        b=TIDDveMkcBGMkTyr8ovfiXjUw6PIMU+lDszaCtxcgEAn3TV6p4TeC96Azri0lIEZe9ptnc
        HQpuvkwJPHclXXqZLAl9evAwGbKgASa/eDGFMOP6dx9n7qPYN7MXHqMlbvEXEdgL+kBPkM
        O9G4FJvQPasTtsPQDS7QYzfFV86aq8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-NnYsBaf6OdOjLVkrtv6HuQ-1; Wed, 07 Jul 2021 04:47:06 -0400
X-MC-Unique: NnYsBaf6OdOjLVkrtv6HuQ-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d52cb0000b02901309f5e7298so544956wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 01:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xC52iUltU3WfDcC93OlrlUwk4UlGcvIsBeHwLS8jT0=;
        b=WOkEx6x6kEnj4GIHpyXfQF0TD25R0ieBFPN4CID4x5F59hKr7HJfsxZISrT7Lqsc/P
         L1MTcf6Dfu6c/sUruwiM0F9cX7FcjJXzW4dZ/D2KgXHkRnXW+bwjZaJe9Ef6QAeADsg7
         FHFqHa8Us2KJSDgy1dKaSeTfJkV6p/rWcxTxxfnYTqDEGyHd+xdDybFlWndBqssPvmv7
         ZZSkUG4kiEbzhoLjn7N5Lj/lVrClvolvksQzewzhwP8Fufirt8NOwwmimsSZ+ODVpwqR
         zaRiro4qKKrW8rnpMyCfNFBfNYXKHBuhMwqszSjDYD8kekIlPxsm9qYEyJ5WNY7Msn0u
         fxxg==
X-Gm-Message-State: AOAM531DkubQpeFuNFo+J/Mr/HoRCAej/RUZ/ZDuKpTsgPJOqBUkENEQ
        aTwRN7449fjiekS9vKmGcG6krBf8Hod6J2mJQdtfwXoam9+eR2ayvV2ACZwAu8ZSWH3WYyrddeY
        8HivyHBtRSPxJocs6EcvCKZzO
X-Received: by 2002:adf:e40e:: with SMTP id g14mr7839454wrm.413.1625647625712;
        Wed, 07 Jul 2021 01:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/m+ox20wlHKwpedk2TuGSMVCIHIs0dcMOW7G+D6Yy/Fykl5ck9j7qt5o6X0pubxsheRtmfQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr7839429wrm.413.1625647625517;
        Wed, 07 Jul 2021 01:47:05 -0700 (PDT)
Received: from localhost.localdomain ([151.29.51.230])
        by smtp.gmail.com with ESMTPSA id t15sm7394311wrx.17.2021.07.07.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 01:47:05 -0700 (PDT)
Date:   Wed, 7 Jul 2021 10:47:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YOVqB1XKdoZYnn4m@localhost.localdomain>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
 <29c071b5-5dd9-42df-9e00-f3df644eeccc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c071b5-5dd9-42df-9e00-f3df644eeccc@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/07/21 16:48, Dietmar Eggemann wrote:
> On 01/07/2021 11:14, Juri Lelli wrote:
> > Double enqueues in rt runqueues (list) have been reported while running
> > a simple test that spawns a number of threads doing a short sleep/run
> > pattern while being concurrently setscheduled between rt and fair class.
> 
> I tried to recreate this in rt-app (with `pi-mutex` resource and
> `pi_enabled=true` but I can't bring the system into hitting this warning.

So, this is a bit hard to reproduce. I'm attaching the reproducer we
have been using to test the fix. Note that we have seen this on RT (thus
why the repro doesn't need to explicitly use mutexes), but I'm not
seeing why this couldn't in principle happen on !RT as well.

> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0c22cd026440..c84ac1d675f4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6823,7 +6823,8 @@ static void __setscheduler_params(struct task_struct *p,
> >  
> >  /* Actually do priority change: must hold pi & rq lock. */
> >  static void __setscheduler(struct rq *rq, struct task_struct *p,
> > -			   const struct sched_attr *attr, bool keep_boost)
> > +			   const struct sched_attr *attr, bool keep_boost,
> > +			   int new_effective_prio)
> >  {
> >  	/*
> >  	 * If params can't change scheduling class changes aren't allowed
> > @@ -6840,7 +6841,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
> >  	 */
> >  	p->prio = normal_prio(p);
> >  	if (keep_boost)
> > -		p->prio = rt_effective_prio(p, p->prio);
> > +		p->prio = new_effective_prio;
> 
> So in case __sched_setscheduler() is called for p (SCHED_NORMAL, NICE0)
> you want to avoid that this 2. rt_effective_prio() call returns
> p->prio=120 in case the 1. call (in __sched_setscheduler()) did return 0
> (due to pi_task->prio=0 (FIFO rt_priority=99 task))?

Not sure I completely follow your question. But what I'm seeing is that
the top_task prio/class can change (by a concurrent setscheduler call,
for example) between two consecutive rt_effective_prio() calls and this
eventually causes the double enqueue in the rt list.

Now, what I'm not sure about is if this is fine (as we always eventually
converge to correctness in the PI chain(s)), and thus the proposed fix,
or if we need to fix this differently.

> >  
> >  	if (dl_prio(p->prio))
> >  		p->sched_class = &dl_sched_class;
> > @@ -6873,7 +6874,7 @@ static int __sched_setscheduler(struct task_struct *p,
> >  	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
> >  		      MAX_RT_PRIO - 1 - attr->sched_priority;
> >  	int retval, oldprio, oldpolicy = -1, queued, running;
> > -	int new_effective_prio, policy = attr->sched_policy;
> > +	int new_effective_prio = newprio, policy = attr->sched_policy;
> >  	const struct sched_class *prev_class;
> >  	struct callback_head *head;
> >  	struct rq_flags rf;
> > @@ -7072,6 +7073,9 @@ static int __sched_setscheduler(struct task_struct *p,
> >  	oldprio = p->prio;
> >  
> >  	if (pi) {
> > +		newprio = fair_policy(attr->sched_policy) ?
> > +			NICE_TO_PRIO(attr->sched_nice) : newprio;
> > +
> 
> Why is this necessary? p (SCHED_NORMAL) would get newprio=99 now and
> with this it gets [100...120...139] which is still greater than any RT
> (0-98)/DL (-1) prio?

It's needed because we might be going to use newprio (returned in
new_effective_prio) with __setscheduler() and that needs to be the
"final" nice scaled value.

Reproducer (on RT) follows.

Best,
Juri

---
# cat load.c
#include <unistd.h>
#include <time.h>


int main(){

        struct timespec t, t2;
        t.tv_sec = 0;
        t.tv_nsec = 100000;
        int i;
        while (1){
                // sleep(1);
                nanosleep(&t, &t2);
                i = 0;
                while(i < 100000){
                        i++;
                }
        }
}

--->8---

# cat setsched.c
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[]){

        int ret;
        pid_t p;
        p = atoi(argv[1]);
        struct sched_param spr = { .sched_priority = 50};
        struct sched_param spo = { .sched_priority = 0};

        while(1){

                ret = sched_setscheduler(p, SCHED_RR, &spr);
                ret = sched_setscheduler(p, SCHED_OTHER, &spo);
        }
}

--->8---

# cat run.sh
#!/bin/bash

gcc -o load ./load.c
gcc -o setsched ./setsched.c
cp load rt_pid
mkdir TMP

for AUX in $(seq 36); do
    cp load TMP/load__${AUX}
    ./TMP/load__${AUX} &
done

sleep 1
for AUX in $(seq 18); do
    cp rt_pid TMP/rt_pid__${AUX}
    cp setsched TMP/setsched__${AUX}
    ./TMP/rt_pid__${AUX} &
    ./TMP/setsched__${AUX} $!&
done

--->8---

# cat destroy.sh
pkill load
pkill setsched
pkill rt_pid

rm load setsched rt_pid
rm -rf TMP

