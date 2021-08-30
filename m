Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1463FBCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhH3Swq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232744AbhH3Swp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:52:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E8360F5B;
        Mon, 30 Aug 2021 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349511;
        bh=Yt+Mqjty1wrTQWlmDgFAEX/GGWZw5Dyn/lwrde7Xepg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+ArxRL5VJnDonD2BzWdHrQ+iudmbZWUOCm5OYYA28xUW229FwE7PDJzS9s7iTtvW
         DndZYAe3uAwaAbMxCy+k/F0DtXiW4tA4csflseBNVk4FY+zzRL1YohU2VE5Iyc4Ku3
         PrhLAQR5wj33uXrmN94BeXCGsuCWFQfEhncIzy58GbIXT8jeysBIlj4bdeuDipnQnX
         ojgOPbG2SG3ZdCv3P/FP6AntNGcR/RHvzMTdpgW4dhtN6CWtITwCLlpfumatyquOw0
         tjeWsZiaLa45jCgtJy/Kc2bm/JUy79fTpUzBkXcRJiwogkvDCvazwasJL1wB3z/WQJ
         idVfKvWIc1LCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA00E4007E; Mon, 30 Aug 2021 15:51:47 -0300 (-03)
Date:   Mon, 30 Aug 2021 15:51:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf stat: Do not allow --for-each-cgroup without cpu
Message-ID: <YS0ow5/33nKYJCQX@kernel.org>
References: <20210830170200.55652-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830170200.55652-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 30, 2021 at 10:02:00AM -0700, Namhyung Kim escreveu:
> The cgroup mode should work with cpu events.  Warn if --for-each-cgroup
> option is used with a task target like existing -G option.
> 
>   # perf stat --for-each-cgroup . sleep 1
>   both cgroup and no-aggregation modes only available in system-wide mode
> 
>    Usage: perf stat [<options>] [<command>]
> 
>       -G, --cgroup <name>   monitor event in cgroup name only
>       -A, --no-aggr         disable CPU count aggregation
>       -a, --all-cpus        system-wide collection from all CPUs
>           --for-each-cgroup <name>
>                             expand events for each cgroup

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 84de61795e67..1a64aebc0d2f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2386,7 +2386,8 @@ int cmd_stat(int argc, const char **argv)
>  	 * --per-thread is aggregated per thread, we dont mix it with cpu mode
>  	 */
>  	if (((stat_config.aggr_mode != AGGR_GLOBAL &&
> -	      stat_config.aggr_mode != AGGR_THREAD) || nr_cgroups) &&
> +	      stat_config.aggr_mode != AGGR_THREAD) ||
> +	     (nr_cgroups || stat_config.cgroup_list)) &&
>  	    !target__has_cpu(&target)) {
>  		fprintf(stderr, "both cgroup and no-aggregation "
>  			"modes only available in system-wide mode\n");
> @@ -2394,6 +2395,7 @@ int cmd_stat(int argc, const char **argv)
>  		parse_options_usage(stat_usage, stat_options, "G", 1);
>  		parse_options_usage(NULL, stat_options, "A", 1);
>  		parse_options_usage(NULL, stat_options, "a", 1);
> +		parse_options_usage(NULL, stat_options, "for-each-cgroup", 0);
>  		goto out;
>  	}
>  
> -- 
> 2.33.0.259.gc128427fd7-goog
