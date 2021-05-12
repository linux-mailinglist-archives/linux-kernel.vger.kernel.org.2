Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209437B6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhELHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:39:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/HtEgfo+8owKtHSJ9OtxcPSq83IlwZd34hGYP6JvrQ=; b=UU46eiONlI6w/kWKXRxOK1NeTa
        aGh0R2DWj6eIklnONmQk6uz1UWUzzHWIzfM9OPclwKLjF/OxF8osvfKn/bZBimzbbx/3SN9EiULsx
        4laXg6fh/4t3OGqoPvMsNJ83vWMfrWIIrY5sQP/jwWO2/Jmhmycu7Ml/uqKaIYLXxzl8ptEYcJ9ZK
        4YijAUZwqrb3tiqu/xvqOsddlGTt0ik+2RNoafc1TC2+R7hr/LB3lyFuKRSd0Dq8GRDLYcf5y5BFj
        C9ubITz56QNrqTStc0jjq5yf2yPu2aODpWvBVIKtfrTjNKNdtPFcdXZTryKoIZ2O+GkuPdTURqnVt
        bbC/7DEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgjPS-0083wY-K4; Wed, 12 May 2021 07:36:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF4C3300242;
        Wed, 12 May 2021 09:35:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9C2320237F69; Wed, 12 May 2021 09:35:55 +0200 (CEST)
Date:   Wed, 12 May 2021 09:35:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
Message-ID: <YJuFW08p8dsKc/wN@hirez.programming.kicks-ass.net>
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
 <20210510191811.GA21560@worktop.programming.kicks-ass.net>
 <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
 <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com>
 <CAL_JsqJrrqbHbMXEpy++nGzZ5JD=mm4O2xPgL8g1MUXAQGk=Jw@mail.gmail.com>
 <f390aa11-e475-9d9d-9384-959a7ed32fd6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f390aa11-e475-9d9d-9384-959a7ed32fd6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 05:42:54PM -0400, Liang, Kan wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1574b70..8216acc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3851,7 +3851,7 @@ static void perf_event_context_sched_in(struct
> perf_event_context *ctx,
>  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>  	perf_event_sched_in(cpuctx, ctx, task);
> 
> -	if (cpuctx->sched_cb_usage && pmu->sched_task)
> +	if (pmu->sched_task && (cpuctx->sched_cb_usage ||
> atomic_read(&pmu->sched_cb_usages)))
>  		pmu->sched_task(cpuctx->task_ctx, true);

Aside from the obvious whitespace issues; I think this should work.
