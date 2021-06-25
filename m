Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB33B443A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFYNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhFYNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:18:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA6C061574;
        Fri, 25 Jun 2021 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lEAVwTNQkIPdoS7zCxdZ2+tlhF2QH6eEkVKF2NaTA2s=; b=ni0JMqIw2+RqrK0BpOB0IaQJG4
        cQcucQGpdVTKUpifDy7m+7akVTFYLdFKdFW5zWaG7+HwPCOsmsHJPARm+v0dQ5sT65v1a6LvGTa0A
        L0kFJvlUlkMOLE39sXUfd+RT3kZOhBKdyq1EzakJUu6HXJ2AN4EOu8kY2IqSRVDJFfYCCLlri3KC5
        q65BWFl8jRXJM4zSvDY3Ynnb7SRB2C3U3Y7AhB25MSYbh2Q2u7LqY4iB0BQaakfzM4PMDPPPOrDDp
        NbnVDdEOjOhm38lPWvTtWPhHJyn4g+UVFM4MPAekHjSeIsvZm7/P0InHlJGlKVgLYpATKXA++20S8
        gzysadew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwlfx-0007Im-Pd; Fri, 25 Jun 2021 13:15:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01E2130021A;
        Fri, 25 Jun 2021 15:15:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B18012BABB0C8; Fri, 25 Jun 2021 15:15:15 +0200 (CEST)
Date:   Fri, 25 Jun 2021 15:15:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/x86: Add new event for AUX output counter index
Message-ID: <YNXW4+QqeO1KL4Xq@hirez.programming.kicks-ass.net>
References: <20210609142055.32226-1-adrian.hunter@intel.com>
 <20210609142055.32226-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142055.32226-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:20:53PM +0300, Adrian Hunter wrote:

> +static void intel_pmu_report_aux_output_id(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * So long as all PEBS-via-PT events for a recording session are
> +	 * scheduled together, then only changes to hwc->idx need be reported.
> +	 */
> +	if (hwc->idx != hwc->idx_reported) {
> +		hwc->idx_reported = hwc->idx;
> +		perf_report_aux_output_id(event, hwc->idx);
> +	}
> +}

AFAICT you want a callback in x86_assign_hw_event(), is that so?
