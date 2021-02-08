Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6F314097
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBHUgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236105AbhBHTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:17:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B2664E85;
        Mon,  8 Feb 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612811809;
        bh=n+pBStucWf+JfyK8Sz4l0A9bjt78b6JU+WbJiyAUaUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ncfa4ehbzB2JS4l41iYUetkNFD/HOATUWpwZrharTkYK9FBSep9vKa9qKBBaQdwH0
         LBZ2pMUXb68HIXV9qxf/Z95KBIkAMgNjriGYVpJFJpombDvmyz9vJ8JfLddhGTeumd
         J1xvvN2bFaxP5+KmeMCXlhR5QkvxyPVko9hXrtn0rUyjjeUoLoi68Z7yUtspsZIisg
         IZUyAGi9/lQT6bNcAnhxkC//yfLR01iY6OitQzkTkeHdnamn7+CN07Ih0SBOBKxtXF
         1xuJWuQIWP5+mTZZS6+ikLwURcDlTepjGyrrIaynNZsqN0Z1xqx3898HFFpAgrGzyE
         5UluqAzR4e2jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E99D40513; Mon,  8 Feb 2021 16:16:45 -0300 (-03)
Date:   Mon, 8 Feb 2021 16:16:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 46/49] perf stat: Filter out unmatched aggregation for
 hybrid event
Message-ID: <20210208191645.GQ920417@kernel.org>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-47-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-47-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 07:25:43AM -0800, kan.liang@linux.intel.com escreveu:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> perf-stat has supported some aggregation modes, such as --per-core,
> --per-socket and etc. While for hybrid event, it may only available
> on part of cpus. So for --per-core, we need to filter out the
> unavailable cores, for --per-socket, filter out the unavailable
> sockets, and so on.
> 
> Before:
> 
> root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0           2            311,114      cycles [cpu_core]

Why not use the pmu style event name, i.e.:

S0-D0-C0           2            311,114        cpu_core/cycles/

?

> S0-D0-C4           2             59,784      cycles [cpu_core]
> S0-D0-C8           2            121,287      cycles [cpu_core]
> S0-D0-C12          2          2,690,245      cycles [cpu_core]
> S0-D0-C16          2          2,060,545      cycles [cpu_core]
> S0-D0-C20          2          3,632,251      cycles [cpu_core]
> S0-D0-C24          2            775,736      cycles [cpu_core]
> S0-D0-C28          2            742,020      cycles [cpu_core]
> S0-D0-C32          0      <not counted>      cycles [cpu_core]
> S0-D0-C33          0      <not counted>      cycles [cpu_core]
> S0-D0-C34          0      <not counted>      cycles [cpu_core]
> S0-D0-C35          0      <not counted>      cycles [cpu_core]
> S0-D0-C36          0      <not counted>      cycles [cpu_core]
> S0-D0-C37          0      <not counted>      cycles [cpu_core]
> S0-D0-C38          0      <not counted>      cycles [cpu_core]
> S0-D0-C39          0      <not counted>      cycles [cpu_core]
> 
>        1.001779842 seconds time elapsed
> 
> After:
> 
> root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0           2          1,088,230      cycles [cpu_core]
> S0-D0-C4           2             57,228      cycles [cpu_core]
> S0-D0-C8           2             98,327      cycles [cpu_core]
> S0-D0-C12          2          2,741,955      cycles [cpu_core]
> S0-D0-C16          2          2,090,432      cycles [cpu_core]
> S0-D0-C20          2          3,192,108      cycles [cpu_core]
> S0-D0-C24          2          2,910,752      cycles [cpu_core]
> S0-D0-C28          2            388,696      cycles [cpu_core]
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 21a3f80..fa11572 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -630,6 +630,20 @@ static void aggr_cb(struct perf_stat_config *config,
>  	}
>  }
>  
> +static bool aggr_id_hybrid_matched(struct perf_stat_config *config,
> +				   struct evsel *counter, struct aggr_cpu_id id)
> +{
> +	struct aggr_cpu_id s;
> +
> +	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
> +		s = config->aggr_get_id(config, evsel__cpus(counter), i);
> +		if (cpu_map__compare_aggr_cpu_id(s, id))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>  				   struct evsel *counter, int s,
>  				   char *prefix, bool metric_only,
> @@ -643,6 +657,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  	double uval;
>  
>  	ad.id = id = config->aggr_map->map[s];
> +
> +	if (perf_pmu__hybrid_exist() &&
> +	    !aggr_id_hybrid_matched(config, counter, id)) {
> +		return;
> +	}
> +
>  	ad.val = ad.ena = ad.run = 0;
>  	ad.nr = 0;
>  	if (!collect_data(config, counter, aggr_cb, &ad))
> -- 
> 2.7.4
> 

-- 

- Arnaldo
