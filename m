Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF8346B52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCWVm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhCWVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:42:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1565C061764
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8rNFDdFuXcvKEbcGYkkCSUHerc7FqNZ2rVvQuj4NgXc=; b=fyzmbsSXFIEU7Oku2tQlk8WIt8
        zPMmJHqW/d84PSQVOl8tlhtWGFuiK6gPKxnRK0YbVELnP81Hytm9o1jo8nhbRwxMzEW4iyUBkdny9
        iEcTMjOjmYKJ85Toc0VHX1FfaJNlCM3ScKqSLzRfJh2wxbD+/v5kK54dGhPiPEYMsCAfeQKforELP
        VZGdDitOT+1TZRRCYZtWxHggAnFYWUrDocmG8sIr/mqnPxI63ouCOdOQZEXwQxN4PDkP50qpIlZIb
        AxK+Tl/olEV8BrIw/vpVdoQXlNSv6b7WwKcbGC7z27FD1A7Q1aV1tcxgM6VkOiQvoeLEBxDz2OyPw
        9aKCwKHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOomT-00FnlG-07; Tue, 23 Mar 2021 21:41:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AF0B9864F6; Tue, 23 Mar 2021 22:41:40 +0100 (CET)
Date:   Tue, 23 Mar 2021 22:41:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] perf/x86/lbr: Move cpuc->lbr_xsave
 allocation out of sleeping region
Message-ID: <20210323214140.GE4746@worktop.programming.kicks-ass.net>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-4-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322060635.821531-4-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:06:33PM +0800, Like Xu wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 18df17129695..a4ce669cc78d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -373,7 +373,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  	return x86_pmu_extra_regs(val, event);
>  }
>  
> -int x86_reserve_hardware(void)
> +int x86_reserve_hardware(struct perf_event *event)
>  {
>  	int err = 0;
>  
> @@ -382,8 +382,10 @@ int x86_reserve_hardware(void)
>  		if (atomic_read(&pmc_refcount) == 0) {
>  			if (!reserve_pmc_hardware())
>  				err = -EBUSY;
> -			else
> +			else {
>  				reserve_ds_buffers();
> +				reserve_lbr_buffers(event);
> +			}
>  		}
>  		if (!err)
>  			atomic_inc(&pmc_refcount);

This makes absolutely no sense what so ever. This is only executed for
the first event that gets here.
