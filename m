Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7340D44A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhIPIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:10:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhIPIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:10:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1980B2232C;
        Thu, 16 Sep 2021 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631779348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3UdE8OKRUWyRhg0kwtjoF0bATzYaRaijgzcmFzDwiY=;
        b=IQZWZWVT1/cwYxYhSrRYozPyoS48UfDv/M3uUtwU9DNhbJqzcXj3lnYrgwQrsMtOSUPXP8
        X1elXOCdCzD6yoZOMS77Ym+i9NRiZXTsZYthbqH65cry5LVbc0eJEYFNDChJb/j9mZj//f
        +Q2NCEQsIOwJaRnL1SNDVHbIyHF5+bA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFC94A3B94;
        Thu, 16 Sep 2021 08:02:27 +0000 (UTC)
Date:   Thu, 16 Sep 2021 10:02:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <piliu@redhat.com>
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
Message-ID: <YUL6E1Psg1xCrIxo@alley>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-3-kernelfans@gmail.com>
 <YUH44qrky9oM+3nU@hirez.programming.kicks-ass.net>
 <YULAuEeSSeLTcBM9@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YULAuEeSSeLTcBM9@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-16 11:57:44, Pingfan Liu wrote:
> On Wed, Sep 15, 2021 at 03:45:06PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 15, 2021 at 11:51:00AM +0800, Pingfan Liu wrote:
> > > hardlockup_detector_event_create() indirectly calls
> > > kmem_cache_alloc_node(), which is blockable.
> > > 
> > > So here, the really planned context is is_percpu_thread().
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Petr Mladek <pmladek@suse.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Wang Qing <wangqing@vivo.com>
> > > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > Cc: Santosh Sivaraj <santosh@fossix.org>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > To: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/watchdog_hld.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> > > index 247bf0b1582c..6876e796dbf5 100644
> > > --- a/kernel/watchdog_hld.c
> > > +++ b/kernel/watchdog_hld.c
> > > @@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
> > >  
> > >  static int hardlockup_detector_event_create(void)
> > >  {
> > > -	unsigned int cpu = smp_processor_id();
> > > +	unsigned int cpu;
> > >  	struct perf_event_attr *wd_attr;
> > >  	struct perf_event *evt;
> > >  
> > > +	/* This function plans to execute in cpu bound kthread */
> > > +	BUG_ON(!is_percpu_thread());
> > > +	cpu = raw_smp_processor_id();
> > >  	wd_attr = &wd_hw_attr;
> > >  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> > 
> > This patch makes no sense.
> 
> This patch aims to disable any attempt such as using get_cpu()/put_cpu() to
> shut up the check_preemption_disabled().

I have to say that the description of the problem is really cryptic.
Please, provide more context, code paths, sample code, next time.

Well, I probably got it. The code might sleep. But it should run on the
same CPU even after waking up. You try to achieve this by running
the code in a process that is bound to a single CPU.

IMHO, this is not reliable. Anyone could change the affinity
of the process in the meantime.

I see two solutions. Either avoid the sleep or making sure
that the code access per-CPU variables on the same CPU
all the time.

For example, you might use

	*per_cpu_ptr(watchdog_ev, cpu) = evt;

instead of

	this_cpu_write(watchdog_ev, evt);

Best Regards,
Petr
