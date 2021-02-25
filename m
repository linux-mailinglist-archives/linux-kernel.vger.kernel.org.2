Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDD3249DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhBYEpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhBYEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:45:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:44:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z7so2516006plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRc9fSNw7HigpXp/hpAWOFXrITbyE5IcMWpcATCeL1A=;
        b=Fa5Dgv3u0+zqkBX/lobj1stt+NMOomgt2+CB5AAmFLsOcEwbzMgDPyuHzpFu2dkUve
         +JSE5cCEWA/nRkhCaCH/iTYzrZMUmOU7wl1sbKl067hSnCMxdui9XM5rSHzMN4gZF71M
         tBNuUtJR1axqK5S96+YOHh7RCGPC90G4Xc5PYwE5VQUwHHmtCzHPEAqm/b3s9XoBToZ3
         v+lMx+i4JHwsFazIa8V0bZI66IMiqjtYKD1u67WvP2rt6VlDIxVh93R/1MBLOktOZWH/
         owzCO+V9XoFv6hZBwiqG89enH7YGE8pXXsWxhebO7YZHiyKNQsikbsyn/RMZchoJmgOv
         9dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRc9fSNw7HigpXp/hpAWOFXrITbyE5IcMWpcATCeL1A=;
        b=QJhkRsK8o90d480gPZq5aT4pBxysuy5Ubi5rNi9ZM4sGB3oXnkqNy5xzG1LU47ZtCi
         H6P/Hl2H5T6elJzdR+NN6Gd66djk9PuHjLziGZBVQwlVa88R/qU+VdtYVJC2Yt7Ei+RG
         vp9KjUWBnipi/qBzxlwZFxVayjUWR9QRH3f//xcnTMrGEZOsA/L+p/l+e9zEuV+qfOjf
         Fzeua7Mg3aiIMYTUEpkrWve067ul4VHvPexn5sVv0HyLwUWe+xO8Ifbihbxzrd2vD9BX
         QAccwwUOprWlo10sZ3IHiJBHJDyx2T2LD5522rNU/qfzri+kBTQGH3UbNmx2E2lO0xFR
         R11Q==
X-Gm-Message-State: AOAM530SlnchzADAlfZ7BhIi80d/r5lYUhxjU8nCAsIFN/q3Hym9PppL
        FhKU1XPAZYMTF2TzcChlr5ZTzQ==
X-Google-Smtp-Source: ABdhPJwtcFKl+y9MmQD3Oz/Knf2/FUDo7KcPYR6XYE8g3zYukTZpXLMhw8Zdo8QxpyMTYfh7QXEz3g==
X-Received: by 2002:a17:90a:694f:: with SMTP id j15mr1367197pjm.187.1614228252491;
        Wed, 24 Feb 2021 20:44:12 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i2sm4288268pgs.82.2021.02.24.20.44.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2021 20:44:11 -0800 (PST)
Date:   Thu, 25 Feb 2021 10:14:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210225044409.t7dfaerwhttxukxa@vireshk-i7>
References: <cover.1613991982.git.viresh.kumar@linaro.org>
 <51c2260e8760fdc0b489bed2ff2c6bb8209ea35d.1613991982.git.viresh.kumar@linaro.org>
 <CAJZ5v0i_JeMMAJA-J7ghuQr_+uN6urCGTn0O0FyZ8x8ntpKcJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_JeMMAJA-J7ghuQr_+uN6urCGTn0O0FyZ8x8ntpKcJg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-21, 16:57, Rafael J. Wysocki wrote:
> On Mon, Feb 22, 2021 at 12:20 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Even though the driver is located in drivers/cpufreq/ CPPC is part of
> ACPI and so a CC to linux-acpi is missing.

I just used get-maintainers, perhaps we should add an entry for this
in MAINTAINERS, will be orphan though..

> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index e65e0a43be64..a3e2d6dfea70 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -19,6 +19,15 @@ config ACPI_CPPC_CPUFREQ
> >
> >           If in doubt, say N.
> >
> > +config ACPI_CPPC_CPUFREQ_FIE
> > +       bool "Frequency Invariance support for CPPC cpufreq driver"
> > +       depends on ACPI_CPPC_CPUFREQ
> 
> In theory, the CPPC cpufreq driver can be used on systems with
> nontrivial arch_freq_scale_tick() in which case the latter should be
> used I suppose.
> 
> Would that actually happen if this option is enabled?

IIUC, you are saying that if this driver runs on x86 then we want
arch_freq_scale_tick() from arch/x86/kernel/smpboot.c to run instead
of this ? Yes that will happen because x86 doesn't enable
CONFIG_GENERIC_ARCH_TOPOLOGY and so this code will never trigger.

For other cases, like ARM AMU counters, the arch specific
implementation takes precedence to this.

> > +static void __init cppc_freq_invariance_init(void)
> > +{
> > +       struct cppc_perf_fb_ctrs fb_ctrs = {0};
> > +       struct cppc_freq_invariance *cppc_fi;
> > +       struct sched_attr attr = {
> > +               .size           = sizeof(struct sched_attr),
> > +               .sched_policy   = SCHED_DEADLINE,
> > +               .sched_nice     = 0,
> > +               .sched_priority = 0,
> > +               /*
> > +                * Fake (unused) bandwidth; workaround to "fix"
> > +                * priority inheritance.
> > +                */
> > +               .sched_runtime  = 1000000,
> > +               .sched_deadline = 10000000,
> > +               .sched_period   = 10000000,
> > +       };
> > +       int i, ret;
> > +
> > +       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +               return;
> > +
> > +       kworker_fie = kthread_create_worker(0, "cppc_fie");
> > +       if (IS_ERR(kworker_fie))
> > +               return;
> > +
> > +       for_each_possible_cpu(i) {
> > +               cppc_fi = &per_cpu(cppc_freq_inv, i);
> > +
> > +               /* A policy failed to initialize, abort */
> > +               if (unlikely(!cppc_fi->cpu_data))
> > +                       return cppc_freq_invariance_exit();
> > +
> > +               kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> > +               init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> 
> What would be wrong with doing the above in
> cppc_freq_invariance_policy_init()?  It looks like a better place to
> me.

Can move it there as well, I just kept policy specific stuff there as
ideally I wanted to do everything here.

> > +               ret = sched_setattr_nocheck(kworker_fie->task, &attr);
> 
> And this needs to be done only once if I'm not mistaken.

Yes, I failed to fix this when I went to a single kworker.

-- 
viresh
