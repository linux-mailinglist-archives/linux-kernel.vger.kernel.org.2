Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA773B9F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGBKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhGBKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625222301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jhy7oQ6OM7B+4Jm5gGboxh5vi7rfcWKg83wb7O5mvMM=;
        b=dgs0e8nWgz0Ye1hgpYTLXRKI4YVC0VhnToLuR7+oTkvKBodP7MvXdSiasBEyUR1yiMJfc2
        1an+R7l7TtCtFViciRUq3DLDRGE8/8NFydC9rwJXQ9Fo272pKKy0EjXYtw9U3ERga+6slP
        jK7C9XjYvC5VgpHXvDAU117mQubpWTE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-ntqCCW3XNg-YDMgA2dOQfQ-1; Fri, 02 Jul 2021 06:38:20 -0400
X-MC-Unique: ntqCCW3XNg-YDMgA2dOQfQ-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso4919129edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jhy7oQ6OM7B+4Jm5gGboxh5vi7rfcWKg83wb7O5mvMM=;
        b=l+S5f/1AB84FxS4YfdR4gzaY30PYk7CUHj7NCdPmqRY2kUp9zar9gkSKtLQZJLtqW3
         6a1pnRohFxcsKZoorHkNpRd36qs7ywuO2w5PNVEcfCSOPv2EfakiMaQg/mH9Gaommvul
         uU5zomL4C2/6U62DSld5VlXmL0OOH0N2V9OcSlqQ3Kd0dtkAsewGNXH1E8/6c9qr4OgX
         pElefeinEVtJvbXRQcrMEJTHZh6d00h36Hq1/ngaK/9WHqZl5xYxjN3+DAeJooZGRYDm
         +l+M2dsOxiP0RCUJit+BHEnAg3FXDJfwMQAAUx509u9OgpUdTmjRWQHvbKipr2tnw+vf
         ap0Q==
X-Gm-Message-State: AOAM532cLxefzPudk7ygzm3hl4hDbJwIMuirbwl+TzmLSS7TAiOW3Fvl
        90H+px3oCeRo2FFBGyATpIdiFus/F5xmiY9cH9RR01X5Idf78PAw2tfwNeFOgKiwTbn9OZmziR7
        UwaxDRQGeUwXCpvJEpv89MsuN
X-Received: by 2002:a17:906:c247:: with SMTP id bl7mr4759355ejb.288.1625222299483;
        Fri, 02 Jul 2021 03:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI7CyjlmpNTyZ9+pKXRhk4lMHzcxEYa32cny4CDcoLN1ivdI0KTySL1aJqQnbF9EbFZBanlg==
X-Received: by 2002:a17:906:c247:: with SMTP id bl7mr4759338ejb.288.1625222299301;
        Fri, 02 Jul 2021 03:38:19 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id j5sm904423ejn.19.2021.07.02.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:38:18 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:38:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf report: Fix --task and --stat with pipe input
Message-ID: <YN7skX0uRz5SrB0w@krava>
References: <20210630043058.1131295-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630043058.1131295-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:30:58PM -0700, Namhyung Kim wrote:
> Current perf report fails to process a pipe input when --task
> or --stat option is used.  This is because they reset all the
> tool callbacks and failed to find a matching event for a sample.
> 
> When pipe input is used, the event info is passed via ATTR records
> so it needs to handle that operation.  Otherwise the following error
> occurred.  Note, -14 (= -EFAULT) comes from evlist__parse_sample():
> 
>   # perf record -a -o- sleep 1 | perf report -i- --stat
>   Can't parse sample, err = -14
>   0x271044 [0x38]: failed to process type: 9
>   Error:
>   failed to process sample
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-report.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index bc5c393021dc..8639bbe0969d 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -729,9 +729,14 @@ static int count_sample_event(struct perf_tool *tool __maybe_unused,
>  	return 0;
>  }
>  
> +static int process_attr(struct perf_tool *tool __maybe_unused,
> +			union perf_event *event,
> +			struct evlist **pevlist);
> +
>  static void stats_setup(struct report *rep)
>  {
>  	memset(&rep->tool, 0, sizeof(rep->tool));
> +	rep->tool.attr = process_attr;
>  	rep->tool.sample = count_sample_event;
>  	rep->tool.no_warn = true;
>  }
> @@ -753,6 +758,7 @@ static void tasks_setup(struct report *rep)
>  		rep->tool.mmap = perf_event__process_mmap;
>  		rep->tool.mmap2 = perf_event__process_mmap2;
>  	}
> +	rep->tool.attr = process_attr;
>  	rep->tool.comm = perf_event__process_comm;
>  	rep->tool.exit = perf_event__process_exit;
>  	rep->tool.fork = perf_event__process_fork;
> -- 
> 2.32.0.93.g670b81a890-goog
> 

