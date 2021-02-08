Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874DA314051
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhBHUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235383AbhBHS6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:58:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EE0264E59;
        Mon,  8 Feb 2021 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612810655;
        bh=a6yQPRTEk7vZQGLw53cjDyiNa69Lzt2uZX/PWzN8GVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJMNNgLFVhLphi5pyDhLhbl/H5pQIXD2tlLi5irAuof0c6irk1Pz5O1AF/LUhH9NU
         QX8PstPwqJzmcal0LpgjUaZE1rrFCaEkBJeCvc1cOrllIQDjBAxySuTpkIAcYoLkAT
         pviHhn4PGsWXj6XeDKv6iDLg3Q9rXYMXF3R9WIyntdqElwqjh8nTfpCT3F6wr4eBpa
         dNALaBqBaDboB9aT01mxz5GeAwNrGS/VMRg9BUkJ15fOwZ5aXBDuPF7QTO2SJlPB7J
         EEl9DRCT4MwytpV/hJm4U0SiMMX4oXt6LCfmiN1afgfX+gNMxuLfXtaG+TSkYQHQKY
         B9SYUIluyTuuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD9AC40513; Mon,  8 Feb 2021 15:57:32 -0300 (-03)
Date:   Mon, 8 Feb 2021 15:57:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 27/49] perf util: Save pmu name to struct perf_pmu_alias
Message-ID: <20210208185732.GK920417@kernel.org>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-28-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-28-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 07:25:24AM -0800, kan.liang@linux.intel.com escreveu:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> On hybrid platform, one event is available on one pmu
> (such as, cpu_core or cpu_atom).
> 
> This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
> Then next we can know the pmu where the event can be enabled.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/pmu.c | 17 +++++++++++++----
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44ef283..0c25457 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -283,6 +283,7 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>  	zfree(&newalias->str);
>  	zfree(&newalias->metric_expr);
>  	zfree(&newalias->metric_name);
> +	zfree(&newalias->pmu);
>  	parse_events_terms__purge(&newalias->terms);
>  	free(newalias);
>  }
> @@ -297,6 +298,10 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>  
>  	list_for_each_entry(a, alist, list) {
>  		if (!strcasecmp(newalias->name, a->name)) {
> +			if (newalias->pmu && a->pmu &&
> +			    !strcasecmp(newalias->pmu, a->pmu)) {
> +				continue;
> +			}
>  			perf_pmu_update_alias(a, newalias);
>  			perf_pmu_free_alias(newalias);
>  			return true;
> @@ -311,7 +316,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  				 char *unit, char *perpkg,
>  				 char *metric_expr,
>  				 char *metric_name,
> -				 char *deprecated)
> +				 char *deprecated,
> +				 char *pmu)
>  {
>  	struct parse_events_term *term;
>  	struct perf_pmu_alias *alias;
> @@ -382,6 +388,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  	}
>  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>  	alias->str = strdup(newval);
> +	alias->pmu = pmu ? strdup(pmu) : NULL;
>  
>  	if (deprecated)
>  		alias->deprecated = true;
> @@ -407,7 +414,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
>  	strim(buf);
>  
>  	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
> -				     NULL, NULL, NULL, NULL);
> +				     NULL, NULL, NULL, NULL, NULL);
>  }
>  
>  static inline bool pmu_alias_info_file(char *name)
> @@ -797,7 +804,8 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>  				(char *)pe->unit, (char *)pe->perpkg,
>  				(char *)pe->metric_expr,
>  				(char *)pe->metric_name,
> -				(char *)pe->deprecated);
> +				(char *)pe->deprecated,
> +				(char *)pe->pmu);
>  	}
>  }
>  
> @@ -870,7 +878,8 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
>  				      (char *)pe->perpkg,
>  				      (char *)pe->metric_expr,
>  				      (char *)pe->metric_name,
> -				      (char *)pe->deprecated);
> +				      (char *)pe->deprecated,
> +				      NULL);

At some point I think passing the whole 'struct pme_event' pointer
should be better?

>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 8164388..0e724d5 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -72,6 +72,7 @@ struct perf_pmu_alias {
>  	bool deprecated;
>  	char *metric_expr;
>  	char *metric_name;
> +	char *pmu;
>  };
>  
>  struct perf_pmu *perf_pmu__find(const char *name);
> -- 
> 2.7.4
> 

-- 

- Arnaldo
