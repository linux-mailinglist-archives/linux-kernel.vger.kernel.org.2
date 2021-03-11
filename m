Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BB3370D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhCKLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhCKLHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:07:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iHh0nGuON0GnhWB0oe/+AjkzECa/k6Nl6YHLZz6URzk=; b=K1YNv30N5uy4XfpYOYBHC95n/S
        UJWgktYZFQGV4RKswmJE1eFv4d4FrIjWHTUzC/hnmyZIRZsUMfBpJ8PIjhaxw/uxw+Im0cNLirSam
        pzddfXw7yQjNg0NM+1wqKCginJIK3wyupX9hADBpdFR1w8huiktmpmh/vAaqFmczzpgIObDjZJrqE
        Qc3yEnFU8NG6nN+8RLNtnrIMUKMQ6DqZOAVUgtY6EYPxNfljzdxG++YEK18uX9aavaq2liwKCFzCD
        bZCt1zmVYGi54dW2DDgUP1lA1fQ4eWYTX0r3bspb+QW1xoyPRa/vrERD0VapOfP4ZcBJHaqoGhFFL
        Z6LH16bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKJ9l-008udr-7q; Thu, 11 Mar 2021 11:07:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34D65304D28;
        Thu, 11 Mar 2021 12:07:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2804529A42B8C; Thu, 11 Mar 2021 12:07:03 +0100 (CET)
Date:   Thu, 11 Mar 2021 12:07:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 08/25] perf/x86: Hybrid PMU support for hardware cache
 event
Message-ID: <YEn513bZDuWKj3LS@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615394281-68214-9-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:44AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The hardware cache events are different among hybrid PMUs. Each hybrid
> PMU should have its own hw cache event table.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c       | 11 +++++++++--
>  arch/x86/events/perf_event.h |  9 +++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 039a851..1db4a67 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -352,6 +352,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  {
>  	struct perf_event_attr *attr = &event->attr;
>  	unsigned int cache_type, cache_op, cache_result;
> +	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
>  	u64 config, val;
>  
>  	config = attr->config;
> @@ -371,7 +372,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  		return -EINVAL;
>  	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
>  
> -	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
> +	if (pmu)
> +		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
> +	else
> +		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
>  
>  	if (val == 0)
>  		return -ENOENT;
> @@ -380,7 +384,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  		return -EINVAL;
>  
>  	hwc->config |= val;
> -	attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
> +	if (pmu)
> +		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
> +	else
> +		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];

Why not:

	attr->config1 = hybrid(event->pmu, hw_cache_extra_regs)[cache_type][cache_op][cache_result];

?
