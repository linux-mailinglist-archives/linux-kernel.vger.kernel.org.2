Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62003BDE22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGFTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625600653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grnweRCrAnKu5258EtepKVmdnjwsuQOcn5Qb0Uhq04g=;
        b=NIKByt2bzb0iwUc2Dk3PNSa23BTAPxTfrr3Jqu3kpftKNEqI6wCCJQlKZzyJr4/YR1kCxl
        CB84LqKdiH76JynUcM5ysf5oqquDq/6KjblRZJrDfibSROU9k9rq9JPxkggoFjg+63HZd6
        7i/8LO8Z9aalKwDtoDtpSwjckrwPE6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-C2tYM5czPReBH-nWhX5dwQ-1; Tue, 06 Jul 2021 15:44:12 -0400
X-MC-Unique: C2tYM5czPReBH-nWhX5dwQ-1
Received: by mail-wm1-f70.google.com with SMTP id t12-20020a7bc3cc0000b02901f290c9c44eso55118wmj.7
        for <Linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grnweRCrAnKu5258EtepKVmdnjwsuQOcn5Qb0Uhq04g=;
        b=Vub0MtzTrFF+dTBqpZYlk1Jtq/kZTLt4UTZ+oC6DLapvu6yDpeIhl7REYnXWdQVDbZ
         43YjjT9brA3nv2PUhTkIyGY/WBK9fR7JOCVsnkguagqKaiJGJ5jlm0hRQK2G6Xy4sm4w
         SyXAN2D6N7JTg6ggbNN+XX8POgO1b4PFg+WW0frUYpV5bNAGD8jchcytkNjZ5o35hbgj
         6wdq3SBkQYskhk0wKFVZmwk3ycKKcAkbfGX1NiWqea90ZTRE9+uMj4LXqAVaNSjmT9Lv
         tbA5gtcgxSWYUK0tEGKxaQo8rADuregxdfnA9fUh/96OHrsW3BLjl1X5HiNbdBTyyvtE
         Kq2A==
X-Gm-Message-State: AOAM531mg79ZN+vvhoIL56owRAh6fj1KAiERUHaQ5MaufoKa7eGv7+YH
        Rm8MshMe7etdNVK8Ar2X3J4dbWfmrHOeeNFUysYB/whFJI8ivjPqQ3S88SFo6do4+yhVj3C7QrJ
        TeY+ecQ/j2LwR4hKtQjlDS3ug
X-Received: by 2002:a5d:508e:: with SMTP id a14mr24241657wrt.92.1625600650880;
        Tue, 06 Jul 2021 12:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRW0eLRNwcOb+WSN8/WHmoDuDZWg39hGqKXbgphGqcY2IllRyxkqiGwn47qS/L62M8FNDoHw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr24241631wrt.92.1625600650655;
        Tue, 06 Jul 2021 12:44:10 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id d24sm3817009wmb.42.2021.07.06.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:44:10 -0700 (PDT)
Date:   Tue, 6 Jul 2021 21:44:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf tools: Fix pattern matching for same substring
 in different pmu type
Message-ID: <YOSyhwJ/E0JoeWOS@krava>
References: <20210701064253.1175-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701064253.1175-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 02:42:53PM +0800, Jin Yao wrote:
> Some different pmu types may have same substring. For example,
> on Icelake server, we have pmu types "uncore_imc" and
> "uncore_imc_free_running". Both pmu types have substring "uncore_imc".
> But the parser would wrongly think they are the same pmu type.
> 
> We enable an imc event,
> perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1
> 
> Perf actually expands the event to:
> uncore_imc_0/event=0xe3/
> uncore_imc_1/event=0xe3/
> uncore_imc_2/event=0xe3/
> uncore_imc_3/event=0xe3/
> uncore_imc_4/event=0xe3/
> uncore_imc_5/event=0xe3/
> uncore_imc_6/event=0xe3/
> uncore_imc_7/event=0xe3/
> uncore_imc_free_running_0/event=0xe3/
> uncore_imc_free_running_1/event=0xe3/
> uncore_imc_free_running_3/event=0xe3/
> uncore_imc_free_running_4/event=0xe3/
> 
> That's because the "uncore_imc_free_running" matches the
> pattern "uncore_imc*".
> 
> Now we check that the last characters of pmu name is
> '_<digit>'.
> 
> For example, for pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
> but "uncore_imc_free_running_0" would be failed.
> 
> Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

looks good to me, Kan, Andi?

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/parse-events.y |  2 +-
>  tools/perf/util/pmu.c          | 36 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/pmu.h          |  1 +
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index aba12a4d488e..9321bd0e2f76 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -316,7 +316,7 @@ event_pmu_name opt_pmu_config
>  			if (!strncmp(name, "uncore_", 7) &&
>  			    strncmp($1, "uncore_", 7))
>  				name += 7;
> -			if (!fnmatch(pattern, name, 0)) {
> +			if (!perf_pmu__match(pattern, name, $1)) {
>  				if (parse_events_copy_term_list(orig_terms, &terms))
>  					CLEANUP_YYABORT;
>  				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 88c8ecdc60b0..44b90d638ad5 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3,6 +3,7 @@
>  #include <linux/compiler.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> +#include <linux/ctype.h>
>  #include <subcmd/pager.h>
>  #include <sys/types.h>
>  #include <errno.h>
> @@ -17,6 +18,7 @@
>  #include <locale.h>
>  #include <regex.h>
>  #include <perf/cpumap.h>
> +#include <fnmatch.h>
>  #include "debug.h"
>  #include "evsel.h"
>  #include "pmu.h"
> @@ -740,6 +742,27 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
>  	return perf_pmu__find_map(NULL);
>  }
>  
> +static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
> +{
> +	char *p;
> +
> +	if (strncmp(pmu_name, tok, strlen(tok)))
> +		return false;
> +
> +	p = pmu_name + strlen(tok);
> +	if (*p == 0)
> +		return true;
> +
> +	if (*p != '_')
> +		return false;
> +
> +	++p;
> +	if (*p == 0 || !isdigit(*p))
> +		return false;
> +
> +	return true;
> +}
> +
>  bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>  {
>  	char *tmp = NULL, *tok, *str;
> @@ -768,7 +791,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>  	 */
>  	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>  		name = strstr(name, tok);
> -		if (!name) {
> +		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
>  			res = false;
>  			goto out;
>  		}
> @@ -1872,3 +1895,14 @@ bool perf_pmu__has_hybrid(void)
>  
>  	return !list_empty(&perf_pmu__hybrid_pmus);
>  }
> +
> +int perf_pmu__match(char *pattern, char *name, char *tok)
> +{
> +	if (fnmatch(pattern, name, 0))
> +		return -1;
> +
> +	if (tok && !perf_pmu__valid_suffix(name, tok))
> +		return -1;
> +
> +	return 0;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index a790ef758171..926da483a141 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  				   char *name);
>  
>  bool perf_pmu__has_hybrid(void);
> +int perf_pmu__match(char *pattern, char *name, char *tok);
>  
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

