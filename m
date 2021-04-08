Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB95B358A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhDHQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhDHQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225DC061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rIlk74hu6u1Wvn2ykETMvGWIBHu9TGe65AK0J/XIh2o=; b=p3jZZ2Q7L9Yo0PrzXwhi1tl+Q4
        31+bdZX/BimJzbQstUpmRYGoppW9blV7D/pP5v+MVzh4+ELDiid3VUXjzLmmXxpn/jZf+TLJfnQ5H
        xIvRHV0VeB+HPxl2zklAaFRPwoMOLcPUUV/32jR1221HD3DVZvkL5DpWVov++Dzj77cQ/hBvLcnpj
        wXzl5UTnNmGmngncq48c8T1wG4I2PsuydMx7rNbOHwoaseFGZ4A/iZNxF2XmMZGE0fKIl5QrVBbfG
        I55J3XL6tz0IcOI9UEY0404yRt6qNWjD/tpDhaCua+Qi2icb1OcO7FGIY1RnEMfKUefaqgSly1zKi
        vbqNT12Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXna-00GXc6-S8; Thu, 08 Apr 2021 16:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8CE43000CC;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0C602C71EC98; Thu,  8 Apr 2021 15:40:56 +0200 (CEST)
Date:   Thu, 8 Apr 2021 15:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 04/25] perf/x86/intel: Hybrid PMU support for perf
 capabilities
Message-ID: <YG8H6Fac/p6PpcAu@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:10:46AM -0700, kan.liang@linux.intel.com wrote:
> +static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
> +{
> +	union perf_capabilities *intel_cap;
> +
> +	intel_cap = is_hybrid() ? &hybrid_pmu(event->pmu)->intel_cap :
> +				  &x86_pmu.intel_cap;

This isn't:

	intel_cap = &hybrid_pmu(event->pmu)->intel_cap;

because..

> +
> +	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
> +}


> @@ -3712,7 +3721,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	 * with a slots event as group leader. When the slots event
>  	 * is used in a metrics group, it too cannot support sampling.
>  	 */
> -	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
> +	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
>  		if (event->attr.config1 || event->attr.config2)
>  			return -EINVAL;
>  

> @@ -4330,7 +4347,7 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>  
>  static int intel_pmu_aux_output_match(struct perf_event *event)
>  {
> -	if (!x86_pmu.intel_cap.pebs_output_pt_available)
> +	if (!intel_pmu_has_cap(event, PERF_CAP_PT_IDX))
>  		return 0;
>  
>  	return is_intel_pt_event(event);

these sites can have !event->pmu ?
