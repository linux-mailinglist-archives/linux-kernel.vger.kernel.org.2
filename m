Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3344F900
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhKNQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhKNQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636906790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcNVEieIhGYImIXgqRGYQa9tv/Z/tWLoYFecC94SoiI=;
        b=dh/wMnSlC1/vYVg8MCYOfLtTzspAGH2/p9l0cZ9RNlTQhuyaiyDgFPWZFKAmnVo1UcTFYS
        89DFBFcd1cHftVBBiwBSNdc9r3pNdEvytmhDkmspD67s+SNGxGhvdNv9G6746sf+kM4Jde
        nn0JGAPFAypYy1BeF22q4bMTmLQUMAg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-2RqA7kUQOzGJhN1KUbjB-w-1; Sun, 14 Nov 2021 11:19:49 -0500
X-MC-Unique: 2RqA7kUQOzGJhN1KUbjB-w-1
Received: by mail-wm1-f71.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so6851801wmq.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lcNVEieIhGYImIXgqRGYQa9tv/Z/tWLoYFecC94SoiI=;
        b=Vl5HJqTzggLt/p40ciAFnqYjtZR9eoI20IlZHfX9kSQej6OOzZRRbjXY6b7aHod6+v
         U+u5k2jUmhdtW+YbJHJhQ0OGTRvHIIpXC6kJtwiYD1o7vSe6yrEbI1apinAsXFUYhNxV
         IZ1XY4hNOJBBLSYYHhIBP6KBgQQwCwUHg/+ysy/vkkiRCcI0aVfXte5iNp/hKIfHX8Oc
         6MN7eD7UlI2Ugjf2qBdUpURFnXq4UWgXwYR6MX9lrSSSFRu92WGqeLZjZV2y0wuyfme8
         aZOgKqnZyN2GlpQM+6AqoSPsiWJMg9KySeVBANuGms5y/F5ptyVpe96ih+OLSIWMNlAl
         nMfw==
X-Gm-Message-State: AOAM532Qxk2OkbyL2P4Lq1vECZqso7wrjrl7tu8Q9j5vvJ6CcZsobQN4
        IWCDBtW/z9AKc2sPKVnHot2b84nx+zkLLBbosGdNxaS5myJqtIoYc5X3RUYgUM6P80Pb8DK8AQ8
        VbKQH9jLhzJQZbR6Xc1M7DeHR
X-Received: by 2002:a5d:628f:: with SMTP id k15mr39595153wru.363.1636906788089;
        Sun, 14 Nov 2021 08:19:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjjy9HA6hcOnNqYGatCHcJX+5rUim1P0azS+SvpbZUD7UYR0QzXY7pftMCVx6aAOBHLKO1Tg==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr39595129wru.363.1636906787928;
        Sun, 14 Nov 2021 08:19:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l16sm12127938wmq.46.2021.11.14.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:19:47 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:19:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Message-ID: <YZE3Ia3UpHPx2/gh@krava>
References: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
 <20211109085831.3770594-2-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109085831.3770594-2-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:58:29PM +0900, Shunsuke Nakamura wrote:
> Move perf_counts_values__scale from tools/perf/util to tools/lib/perf
> so that it can be used with libperf.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/evsel.c              | 19 +++++++++++++++++++
>  tools/lib/perf/include/perf/evsel.h |  4 ++++
>  tools/lib/perf/libperf.map          |  1 +
>  tools/perf/util/evsel.c             | 19 -------------------
>  tools/perf/util/evsel.h             |  3 ---
>  5 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 8441e3e1aaac..5097aadea37a 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -431,3 +431,22 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
>  	zfree(&evsel->id);
>  	evsel->ids = 0;
>  }
> +
> +void perf_counts_values__scale(struct perf_counts_values *count,
> +			       bool scale, s8 *pscaled)
> +{
> +	s8 scaled = 0;
> +
> +	if (scale) {
> +		if (count->run == 0) {
> +			scaled = -1;
> +			count->val = 0;
> +		} else if (count->run < count->ena) {
> +			scaled = 1;
> +			count->val = (u64)((double)count->val * count->ena / count->run);
> +		}
> +	}
> +
> +	if (pscaled)
> +		*pscaled = scaled;
> +}
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 60eae25076d3..9013d73af22d 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -4,6 +4,8 @@
>  
>  #include <stdint.h>
>  #include <perf/core.h>
> +#include <stdbool.h>
> +#include <linux/types.h>
>  
>  struct perf_evsel;
>  struct perf_event_attr;
> @@ -39,5 +41,7 @@ LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> +LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
> +					   bool scale, s8 *pscaled);

not sure if we should use __s8 for pscaled now when it's exported?
it's just we use it everywhere else with '__' prefix, I forgot what's
the difference actually ;-)

but other that all looks good, for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


>  
>  #endif /* __LIBPERF_EVSEL_H */
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 71468606e8a7..5979bf92d98f 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -50,6 +50,7 @@ LIBPERF_0.0.1 {
>  		perf_mmap__read_init;
>  		perf_mmap__read_done;
>  		perf_mmap__read_event;
> +		perf_counts_values__scale;
>  	local:
>  		*;
>  };
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..49e4d0bdd7cc 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1457,25 +1457,6 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  	count->run = count->run - tmp.run;
>  }
>  
> -void perf_counts_values__scale(struct perf_counts_values *count,
> -			       bool scale, s8 *pscaled)
> -{
> -	s8 scaled = 0;
> -
> -	if (scale) {
> -		if (count->run == 0) {
> -			scaled = -1;
> -			count->val = 0;
> -		} else if (count->run < count->ena) {
> -			scaled = 1;
> -			count->val = (u64)((double) count->val * count->ena / count->run);
> -		}
> -	}
> -
> -	if (pscaled)
> -		*pscaled = scaled;
> -}
> -
>  static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
>  {
>  	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..8a6a4182c5fd 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -190,9 +190,6 @@ static inline int evsel__nr_cpus(struct evsel *evsel)
>  	return evsel__cpus(evsel)->nr;
>  }
>  
> -void perf_counts_values__scale(struct perf_counts_values *count,
> -			       bool scale, s8 *pscaled);
> -
>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  			   struct perf_counts_values *count);
>  
> -- 
> 2.27.0
> 

