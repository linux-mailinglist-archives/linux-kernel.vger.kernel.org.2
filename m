Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74064110DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhITIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:22:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34360 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhITIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:22:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0951D21F71;
        Mon, 20 Sep 2021 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632126048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=019wXnCAxMvTlV6EoifAZHeBxG76xSVoI2H7fG2HMoo=;
        b=DhTX+IYYsryFVSZvYhYE6Ein1y3JvlrjNTs5nJmNnXpXVuMpQjwgU6IDWKxGLGWtr0VL+2
        Xr8kuN1e6V8Bg1b8H2ILtaKJhlfVRzFIpn3P6DxTV9O5ZPWdtr1T76s5NA7V4uBRKxzmU8
        KrL5m5ihOsEijtdgEBb6ZIBejvQtExE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 638D9A3B98;
        Mon, 20 Sep 2021 08:20:47 +0000 (UTC)
Date:   Mon, 20 Sep 2021 10:20:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YUhEXj88J3olXRB1@alley>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUMAUE5RFJAtAS/z@alley>
 <YUMB+ghuYiuhNm2D@alley>
 <YUS3K4D6OlGybQ9G@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUS3K4D6OlGybQ9G@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-09-17 23:41:31, Pingfan Liu wrote:
> On Thu, Sep 16, 2021 at 10:36:10AM +0200, Petr Mladek wrote:
> > On Thu 2021-09-16 10:29:05, Petr Mladek wrote:
> > > On Wed 2021-09-15 11:51:01, Pingfan Liu wrote:
> > > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > > yet. E.g. on arm64, PMU is not ready until
> > > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > > with the driver model and cpuhp. Hence it is hard to push this
> > > > initialization before smp_init().
> > > > 
> > > > But it is easy to take an opposite approach by enabling watchdog_hld to
> > > > get the capability of PMU async.
> > > 
> > > This is another cryptic description. I have probably got it after
> > > looking at the 5th patch (was not Cc :-(
> > > 
> > > > The async model is achieved by introducing an extra parameter notifier
> > > > of watchdog_nmi_probe().
> > > 
> > > I would say that the code is horrible and looks too complex.
> > > 
> > > What about simply calling watchdog_nmi_probe() and
> > > lockup_detector_setup() once again when watchdog_nmi_probe()
> > > failed in lockup_detector_init()?
> > > 
> > > Or do not call lockup_detector_init() at all in
> > > kernel_init_freeable() when PMU is not ready yet.
> > 
> > BTW: It is an overkill to create your own kthread just to run some
> > code just once. And you implemeted it a wrong way. The kthread
> 
> I had thought about queue_work_on() in watchdog_nmi_enable(). But since
> this work will block the worker kthread for this cpu. So finally,
> another worker kthread should be created for other work.

This is not a problem. workqueues use a pool of workers that are
already created and can be used when one worker gets blocked.

> But now, I think queue_work_on() may be more neat.
> 
> > must wait in a loop until someone else stop it and read
> > the exit code.
> > 
> Is this behavior mandotory? Since this kthread can decide the exit
> condition by itself.

I am pretty sure. Unfortunately, I can't find it in the documentation.

My view is the following. Each process has a task_struct. The
scheduler needs task_struct so that it can switch processes.
The task_struct must still exist when the process exits.
The scheduler puts the task into TASK_DEAD state.
Another process has to read the exit code and destroy the
task struct.

See, do_exit() in kernel/exit.c. It ends with do_dead_task().
It is the point when the process goes into TASK_DEAD state.

For a good example, see lib/test_vmalloc.c. The kthread waits
until anyone want him to stop:

static int test_func(void *private)
{
[...]

	/*
	 * Wait for the kthread_stop() call.
	 */
	while (!kthread_should_stop())
		msleep(10);

	return 0;
}

The kthreads are started and stopped in:

static void do_concurrent_test(void)
{
[...]
	for (i = 0; i < nr_threads; i++) {
[...]
		t->task = kthread_run(test_func, t, "vmalloc_test/%d", i);
[...]
	/*
	 * Sleep quiet until all workers are done with 1 second
	 * interval. Since the test can take a lot of time we
	 * can run into a stack trace of the hung task. That is
	 * why we go with completion_timeout and HZ value.
	 */
	do {
		ret = wait_for_completion_timeout(&test_all_done_comp, HZ);
	} while (!ret);
[...]
	for (i = 0; i < nr_threads; i++) {
[...]
		if (!IS_ERR(t->task))
			kthread_stop(t->task);
[...]
}


You do not have to solve this if you use the system workqueue
(system_wq).

Best Regards,
Petr
