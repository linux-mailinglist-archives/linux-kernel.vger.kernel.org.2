Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86143C3DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhGKQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 12:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhGKQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 12:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626019339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izt5w5x+G/7QEzY8+umsah51hf3F075Loda4jzNu39I=;
        b=d/qlnvuqniruufTFCI44ewFiH5V2Yo0GK9WXJl6QB/OsdULjpjVtUIwVg0lK1CzaldY4ff
        sYZMiM1F42Eq4S0EpXj9MgGJfdeeJJ+rhRxeq7I5ogVb5Nr9ozUtUuDJhpCzklyFOahFfI
        J9z68gJi8TYkeirmaWNssa+T4wVSIJw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-N2gAihLmNFyB-So_XVk9rA-1; Sun, 11 Jul 2021 12:02:18 -0400
X-MC-Unique: N2gAihLmNFyB-So_XVk9rA-1
Received: by mail-ed1-f72.google.com with SMTP id v14-20020a056402184eb029039994f9cab9so2619846edy.22
        for <Linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izt5w5x+G/7QEzY8+umsah51hf3F075Loda4jzNu39I=;
        b=oMIS9qYqpgAQsQyagpY1cR7FlDMLe3HoZM+lwEk743BFD4v42fyRXu3npTMEQJ/alw
         l8bTkqFxzYfMTDD1T0vECutfy197NI8qbg9gkIwtZYmMAK5GlcRQcZMU6QRgBr5YF5t8
         25kAsY6o3WmSleS8MXEi03Nb2ru2RGQhZ1goWSoWn8ATiWDuCQzwj4KDj8JX+oBX/7xK
         vO3Y7MliC6ei4PugalvMSimf+/dmSd40LnCJ+p+9oreAAhjSRFncAehJkaZjuQ3i9gb0
         yAOlm9dLpyK0NB/gW0AThpwfnMv0g/ZbvwsreThGOtGONePf8ksrv00wnDuJCZpkvsZ2
         S5Eg==
X-Gm-Message-State: AOAM533aaXM0iQFPzWnJJuntWJaxUol6901G0XAPu9mLC6Zoc39BQOEk
        U6+mufWFC+23xsqDTKlKZdWiuG8bAQxGZ84jbIZYQYV4d7KMQQuwW/R27Ons9m3tuo/7nqm0Tc2
        WaOaal+SCSgH0T5JsAFp46n8A
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr21365983eja.9.1626019336957;
        Sun, 11 Jul 2021 09:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6PaTau/7o4zjDMxMmudv7FKHK0DCuUpebKeJLDg9lYU28HZTCTGrS3a2l7+Pj4Iu3raxUOw==
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr21365968eja.9.1626019336790;
        Sun, 11 Jul 2021 09:02:16 -0700 (PDT)
Received: from krava ([5.171.249.81])
        by smtp.gmail.com with ESMTPSA id x1sm6060536edd.25.2021.07.11.09.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:02:16 -0700 (PDT)
Date:   Sun, 11 Jul 2021 18:02:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Merge uncore events by default for hybrid
 platform
Message-ID: <YOsWBdoGFkDZKh94@krava>
References: <20210707055652.962-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707055652.962-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:56:52PM +0800, Jin Yao wrote:
> On hybrid platform, by default stat aggregates and reports the event counts
> per pmu. For example,
> 
>   # perf stat -e cycles -a true
> 
>    Performance counter stats for 'system wide':
> 
>            1,400,445      cpu_core/cycles/
>              680,881      cpu_atom/cycles/
> 
>          0.001770773 seconds time elapsed
> 
> While for uncore events, that's not a suitable method. Uncore has nothing
> to do with hybrid. So for uncore events, we aggregate event counts from all
> PMUs and report the counts without PMUs.
> 
> Before:
> 
>   # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
> 
>    Performance counter stats for 'system wide':
> 
>                2,058      uncore_arb_0/event=0x81,umask=0x1/
>                2,028      uncore_arb_1/event=0x81,umask=0x1/
>                    0      uncore_arb_0/event=0x84,umask=0x1/
>                    0      uncore_arb_1/event=0x84,umask=0x1/
> 
>          0.000614498 seconds time elapsed
> 
> After:
> 
>   # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
> 
>    Performance counter stats for 'system wide':
> 
>                3,996      arb/event=0x81,umask=0x1/
>                    0      arb/event=0x84,umask=0x1/
> 
>          0.000630046 seconds time elapsed
> 
> Of course, we also keep the '--no-merge' working for uncore events.
> 
>   # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ --no-merge true
> 
>    Performance counter stats for 'system wide':
> 
>                1,952      uncore_arb_0/event=0x81,umask=0x1/
>                1,921      uncore_arb_1/event=0x81,umask=0x1/
>                    0      uncore_arb_0/event=0x84,umask=0x1/
>                    0      uncore_arb_1/event=0x84,umask=0x1/
> 
>          0.000575536 seconds time elapsed
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>  - Use evsel__find_pmu() to find uncore pmu.
>  - Create hybrid_uniquify() to check if uniquify the event name for hybrid.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> 
>  tools/perf/builtin-stat.c      |  3 ---
>  tools/perf/util/stat-display.c | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f9f74a514315..b67a44982b61 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2442,9 +2442,6 @@ int cmd_stat(int argc, const char **argv)
>  
>  	evlist__check_cpu_maps(evsel_list);
>  
> -	if (perf_pmu__has_hybrid())
> -		stat_config.no_merge = true;
> -
>  	/*
>  	 * Initialize thread_map with comm names,
>  	 * so we could print it out on output.
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index c588a6b7a8db..87f77016b9cc 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -593,6 +593,18 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
>  	}
>  }
>  
> +static bool is_uncore(struct evsel *evsel)
> +{
> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +
> +	return pmu && pmu->is_uncore;
> +}
> +
> +static bool hybrid_uniquify(struct evsel *evsel)
> +{
> +	return perf_pmu__has_hybrid() && !is_uncore(evsel);
> +}
> +
>  static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>  			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
>  				       bool first),
> @@ -601,7 +613,7 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>  	if (counter->merged_stat)
>  		return false;
>  	cb(config, counter, data, true);
> -	if (config->no_merge)
> +	if (config->no_merge || hybrid_uniquify(counter))
>  		uniquify_event_name(counter);
>  	else if (counter->auto_merge_stats)
>  		collect_all_aliases(config, counter, cb, data);
> -- 
> 2.27.0
> 

