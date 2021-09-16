Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2B40D223
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 05:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhIPDsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 23:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232541AbhIPDsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 23:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631764040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+JIT4AJ69wrTaVMTCPeIuiXXsajLMxUyTsNs8z9LR4=;
        b=iOgPIAOU5vqNbiIBeVXzrQEqCQKfzIiAzJDyavSwZwYf2YptW1P82a94dHKCItJUJQbKOv
        KZ9Bo3PlZrvGnEN64MZFZWS/OD4SWA2LqQWP4R3U6y+4qkenjOPhJK6KegIhAFHjzgHZ8X
        pzjlWFu/9Psg0u6HVm2FtePZJgFU12U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-8JTwBmQoNWWTwAVrxpwsPQ-1; Wed, 15 Sep 2021 23:47:18 -0400
X-MC-Unique: 8JTwBmQoNWWTwAVrxpwsPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0151084686;
        Thu, 16 Sep 2021 03:47:16 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8D25D9CA;
        Thu, 16 Sep 2021 03:47:11 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:47:07 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YUK+O0QI4o0CoVeT@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-3-kernelfans@gmail.com>
 <20210914210627.c92374b3726a22014b359dbd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914210627.c92374b3726a22014b359dbd@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 09:06:27PM -0700, Andrew Morton wrote:
> On Wed, 15 Sep 2021 11:51:00 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:
> 
> > hardlockup_detector_event_create() indirectly calls
> > kmem_cache_alloc_node(), which is blockable.
> > 
> > So here, the really planned context is is_percpu_thread().
> > 
> > ...
> >
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
> 
> Can we avoid adding the BUG()?  Find a way to emit a WARNing and then
> permit the kernel to continue?
> 
Yes, WARN_ON() can work in this case.

Thanks,

	Pingfan

