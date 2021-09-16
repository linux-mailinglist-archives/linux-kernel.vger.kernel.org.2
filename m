Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE340D4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhIPIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:37:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhIPIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:37:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC1A71FEB1;
        Thu, 16 Sep 2021 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631781370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79mscK8roTgwKozDJaNFGPb9v79JgIWvwk3WR5On0oU=;
        b=TlnPBdyYJHEHdBkGw6SFRCA4CswKRzdbRyeubemAwG6mbd3ZoOka7ByDwr+fxtwJBVy0EX
        uEx3SRbyV8evPNoCZjhRt0amIAdNLlSR+y51WUyL/cDQ1HHgoF42XT5ZIEweTyJ316+YZd
        F0oXxS4GAtTSdTRP6nx/qSj6GrLmK0I=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A988A3BA4;
        Thu, 16 Sep 2021 08:36:10 +0000 (UTC)
Date:   Thu, 16 Sep 2021 10:36:10 +0200
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
Message-ID: <YUMB+ghuYiuhNm2D@alley>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUMAUE5RFJAtAS/z@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMAUE5RFJAtAS/z@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-16 10:29:05, Petr Mladek wrote:
> On Wed 2021-09-15 11:51:01, Pingfan Liu wrote:
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach by enabling watchdog_hld to
> > get the capability of PMU async.
> 
> This is another cryptic description. I have probably got it after
> looking at the 5th patch (was not Cc :-(
> 
> > The async model is achieved by introducing an extra parameter notifier
> > of watchdog_nmi_probe().
> 
> I would say that the code is horrible and looks too complex.
> 
> What about simply calling watchdog_nmi_probe() and
> lockup_detector_setup() once again when watchdog_nmi_probe()
> failed in lockup_detector_init()?
> 
> Or do not call lockup_detector_init() at all in
> kernel_init_freeable() when PMU is not ready yet.

BTW: It is an overkill to create your own kthread just to run some
code just once. And you implemeted it a wrong way. The kthread
must wait in a loop until someone else stop it and read
the exit code.

The easiest solution is to queue a work into system_wq for this.

I was not Cc for the 5th patch, so I write it here.

Best Regards,
Petr
