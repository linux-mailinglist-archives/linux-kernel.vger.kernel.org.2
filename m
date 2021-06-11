Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501913A4262
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFKMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231315AbhFKMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:50:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A987D6E;
        Fri, 11 Jun 2021 05:48:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A183D3F73D;
        Fri, 11 Jun 2021 05:48:22 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:48:20 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610151306.1789549-4-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 15:13, Quentin Perret wrote:
> There is currently nothing preventing tasks from changing their per-task
> clamp values in anyway that they like. The rationale is probably that
> system administrators are still able to limit those clamps thanks to the
> cgroup interface. However, this causes pain in a system where both
> per-task and per-cgroup clamp values are expected to be under the
> control of core system components (as is the case for Android).
> 
> To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> values. This allows unprivileged tasks to lower their requests, but not
> increase them, which is consistent with the existing behaviour for nice
> values.

Hmmm. I'm not in favour of this.

So uclamp is a performance and power management mechanism, it has no impact on
fairness AFAICT, so it being a privileged operation doesn't make sense.

We had a thought about this in the past and we didn't think there's any harm if
a task (app) wants to self manage. Yes a task could ask to run at max
performance and waste power, but anyone can generate a busy loop and waste
power too.

Now that doesn't mean your use case is not valid. I agree if there's a system
wide framework that wants to explicitly manage performance and power of tasks
via uclamp, then we can end up with 2 layers of controls overriding each
others.

Would it make more sense to have a procfs/sysfs flag that is disabled by
default that allows sys-admin to enforce a privileged uclamp access?

Something like

	/proc/sys/kernel/sched_uclamp_privileged

I think both usage scenarios are valid and giving sys-admins the power to
enforce a behavior makes more sense for me.

Unless there's a real concern in terms of security/fairness that we missed?


Cheers

--
Qais Yousef
