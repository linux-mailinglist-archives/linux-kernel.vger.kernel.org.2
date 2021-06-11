Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B193A4300
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFKN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:28:58 -0400
Received: from foss.arm.com ([217.140.110.172]:58322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhFKN2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:28:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BAED6E;
        Fri, 11 Jun 2021 06:26:57 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5743F73D;
        Fri, 11 Jun 2021 06:26:55 -0700 (PDT)
Date:   Fri, 11 Jun 2021 14:26:53 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMNgPyfiIaIIsjqq@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

On 06/11/21 13:08, Quentin Perret wrote:
> Hi Qais,
> 
> On Friday 11 Jun 2021 at 13:48:20 (+0100), Qais Yousef wrote:
> > On 06/10/21 15:13, Quentin Perret wrote:
> > > There is currently nothing preventing tasks from changing their per-task
> > > clamp values in anyway that they like. The rationale is probably that
> > > system administrators are still able to limit those clamps thanks to the
> > > cgroup interface. However, this causes pain in a system where both
> > > per-task and per-cgroup clamp values are expected to be under the
> > > control of core system components (as is the case for Android).
> > > 
> > > To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> > > values. This allows unprivileged tasks to lower their requests, but not
> > > increase them, which is consistent with the existing behaviour for nice
> > > values.
> > 
> > Hmmm. I'm not in favour of this.
> > 
> > So uclamp is a performance and power management mechanism, it has no impact on
> > fairness AFAICT, so it being a privileged operation doesn't make sense.
> > 
> > We had a thought about this in the past and we didn't think there's any harm if
> > a task (app) wants to self manage. Yes a task could ask to run at max
> > performance and waste power, but anyone can generate a busy loop and waste
> > power too.
> > 
> > Now that doesn't mean your use case is not valid. I agree if there's a system
> > wide framework that wants to explicitly manage performance and power of tasks
> > via uclamp, then we can end up with 2 layers of controls overriding each
> > others.
> 
> Right, that's the main issue. Also, the reality is that most of time the
> 'right' clamps are platform-dependent, so most userspace apps are simply
> not equipped to decide what their own clamps should be.

I'd argue this is true for both a framework or an app point of view. It depends
on the application and how it would be used.

I can foresee for example and HTTP server wanting to use uclamp to guarantee
a QoS target ie: X number of requests per second or a maximum of Y tail
latency. The application can try to tune (calibrate) itself without having to
have the whole system tuned or pumped on steroid.

Or a framework could manage this on behalf of the application. Both can use
uclamp with a feedback loop to calibrate the perf requirement of the tasks to
meet a given perf/power criteria.

If you want to do a static management, system framework would make more sense
in this case, true.

> 
> > Would it make more sense to have a procfs/sysfs flag that is disabled by
> > default that allows sys-admin to enforce a privileged uclamp access?
> > 
> > Something like
> > 
> > 	/proc/sys/kernel/sched_uclamp_privileged
> 
> Hmm, dunno, I'm not aware of anything else having a behaviour like that,
> so that feels a bit odd.

I think /proc/sys/kernel/perf_event_paranoid falls into this category.

> 
> > I think both usage scenarios are valid and giving sys-admins the power to
> > enforce a behavior makes more sense for me.
> 
> Yes, I wouldn't mind something like that in general. I originally wanted
> to suggest introducing a dedicated capability for uclamp, but that felt
> a bit overkill. Now if others think this should be the way to go I'm
> happy to go implement it.

Would be good to hear what others think for sure :)


Cheers

--
Qais Yousef
