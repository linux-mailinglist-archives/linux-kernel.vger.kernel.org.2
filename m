Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55583447006
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 20:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhKFTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 15:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhKFTMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 15:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 895BC6108D;
        Sat,  6 Nov 2021 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636225792;
        bh=/hyIP0/aSOelHVPVtktQKqkIJLZLCwG1oOqZzq2GOi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKwfgIdXifT8pDUrWDFph8Ug8hHvg476fdxt+wUYCjTHc0TsvEixX26ArWJr1faYK
         /PUv5K5puB5uzap7QXKHdcldroT8bjTSnL3NRHOGoDJAn4xhG7sfJq5lO57rg8jQAI
         Q49dlUdL4zSlNtEU7TbdIQJiNqKm9H3yLcnNLiZeiHtRXeINBGq44id6KFd9uQQmX7
         BR5HCIcjA+68wFhRzTk9qDehaLdZTcUYf16Oa3ho55gulLjTRXetpE5wyZLzlEo41T
         1Rmw0OeVERNfRJenOVTTycpuXv4AgurG0AXrHDvLjtQneDS6UfhEbvNL5XZJ1F5H93
         Gx0yrW4qXmHrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17B94410A1; Sat,  6 Nov 2021 16:09:49 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:09:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v4] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYbS/UoQ9wHAc44j@kernel.org>
References: <20211105205847.120950-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211105205847.120950-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 05, 2021 at 01:58:47PM -0700, Namhyung Kim escreveu:
> The current logic for the perf missing feature has a bug that it can
> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> support any filtering or exclusion while others do.  But we check it
> as a global feature.
> 
> For example, the cycles event can have 'G' modifier to enable it only
> in the guest mode on x86.  When you don't run any VMs it'll return 0.
> 
>   # perf stat -a -e cycles:G sleep 1
> 
>     Performance counter stats for 'system wide':
> 
>                     0      cycles:G
> 
>           1.000721670 seconds time elapsed
> 
> But when it's used with other pmu events that don't support G modifier,
> it'll be reset and return non-zero values.
> 
>   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> 
>     Performance counter stats for 'system wide':
> 
>           538,029,960      cycles:G
>        16,924,010,738      msr/tsc/
> 
>           1.001815327 seconds time elapsed
> 
> This is because of the missing feature detection logic being global.
> Add a hashmap to set pmu-specific exclude_host/guest features.

⬢[acme@toolbox perf]$ perf test python
19: 'import perf' in python                                         : FAILED!
⬢[acme@toolbox perf]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
19: 'import perf' in python                                         :
--- start ---
test child forked, pid 11602
python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: evsel__find_pmu
test child finished with -1
---- end ----
'import perf' in python: FAILED!
⬢[acme@toolbox perf]$

Trying to fix this now. please do a 'perf test' before submitting
patches.

- Arnaldo

 
> Reported-by: Stephane Eranian <eranian@google.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v4 changes)
>  * add pmu->missing_features.exclude_guest
>  * bail out if evsel->exclude_GH is set
> 
> v3 changes)
>  * check memory allocation failure
>  * add more NULL check
> 
> v2 changes)
>  * change to enum perf_missing_pmu_features
>  * pass NULL to hashmap__find() to skip checking
>  * add a blank line after declaration
> 
>  tools/perf/util/evsel.c | 27 ++++++++++++++++++++++-----
>  tools/perf/util/evsel.h |  4 ++++
>  tools/perf/util/pmu.h   |  4 ++++
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2cfc2935d1d2..3cc1f8fcf15c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1824,7 +1824,7 @@ static void evsel__disable_missing_features(struct evsel *evsel)
>  		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
> -	if (perf_missing_features.exclude_guest)
> +	if (evsel->pmu && evsel->pmu->missing_features.exclude_guest)
>  		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
>  	if (perf_missing_features.lbr_flags)
>  		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> @@ -1917,10 +1917,27 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  		perf_missing_features.mmap2 = true;
>  		pr_debug2_peo("switching off mmap2\n");
>  		return true;
> -	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> -		perf_missing_features.exclude_guest = true;
> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> +		   (evsel->pmu == NULL || evsel->pmu->missing_features.exclude_guest)) {
> +		if (evsel->pmu == NULL) {
> +			evsel->pmu = evsel__find_pmu(evsel);
> +			if (evsel->pmu)
> +				evsel->pmu->missing_features.exclude_guest = true;
> +			else {
> +				/* we cannot find PMU, disable attrs now */
> +				evsel->core.attr.exclude_host = false;
> +				evsel->core.attr.exclude_guest = false;
> +			}
> +		}
> +
> +		if (evsel->exclude_GH) {
> +			pr_debug2_peo("PMU has no exclude_host/guest support, bailing out\n");
> +			return false;
> +		}
> +		if (!perf_missing_features.exclude_guest) {
> +			perf_missing_features.exclude_guest = true;
> +			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +		}
>  		return true;
>  	} else if (!perf_missing_features.sample_id_all) {
>  		perf_missing_features.sample_id_all = true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 846c827934de..dcc87c2881b8 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -22,6 +22,7 @@ struct target;
>  struct hashmap;
>  struct bperf_leader_bpf;
>  struct bperf_follower_bpf;
> +struct perf_pmu;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> @@ -153,6 +154,9 @@ struct evsel {
>  	};
>  	unsigned long		open_flags;
>  	int			precise_ip_original;
> +
> +	/* for missing_features */
> +	struct perf_pmu		*pmu;
>  };
>  
>  struct perf_missing_features {
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 15bbec3a9959..541889fa9f9c 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -49,6 +49,10 @@ struct perf_pmu {
>  	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>  	struct list_head list;    /* ELEM */
>  	struct list_head hybrid_list;
> +
> +	struct {
> +		bool exclude_guest;
> +	} missing_features;
>  };
>  
>  extern struct perf_pmu perf_pmu__fake;
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog

-- 

- Arnaldo
