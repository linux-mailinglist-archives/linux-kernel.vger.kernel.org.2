Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062E244D265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKKHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:21:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B7AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:18:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso3884707pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYrvbXawX/D86nhUYmoX07v/ep6S8FSDyEh1vsVQ5lA=;
        b=nBaUZWPAK0PuqPJ946GqOziDlcGX017pnlnYd7tQi7u36QwyYhUNmU78WEgB/Bwh8z
         lquVB+f2q2T6ei+5VFL9vGKhkUKLjv1FdfSuSH4CIy76Rwbi9p62GXC3iT2x+BCPpclQ
         aTrKoP+LsHRj1uOeFh/FiRAm7BluCU7MPJRn4JIkLzziU/Go1KD1FeGVHIwMA05zPdAm
         QtV6j2LswVZ48UQtJmU2NrD8ibnX1Ox673WVu/IteTsYHBj+zF4hEUplqzPZ7kV8GI2D
         grY7eaHTS4enzY7pRi8pDgSq1VmIIriOYWT0ldtnM686k0U1DRmgne90k3b7DJgcQ1BJ
         +p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYrvbXawX/D86nhUYmoX07v/ep6S8FSDyEh1vsVQ5lA=;
        b=qEEwdmo94B82QGKRxg1SSM/oNXp/QAj2la3ZwMixeQZwWR0uJF4Ev87M7G3BK3nC6h
         wBMG6NZ/TT6YFHx8eCg7M8SsZcE21DoeWlM8kTrLcPODrvqfKlT4VtdbccVPrsRSjC78
         xMsQrIUUgSLKOslUN0hsr9t0W/hAJKmFsqT2VvLpLMhT78E9Jidalwog5gUY31QkFayR
         ZwrrECQ3efc4nE19ESfvxDJ7w9y/KUI5+iFZM+EEIINAgp+3k6RFbNtdxoI0R4xM5iAI
         kyzHeSa3D2Ue05u9/h+8W7NsH8RIZefrXo1RRuA9n846FJQMzYrzpLCmQ0QhsVuYkb0l
         wNTQ==
X-Gm-Message-State: AOAM530r7PNrNTvYTV/wjseeygt20Xj/8QciyLm8jWfvGumfvVOhcf6f
        5W2zNU4khDAGlga2ORxCwWatC0oDsM3Pp90D
X-Google-Smtp-Source: ABdhPJydPbEjUiXMik5uIU53Rj70Ky1Wu38t2u0Q19XKvOMobEIbSXRkxrgmnL6ASFs/LxSavtIGbw==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr23719780pjb.97.1636615101877;
        Wed, 10 Nov 2021 23:18:21 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id h6sm1865485pfi.174.2021.11.10.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:18:21 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:18:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] perf arm-spe: Update --switch-events docs in
 perf-record
Message-ID: <20211111071815.GA102075@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211109115020.31623-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109115020.31623-3-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:50:18AM +0000, German Gomez wrote:
> Update perf-record docs and Arm SPE recording options so that they are
> consistent. This includes supporting the --no-switch-events flag in Arm
> SPE as well.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  tools/perf/arch/arm64/util/arm-spe.c     | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 2d7df8703..3cf7bac67 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -469,7 +469,7 @@ This option sets the time out limit. The default value is 500 ms.
>  
>  --switch-events::
>  Record context switch events i.e. events of type PERF_RECORD_SWITCH or
> -PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT or CoreSight)
> +PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight or Arm SPE)
>  switch events will be enabled automatically, which can be suppressed by
>  by the option --no-switch-events.
>  
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 58ba8d15c..725a06cd2 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -169,8 +169,10 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	if (!perf_cpu_map__empty(cpus)) {
>  		evsel__set_sample_bit(tracking_evsel, TIME);
>  		evsel__set_sample_bit(tracking_evsel, CPU);
> +
>  		/* also track task context switch */
> -		tracking_evsel->core.attr.context_switch = 1;
> +		if (!record_opts__no_switch_events(opts))
> +			tracking_evsel->core.attr.context_switch = 1;
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
