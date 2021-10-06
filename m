Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C8423AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhJFJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:38:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528AC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:36:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p1so1849029pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q5RcU7Cd+l7p3SwyuGfDKoPMym4fFieCnhHpZSVSB3U=;
        b=LhOlkanF51f84DPt+fWaOrOWxWdtGnSN+MuVy6NjxfnqlD4yUUPtMfqqJcM6jgXVH3
         T8XvWb6OzK4dXltUd67UOpiUfl9tJ7OLindQ0H3fsso6Y6bO6DliafOccqgORiqxfVcP
         guOx/eZM2rJFciW/2gWBIQB/ju8B1OWKKFwwbXphXXMRHn/dJiv0g7ssh8CCLwTCTWpx
         gEXc1Yj+Gne3WVpttMcv2XaGHIOELvCikJHAuKa4DJPH7pXN4Q5MFwVLEP6abhtbbl29
         SH/TkOw9au/fci7YWhgV8KucTxJuQNMBzPOLYJFyrrQZwAU3wHwuuQMPv9T8mftenLmr
         7lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q5RcU7Cd+l7p3SwyuGfDKoPMym4fFieCnhHpZSVSB3U=;
        b=hIp41D6KRmhazwXtLQBzL8MVzoCchsJIEz1K11NXOXLnEbmKGfIxwd6RFnzYqonN57
         +hqlchpIS3F1YSIh0TWjET1Nfjgd/4OVywB2ZDgdqHpljUtYgFN98B2vBZL+KRAwdIFy
         liEkUXf2UZjqgzM8lXbqhHvTOR+5tOqgMHQbPGKHm2oYqZXFS9FUGHxZt14bEpx22FfS
         ku5rv1NZOxjSXS8eujd8mPhCpZ6HpiW+HPDejZClZ/aRLR+GV8oDIVADMyUpg48AMt28
         FlcCwyfb1nVcmMvv03va3JNbTKwZj5q4xFRpzfbQNwU1YXSI+F3FrLzvMaWOnAykPhBi
         0aTg==
X-Gm-Message-State: AOAM530ZkFk0nMreNjkIsZN1+Q9Y4pJnbx2KR6CietZOXxZ5S3dZYfJ6
        pmWRaR433iLpeDKPqVWWvY+D0g==
X-Google-Smtp-Source: ABdhPJyLCrcof0wyFFQcn47INgjPd+eW3OMXI0q07teu7d0jEXelUV9wQn+BkQA/+lg9LohHY6664A==
X-Received: by 2002:a63:4a18:: with SMTP id x24mr19656400pga.209.1633512987501;
        Wed, 06 Oct 2021 02:36:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.210])
        by smtp.gmail.com with ESMTPSA id u2sm4659583pji.30.2021.10.06.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:36:26 -0700 (PDT)
Date:   Wed, 6 Oct 2021 17:36:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211006093620.GA14400@leoy-ThinkPad-X240s>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Tue, Oct 05, 2021 at 11:06:12AM +0100, German Gomez wrote:

[...]

> Yesterday we did some testing and found that there seems to be an exact
> match between using context packets and switch events. However this only
> applies when tracing in userspace (by adding the 'u' suffix to the perf
> event). Otherwise we still see as much as 2% of events having the wrong
> PID around the time of the switch.

This result sounds reasonable for me, if we only trace the userspace,
the result should have no any difference between using context packets
and switch events.

It's a bit high deviation with switch events (1.30% as shown in below
result) after enable kernel tracing.

> In order to measure this I applied Namhyung's patch and James's patch
> from [1]. Then added a printf line to the function arm_spe_prep_sample
> where I have access to both PID values, as a quick way to compare them
> later in a perf-report run. This is the diff of the printf patch:
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 41385ab96fbc..591985c66ac4 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -247,6 +247,8 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
>     event->sample.header.type = PERF_RECORD_SAMPLE;
>     event->sample.header.misc = sample->cpumode;
>     event->sample.header.size = sizeof(struct perf_event_header);
> +
> +       printf(">>>>>> %d / %lu\n", speq->tid, record->context_id & 0x7fff);
>  }
> 
> The differences obtained as error % were obtained by running the
> following perf-record commands for different configurations:
> 
> $ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/u -a -- sleep 60
> $ sudo ./perf report --stdio \
>     | grep ">>>>>>" \
>     | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'
> 
> Error: 0% out of 11839328 samples
> 
> $ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/ -a -- sleep 10
> $ sudo ./perf report --stdio \
>     | grep ">>>>>>" \
>     | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'
> 
> Error: 1.30624% out of 3418731 samples

Thanks for sharing this!

> I think the fallback to using switch when we can't use the CONTEXTIDR
> register is a viable option for userspace events, but maybe not so much
> for non-userspace.

Agreed.

If so, it's good to check the variable
'evsel->core.attr.exclude_kernel' when decode Arm SPE trace data, and
only use context switch event when 'exclude_kernel' is set.

Here should note one thing is the perf tool needs to have knowledge to
decide if the bit 3 'CX' (macro 'SYS_PMSCR_EL1_CX_SHIFT' in kernel) has
been set in register PMSCR or not.  AFAIK, Arm SPE driver doesn't
expose any interface (or config) to userspace for the context tracing,
so one method is to add an extra config in Arm SPE driver for this
bit, e.g. 'ATTR_CFG_FLD_cx_enable_CFG' can be added in Arm SPE driver.

Alternatively, rather than adding new config, I am just wandering we
simply use two flags in perf's decoding: 'use_switch_event_for_pid' and
'use_ctx_packet_for_pid', the first variable will be set if detects
the tracing is userspace only, the second varaible will be set when
detects the hardware tracing containing context packet.  So if the
variable 'use_ctx_packet_for_pid' has been set, then the decoder will
always use context packet for sample's PID, otherwise, it falls back
to check 'use_switch_event_for_pid' and set sample PID based on switch
events.

If have any other idea, please feel free bring up.

Thanks,
Leo
