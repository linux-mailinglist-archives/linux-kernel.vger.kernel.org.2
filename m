Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4CB3A434A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFKNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:51:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26325C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:49:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6399727wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vV/m/F3R0OquGMen6MuvJvZ+QS+7DYakie7GO5U9UV0=;
        b=oi9RmzEozqytT+6DyYJApf5janWPSpAr3FFeZhWqNske88lJ9TdQyR1SqB59xxi8nt
         TaTC8c8bx4IBW0VOFtPbTs44zAFlPLwnCEbW4dHQygVjefK1AxEIjaTNHkQbVvrxci8j
         NLcqZliWXLKpIAXcagegv3S96zIA8WegIWD4appdYHu3LGu4X2X3d/hpDiFoDnb2iRH/
         d6KKAmld+3JWEJP3BSGRUhcmwALU35zYsvyfVLwg8UMyUo1GqCTiKU0p/xqlcHlB4/cZ
         fznX1GGxWyiryjHHdO6Pc0OuIg9NmU6Z0Uj0jJrRq86G3Xj9VaSlmnWewVfGuxNnebav
         M/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vV/m/F3R0OquGMen6MuvJvZ+QS+7DYakie7GO5U9UV0=;
        b=PBTG6WEFTM7jfcnMeN/3AqRP05gLruBEGfMCxEX7CVk6gsu57a5tGgC9gmlTJ9lvCn
         Uz//WZFqIjvEig1sSDVuuTYoMBXZYD/17PFu+FuLwwYdndRQhV4bYrUd1vkRD9i1hTnm
         1Qcs2RpRmWeJaRVTPGSUR5fyVKo/eDu1PyDtqZ9eKLB95zkYvKz2cotTBASgz0ZJ0dUf
         yvvniYlkwx+kEwGy0iF5d1NDp+x4wZKrlLG7p7f2f3qshdfNXmusf43hN/gAeWkbTBeV
         9w66D4CIrT+8q7u1YZpM/Z+cwgIHwz+ndB1pgXS5HgH/ZualoKOkpGK4Y8SqEcGMa6sj
         A16A==
X-Gm-Message-State: AOAM5306FqKThokTVJ9qtzybIV+549XFIPaGUi2RTA/sU/F+uT/pKFgf
        PDGBc5JA8sKB0A6NL06Dawgtmg==
X-Google-Smtp-Source: ABdhPJykrNCAtgTLMCbQpBJTrknjMbh5sTpCOgN6r0K6NJlBDP0z/GXSPMmpNSKLT/knqSUevq3mXg==
X-Received: by 2002:a05:600c:3393:: with SMTP id o19mr20831315wmp.163.1623419359529;
        Fri, 11 Jun 2021 06:49:19 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m23sm14876074wml.27.2021.06.11.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:49:19 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:49:16 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <YMNp3EigvYjeMVAj@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
 <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 Jun 2021 at 14:26:53 (+0100), Qais Yousef wrote:
> Hi Quentin
> 
> On 06/11/21 13:08, Quentin Perret wrote:
> > Hi Qais,
> > 
> > On Friday 11 Jun 2021 at 13:48:20 (+0100), Qais Yousef wrote:
> > > On 06/10/21 15:13, Quentin Perret wrote:
> > > > There is currently nothing preventing tasks from changing their per-task
> > > > clamp values in anyway that they like. The rationale is probably that
> > > > system administrators are still able to limit those clamps thanks to the
> > > > cgroup interface. However, this causes pain in a system where both
> > > > per-task and per-cgroup clamp values are expected to be under the
> > > > control of core system components (as is the case for Android).
> > > > 
> > > > To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> > > > values. This allows unprivileged tasks to lower their requests, but not
> > > > increase them, which is consistent with the existing behaviour for nice
> > > > values.
> > > 
> > > Hmmm. I'm not in favour of this.
> > > 
> > > So uclamp is a performance and power management mechanism, it has no impact on
> > > fairness AFAICT, so it being a privileged operation doesn't make sense.
> > > 
> > > We had a thought about this in the past and we didn't think there's any harm if
> > > a task (app) wants to self manage. Yes a task could ask to run at max
> > > performance and waste power, but anyone can generate a busy loop and waste
> > > power too.
> > > 
> > > Now that doesn't mean your use case is not valid. I agree if there's a system
> > > wide framework that wants to explicitly manage performance and power of tasks
> > > via uclamp, then we can end up with 2 layers of controls overriding each
> > > others.
> > 
> > Right, that's the main issue. Also, the reality is that most of time the
> > 'right' clamps are platform-dependent, so most userspace apps are simply
> > not equipped to decide what their own clamps should be.
> 
> I'd argue this is true for both a framework or an app point of view. It depends
> on the application and how it would be used.
> 
> I can foresee for example and HTTP server wanting to use uclamp to guarantee
> a QoS target ie: X number of requests per second or a maximum of Y tail
> latency. The application can try to tune (calibrate) itself without having to
> have the whole system tuned or pumped on steroid.

Right, but the problem I see with this approach is that the app only
understand its own performance, but is unable to decide what is best for
the overall system health.

Anyway, it sounds like we agree that having _some_ way of limiting this
would be useful, so we're all good.

> Or a framework could manage this on behalf of the application. Both can use
> uclamp with a feedback loop to calibrate the perf requirement of the tasks to
> meet a given perf/power criteria.
> 
> If you want to do a static management, system framework would make more sense
> in this case, true.
> 
> > 
> > > Would it make more sense to have a procfs/sysfs flag that is disabled by
> > > default that allows sys-admin to enforce a privileged uclamp access?
> > > 
> > > Something like
> > > 
> > > 	/proc/sys/kernel/sched_uclamp_privileged
> > 
> > Hmm, dunno, I'm not aware of anything else having a behaviour like that,
> > so that feels a bit odd.
> 
> I think /proc/sys/kernel/perf_event_paranoid falls into this category.

Aha, so I'm guessing this was introduced as a sysfs knob rather than a
CAP because it is a non-binary knob, but it's an interesting example.

> > 
> > > I think both usage scenarios are valid and giving sys-admins the power to
> > > enforce a behavior makes more sense for me.
> > 
> > Yes, I wouldn't mind something like that in general. I originally wanted
> > to suggest introducing a dedicated capability for uclamp, but that felt
> > a bit overkill. Now if others think this should be the way to go I'm
> > happy to go implement it.
> 
> Would be good to hear what others think for sure :)

Thinking about it a bit more, a more involved option would be to have
this patch as is, but to also introduce a new RLIMIT_UCLAMP on top of
it. The semantics could be:

  - if the clamp requested by the non-privileged task is lower than its
    existing clamp, then allow;
  - otherwise, if the requested clamp is less than UCLAMP_RLIMIT, then
    allow;
  - otherwise, deny,

And the same principle would apply to both uclamp.min and uclamp.max,
and UCLAMP_RLIMIT would default to 0.

Thoughts?

Thanks,
Quentin
