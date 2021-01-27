Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A253063E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhA0TOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhA0TOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:14:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC2C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+MDgdoUrWzI/DQUcv9LF2ByGyh+pDALIpKBjDIM6DNI=; b=xMQXpj8jToEcbeERsf40GfbdIz
        53BP6Cg6PG42ZG9RYJu4c6erfYRjmBe25jxrj1jTwYSXOFC8iykLJQt4cG6yp4d4EgHTCqCk3VQ/D
        fa3GrowEq1sOKuWal5Wvibqy/f+9aNlnaTFnLYxmz5VVo5HVVX2ZQw/HViQKkXHMw8SjL6gyfLrXG
        9ZOZE/+lX1QQoKSTzxj/yj8G0R8cbBK97v3gPfTMXscsi1BV6ft69sOWpZd5xV3zSKvGyC2D5L9Gh
        FN0X8vrxlsEmYKylr+xv1mcZKNZjd+rZ/S6l2EpcsyAV9VtoKh03e8fj9xqB0pChzAq9IHGPsk/Jq
        mO5Zyo+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4qG7-0000TW-7i; Wed, 27 Jan 2021 19:13:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A8F73003D8;
        Wed, 27 Jan 2021 20:13:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 059D42D2DAB27; Wed, 27 Jan 2021 20:13:40 +0100 (CET)
Date:   Wed, 27 Jan 2021 20:13:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH V2 3/5] perf/x86/intel: Filter unsupported Topdown
 metrics event
Message-ID: <YBG7ZJUBQsUmoXlY@hirez.programming.kicks-ass.net>
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
 <1611761925-159055-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611761925-159055-4-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 07:38:43AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current perf doesn't check the index of a Topdown metrics event before
> updating the event. A perf tool user may get a value from an unsupported
> Topdown metrics event.
> 
> For example, the L2 topdown event, cpu/event=0x00,umask=0x84/, is not
> supported on Ice Lake. A perf tool user may mistakenly use the
> unsupported events via RAW format. In this case, the scheduler follows
> the unknown event handling and assigns a GP counter to the event. The
> icl_get_topdown_value() returns the value of the slots to the event.
> The perf tool user will get the value for the unsupported
> Topdown metrics event.
> 
> Add a check in the __icl_update_topdown_event() and avoid updating
> unsupported events.

I was struggling trying to understand how we end up here. Because
userspace can add whatever crap it wants, and why is only this thing a
problem..

But the actual problem is the next patch changing INTEL_TD_METRIC_NUM,
which then means is_metric_idx() will change, and that means that for
ICL we'll accept these raw events as metric events on creation and then
at runtime we get into trouble.

This isn't spelled out.

I do think this is entirely the wrong fix for that though. You're now
adding cycles to the relative hot path, instead of fixing the problem at
event creation, which is the slow path.

Why can't we either refuse the event on ICL or otherwise wreck it on
construction to avoid getting into trouble here?

> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 8eba41b..b02d482 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2319,6 +2319,17 @@ static void __icl_update_topdown_event(struct perf_event *event,
>  {
>  	u64 delta, last = 0;
>  
> +	/*
> +	 * Although the unsupported topdown events are not exposed to users,
> +	 * users may mistakenly use the unsupported events via RAW format.
> +	 * For example, using L2 topdown event, cpu/event=0x00,umask=0x84/,
> +	 * on Ice Lake. In this case, the scheduler follows the unknown
> +	 * event handling and assigns a GP counter to the event.
> +	 * Check the case, and avoid updating unsupported events.
> +	 */
> +	if (event->hw.idx < INTEL_PMC_IDX_FIXED)
> +		return;
> +
>  	delta = icl_get_topdown_value(event, slots, metrics);
>  	if (last_slots)
>  		last = icl_get_topdown_value(event, last_slots, last_metrics);
> -- 
> 2.7.4
> 
