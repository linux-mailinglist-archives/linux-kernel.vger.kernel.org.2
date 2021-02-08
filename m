Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244131407A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhBHU26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:28:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236101AbhBHTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC7B64E5A;
        Mon,  8 Feb 2021 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612811238;
        bh=fZUxdU/A9ob4jCsmdmgPMaAsRktjcloV4iSWSXds3rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5X6jw0wBv1ANoiy0jWueoNa2tByoUXR+8vdRGot1ayT390T9tqVFjU9RGFRshnCv
         Ki3Xu2yizrsrcgQoPsGoaTlYXZovu9KyDoBK2v0piMroUqQ/Zq8DCsermZzCb3CYGj
         ncmNz7O8WLTHbPoRcrWwRbWOyWiQ9wpLhi0+bAorXcIvv/lFWDutT6N5H9IdhLRuGC
         CI9jxIHKd/7eCZ17KPW6JAgmFbF3gNZv8VWog/nL9If4ipFCoo2eA6PCJ6F4KSvsDg
         UfaDoy9pl0r1ry0sunLzr1J9gYonGrZ+NAzsI3AHH+t2JN7WJ1DyuDDkh+l7YDdNB9
         B7/iHFIN0iNxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 002A740513; Mon,  8 Feb 2021 16:07:15 -0300 (-03)
Date:   Mon, 8 Feb 2021 16:07:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 39/49] perf parse-events: Support hybrid raw events
Message-ID: <20210208190715.GN920417@kernel.org>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-40-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-40-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 07:25:36AM -0800, kan.liang@linux.intel.com escreveu:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> On hybrid platform, same raw event is possible to be available on
> both cpu_core pmu and cpu_atom pmu. So it's supported to create
> two raw events for one event encoding.
> 
> root@otcpl-adl-s-2:~# ./perf stat -e r3c -a -vv  -- sleep 1
> Control descriptor is not initialized
> ------------------------------------------------------------

please move thie command outout two chars to the right

> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0x3c
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 5
> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 8
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 9
> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 10
> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 11
> sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 12
> sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 13
> sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 14
> sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 15
> sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 16
> sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 17
> sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 18
> sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
> ------------------------------------------------------------
> perf_event_attr:
>   type                             10
>   size                             120
>   config                           0x3c
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
> sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
> sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 22
> sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 23
> sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 24
> sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 25
> sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
> sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
> ...
> 
>  Performance counter stats for 'system wide':
> 
>         13,107,070      r3c
>            316,562      r3c
> 
>        1.002161379 seconds time elapsed
> 
> It also supports the raw event inside pmu. Syntax is similar:
> 
> cpu_core/<raw event>/
> cpu_atom/<raw event>/
> 
> root@otcpl-adl-s-2:~# ./perf stat -e cpu_core/r3c/ -vv  -- ./triad_loop
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0x3c
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 23641  cpu -1  group_fd -1  flags 0x8 = 3
> cpu_core/r3c/: 0: 401407363 102724005 102724005
> cpu_core/r3c/: 401407363 102724005 102724005
> 
>  Performance counter stats for './triad_loop':
> 
>        401,407,363      cpu_core/r3c/
> 
>        0.103186241 seconds time elapsed
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/parse-events.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ddf6f79..6d7a2ce 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1532,6 +1532,55 @@ static int add_hybrid_numeric(struct parse_events_state *parse_state,
>  	return 0;
>  }
>  
> +static int create_hybrid_raw_event(struct parse_events_state *parse_state,
> +				   struct list_head *list,
> +				   struct perf_event_attr *attr,
> +				   struct list_head *head_config,
> +				   struct list_head *config_terms,
> +				   struct perf_pmu *pmu)
> +{
> +	struct evsel *evsel;
> +
> +	attr->type = pmu->type;
> +	evsel = __add_event(list, &parse_state->idx, attr, true,
> +			    get_config_name(head_config),
> +			    pmu, config_terms, false, NULL);
> +	if (evsel)
> +		evsel->pmu_name = strdup(pmu->name);
> +	else
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int add_hybrid_raw(struct parse_events_state *parse_state,
> +			  struct list_head *list,
> +			  struct perf_event_attr *attr,
> +			  struct list_head *head_config,
> +			  struct list_head *config_terms,
> +			  bool *hybrid)
> +{
> +	struct perf_pmu *pmu;
> +	int ret;
> +
> +	*hybrid = false;
> +	perf_pmu__for_each_hybrid_pmus(pmu) {
> +		*hybrid = true;
> +		if (parse_state->pmu_name &&
> +		    strcmp(parse_state->pmu_name, pmu->name)) {
> +			continue;
> +		}
> +
> +		ret = create_hybrid_raw_event(parse_state, list, attr,
> +					      head_config, config_terms,
> +					      pmu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			     struct list_head *list,
>  			     u32 type, u64 config,
> @@ -1558,7 +1607,12 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  	/*
>  	 * Skip the software dummy event.
>  	 */
> -	if (type != PERF_TYPE_SOFTWARE) {
> +	if (type == PERF_TYPE_RAW) {
> +		ret = add_hybrid_raw(parse_state, list, &attr, head_config,
> +				     &config_terms, &hybrid);
> +		if (hybrid)
> +			return ret;
> +	} else if (type != PERF_TYPE_SOFTWARE) {
>  		if (!perf_pmu__hybrid_exist())
>  			perf_pmu__scan(NULL);
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo
