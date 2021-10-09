Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7E4276E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbhJIDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbhJIDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:25:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D4C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:23:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m20so12047967iol.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IrbmdjAqAfAVJBDOItfd3tnvbF827LvgAMob8nS/d6o=;
        b=fGvqflds5lsppvCA/MCHjr9XH3HxTKoAm6EXDqeb6NuMHkEmt/t57NbF3aKMvka/a3
         pKbp3pvgbqX3gifT4LrAZ7LlXDNQJyW9GEhee0uidnDfzSVp3XlZt5eFBCTGr/NyylGD
         5IL5BYn4ePmT0AFDKV8SQYzAG/BeAOrp/EuBPqafKIBOCAEkVMG+aXNuAti+pYlHOCGg
         PSqtPbDwJcEebJNnITes5INEsz3/ymJUt4wmyeGwSyCJ2NHdMjY15SdCd6XPmIN359/M
         AGit42wi5F1hXbO72lTKyTaCqPHukDj09XUMUFJjX8R1wREn6oE5J2Z/kiZdQ+M/8tK0
         9URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IrbmdjAqAfAVJBDOItfd3tnvbF827LvgAMob8nS/d6o=;
        b=SVz5WfwjhWK6StdrZVJ8PmpmohKGn5lMrrSEB2TGwf5cOE+Iy8b4UefLNGyIIWnxtY
         78VosnzsQWVUu+zQgIw3lhaJCdSU6BwNMeG3hsS0/64u3AmMNuafNBeMNH3/+kG94vF/
         1W9CSQBg+8zMw+aPSvW8B7L55KXTX1wa9M8UpW7KjXctO5iJ1no2lKDOjy9v+nyg21Ju
         FjHeE3sOgdYhg6aJ6bcXW5USJFsrIK2A1nm7SpTFFjY8ufZzxfS7hLWV4OyWU076qY1O
         FxqiSlrNpmkYpPWl8z864YijzTjsfl3mHeAY+nnfEHT0Qcx7pZPYM/9BG4HgCfuLKX9R
         sflA==
X-Gm-Message-State: AOAM533RqRHKD6bkX+PVrhHglpdpxejPLE/+fhUt9Pnn0Zl/5nPzHs6A
        ShRPoLqiNuEM2TjUW9BZmn4=
X-Google-Smtp-Source: ABdhPJx3AedwhYEHO7lblqxTQAdKbBVDFL2GpOODyso+LGbEe893rhbCIG6gUT3705ZuyLXKPcJImA==
X-Received: by 2002:a05:6638:10c4:: with SMTP id q4mr2520114jad.98.1633749792740;
        Fri, 08 Oct 2021 20:23:12 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l12sm552456ilh.19.2021.10.08.20.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 20:23:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9A84E27C0054;
        Fri,  8 Oct 2021 23:23:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 08 Oct 2021 23:23:10 -0400
X-ME-Sender: <xms:HQthYQ73MRNSPovXL15weDWI3iH5GckOkT_3TA7JDCc1TjisbXaN0w>
    <xme:HQthYR7hGj0fLA-EiBe37LkYEOcnl-QjAZlVc19YzrANUTNQ_HeX4pnB_L-SZy1t2
    iaXWi68wS0cHWHoVQ>
X-ME-Received: <xmr:HQthYfclu61XH-jo_0J7l3vBrPe87oBb8vk4a4rlf_ffxfqrE0J0toji2bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HQthYVKAYpMkd8SG3zu2i_B3ia_B37-NQxoB_CcWzZLEs9-1hv_8-Q>
    <xmx:HQthYUITFuQEx98CKb5WxgSdlnFK7wxzlbQyOqi0QFa1dSISAFo1iQ>
    <xmx:HQthYWwbcnCoPbxx9Sw_TsbODyHf83R9Lr0S7foncPrenbcDXAq3sQ>
    <xmx:HgthYc87YyEiGAG28NZQwv_7jdam-Y092AJDJR2aefCFJrm5snE86A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Oct 2021 23:23:09 -0400 (EDT)
Date:   Sat, 9 Oct 2021 11:21:58 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC 2/2] workqueue: Fix work re-entrance when requeue to a
 different workqueue
