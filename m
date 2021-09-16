Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37B840D1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 05:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhIPDJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 23:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233982AbhIPDJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 23:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631761661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewIrGyvVBlsUzMY/tfpMG8U9MTVOYjLYfX7pFihyo8M=;
        b=iwrhf0PRvp93IBMV7kch35j84QetJTDrPrJxOXGgcOA3r0t/9c38tipttyuSCvWlJbOcMH
        xUNhhlwBsKD/UiNNYVs+OqFGeFAN34QlsVob1rME+UhNfEdjtijaJGMTNCqhctsHCgV0P+
        mqCaVEsXuMWrmYJ5PRRuoyWokGvabAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-iIgzS-9gPpywYjaz4atWZQ-1; Wed, 15 Sep 2021 23:07:39 -0400
X-MC-Unique: iIgzS-9gPpywYjaz4atWZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3719E362F8;
        Thu, 16 Sep 2021 03:07:37 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA9CD60C81;
        Thu, 16 Sep 2021 03:07:26 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:07:22 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YUK06iqiCwiIvpRM@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUH89GX1RB8fdcvh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUH89GX1RB8fdcvh@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:02:28PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 15, 2021 at 11:51:01AM +0800, Pingfan Liu wrote:
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach by enabling watchdog_hld to
> > get the capability of PMU async.
> > 
> > The async model is achieved by introducing an extra parameter notifier
> > of watchdog_nmi_probe().
> > 
> > Note after this patch, the async model, which is utilized by the next
> > patch, does not take effect yet.
> 
> I can't make any sense of what you're trying to do..
> 
Sorry for a bad expression. what I mean is: this patch [3/5] provides an
framework for async model. But since watchdog_nmi_probe() still return 0 or
-ENODEV after this patch, the code's behavior is the same as original.

Does it make sense to you?
> > +static void watchdog_nmi_report_capability(struct watchdog_nmi_status *data)
> > +{
> > +	/* Set status to 1 temporary to block any further access */
> > +	if (atomic_cmpxchg((atomic_t *)&nmi_watchdog_status, -EBUSY, 1)
> > +			== -EBUSY) {
> 
> But this..
> 
Oh, check other codes, for a wrapped condition, blanks should be better choice.
> > +		if (!data->status) {
> > +			nmi_watchdog_status = 0;
> > +			lockup_detector_update_enable();
> > +		} else {
> > +			nmi_watchdog_status = -ENODEV;
> > +			/* turn offf watchdog_enabled forever */
> > +			lockup_detector_update_enable();
> > +			pr_info("Perf NMI watchdog permanently disabled\n");
> > +		}
> > +	}
> > +}
> 
> > @@ -467,7 +494,8 @@ static void watchdog_enable(unsigned int cpu)
> >  	/* Initialize timestamp */
> >  	update_touch_ts();
> >  	/* Enable the perf event */
> > -	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
> > +	if (watchdog_enabled &
> > +			(NMI_WATCHDOG_ENABLED | NMI_WATCHDOG_UNDETERMINED))
> 
> and this, are horrible indenting.

Ditto.

Thanks for your comment and review.

Regards,

	Pingfan

