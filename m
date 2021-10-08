Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06617426D47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbhJHPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbhJHPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:12:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:10:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g2so8508436pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrQMLNulJoJqcEgH5ag14CKeZC7bDRhJI4hv3UVlHGw=;
        b=iGj1rc4t8JyEZm69sGoZ+F4r1NMdloKM6khdy/QXwebqB3eHPyMae/nB4pQl4TMAYJ
         EN2bdIivFGDf6EcKTwM6hILirxhPkO+6nI7qePmt7IfnmkYn+u8f+1XL632RYsscalQ2
         hQavFQVjAcrSi1QSYHJ2rrzoFQNYq9Fsbku9qJBdtMz7cPxijHLXn1gUBhZ4WL/4Tqfu
         GjC8L87rkDUSVp7GXke8sJZ3jf09HjRj1OEr+aWrlA9SHD/wzkrOE2EKbv+yCnOmr3p1
         RlblX08SL2pmBBXV8qZJTRqw1JIA4WEmTsuR4aSS1nYGXqXiUF69vNwJjo/GSAvp+pf/
         n6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrQMLNulJoJqcEgH5ag14CKeZC7bDRhJI4hv3UVlHGw=;
        b=qV+rc9msZVTgX9HBEV7mto+FXKTVd7ix5w/CJLhCO8xGNWgCrx2A8O8ONn/ctl2JaA
         F4X8Vo5+AJ5sCkUoao3rqqw1n4TCRGW1P3g/rsD45AQljjlTI2MrUG3i8bKfoaCmM2Ka
         5WPihxVGvgvt85/Wb+Gx5veJwrvKAeGPO5emJ/e5GYrm0JcAWXSxpBcF+caT/p9u3f0p
         3ock+bJgcKvqLapj7De1uQmQqM7MEsWwXG4k8AXiEF+m7cE+fxEb2keo0Jegnm6DbRWG
         sHbmZ5I5/mxUZeOCb+qtUr+qQMD+5KhsjrD/UtRGiF0tErmwwankwE5DV7Kj1mLLKnCu
         ZJ1g==
X-Gm-Message-State: AOAM5304qsoEEOTSK0KQRT4x834kplaxVpmSbgrs06Yv/6I/i3W6I/Ko
        LqjwMMJ3S9FpUQ6i40w0lA==
X-Google-Smtp-Source: ABdhPJwht56yioI0d2RMiaujCI60fKYPq/7RRjqtS9bLsnkYugcFncYYpz3sbEnzvgvsQOZdHqYTdQ==
X-Received: by 2002:a63:454e:: with SMTP id u14mr5100266pgk.314.1633705824237;
        Fri, 08 Oct 2021 08:10:24 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 8sm2972551pfi.194.2021.10.08.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 08:10:23 -0700 (PDT)
Date:   Fri, 8 Oct 2021 23:10:12 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/4] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YWBfVBXBY5ykK+qT@piliu.users.ipa.redhat.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-4-kernelfans@gmail.com>
 <YVv4tT3WXrKvPe0g@alley>
 <YV/c6X7bPT5pBg/R@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV/c6X7bPT5pBg/R@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 01:53:45PM +0800, Pingfan Liu wrote:
