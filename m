Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70533F9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhCQUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhCQUFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:05:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E397C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:05:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4114955wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Vwc4bO99bghaL7G6q7uXcTp67keKl3EuKi8TYc6T54=;
        b=Nh4IiV+CY/hil5aTSUXqAdzud5UnOUwWcJXs3tAmQbpCoS0BDd4G3ZBrLvEgalinjg
         dW3W7ErDtmCGkZ7f84aV/aJAGG8bpIoXkG+Clgb5wmzz/LnFLdYyTMGQi3ezM/p3Xt6+
         i5+ipOzD/QZ14Gugee1di73kOvGqV/y12muzhvmUeqEasxeY1X99M3S4xaYA8JNBC5A3
         LpTBJPRA2qsTGzEtBBLzbP0mdbMqyBFosn/H8BOUtVAR05c1+C3cmMUb7d/+2lMxkAFT
         NTtYSGNKvWsiWWDopzoyTkKQzYNI5hQ4e5NFmN1AlotqaXL8ukhICeEXFnwJxzI9Pcr8
         JGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+Vwc4bO99bghaL7G6q7uXcTp67keKl3EuKi8TYc6T54=;
        b=qAPpMX6Ed7wuWRw7b9hAMch14WFt1Hpv8dKWp4Y82zBQIl5mMgfug4x+yMx+Cla2Kh
         6JW/RHJf7PJ3FBwLrWTc/W+2D9cHobWTkvC5FVMkV1NLmNlZ6tkTeu1g0RTW7d06hnyV
         KFr0jYKbIQC9GsTXm0VSX9nWOOjhecbFNwCc3desia59yPs/CztnkMtYR0Ko4DO82YmO
         RhL4Gunewgm8OoG5rVYbCeYWI7lUGpS2HQzwSsfn2HvDd1CGkEKmKO94eD4+iWXnAH75
         qqrriRR6dS0yc8+TUwclOfUvver9Fy7Xs5dZ7Lz9uuhq5+rG7TlJHCriDr0/7xUMdAi9
         12mA==
X-Gm-Message-State: AOAM530iYzvEecqGVRB0i/ZzQYzrydpKopJQJwzfCCo+4HBsWDiU78dj
        5TiG35nh/QKIzJ1oGqlqs6N8iu7dIKE=
X-Google-Smtp-Source: ABdhPJx29S0INZGC+J96IDESf4RF29iLlRyZo3x9X6n+/Fo69AJFqcXgeC3VCumaRgLOg8d3IvmdbA==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr443832wmg.7.1616011532075;
        Wed, 17 Mar 2021 13:05:32 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c9sm3382698wml.42.2021.03.17.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:05:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 21:05:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
Message-ID: <20210317200529.GB3830960@gmail.com>
References: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210317083947.GD3881262@gmail.com>
 <20210317084132.GA378908@gmail.com>
 <CAK8P3a2qqWV3RGvb4ooiz4LS5GAKL0OHEiVtdgnHAgtmiRDSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2qqWV3RGvb4ooiz4LS5GAKL0OHEiVtdgnHAgtmiRDSNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@kernel.org> wrote:

> On Wed, Mar 17, 2021 at 9:45 AM Ingo Molnar <mingo@kernel.org> wrote:
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > > * Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> > >
> > > > Fix the following coccicheck warnings:
> > > >
> > > > ./kernel/sched/core.c:8039:2-5: WARNING: Use BUG_ON instead of if
> > > > condition followed by BUG.
> > > >
> > > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > > ---
> > > >  kernel/sched/core.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 9819121..7392bc0 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -8035,8 +8035,7 @@ void __init sched_init_smp(void)
> > > >     mutex_unlock(&sched_domains_mutex);
> > > >
> > > >     /* Move init over to a non-isolated CPU */
> > > > -   if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
> > > > -           BUG();
> > > > +   BUG(set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0);
> > >
> > > The patch doesn't quite do what the title & changelog claims...
> >
> > More importantly, we use this pattern when we don't want !CONFIG_BUG
> > to remove the 'condition'.
> >
> > I.e. the "side effect" here is important scheduler logic. It must
> > never be optimized out.
> 
> This behavior for !CONFIG_BUG has changed a while ago, it is now safe
> to rely on the side-effect of the BUG_ON() condition regardless of
> CONFIG_BUG. When that option is disabled, running into the condition
> just ends up in a "do {} while (1)" loop.

Dunno, I still think it's not a particularly clean pattern to 'hide' 
significant side effects within a BUG_ON().

Thanks,

	Ingo
