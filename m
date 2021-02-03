Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA630D9B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhBCMWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBCMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:22:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B4C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BLKFiOlbJDOWii2pbgHA5lJ2Ah9mF9AHYQiKGvGJc/A=; b=tQXSKKB7FTpIrzIZOEkfWKPuYg
        ecnN4Cii/6JuxPPQjJrNNevlznfrjXOnnZKV2a8jSofWKbxaHopuuMP6eXKTRvcEnX0dV2PoOtyE5
        CpyzpKIGtKo7Q8G8Q8m5StfCzwZMr1McK1e36QzKiRVUNsXi+8y7+dq3ZIphGc0Zun4tWvd95ekk7
        gkerjaA7dDClIwYTix/Ukgr838DpKz3YxMLVm8YwLpRun0f5FfD1jTM3WWO2y6gXdgEDa5TLnVwPu
        J4/HTEGC9Tlmzzsirj0t81VZA2ApuVbh3A0mfcteCnerDYu995Xmo1CnMCZYggi9cbz607O1lSN3w
        ApHTybNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7HAZ-00015k-5f; Wed, 03 Feb 2021 12:22:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB628301179;
        Wed,  3 Feb 2021 13:22:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D1CF2364E362; Wed,  3 Feb 2021 13:22:01 +0100 (CET)
Date:   Wed, 3 Feb 2021 13:22:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBqVaY8aTMYtoUnX@hirez.programming.kicks-ass.net>
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net>
 <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 11:04:43AM +0100, Dmitry Vyukov wrote:

> PERF_EVENT_IOC_{ENABLE,DISABLE} work as advertised.
> However, PERF_EVENT_IOC_MODIFY_ATTRIBUTES does not work for inherited
> child events.
> Does something like this make any sense to you? Are you willing to
> accept such change?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 55d18791a72d..f6974807a32c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3174,7 +3174,7 @@ int perf_event_refresh(struct perf_event *event,
> int refresh)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_refresh);
> 
> -static int perf_event_modify_breakpoint(struct perf_event *bp,
> +static int _perf_event_modify_breakpoint(struct perf_event *bp,
>                                          struct perf_event_attr *attr)
>  {
>         int err;
> @@ -3189,6 +3189,28 @@ static int perf_event_modify_breakpoint(struct
> perf_event *bp,
>         return err;
>  }
> 
> +static int perf_event_modify_breakpoint(struct perf_event *bp,
> +                                       struct perf_event_attr *attr)
> +{
> +       struct perf_event *child;
> +       int err;
> +
> +       WARN_ON_ONCE(bp->ctx->parent_ctx);
> +
> +       mutex_lock(&bp->child_mutex);
> +       err = _perf_event_modify_breakpoint(bp, attr);
> +       if (err)
> +               goto unlock;
> +       list_for_each_entry(child, &bp->child_list, child_list) {
> +               err = _perf_event_modify_breakpoint(child, attr);
> +               if (err)
> +                       goto unlock;
> +       }
> +unlock:
> +       mutex_unlock(&bp->child_mutex);
> +       return err;
> +}
> +
>  static int perf_event_modify_attr(struct perf_event *event,
>                                   struct perf_event_attr *attr)

Oh.. yeah, normal ioctl()s go through the perf_event_for_each_child()
thing, but that doesn't work here.

So yeah, I suppose your patch makes sense.
