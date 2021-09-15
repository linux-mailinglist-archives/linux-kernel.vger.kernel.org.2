Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E172740C6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhIOOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbhIOOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:06:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dk6obZxaaJ+u2DCXDBWFHKjLWJQNb3BiT9vPulsHNiE=; b=nFOILaamMzz0kf8HzmZxppyHW5
        uNW5I8vfo5S7j1HKNG1Hwhfv8mK9CjFk1O4PKy63hK7145GPCYA++Et78zg2rCLzw3EoXPzDpQHiH
        Aq8jPYmoGTbf91bvtkJtNYCFzX7gI01COG9zF4QX0QUan8mwZ9KCnPuMFFllVdsGM1dK1MoVS7TzA
        nrL2lz6nwRE9vVvgEDjOmXVFuqqG85Qeuuq1YbqXNYghbo2ngGMpJzgJUJEGVrai1Jbvmgd7z2oLN
        mH/RR/IDQ6B/9/xwORNwA3N0YTp01h/800bLZsXiz0MaSm+jJqwM5Oi2btTgGer6n5ZfI8oETXwBo
        oHqOjJGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVUc-00FjOH-B6; Wed, 15 Sep 2021 14:02:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 483A83001C7;
        Wed, 15 Sep 2021 16:02:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07FF2285DFF65; Wed, 15 Sep 2021 16:02:29 +0200 (CEST)
Date:   Wed, 15 Sep 2021 16:02:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
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
Message-ID: <YUH89GX1RB8fdcvh@hirez.programming.kicks-ass.net>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915035103.15586-4-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:51:01AM +0800, Pingfan Liu wrote:
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().
> 
> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async.
> 
> The async model is achieved by introducing an extra parameter notifier
> of watchdog_nmi_probe().
> 
> Note after this patch, the async model, which is utilized by the next
> patch, does not take effect yet.

I can't make any sense of what you're trying to do..

> +static void watchdog_nmi_report_capability(struct watchdog_nmi_status *data)
> +{
> +	/* Set status to 1 temporary to block any further access */
> +	if (atomic_cmpxchg((atomic_t *)&nmi_watchdog_status, -EBUSY, 1)
> +			== -EBUSY) {

But this..

> +		if (!data->status) {
> +			nmi_watchdog_status = 0;
> +			lockup_detector_update_enable();
> +		} else {
> +			nmi_watchdog_status = -ENODEV;
> +			/* turn offf watchdog_enabled forever */
> +			lockup_detector_update_enable();
> +			pr_info("Perf NMI watchdog permanently disabled\n");
> +		}
> +	}
> +}

> @@ -467,7 +494,8 @@ static void watchdog_enable(unsigned int cpu)
>  	/* Initialize timestamp */
>  	update_touch_ts();
>  	/* Enable the perf event */
> -	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
> +	if (watchdog_enabled &
> +			(NMI_WATCHDOG_ENABLED | NMI_WATCHDOG_UNDETERMINED))

and this, are horrible indenting.
