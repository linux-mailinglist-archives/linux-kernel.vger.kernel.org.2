Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851303B91BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhGAMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbhGAMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:46:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5054C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:43:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i8so8125863wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoBRMq2ckEaFpfMTdoMG6cbTwKFW1kJrAlv4Ay9rkwg=;
        b=Wo9jIQ1lvC4uJQZbOJK/dmpw3JtOoygEYx6yHtuPYFX0MLA9LPywcideiSzgWduHkC
         carfTrr6JucbbNR/oWItUMyLLxUDQ7T7W3ZaBq0dO5nasz2KkLZpXfj8rCCiqAgXFkUO
         e7jcmY34w0nJO3uFmzbGCx+wvnorEQwoc4XjURJztLX+s2b7f9M8hU1DejHlf3VpFbu0
         gMvq8grfHLxsrJ9EdC77lBLx6sFqWrc5td0Shy0Lo1Qv1mG1Ui5hbFWwpR3DMvKorX6E
         0mxON1qxVWUeN11DZoMC/3H/IvPrtugd4Wl5NOjNrQpH2eryWfpjcLzzlXhxJ02HmeSZ
         I9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoBRMq2ckEaFpfMTdoMG6cbTwKFW1kJrAlv4Ay9rkwg=;
        b=RAEDCwmrA05IQe84cRGa/MYi9QAwz6PTND+SlLwg7FjvEKMG0kooevP/XK0rFCxzgG
         7SCinNrI3PdYk5ABLGV8QKkuw/6efhx2ZsjTY/hdn8NfzqZVkVjZkz1DHt+5HXYvNwHo
         rjIL9Yrii482kiOws4PRLzv73TkhCTSR9pbnwHsVjOkLIzhY8AmCUFwI2yMok3OJ24H8
         Pmts/BudyJdio+hJYzsT97MZRI2VwScMMACn2FecB6QwD9r6KwdRMxiyWS1vOl5QYIIE
         85z0jGvY+cLIwb3JuUvDSwCWpAWcTEiyFpXePLaFwSs+S7XU4WZoVMSFwufdxEMt+NJk
         rTIQ==
X-Gm-Message-State: AOAM531Z/xxvSA2oTJQ5LjtRgFRMCXRSxhOqnoL1jVRoTCXxbUVY2I9O
        k7YXyZ20YRzFlurwh53Off9+cA==
X-Google-Smtp-Source: ABdhPJyW1DRrOyM421O7rCpBdaI0qxcHiyqGq2aRMIoQTdUlAlDaUfEekNUqMsstWk7dfArQXYY3hQ==
X-Received: by 2002:adf:d23b:: with SMTP id k27mr5918232wrh.341.1625143408277;
        Thu, 01 Jul 2021 05:43:28 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v1sm1995241wre.20.2021.07.01.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:43:27 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:43:24 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YN24bLOthLd6RIpF@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
 <YN2T1qnalRUKNcXt@google.com>
 <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 Jul 2021 at 12:08:03 (+0100), Qais Yousef wrote:
> On 07/01/21 10:07, Quentin Perret wrote:
> > On Wednesday 30 Jun 2021 at 15:45:14 (+0000), Quentin Perret wrote:
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index b094da4c5fea..c0b999a8062a 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
> > >         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> > >                 return;
> > > 
> > > -       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > >         WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> > >  }
> > > 
> > > @@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > > 
> > >         for_each_clamp_id(clamp_id)
> > >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > > +
> > > +       /* Reset clamp idle holding when there is one RUNNABLE task */
> > > +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > >  }
> > > 
> > >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> > > @@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
> > >         if (p->uclamp[clamp_id].active) {
> > >                 uclamp_rq_dec_id(rq, p, clamp_id);
> > >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > > +
> > > +               /*
> > > +                * Make sure to clear the idle flag if we've transiently reached
> > > +                * 0 uclamp active tasks on the rq.
> > > +                */
> > > +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > +                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > 
> > Bah, now that I had coffee I realize this has the exact same problem.
> > Let me look at this again ...
> 
> Hehe uclamp has this effect. It's all obvious, until it's not :-)

Indeed ... :)

> Yes this needs to be out of the loop.

Right or maybe we can just check that uclamp_id == UCLAMP_MAX here and
we should be good to go? That is, what about the below?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b094da4c5fea..8e9b8106a0df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
        if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
                return;

-       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
        WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
 }

@@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)

        for_each_clamp_id(clamp_id)
                uclamp_rq_inc_id(rq, p, clamp_id);
+
+       /* Reset clamp idle holding when there is one RUNNABLE task */
+       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }

 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
@@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
        if (p->uclamp[clamp_id].active) {
                uclamp_rq_dec_id(rq, p, clamp_id);
                uclamp_rq_inc_id(rq, p, clamp_id);
+
+               /*
+                * Make sure to clear the idle flag if we've transiently reached
+                * 0 active tasks on rq.
+                */
+               if (clamp_id == MAX && rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
        }

        task_rq_unlock(rq, p, &rf);
