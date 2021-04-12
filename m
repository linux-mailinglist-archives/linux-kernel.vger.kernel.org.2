Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1335B7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhDLARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 20:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDLARv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:17:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663CCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:17:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a12so8058233pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/hDbATFNZsis7MWYUW3u7wfCnoY+1VO0z3DbFmvJs9I=;
        b=BrIf0jfTibULDNdipQhwdZxgjP9p9QFHfXRfBzGNZWRMyCS2VLDSdd+BgYJ1Fzmm+I
         2nksNfroo24+ZOQDaui15/5i3HUnFv3ACLnlwtFxPlHYmO9feBpllXZUjCY8zT21F4hU
         G0g66eMBVu0nl8e/kUc3ptr83StvWP1GZoMDP6m2Vy7YnT22lVNYvL79ebmP45MLSQNF
         jabZsNmw+2JKe7jTG4oIy/1d1ka1X7fKPRtgqIgjmOkeFyH0MASlQxr1oDcKahQgHMr8
         urSXBe/XnIxD1r4QDyy0vZ7AB1pdeaMQapLkBTxIlq72Qr0Ue5FSxlFalxuJYx859uzP
         4Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hDbATFNZsis7MWYUW3u7wfCnoY+1VO0z3DbFmvJs9I=;
        b=SbyAm42ehWU3xQr+ZOFt3eJaJAGDXRgya5Ceo7Crj2hsDfuXArB8xqUgn0L85K5Fap
         mNe5+zTn3FzAi5fHh4ENR+Wm/I5RRTQbEx5U7P5OlD6C53+Vp5/FiIPorY5jLZAwAAKy
         GaRvlZUGAfep/OfVQsQ3gp5pTt8vN60Ypsm6fslsFeULiRqBrTFhCrgfh9gxr7xLj42K
         VyAU4zfgc5XiVznOSNREN0QbZU+vneLb7DQcfUm83akVfiEr2Ixtze7tGCdsYvZQePKi
         BO27zki9whxflTNuo5bC2RYxqisJNp0OOMT9iFZIN9bYPV+Pc9gdnWDZmH2aSe1pGKjy
         MPWg==
X-Gm-Message-State: AOAM530T24NH+U3ACfExSf4omUhrsRynfUZ95g4W5wntaHjM9CciagLv
        MSqxExSDiUAPTHq6RMNV/W9adw==
X-Google-Smtp-Source: ABdhPJy22eytH778tsIHdUopZvfBmkSPHVx2RRngj50ySdL1fZWOPxUWrYyNwitC25GIZMQTRp54JA==
X-Received: by 2002:a63:5626:: with SMTP id k38mr25443942pgb.128.1618186653745;
        Sun, 11 Apr 2021 17:17:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id v126sm8067548pfv.138.2021.04.11.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 17:17:33 -0700 (PDT)
Date:   Mon, 12 Apr 2021 08:17:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH v3 2/6] perf arm-spe: Save clock parameters from
 TIME_CONV event
Message-ID: <20210412001727.GB6012@leoy-ThinkPad-X240s>
References: <20210410050046.5394-1-leo.yan@linaro.org>
 <20210410050046.5394-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410050046.5394-3-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 01:00:42PM +0800, Leo Yan wrote:
> During the recording phase, "perf record" tool synthesizes event
> PERF_RECORD_TIME_CONV for the hardware clock parameters and saves the
> event into the data file.
> 
> Afterwards, when processing the data file, the event TIME_CONV will be
> processed at the very early time and is stored into session context.
> 
> This patch extracts these parameters from the session context and saves
> into the structure "spe->tc" with the type perf_tsc_conversion, so that
> the parameters are ready for conversion between clock counter and time
> stamp.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

[...]

> ---
>  tools/perf/util/arm-spe.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 2539d4baec44..b48816d5c0b4 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -26,6 +26,7 @@
>  #include "symbol.h"
>  #include "thread.h"
>  #include "thread-stack.h"
> +#include "tsc.h"
>  #include "tool.h"
>  #include "util/synthetic-events.h"
>  
> @@ -45,6 +46,8 @@ struct arm_spe {
>  	struct machine			*machine;
>  	u32				pmu_type;
>  
> +	struct perf_tsc_conversion	tc;
> +
>  	u8				timeless_decoding;
>  	u8				data_queued;
>  
> @@ -1027,6 +1030,22 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
> +
> +	/*
> +	 * The synthesized event PERF_RECORD_TIME_CONV has been handled
> +	 * ahead and the parameters for hardware clock are stored in
> +	 * the session context.  Passes these parameters to the structure
> +	 * perf_tsc_conversion in "spe->tc", which is used for later
> +	 * conversion between clock counter and timestamp.
> +	 */
> +	spe->tc.time_shift = session->time_conv.time_shift;
> +	spe->tc.time_mult = session->time_conv.time_mult;
> +	spe->tc.time_zero = session->time_conv.time_zero;
> +	spe->tc.time_cycles = session->time_conv.time_cycles;
> +	spe->tc.time_mask = session->time_conv.time_mask;
> +	spe->tc.cap_user_time_zero = session->time_conv.cap_user_time_zero;
> +	spe->tc.cap_user_time_short = session->time_conv.cap_user_time_short;

As Adrain suggested, this patch also should check the size of event
PERF_RECORD_TIME_CONV for backwards-compability.   I will send a new
patch set for this.

Thanks,
Leo

>  	spe->auxtrace.process_event = arm_spe_process_event;
>  	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
>  	spe->auxtrace.flush_events = arm_spe_flush;
> -- 
> 2.25.1
> 
