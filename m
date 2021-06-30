Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B43B891A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhF3TVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:21:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:48342 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhF3TVR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:21:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="294051610"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="294051610"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 12:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="447597287"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2021 12:18:17 -0700
Received: from [10.209.45.119] (kliang2-MOBL.ccr.corp.intel.com [10.209.45.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3AC43580279;
        Wed, 30 Jun 2021 12:18:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] perf tools: Fix pattern matching for same
 substring in different pmu type
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210630120912.6998-1-yao.jin@linux.intel.com>
 <20210630120912.6998-2-yao.jin@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <62c7f221-64af-f6b2-147c-09d56667ccd6@linux.intel.com>
Date:   Wed, 30 Jun 2021 15:18:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630120912.6998-2-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2021 8:09 AM, Jin Yao wrote:
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
> For pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
> but "uncore_imc_free_running_0" is failed.
> 
> Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>   tools/perf/util/pmu.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 96f5ff9b5440..9ee123d77e6d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3,6 +3,7 @@
>   #include <linux/compiler.h>
>   #include <linux/string.h>
>   #include <linux/zalloc.h>
> +#include <linux/ctype.h>
>   #include <subcmd/pager.h>
>   #include <sys/types.h>
>   #include <errno.h>
> @@ -741,6 +742,28 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
>   	return perf_pmu__find_map(NULL);
>   }
>   
> +static bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
> +{
> +	char *p;
> +
> +	/*
> +	 * The pmu_name has substring tok. If the format of

The uncore PMU may have two names, e.g., uncore_cha_Y or 
uncore_type_X_Y. User can use either name. I don't think we can assume 
that the pmu_name has substring tok. I think we should add a check as below.


@@ -746,6 +746,8 @@ static bool perf_pmu__valid_suffix(char *tok, char 
*pmu_name)
  {
  	char *p;

+	if (strncmp(pmu_name, tok, strlen(tok)))
+		return false;
	/*
	 * The pmu_name has substring tok. If the format of
  	 * pmu_name is tok or tok_digit, return true.

> +	 * pmu_name is tok or tok_digit, return true.
> +	 */
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
>   bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   {
>   	char *tmp = NULL, *tok, *str;
> @@ -769,7 +792,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   	 */
>   	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>   		name = strstr(name, tok);
> -		if (!name) {
> +		if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
>   			res = false;
>   			goto out;
>   		}
> @@ -1886,5 +1909,8 @@ int perf_pmu__pattern_match(struct perf_pmu *pmu, char *pattern, char *tok)
>   	if (fnmatch(pattern, name, 0))
>   		return -1;
>   
> +	if (!perf_pmu__valid_suffix(tok, name))
> +		return -1;
> +

They are still two functions. I'm wondering if we can merge the two 
functions to one function, e.g., perf_pmu_match()?

So my patch just need to simply do
  	if (!perf_pmu_match(tok, name) && !perf_pmu_match(tok, 
pmu->alias_name)) 		return -1;

Thanks,
Kan
