Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0340FCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhIQPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230146AbhIQPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631893331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=noifM8XXyMwbbFJd5i/42aORUxxVOt7zx3PNERa/hzo=;
        b=gXcJ2+6I13euwmHBy91yR0tcjHRecQNqV5Wj5NU82osIossZBsognSoI5hhV2674J7pZgG
        5yjjFW32AK+0m4rK+igj/Ri25Y+3UUnZeNPlHuZqKpJOyDAbcFsrXQ94r+Y0JD1IuDFr4e
        gCvFKcnRViOO+o38WLUTT3vo++Y8Wtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-UdQGdhi9NgW7pwDA-y5Zeg-1; Fri, 17 Sep 2021 11:42:10 -0400
X-MC-Unique: UdQGdhi9NgW7pwDA-y5Zeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26B19802C92;
        Fri, 17 Sep 2021 15:42:07 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA3805C1A1;
        Fri, 17 Sep 2021 15:41:35 +0000 (UTC)
Date:   Fri, 17 Sep 2021 23:41:31 +0800
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
Message-ID: <YUS3K4D6OlGybQ9G@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUMAUE5RFJAtAS/z@alley>
 <YUMB+ghuYiuhNm2D@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMB+ghuYiuhNm2D@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:36:10AM +0200, Petr Mladek wrote:
> On Thu 2021-09-16 10:29:05, Petr Mladek wrote:
> > On Wed 2021-09-15 11:51:01, Pingfan Liu wrote:
> > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > yet. E.g. on arm64, PMU is not ready until
> > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > with the driver model and cpuhp. Hence it is hard to push this
> > > initialization before smp_init().
> > > 
> > > But it is easy to take an opposite approach by enabling watchdog_hld to
> > > get the capability of PMU async.
> > 
> > This is another cryptic description. I have probably got it after
> > looking at the 5th patch (was not Cc :-(
> > 
> > > The async model is achieved by introducing an extra parameter notifier
> > > of watchdog_nmi_probe().
> > 
> > I would say that the code is horrible and looks too complex.
> > 
> > What about simply calling watchdog_nmi_probe() and
> > lockup_detector_setup() once again when watchdog_nmi_probe()
> > failed in lockup_detector_init()?
> > 
> > Or do not call lockup_detector_init() at all in
> > kernel_init_freeable() when PMU is not ready yet.
> 
> BTW: It is an overkill to create your own kthread just to run some
> code just once. And you implemeted it a wrong way. The kthread

I had thought about queue_work_on() in watchdog_nmi_enable(). But since
this work will block the worker kthread for this cpu. So finally,
another worker kthread should be created for other work.

But now, I think queue_work_on() may be more neat.

> must wait in a loop until someone else stop it and read
> the exit code.
> 
Is this behavior mandotory? Since this kthread can decide the exit
condition by itself.

And a quick through static int kthread(void *_create), I am not aware of
any problem with it.

> The easiest solution is to queue a work into system_wq for this.
> 
> I was not Cc for the 5th patch, so I write it here.
> 
Sorry for the inconvenience and Cc you now in case that you have further
comments. I will cc you in the next version.

Appreciate for all of your suggestions and comments

Thanks,

	Pingfan

