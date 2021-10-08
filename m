Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA1426390
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhJHENk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232118AbhJHENj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633666303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Osq7yHITSy77g/Lrd5YqQ5+z91i4cbWQpNrrgt8Jybc=;
        b=MRvjwAt7Lc8uTWglJqzwoPvWaAVwrKfZYVVNR5nU6rP7DPyeUN0k3V05fXEtXkBOYx9XsU
        Cc2A9A0/0cwLxfLzGg9vAWlulVKrCokyNw7FbHBWOiYSXvA3eiebdoLXBplKfEARGK+s4P
        tw2OqeXye5wjgl55U4h1I1EFjyIG52U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-m1KOfDvHNJ60G1otsXrsww-1; Fri, 08 Oct 2021 00:11:42 -0400
X-MC-Unique: m1KOfDvHNJ60G1otsXrsww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 088EB362FA;
        Fri,  8 Oct 2021 04:11:41 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09E9210013D7;
        Fri,  8 Oct 2021 04:11:36 +0000 (UTC)
Date:   Fri, 8 Oct 2021 12:11:32 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/4] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YV/E9BvUrgECI8Hw@piliu.users.ipa.redhat.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-3-kernelfans@gmail.com>
 <YVr0bwfDZQFbBCFG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVr0bwfDZQFbBCFG@alley>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:32:47PM +0200, Petr Mladek wrote:
> On Thu 2021-09-23 22:09:49, Pingfan Liu wrote:
> > As for the context, there are two arguments to change
> > debug_smp_processor_id() to is_percpu_thread().
> > 
> >   -1. watchdog_ev is percpu, and migration will frustrate the attempt
> > which try to bind a watchdog_ev to a cpu by protecting this func inside
> > the pair of preempt_disable()/preempt_enable().
> > 
> >   -2. hardlockup_detector_event_create() indirectly calls
> > kmem_cache_alloc_node(), which is blockable.
> > 
> > So here, spelling out the really planned context "is_percpu_thread()".
> 
> The description is pretty hard to understand. I would suggest
> something like:
> 
> Subject: kernel/watchdog_hld: Ensure CPU-bound context when creating
> hardlockup detector event
> 
> hardlockup_detector_event_create() should create perf_event on the
> current CPU. Preemption could not get disabled because
> perf_event_create_kernel_counter() allocates memory. Instead,
> the CPU locality is achieved by processing the code in a per-CPU
> bound kthread.
> 
> Add a check to prevent mistakes when calling the code in another
> code path.
> 
Appreciate for that. I will use it.

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Wang Qing <wangqing@vivo.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Santosh Sivaraj <santosh@fossix.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  kernel/watchdog_hld.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> > index 247bf0b1582c..df010df76576 100644
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
> 
> This does not explain why it is needed. I suggest something like:
> 
> 	/*
> 	 * Preemption is not disabled because memory will be allocated.
> 	 * Ensure CPU-locality by calling this in per-CPU kthread.
> 	 */
> 
It sounds good. I will use it.

> 
> > +	WARN_ON(!is_percpu_thread());
> > +	cpu = raw_smp_processor_id();
> >  	wd_attr = &wd_hw_attr;
> >  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> >  
> 
> Othrewise the change looks good to me.
> 
Thank for your help.

Regards,

	Pingfan
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

