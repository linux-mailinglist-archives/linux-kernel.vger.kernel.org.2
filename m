Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72D40D47B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhIPIa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:30:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhIPIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:30:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6041022343;
        Thu, 16 Sep 2021 08:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631780945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G97GCwmyfCkI6JmtTd8q5za/edjByNEk6qqCT0LjfvM=;
        b=WQJkUYQL5bmETUpztyvvPaesPsa53Cyg2kjkyAUTQXSyPKaq0AKL13x+xN6xmDu/cfDw8u
        mr5lnV3+Ig5550wNV4DtqlRbTCfdGgeeOKSVFaowTv9WFbdsyHVHfpiMHTS9+0RTeyRAWT
        s3o1XxXc3d81dWM+6loLOrHXSG3DFYE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1D48A3B94;
        Thu, 16 Sep 2021 08:29:04 +0000 (UTC)
Date:   Thu, 16 Sep 2021 10:29:04 +0200
From:   Petr Mladek <pmladek@suse.com>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YUMAUE5RFJAtAS/z@alley>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915035103.15586-4-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-09-15 11:51:01, Pingfan Liu wrote:
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().
> 
> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async.

This is another cryptic description. I have probably got it after
looking at the 5th patch (was not Cc :-(

> The async model is achieved by introducing an extra parameter notifier
> of watchdog_nmi_probe().

I would say that the code is horrible and looks too complex.

What about simply calling watchdog_nmi_probe() and
lockup_detector_setup() once again when watchdog_nmi_probe()
failed in lockup_detector_init()?

Or do not call lockup_detector_init() at all in
kernel_init_freeable() when PMU is not ready yet.

Best Regards,
Petr
