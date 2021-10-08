Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00CF42644C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJHF4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhJHF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633672452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p/8Q73TOBZDtJheVPT8JeTVTM8ZE3M+LmUjxYN/WtSU=;
        b=h740c6vd/YitlLrQNXH+tSsDFp/bIfskirjJbXcdJO1pWCFvHTbgU6+8YYBSCQTXw7kTJ3
        HFAL+5y75NEUr05WPqKNJ/kqS1YOtve4rK3pPQ2hHfQpEMKhaIlHIE9gZQEVXlqSrhVPT6
        V+eXq9/apl85tXMPXYWDX9Ic8jSDtCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Fnie5ebpOfeRR5HnIGGaGw-1; Fri, 08 Oct 2021 01:54:03 -0400
X-MC-Unique: Fnie5ebpOfeRR5HnIGGaGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7188801AA7;
        Fri,  8 Oct 2021 05:54:00 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06D315F4EE;
        Fri,  8 Oct 2021 05:53:49 +0000 (UTC)
Date:   Fri, 8 Oct 2021 13:53:45 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <YV/c6X7bPT5pBg/R@piliu.users.ipa.redhat.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-4-kernelfans@gmail.com>
 <YVv4tT3WXrKvPe0g@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVv4tT3WXrKvPe0g@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:03:17AM +0200, Petr Mladek wrote:
[...]
> > +static void lockup_detector_delay_init(struct work_struct *work);
> > +bool hld_detector_delay_initialized __initdata;
> > +
> > +struct wait_queue_head hld_detector_wait __initdata =
> > +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> > +
> > +static struct work_struct detector_work __initdata =
> > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > +
> > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > +{
> > +	int ret;
> > +
> > +	wait_event(hld_detector_wait, hld_detector_delay_initialized);
> > +	ret = watchdog_nmi_probe();
> > +	if (!ret) {
> > +		nmi_watchdog_available = true;
> > +		lockup_detector_setup();
> 
> Is it really safe to call the entire lockup_detector_setup()
> later?
> 
> It manipulates also softlockup detector. And more importantly,
> the original call is before smp_init(). It means that it was
> running when only single CPU was on.
> 
For the race analysis, lockup_detector_reconfigure() is on the centre stage.
Since proc_watchdog_update() can call lockup_detector_reconfigure() to
re-initialize both soft and hard lockup detector, so the race issue
should be already taken into consideration.

> It seems that x86 has some problem with hardlockup detector as
> well. It later manipulates only the hardlockup detector. Also it uses
> cpus_read_lock() to prevent races with CPU hotplug, see
> fixup_ht_bug().
> 
Yes. But hardlockup_detector_perf_{stop,start}() can not meet the
requirement, since no perf_event is created yet. So there is no handy
interface to re-initialize hardlockup detector directly.

> 
> > +	} else {
> > +		WARN_ON(ret == -EBUSY);
> > +		pr_info("Perf NMI watchdog permanently disabled\n");
> > +	}
> > +}
> > +
> >  void __init lockup_detector_init(void)
> >  {
> > +	int ret;
> > +
> >  	if (tick_nohz_full_enabled())
> >  		pr_info("Disabling watchdog on nohz_full cores by default\n");
> >  
> >  	cpumask_copy(&watchdog_cpumask,
> >  		     housekeeping_cpumask(HK_FLAG_TIMER));
> >  
> > -	if (!watchdog_nmi_probe())
> > +	ret = watchdog_nmi_probe();
> > +	if (!ret)
> >  		nmi_watchdog_available = true;
> > +	else if (ret == -EBUSY)
> > +		queue_work_on(smp_processor_id(), system_wq, &detector_work);
> 
> IMHO, this is not acceptable. It will block one worker until someone
> wakes it. Only arm64 will have a code to wake up the work and only
> when pmu is successfully initialized. In all other cases, the worker
> will stay blocked forever.
> 
What about consider -EBUSY and hld_detector_delay_initialized as a unit?
If watchdog_nmi_probe() returns -EBUSY, then
set the state of ld_detector_delay_initialized as "waiting", and then moved to state "finished".

And at the end of do_initcalls(), check the state is "finished". If not,
then throw a warning and wake up the worker.

> The right solution is to do it the other way. Queue the work
> from arm64-specific code when armv8_pmu_driver_init() succeeded.
> 
Could it be better if watchdog can provide a common framework for future
extension instead of arch specific? The 2nd argument is to avoid the
message "Perf NMI watchdog permanently disabled" while later enabling
it.  (Please see
lockup_detector_init()->watchdog_nmi_probe()->hardlockup_detector_perf_init(),
but if providing arch specific probe method, it can be avoided)

> Also I suggest to flush the work to make sure that it is finished
> before __init code gets removed.
> 
Good point, and very interesting. I will look into it.

> 
> The open question is what code the work will call. As mentioned
> above, I am not sure that lockup_detector_delay_init() is safe.
> IMHO, we need to manipulate only hardlockup detector and
> we have to serialize it against CPU hotplug.
> 
As explained ahead, it has already consider the race against CPU
hotplug.

Thanks,

	Pingfan

