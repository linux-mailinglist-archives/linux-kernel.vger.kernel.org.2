Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D634A42C790
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhJMR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:28:46 -0400
Received: from foss.arm.com ([217.140.110.172]:42826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhJMR2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:28:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A45A1063;
        Wed, 13 Oct 2021 10:26:40 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED533F694;
        Wed, 13 Oct 2021 10:26:35 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:26:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/5] perf: Add a counter for number of user access
 events in context
Message-ID: <20211013172633.GB5400@C02TD0UTHF1T.local>
References: <20210914204800.3945732-1-robh@kernel.org>
 <20210914204800.3945732-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914204800.3945732-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 03:47:57PM -0500, Rob Herring wrote:
> For controlling user space counter access, we need to know if any event
> in a context (currently scheduled or not) is using user space counters.
> Walking the context's list of events would be slow, so add a counter
> to track this.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v10:
>  - Re-added.
>  - Maintain the count in the perf core
> v9:
>  - Dropped
> v8:
>  - new patch
> ---
>  include/linux/perf_event.h | 1 +
>  kernel/events/core.c       | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 12debf008d39..4f82a4d47139 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -821,6 +821,7 @@ struct perf_event_context {
>  
>  	int				nr_events;
>  	int				nr_active;
> +	int				nr_user;
>  	int				is_active;
>  	int				nr_stat;
>  	int				nr_freq;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 744e8726c5b2..01290d150da3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1808,6 +1808,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	list_add_rcu(&event->event_entry, &ctx->event_list);
>  	ctx->nr_events++;
> +	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> +		ctx->nr_user++;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat++;
>  
> @@ -1999,6 +2001,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>  	event->attach_state &= ~PERF_ATTACH_CONTEXT;
>  
>  	ctx->nr_events--;
> +	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> +		ctx->nr_user--;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat--;
>  
> -- 
> 2.30.2
> 
