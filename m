Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5140FB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhIQPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhIQPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631891308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDOPunLui+O3AxAR6Z76Qgr43mUFIQ9hp6aQ6KbOUvg=;
        b=Ak5Fu7Yau4XkSwL+r3xegtn5avbxiOKpTJlPHcuSrFY/GzaPRHz2I2r3f44vZ/NuhPSwmy
        CT56pB7WbP9wmsxN2CgdEhTyfQW3jEZ4Hi1+GrOqDEfw1V9zO+bLsFs7OnBIVqwhVYhlOh
        3L2p6zqHb3g60VjXQhSc63VU1EJnYUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-CrElNu7_PNekYFzVga5gBQ-1; Fri, 17 Sep 2021 11:08:26 -0400
X-MC-Unique: CrElNu7_PNekYFzVga5gBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E40E1084683;
        Fri, 17 Sep 2021 15:08:25 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28F5069FAD;
        Fri, 17 Sep 2021 15:08:19 +0000 (UTC)
Date:   Fri, 17 Sep 2021 23:08:13 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YUSvXZoJfVItExkG@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-3-kernelfans@gmail.com>
 <YUH44qrky9oM+3nU@hirez.programming.kicks-ass.net>
 <YULAuEeSSeLTcBM9@piliu.users.ipa.redhat.com>
 <YUL6E1Psg1xCrIxo@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUL6E1Psg1xCrIxo@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:02:27AM +0200, Petr Mladek wrote:
> On Thu 2021-09-16 11:57:44, Pingfan Liu wrote:
> > On Wed, Sep 15, 2021 at 03:45:06PM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 15, 2021 at 11:51:00AM +0800, Pingfan Liu wrote:
> > > > hardlockup_detector_event_create() indirectly calls
> > > > kmem_cache_alloc_node(), which is blockable.
> > > > 
> > > > So here, the really planned context is is_percpu_thread().
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Petr Mladek <pmladek@suse.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Wang Qing <wangqing@vivo.com>
> > > > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > > Cc: Santosh Sivaraj <santosh@fossix.org>
> > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > To: linux-kernel@vger.kernel.org
> > > > ---
> > > >  kernel/watchdog_hld.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> > > > index 247bf0b1582c..6876e796dbf5 100644
> > > > --- a/kernel/watchdog_hld.c
> > > > +++ b/kernel/watchdog_hld.c
> > > > @@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
> > > >  
> > > >  static int hardlockup_detector_event_create(void)
> > > >  {
> > > > -	unsigned int cpu = smp_processor_id();
> > > > +	unsigned int cpu;
> > > >  	struct perf_event_attr *wd_attr;
> > > >  	struct perf_event *evt;
> > > >  
> > > > +	/* This function plans to execute in cpu bound kthread */
> > > > +	BUG_ON(!is_percpu_thread());
> > > > +	cpu = raw_smp_processor_id();
> > > >  	wd_attr = &wd_hw_attr;
> > > >  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> > > 
> > > This patch makes no sense.
> > 
> > This patch aims to disable any attempt such as using get_cpu()/put_cpu() to
> > shut up the check_preemption_disabled().
> 
> I have to say that the description of the problem is really cryptic.
> Please, provide more context, code paths, sample code, next time.
> 
Sorry, I will be more straight forward. And I had thought commit log had
mentioned it.
> Well, I probably got it. The code might sleep. But it should run on the

And you do get it.
> same CPU even after waking up. You try to achieve this by running
> the code in a process that is bound to a single CPU.
> 
> IMHO, this is not reliable. Anyone could change the affinity
> of the process in the meantime.
> 
No, it is not. As the code says: PF_NO_SETAFFINITY.
static inline bool is_percpu_thread(void)
{
#ifdef CONFIG_SMP
	return (current->flags & PF_NO_SETAFFINITY) &&
		(current->nr_cpus_allowed  == 1);
#else
	return true;
#endif
}

This is critical for cpuhp_* (kernel/cpu.c). And
hardlockup_detector_event_create() should be planned to run on such a
kthread.

Thanks,

	Pingfan

> I see two solutions. Either avoid the sleep or making sure
> that the code access per-CPU variables on the same CPU
> all the time.
> 
> For example, you might use
> 
> 	*per_cpu_ptr(watchdog_ev, cpu) = evt;
> 
> instead of
> 
> 	this_cpu_write(watchdog_ev, evt);
> 
> Best Regards,
> Petr