Message-ID: <YWEK1iNVXcJmDQVP@boqun-archlinux>
References: <20211008100454.2802393-1-boqun.feng@gmail.com>
 <20211008100454.2802393-3-boqun.feng@gmail.com>
 <CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 10:06:23AM +0800, Lai Jiangshan wrote:
> On Fri, Oct 8, 2021 at 6:06 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > When requeuing a work to a different workqueue while it's still getting
> > processed, re-entrace as the follow can happen:
> >
> >         { both WQ1 and WQ2 are bounded workqueue, and a work W has been
> >           queued on CPU0 for WQ1}
> >
> >         CPU 0                   CPU 1
> >         =====                   ====
> >         <In worker on CPU 0>
> >         process_one_work():
> >           ...
> >           // pick up W
> >           worker->current_work = W;
> >           worker->current_func = W->func;
> >           ...
> >           set_work_pool_and_clear_pending(...);
> >           // W can be requeued afterwards
> >                                 queue_work_on(1, WQ2, W):
> >                                   if (!test_and_set_bit(...)) {
> >                                     // this branch is taken, as CPU 0
> >                                     // just clears pending bit.
> >                                     __queue_work(...):
> >                                       pwq = <pool for CPU1 of WQ2>;
> >                                       last_pool = <pool for CPU 0 of WQ1>;
> >                                       if (last_pool != pwq->pool) { // true
> >                                         if (.. && worker->current_pwq->wq == wq) {
> >                                           // false, since @worker is a
> >                                           // a worker of @last_pool (for
> >                                           // WQ1), and @wq is WQ2.
> >                                         }
> >                                         ...
> >                                         insert_work(pwq, W, ...);
> >                                       }
> >                                 // W queued.
> >                                 <schedule to worker on CPU 1>
> >                                 process_one_work():
> >                                   collision = find_worker_executing_work(..);
> >                                   // NULL, because we're searching the
> >                                   // worker pool of CPU 1, while W is
> >                                   // the current work on worker pool of
> >                                   // CPU 0.
> >                                   worker->current_work = W;
> >                                   worker->current_func = W->func;
> >           worker->current_func(...);
> >                                   ...
> >                                   worker->current_func(...); // Re-entrance
> 
> Concurrent or parallel executions on the same work item aren't
> considered as "Re-entrance" if the workqueue is changed.
> 

Well, then Documentation/core-api/workqueue.rst can use some help:

"Note that the flag ``WQ_NON_REENTRANT`` no longer exists as all
workqueues are now non-reentrant - any work item is guaranteed to be
executed by at most one worker system-wide at any given time."

Clearly in the above case that a work item is executed by two worker at
the same time.

> It allows the work function to free itself(the item) and another
> subsystem allocates the same item and reuses it.
> 

So you're saying in process_one_work(), ->current_work can point to a
work which gets freed and reallocated before the worker actually
execute it? And users should guarantee it's safe to do so? I mean this
is something that workqueue subsystem allows/expects users to do?

> "Re-entrance" is defined as:
>   work function has not been changed
>   wq has not been changed
>   the item has not been reinitiated.
>   (To reduce the check complication, the workqueue subsystem often
> considers it "Re-entrance" if the condition is changed and has changed
> back. But the wq users should not depend on this behavior and should avoid
> it)
> 

Thanks for clarifiction, could you also update the documentation to
avoid future confusion? Thanks!

Regards,
Boqun

> 
> >
> > This issue is already partially fixed because in queue_work_on(),
> > last_pool can be used to queue the work, as a result the requeued work
> > processing will find the collision and wait for the existing one to
> > finish. However, currently the last_pool is only used when two
> > workqueues are the same one, which causes the issue. Therefore extend
> > the behavior to allow last_pool to requeue the work W even if the
> > workqueues are different. It's safe to do this since the work W has been
> > proved safe to queue and run on the last_pool.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/workqueue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 1418710bffcd..410141cc5f88 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1465,7 +1465,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> >
> >                 worker = find_worker_executing_work(last_pool, work);
> >
> > -               if (worker && worker->current_pwq->wq == wq) {
> > +               if (worker) {
> >                         pwq = worker->current_pwq;
> >                 } else {
> >                         /* meh... not running there, queue here */
> > --
> > 2.32.0
> >
