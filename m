Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C46367292
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245248AbhDUSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245226AbhDUSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=78FjrxbP3adjkmaBwC6DzdKj1Qo74dKU3GXHVdCMtZg=;
        b=hArY4mBHbXxt30szzxjcxOXrg2M7lAGVl5NqKZfjseMyLi0+OLVxKU4H13vf5AvGD3GkGu
        mEaE0iZsjsrGoCeWnf8uYran+tSbuCZtaO5LoMYZTN91lObiMqjxIql8X0et9tzgVzfJUa
        0arHfAOytOdIdPaKRwNy9oXaMto3WEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-h_AyY3NUMw-8S39_Xi2qCA-1; Wed, 21 Apr 2021 14:29:59 -0400
X-MC-Unique: h_AyY3NUMw-8S39_Xi2qCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9BBB10A0992;
        Wed, 21 Apr 2021 18:29:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id A2B3F5D9C0;
        Wed, 21 Apr 2021 18:29:28 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 12/25] perf parse-events: Support event inside hybrid
 pmu
Message-ID: <YIBvB8J6uJhIPBXz@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-13-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-13-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:04PM +0800, Jin Yao wrote:

SNIP

> ---
> v4:
>  - New in v4.
> 
>  tools/perf/util/parse-events.c | 55 ++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index f69475a158bb..bd3fd722b4ac 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -38,6 +38,7 @@
>  #include "util/event.h"
>  #include "util/pfm.h"
>  #include "util/parse-events-hybrid.h"
> +#include "util/pmu-hybrid.h"
>  #include "perf.h"
>  
>  #define MAX_NAME_LEN 100
> @@ -48,6 +49,9 @@ extern int parse_events_debug;
>  int parse_events_parse(void *parse_state, void *scanner);
>  static int get_config_terms(struct list_head *head_config,
>  			    struct list_head *head_terms __maybe_unused);
> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> +					 const char *str, char *pmu_name,
> +					 struct list_head *list, bool *parsed);
>  
>  static struct perf_pmu_event_symbol *perf_pmu_events_list;
>  /*
> @@ -1567,6 +1571,27 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
>  		return -ENOMEM;
>  
> +	if (!parse_state->fake_pmu && head_config &&
> +	    perf_pmu__is_hybrid(name)) {
> +		struct parse_events_term *term;
> +		bool parsed;
> +		int ret;
> +
> +		term = list_first_entry(head_config, struct parse_events_term,
> +					list);

you need to test that there's something in the head_config first,
and I thought you wanted to check that there's just 1 term, right?
(you could check the next pointer == head_config)

also please move this to separated function

> +		if (term && term->config && strcmp(term->config, "event")) {
> +			ret = parse_events__with_hybrid_pmu(parse_state,
> +							    term->config, name,
> +							    list, &parsed);
> +			/*
> +			 * If the string inside the pmu can't be parsed,
> +			 * don't return, try next steps.
> +			 */
> +			if (parsed)
> +				return ret;

so if the function fails we ignore the return value,
because parsed is set only for ret == 0, so I think we
don't need 'parsed' param and we could make parse_events__with_hybrid_pmu
return 0 when we found some event and let it go through otherwise


> +		}
> +	}
> +
>  	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
>  		struct evsel_config_term *pos, *tmp;
>  
> @@ -1585,6 +1610,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	if (!evsel)
>  		return -ENOMEM;
>  
> +	if (evsel->name)
> +		evsel->use_config_name = true;

should this go to:
 perf stat: Uniquify hybrid event name
?

thanks,
jirka

> +
>  	evsel->pmu_name = name ? strdup(name) : NULL;
>  	evsel->use_uncore_alias = use_uncore_alias;
>  	evsel->percore = config_term_percore(&evsel->config_terms);
> @@ -2180,6 +2208,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
>  	return ret;
>  }
>  
> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> +					 const char *str, char *pmu_name,
> +					 struct list_head *list, bool *parsed)
> +{
> +	struct parse_events_state ps = {
> +		.list            = LIST_HEAD_INIT(ps.list),
> +		.stoken          = PE_START_EVENTS,
> +		.hybrid_pmu_name = pmu_name,
> +		.idx             = parse_state->idx,
> +	};
> +	int ret;
> +
> +	*parsed = false;
> +	ret = parse_events__scanner(str, &ps);
> +	perf_pmu__parse_cleanup();
> +
> +	if (!ret) {
> +		if (!list_empty(&ps.list)) {
> +			*parsed = true;
> +			list_splice(&ps.list, list);
> +			parse_state->idx = ps.idx;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int __parse_events(struct evlist *evlist, const char *str,
>  		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>  {
> -- 
> 2.17.1
> 