> On Tue, Oct 05, 2021 at 09:03:17AM +0200, Petr Mladek wrote:
> [...]
> > > +static void lockup_detector_delay_init(struct work_struct *work);
> > > +bool hld_detector_delay_initialized __initdata;
> > > +
> > > +struct wait_queue_head hld_detector_wait __initdata =
> > > +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> > > +
> > > +static struct work_struct detector_work __initdata =
> > > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > > +
> > > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > > +{
> > > +	int ret;
> > > +
> > > +	wait_event(hld_detector_wait, hld_detector_delay_initialized);
> > > +	ret = watchdog_nmi_probe();
> > > +	if (!ret) {
> > > +		nmi_watchdog_available = true;
> > > +		lockup_detector_setup();
> > 
> > Is it really safe to call the entire lockup_detector_setup()
> > later?
> > 
> > It manipulates also softlockup detector. And more importantly,
> > the original call is before smp_init(). It means that it was
> > running when only single CPU was on.
> > 
> For the race analysis, lockup_detector_reconfigure() is on the centre stage.
> Since proc_watchdog_update() can call lockup_detector_reconfigure() to
> re-initialize both soft and hard lockup detector, so the race issue
> should be already taken into consideration.
> 
> > It seems that x86 has some problem with hardlockup detector as
> > well. It later manipulates only the hardlockup detector. Also it uses
> > cpus_read_lock() to prevent races with CPU hotplug, see
> > fixup_ht_bug().
> > 
> Yes. But hardlockup_detector_perf_{stop,start}() can not meet the
> requirement, since no perf_event is created yet. So there is no handy
> interface to re-initialize hardlockup detector directly.
> 
> > 
> > > +	} else {
> > > +		WARN_ON(ret == -EBUSY);
> > > +		pr_info("Perf NMI watchdog permanently disabled\n");
> > > +	}
> > > +}
> > > +
> > >  void __init lockup_detector_init(void)
> > >  {
> > > +	int ret;
> > > +
> > >  	if (tick_nohz_full_enabled())
> > >  		pr_info("Disabling watchdog on nohz_full cores by default\n");
> > >  
> > >  	cpumask_copy(&watchdog_cpumask,
> > >  		     housekeeping_cpumask(HK_FLAG_TIMER));
> > >  
> > > -	if (!watchdog_nmi_probe())
> > > +	ret = watchdog_nmi_probe();
> > > +	if (!ret)
> > >  		nmi_watchdog_available = true;
> > > +	else if (ret == -EBUSY)
> > > +		queue_work_on(smp_processor_id(), system_wq, &detector_work);
> > 
> > IMHO, this is not acceptable. It will block one worker until someone
> > wakes it. Only arm64 will have a code to wake up the work and only
> > when pmu is successfully initialized. In all other cases, the worker
> > will stay blocked forever.
> > 
> What about consider -EBUSY and hld_detector_delay_initialized as a unit?
                                                                     ^^^
								     unity
> If watchdog_nmi_probe() returns -EBUSY, then
> set the state of ld_detector_delay_initialized as "waiting", and then moved to state "finished".
> 
> And at the end of do_initcalls(), check the state is "finished". If not,
> then throw a warning and wake up the worker.
> 
> > The right solution is to do it the other way. Queue the work
> > from arm64-specific code when armv8_pmu_driver_init() succeeded.
> > 
> Could it be better if watchdog can provide a common framework for future
> extension instead of arch specific? The 2nd argument is to avoid the
> message "Perf NMI watchdog permanently disabled" while later enabling
> it.  (Please see
> lockup_detector_init()->watchdog_nmi_probe()->hardlockup_detector_perf_init(),
> but if providing arch specific probe method, it can be avoided)
> 
Sorry for poor expression. I have not explained it completely for the
second point.

Since using arch specific watchdog_nmi_probe() to avoid misleading
message "Perf NMI watchdog permanently disabled", then -EBUSY should be
returned. And from watchdog level, it should know how to handle error,
that is to say queue_work_on(smp_processor_id(), system_wq, &detector_work).

Thanks,

	Pingfan

> > Also I suggest to flush the work to make sure that it is finished
> > before __init code gets removed.
> > 
> Good point, and very interesting. I will look into it.
> 
> > 
> > The open question is what code the work will call. As mentioned
> > above, I am not sure that lockup_detector_delay_init() is safe.
> > IMHO, we need to manipulate only hardlockup detector and
> > we have to serialize it against CPU hotplug.
> > 
> As explained ahead, it has already consider the race against CPU
> hotplug.
> 
> Thanks,
> 
> 	Pingfan
> 
