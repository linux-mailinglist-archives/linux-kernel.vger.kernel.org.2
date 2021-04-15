Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320843607ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhDOLEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhDOLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618484626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qPXzaz7kdfUpLbhF7LQeun+DZUK7B4tujD79sVnS78=;
        b=NZ6BRnYCWPr/gdi/jwjDNn9vnGRfYmw6n1v28ci+F8PcWlAEJjfrZOSDqEJENYALQNpJf3
        BOiJHQmxJgOSOILU0xd3K9Fc7o81CfdTQi4sWogzQ4AJ2BBEUH+e+d7eRy6yyD6yTp+mcu
        sTRlOZJCdcm//UY24D+v1+XxyZRLpTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-OCdmZoL9N_yqoD8hjGxBKw-1; Thu, 15 Apr 2021 07:03:44 -0400
X-MC-Unique: OCdmZoL9N_yqoD8hjGxBKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E296415F;
        Thu, 15 Apr 2021 11:03:42 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA72B19D9F;
        Thu, 15 Apr 2021 11:03:40 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:03:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
Message-ID: <YHgdixeqOu2NarkC@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329070046.8815-13-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:00:31PM +0800, Jin Yao wrote:

SNIP

> ---
> v3:
>  - Rename the patch:
>    'perf parse-events: Support hardware events inside PMU' -->
>    'perf parse-events: Support no alias assigned event inside hybrid PMU'
> 
>  - Major code is moved to parse-events-hybrid.c.
>  - Refine the code.
> 
>  tools/perf/util/parse-events-hybrid.c | 18 +++++-
>  tools/perf/util/parse-events-hybrid.h |  3 +-
>  tools/perf/util/parse-events.c        | 80 +++++++++++++++++++++++++--
>  tools/perf/util/parse-events.h        |  4 +-
>  tools/perf/util/parse-events.y        |  9 ++-
>  tools/perf/util/pmu.c                 |  4 +-
>  tools/perf/util/pmu.h                 |  2 +-
>  7 files changed, 108 insertions(+), 12 deletions(-)

please move the support to pass pmu_name and filter
on it within hybrid code in to separate patch

> 
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 8a630cbab8f3..5bf176b55573 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -64,6 +64,11 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
>  	int ret;
>  
>  	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		if (parse_state->pmu_name &&
> +		    strcmp(parse_state->pmu_name, pmu->name)) {
> +			continue;

please add this check to separate function

	if (pmu_cmp(parse_stat))
		continue;

SNIP

> +	if (!parse_state->fake_pmu && head_config && !found &&
> +	    perf_pmu__is_hybrid(name)) {
> +		struct parse_events_term *term;
> +		int ret;
> +
> +		list_for_each_entry(term, head_config, list) {
> +			if (!term->config)
> +				continue;
> +
> +			ret = parse_events__with_hybrid_pmu(parse_state,
> +							    term->config,
> +							    name, &found,
> +							    list);
> +			if (found)
> +				return ret;

what if there are more terms in head_config?
should we make sure there's just one term and fail if there's more?

also we already know the perf_pmu__is_hybrid(name) is true,
so can't we just call:

  return parse_events__with_hybrid_pmu(....)


> +		}
> +	}
>  
>  	if (verbose > 1) {
>  		fprintf(stderr, "After aliases, add event pmu '%s' with '",
> @@ -1605,6 +1630,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  	struct perf_pmu *pmu = NULL;
>  	int ok = 0;
>  
> +	if (parse_state->pmu_name) {
> +		list = malloc(sizeof(struct list_head));
> +		if (!list)
> +			return -1;
> +		INIT_LIST_HEAD(list);
> +		*listp = list;
> +		return 0;
> +	}

hum, why is this needed?

> +
>  	*listp = NULL;
>  	/* Add it for all PMUs that support the alias */
>  	list = malloc(sizeof(struct list_head));
> @@ -2176,6 +2210,44 @@ int parse_events_terms(struct list_head *terms, const char *str)
>  	return ret;
>  }
>  
> +static int list_entries_nr(struct list_head *list)
> +{
> +	struct list_head *pos;
> +	int n = 0;
> +
> +	list_for_each(pos, list)
> +		n++;
> +
> +	return n;
> +}
> +
> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> +					 const char *str, char *pmu_name,
> +					 bool *found, struct list_head *list)
> +{
> +	struct parse_events_state ps = {
> +		.list           = LIST_HEAD_INIT(ps.list),
> +		.stoken         = PE_START_EVENTS,
> +		.pmu_name       = pmu_name,
> +		.idx            = parse_state->idx,
> +	};

could we add this pmu_name directly to __parse_events?

it duplicates the code plus there are some extra checks
you don't do in here and which might be needed, like
last->cmdline_group_boundary setup

> +	int ret;
> +
> +	*found = false;
> +	ret = parse_events__scanner(str, &ps);
> +	perf_pmu__parse_cleanup();
> +
> +	if (!ret) {
> +		if (!list_empty(&ps.list)) {
> +			*found = true;
> +			list_splice(&ps.list, list);
> +			parse_state->idx = list_entries_nr(list);

could you just use ps.idx instead of list_entries_nr ?

> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int __parse_events(struct evlist *evlist, const char *str,
>  		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index c4f2f96304ce..f9d8e8e41c38 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -138,6 +138,7 @@ struct parse_events_state {
>  	struct list_head	  *terms;
>  	int			   stoken;
>  	struct perf_pmu		  *fake_pmu;
> +	char			  *pmu_name;

so it's hybrid specific, we should name it like hybrid_pmu_name or such

thanks,
jirka

