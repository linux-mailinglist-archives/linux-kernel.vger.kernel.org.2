Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83793B93D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhGAPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhGAPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:23:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6792C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 08:20:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g7so8707431wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Er7ybKiXfctLqzPVX4VM8W34OVVkmeIIC7cooFlaboc=;
        b=pllr7mM8SDMdNmnHh5aOoW5WmlumkPT4CYdonZzPaITEilLjVkfvWsp5yJaNSgOmGs
         AWCpUHdrMQam4R0/tLLu9MvxrKimXmfMODiEG9UzadmcFbA3u/aSKkfztYAyeu/tZMgD
         yagIQ4kQ9vt3VPrHvdkcuO++Z22UQBI8/370n4MBi2oOVZEuGiVUxpsn4bQbWs4C5q6J
         Iz2CA0Nr8hVult2jDn5Beg1w35j9PLhtPJ0NPImR7MtD9ty/oQ5FcDFt0nPGx0SL70Ko
         DsMNaeeZEE1qbrmkTDh4vJPjoe7bWeRSDxsrTIGg3bNo5xxu1LG/BWyDlwUCpR+vwnz3
         WnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Er7ybKiXfctLqzPVX4VM8W34OVVkmeIIC7cooFlaboc=;
        b=Jav/xwfiTLTCF7k52RBf5dNBOpDLzDEle5D4oI/urkStRahnzWGgKWPXKts7fFa+LQ
         5co8ICb2Y+0ZUjhYEt3dzMi0r+JhXUxp4eLOxemR9mrOwh2bPM/K/33gysZaJe8ui315
         GPZpo9Qhy+8g/nbwNywNwkpHEULu9N/yAoPuETNbhrHVe9DzDvS2wpBPAXAEqMhZHsHp
         hFYwvz1JkL5PAMfV4R0gJaqQInSNWD/QNXx4eVgk3tMaAXZ1O4HQR/Y0vhXoHSnQPS7s
         jdaBV4id9e4UQSM3wjfN1nbGDOR1/qzb2ErDTYPKIMZZFL7BigyziVpQi/iDtUGtCVJW
         OMXg==
X-Gm-Message-State: AOAM5310sSL9+FsFi3ao0TuuWAvGI3a9IH4NQczghecl12MY26UJ/FLS
        KoDIV9QWI15cOIBdDWk8JaKfeA==
X-Google-Smtp-Source: ABdhPJyB+vxrQxT8C6V3+iSUB0okgZOf61K8vfdPx/q2M615kBDBCcN0xKs/iTTQcQZB04Q9g4CU5A==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr232930wrv.310.1625152853277;
        Thu, 01 Jul 2021 08:20:53 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l22sm279416wrz.54.2021.07.01.08.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 08:20:52 -0700 (PDT)
Date:   Thu, 1 Jul 2021 15:20:50 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YN3dUhsAHL2M4JbR@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
 <YN2T1qnalRUKNcXt@google.com>
 <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
 <YN24bLOthLd6RIpF@google.com>
 <20210701145750.7mqat4ehja7ikbtc@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701145750.7mqat4ehja7ikbtc@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 Jul 2021 at 15:57:50 (+0100), Qais Yousef wrote:
> On 07/01/21 12:43, Quentin Perret wrote:
> > On Thursday 01 Jul 2021 at 12:08:03 (+0100), Qais Yousef wrote:
> > > On 07/01/21 10:07, Quentin Perret wrote:
> > > > On Wednesday 30 Jun 2021 at 15:45:14 (+0000), Quentin Perret wrote:
> > > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > > index b094da4c5fea..c0b999a8062a 100644
> > > > > --- a/kernel/sched/core.c
> > > > > +++ b/kernel/sched/core.c
> > > > > @@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
> > > > >         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> > > > >                 return;
> > > > > 
> > > > > -       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > > > >         WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> > > > >  }
> > > > > 
> > > > > @@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > > > > 
> > > > >         for_each_clamp_id(clamp_id)
> > > > >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > > > > +
> > > > > +       /* Reset clamp idle holding when there is one RUNNABLE task */
> > > > > +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > > > +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > > > >  }
> > > > > 
> > > > >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> > > > > @@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
> > > > >         if (p->uclamp[clamp_id].active) {
> > > > >                 uclamp_rq_dec_id(rq, p, clamp_id);
> > > > >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > > > > +
> > > > > +               /*
> > > > > +                * Make sure to clear the idle flag if we've transiently reached
> > > > > +                * 0 uclamp active tasks on the rq.
> > > > > +                */
> > > > > +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > > > +                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > > > 
> > > > Bah, now that I had coffee I realize this has the exact same problem.
> > > > Let me look at this again ...
> > > 
> > > Hehe uclamp has this effect. It's all obvious, until it's not :-)
> > 
> > Indeed ... :)
> > 
> > > Yes this needs to be out of the loop.
> > 
> > Right or maybe we can just check that uclamp_id == UCLAMP_MAX here and
> > we should be good to go? That is, what about the below?
> 
> Wouldn't it be better to do this from uclamp_idle_reset() then?

That should work too, but clearing the flag outside of
uclamp_rq_inc_id() feels a little bit more robust to ordering
issues.

Specifically, uclamp_rq_inc() has the following pattern:

	for_each_clamp_id(clamp_id)
		uclamp_rq_inc_id(rq, p , clamp_id);

	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;

So, if we change this to clear the flag from
uclamp_rq_inc_id()->uclamp_idle_reset() then we'll have issues if
(for example) for_each_clamp_id()'s order changes in the future.
IOW, it feels cleaner to not create side effects in uclamp_rq_inc_id()
that impact the idle flag given that its very own behaviour depends on
the flag.

WDYT?

Cheers,
Quentin
