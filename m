Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08640D22E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 05:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhIPD7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 23:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232217AbhIPD7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 23:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631764681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hNTVI4DHdE4iH7+lWLOfR6K8Vz2L3FwykdFKQ1bK5eo=;
        b=NuMMS2clKsFBUAjAEq629rbNsGcqgSPuovtOxNM0yb94DUznVz8MwINf17aHsVz1+90b2x
        bgIrQUBd0LRK5+LF/GRmJQlq+3T815gecwm0w8p6k4Bv092csPmYLbK4Dl4+rBKORE0ePP
        3E0Mn9Xmqm0ZqZPpNJUlEkbQN5GKzok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-dCJgUVJpM26-lcpE4cnw-A-1; Wed, 15 Sep 2021 23:57:58 -0400
X-MC-Unique: dCJgUVJpM26-lcpE4cnw-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F360343D0;
        Thu, 16 Sep 2021 03:57:55 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DB0810016FB;
        Thu, 16 Sep 2021 03:57:48 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:57:44 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YULAuEeSSeLTcBM9@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-3-kernelfans@gmail.com>
 <YUH44qrky9oM+3nU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUH44qrky9oM+3nU@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:45:06PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 15, 2021 at 11:51:00AM +0800, Pingfan Liu wrote:
> > hardlockup_detector_event_create() indirectly calls
> > kmem_cache_alloc_node(), which is blockable.
> > 
> > So here, the really planned context is is_percpu_thread().
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Wang Qing <wangqing@vivo.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Santosh Sivaraj <santosh@fossix.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > To: linux-kernel@vger.kernel.org
> > ---
> >  kernel/watchdog_hld.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> > index 247bf0b1582c..6876e796dbf5 100644
> > --- a/kernel/watchdog_hld.c
> > +++ b/kernel/watchdog_hld.c
> > @@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
> >  
> >  static int hardlockup_detector_event_create(void)
> >  {
> > -	unsigned int cpu = smp_processor_id();
> > +	unsigned int cpu;
> >  	struct perf_event_attr *wd_attr;
> >  	struct perf_event *evt;
> >  
> > +	/* This function plans to execute in cpu bound kthread */
> > +	BUG_ON(!is_percpu_thread());
> > +	cpu = raw_smp_processor_id();
> >  	wd_attr = &wd_hw_attr;
> >  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> 
> This patch makes no sense.

This patch aims to disable any attempt such as using get_cpu()/put_cpu() to
shut up the check_preemption_disabled().

But if anybody is familiar with the integration of watchdog_hld and
cpuhp, he should know the right way without this BUG_ON() or warn.

Do you still think it is pointless?


Thanks,

	Pingfan

