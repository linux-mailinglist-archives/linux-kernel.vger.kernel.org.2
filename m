Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F730E3BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhBCUDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBCUDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:03:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 458FB64E4E;
        Wed,  3 Feb 2021 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612382580;
        bh=xPKi0qpw6PU2S+DRMD8ah3GPzakCFkpuK1SAeSILl6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjsPYfjANbUovVyAa68zDejqIjUPkTer2aqRUOgtDcxk3ODwJ/uHzD/vmwYLfmSr2
         6C5hdww48o/SmVjnG0CYm4VJ48Q0MNuwpCewz05KK/t3Z3EHxB8WQki0Puotzeoa1P
         6y3v+42WFJs8fnX9I4UniqTPFSURriTaPGQFKlwrSv1tdpHlrD114aM9aVVlISraL6
         B2ge3YVsgv0BBEdF3XR+bA7sj9v8tdm0qXEMXNrq1PDTJwOJsLsq18t2rSjTvDUu5O
         DEakNTq3e9S37ee7qBLpfYlo+etkZ0+cptfA1Hi8iyoaVv4c2shr1iIUZb/H0i6cJz
         6R53ceyXfozpQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CA8D40513; Wed,  3 Feb 2021 17:02:56 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:02:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
Message-ID: <20210203200256.GH854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 12:09:06PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index c26ea822..c48f6de 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2689,6 +2689,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>  		break;
> +	case ENODATA:
> +		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> +				 "Please add an auxiliary event in front of the load latency event.");

Are you sure this is the only case where ENODATA comes out from
perf_event_open()? Well, according to your comment in:

  61b985e3e775a3a7 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")

It should be at that point in time, so its safe to merge as-is, but then
I think this is fragile, what if someone else, in the future, not
knowing that ENODATA is supposed to be used only with that ancient CPU,
Sapphire Rapids, uses it? :-)

Please consider adding a check before assuming ENODATA is for this
specific case.

Back to processing the other patches.

- Arnaldo

>  	default:
>  		break;
>  	}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 19007e4..3edfb88 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -56,6 +56,11 @@ char * __weak perf_mem_events__name(int i)
>  	return (char *)e->name;
>  }
>  
> +__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> +{
> +	return false;
> +}
> +
>  int perf_mem_events__parse(const char *str)
>  {
>  	char *tok, *saveptr = NULL;
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 5ef1782..045a507 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -9,6 +9,7 @@
>  #include <linux/refcount.h>
>  #include <linux/perf_event.h>
>  #include "stat.h"
> +#include "evsel.h"
>  
>  struct perf_mem_event {
>  	bool		record;
> @@ -39,6 +40,7 @@ int perf_mem_events__init(void);
>  
>  char *perf_mem_events__name(int i);
>  struct perf_mem_event *perf_mem_events__ptr(int i);
> +bool is_mem_loads_aux_event(struct evsel *leader);
>  
>  void perf_mem_events__list(void);
>  
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 9db5097..0b36285 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -356,6 +356,7 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
>  cycles-ct				|
>  cycles-t				|
>  mem-loads				|
> +mem-loads-aux				|
>  mem-stores				|
>  topdown-[a-z-]+				|
>  tx-capacity-[a-z-]+			|
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index e70c9dd..d0735fb 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -15,6 +15,8 @@
>  #include "record.h"
>  #include "../perf-sys.h"
>  #include "topdown.h"
> +#include "map_symbol.h"
> +#include "mem-events.h"
>  
>  /*
>   * evsel__config_leader_sampling() uses special rules for leader sampling.
> @@ -25,7 +27,8 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
>  {
>  	struct evsel *leader = evsel->leader;
>  
> -	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader)) {
> +	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
> +	    is_mem_loads_aux_event(leader)) {
>  		evlist__for_each_entry(evlist, evsel) {
>  			if (evsel->leader == leader && evsel != evsel->leader)
>  				return evsel;
> -- 
> 2.7.4
> 

-- 

- Arnaldo
