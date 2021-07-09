Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329D3C23DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhGINBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhGINBt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E84C1613B5;
        Fri,  9 Jul 2021 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625835546;
        bh=7A7c7zqoaufBPARmr8/9p+A/DjswEQjyzl09hviXTMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etaxLMmqZm9sCxYmTHArZnB13O5eX/h+qR5lk01/R1y5YVYt/gORRIbixRFJ3eGWh
         n3vQ0Dp/zZmYtlI9BDv0KAXRy5EgTsxcVWGP46wZwM5Fyn2nJ0nF7OBz1yhpfMabFS
         z1Te2MVyfB+uy3WAZ79G3z5onwd38ZgpIEZ2FPKtSV8211bDbkZD2WQBLyFbEhszkW
         1xcsb1J8LXETL4RSZ6+ux9PsFMrqmpTZrPHuchznMccEpwXCntEvEvnREmAjtiljT/
         4kwgG2PElH/PBUHq7SFpYLaBa0G8Oqe0uLr1cscqW6HvLkkPjKTXcwnrgtKeJzVW7i
         88GZev46DYX7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A276340B1A; Fri,  9 Jul 2021 09:59:01 -0300 (-03)
Date:   Fri, 9 Jul 2021 09:59:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Agustin Vega-Frias <agustinv@codeaurora.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf tools: Fix pattern matching for same substring
 in different pmu type
Message-ID: <YOhIFZ5IaFua9HbS@kernel.org>
References: <20210701064253.1175-1-yao.jin@linux.intel.com>
 <YOSyhwJ/E0JoeWOS@krava>
 <8c2b5f66-c85e-8717-d218-4d6a2182262a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2b5f66-c85e-8717-d218-4d6a2182262a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 06, 2021 at 04:02:24PM -0400, Liang, Kan escreveu:
> On 7/6/2021 3:44 PM, Jiri Olsa wrote:
> > On Thu, Jul 01, 2021 at 02:42:53PM +0800, Jin Yao wrote:
> > > Some different pmu types may have same substring. For example,
> > > on Icelake server, we have pmu types "uncore_imc" and
> > > "uncore_imc_free_running". Both pmu types have substring "uncore_imc".
> > > But the parser would wrongly think they are the same pmu type.

> > > We enable an imc event,
> > > perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1

> > > Perf actually expands the event to:
> > > uncore_imc_0/event=0xe3/
> > > uncore_imc_1/event=0xe3/
> > > uncore_imc_2/event=0xe3/
> > > uncore_imc_3/event=0xe3/
> > > uncore_imc_4/event=0xe3/
> > > uncore_imc_5/event=0xe3/
> > > uncore_imc_6/event=0xe3/
> > > uncore_imc_7/event=0xe3/
> > > uncore_imc_free_running_0/event=0xe3/
> > > uncore_imc_free_running_1/event=0xe3/
> > > uncore_imc_free_running_3/event=0xe3/
> > > uncore_imc_free_running_4/event=0xe3/

> > > That's because the "uncore_imc_free_running" matches the
> > > pattern "uncore_imc*".

> > > Now we check that the last characters of pmu name is
> > > '_<digit>'.
> > > 
> > > For example, for pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
> > > but "uncore_imc_free_running_0" would be failed.
> > > 
> > > Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

> > looks good to me, Kan, Andi?

> Yes, it looks good to me too.

> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, I'm applying it, Jin, please next time Cc the author of the
patch you're fixing, in this case:

  Cc: Agustin Vega-Frias <agustinv@codeaurora.org>

I'm adding it to this message as well.
 
> BTW: The new uncore patch[1] for the "alias" attribute should be easily
> rebase on this patch. I believe Yao has already finished the test as well. I
> think he will resend the new "alias" attribute patch later soon.
> [1] https://lore.kernel.org/lkml/1624990443-168533-7-git-send-email-kan.liang@linux.intel.com
> 
> Thanks,
> Kan
> 
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> > 
> > > ---
> > >   tools/perf/util/parse-events.y |  2 +-
> > >   tools/perf/util/pmu.c          | 36 +++++++++++++++++++++++++++++++++-
> > >   tools/perf/util/pmu.h          |  1 +
> > >   3 files changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index aba12a4d488e..9321bd0e2f76 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -316,7 +316,7 @@ event_pmu_name opt_pmu_config
> > >   			if (!strncmp(name, "uncore_", 7) &&
> > >   			    strncmp($1, "uncore_", 7))
> > >   				name += 7;
> > > -			if (!fnmatch(pattern, name, 0)) {
> > > +			if (!perf_pmu__match(pattern, name, $1)) {
> > >   				if (parse_events_copy_term_list(orig_terms, &terms))
> > >   					CLEANUP_YYABORT;
> > >   				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 88c8ecdc60b0..44b90d638ad5 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -3,6 +3,7 @@
> > >   #include <linux/compiler.h>
> > >   #include <linux/string.h>
> > >   #include <linux/zalloc.h>
> > > +#include <linux/ctype.h>
> > >   #include <subcmd/pager.h>
> > >   #include <sys/types.h>
> > >   #include <errno.h>
> > > @@ -17,6 +18,7 @@
> > >   #include <locale.h>
> > >   #include <regex.h>
> > >   #include <perf/cpumap.h>
> > > +#include <fnmatch.h>
> > >   #include "debug.h"
> > >   #include "evsel.h"
> > >   #include "pmu.h"
> > > @@ -740,6 +742,27 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
> > >   	return perf_pmu__find_map(NULL);
> > >   }
> > > +static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
> > > +{
> > > +	char *p;
> > > +
> > > +	if (strncmp(pmu_name, tok, strlen(tok)))
> > > +		return false;
> > > +
> > > +	p = pmu_name + strlen(tok);
> > > +	if (*p == 0)
> > > +		return true;
> > > +
> > > +	if (*p != '_')
> > > +		return false;
> > > +
> > > +	++p;
> > > +	if (*p == 0 || !isdigit(*p))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > >   bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> > >   {
> > >   	char *tmp = NULL, *tok, *str;
> > > @@ -768,7 +791,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> > >   	 */
> > >   	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
> > >   		name = strstr(name, tok);
> > > -		if (!name) {
> > > +		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
> > >   			res = false;
> > >   			goto out;
> > >   		}
> > > @@ -1872,3 +1895,14 @@ bool perf_pmu__has_hybrid(void)
> > >   	return !list_empty(&perf_pmu__hybrid_pmus);
> > >   }
> > > +
> > > +int perf_pmu__match(char *pattern, char *name, char *tok)
> > > +{
> > > +	if (fnmatch(pattern, name, 0))
> > > +		return -1;
> > > +
> > > +	if (tok && !perf_pmu__valid_suffix(name, tok))
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > > index a790ef758171..926da483a141 100644
> > > --- a/tools/perf/util/pmu.h
> > > +++ b/tools/perf/util/pmu.h
> > > @@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> > >   				   char *name);
> > >   bool perf_pmu__has_hybrid(void);
> > > +int perf_pmu__match(char *pattern, char *name, char *tok);
> > >   #endif /* __PMU_H */
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 

- Arnaldo
