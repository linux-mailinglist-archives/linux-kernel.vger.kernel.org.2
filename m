Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A698744C1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhKJM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhKJM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636548997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiNUxX7YP1FDAJqD9JAEwPdXebjdzMeH6N5HSXq36Gg=;
        b=Co0rJNwE8xKydiqAc+qXPQAJ8pw2XgbrZbHOm/gLaJ96Pw5krwceNQuCl3M6kcUJ9IdMtd
        4mFvY/x29TaKy34yv1XPCD1KN6HcG77fd4hII0jGHjIvL8aWD9AXmcMuxJBmyQLT0vo+qf
        mW/4HmLOveoxmwXklEWp6HoGxjybZ18=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-BCLrks2oOrKICtKevXxgug-1; Wed, 10 Nov 2021 07:56:35 -0500
X-MC-Unique: BCLrks2oOrKICtKevXxgug-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso2204884edj.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CiNUxX7YP1FDAJqD9JAEwPdXebjdzMeH6N5HSXq36Gg=;
        b=zN/2mYyL3xYFKDuKGkdLpesPLJw2RVQCDFKZ1YJAcB1MtTQruTWvcEz/OOlT/QdC/o
         tarZj99jimvVNC39Q7ego1Nb81gJjtlITHo13yLS50mj73T3/wN7l/ESuilIHgBz8fT9
         brZ1e7ITJUwNeT5TGx+OVzEAorkbT36v2duq0ge+OvIZnwSc2zEiGts/4BgS8LiK88xu
         OeV/IbywreLdyH+OY0Ulv2V6O+5UJ+Cp4ySgUaTOue8TdYEWI44MdWt74h+R9iv8tstC
         wor9hxExUZb21ejtrAlkgXur9Gnpt6sudcbC+TxsY1zNpUp07R+ZKBc9zI2YX+TbYqjW
         iN/Q==
X-Gm-Message-State: AOAM532hZdOwWRx/UFGveP/4OIFARxOjyRstee9d6jO4U4qYVyIfZAi+
        iqMYb2gSm10KDjLXeGipdINLqTkfhwDqH3/LsXVD7R4yWJwbk7TliUstyeqgxxFLmSKOlCTcla1
        uOl+4XlK8HTPBGZvb3PEOMG4w
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr20682621ejc.160.1636548993996;
        Wed, 10 Nov 2021 04:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ5zX39ITZ/sgTFZ+VhWNknQujRSQQvByT1P5SFh7HHpUvA9tZxxzd0t8LmzwkHiLvdJsvFA==
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr20682554ejc.160.1636548993582;
        Wed, 10 Nov 2021 04:56:33 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id i13sm13057694edc.62.2021.11.10.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:56:33 -0800 (PST)
Date:   Wed, 10 Nov 2021 13:56:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] perf expr: Add source_count for aggregating events
Message-ID: <YYvBfrP6fl3oNMyj@krava>
References: <20211105170943.3479315-1-irogers@google.com>
 <20211105170943.3479315-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105170943.3479315-8-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 10:09:43AM -0700, Ian Rogers wrote:
> Events like uncore_imc/cas_count_read/ on Skylake open multiple events
> and then aggregate in the metric leader. To determine the average value
> per event the number of these events is needed. Add a source_count
> function that returns this value by counting the number of events with
> the given metric leader. For most events the value is 1 but for
> uncore_imc/cas_count_read/ it can yield values like 6.
> 
> Add a generic test, but manually tested with a test metric that uses
> the function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c       | 12 +++++++
>  tools/perf/util/evsel.c       | 12 +++++++
>  tools/perf/util/evsel.h       |  1 +
>  tools/perf/util/expr.c        | 27 ++++++++++++---
>  tools/perf/util/expr.h        |  3 ++
>  tools/perf/util/expr.l        |  1 +
>  tools/perf/util/expr.y        | 65 ++++++++++++++++++++---------------
>  tools/perf/util/stat-shadow.c |  7 +++-
>  8 files changed, 95 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 0c09ccc76665..f14d11ac353e 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -171,6 +171,18 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
>  	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
>  
> +	/*
> +	 * Source count returns the number of events aggregating in a leader
> +	 * event including the leader. Check parsing yields an id.
> +	 */
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("source count",
> +			expr__find_ids("source_count(EVENT1)",
> +			NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
> +	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1",
> +							(void **)&val_ptr));
> +
>  	expr__ctx_free(ctx);
>  
>  	return 0;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2cfc2935d1d2..9a2a5087f00a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3018,3 +3018,15 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader)
>  {
>  	evsel->core.leader = &leader->core;
>  }
> +
> +int evsel__source_count(const struct evsel *evsel)
> +{
> +	struct evsel *pos;
> +	int count = 0;
> +
> +	evlist__for_each_entry(evsel->evlist, pos) {
> +		if (pos->metric_leader == evsel)
> +			count++;
> +	}
> +	return count;
> +}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 846c827934de..d733a8458a52 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -484,6 +484,7 @@ struct evsel *evsel__leader(struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> +int evsel__source_count(const struct evsel *evsel);
>  
>  /*
>   * Macro to swap the bit-field postition and size.
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 15af8b8ef5e7..1d532b9fed29 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -23,7 +23,10 @@ extern int expr_debug;
>  
>  struct expr_id_data {
>  	union {
> -		double val;
> +		struct {
> +			double val;
> +			int source_count;
> +		} val;
>  		struct {
>  			double val;
>  			const char *metric_name;
> @@ -140,6 +143,13 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
>  
>  /* Caller must make sure id is allocated */
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> +{
> +	return expr__add_id_val_source_count(ctx, id, val, /*source_count=*/1);
> +}
> +
> +/* Caller must make sure id is allocated */
> +int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
> +				  double val, int source_count)
>  {
>  	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
>  	char *old_key = NULL;
> @@ -148,7 +158,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  	data_ptr = malloc(sizeof(*data_ptr));
>  	if (!data_ptr)
>  		return -ENOMEM;
> -	data_ptr->val = val;
> +	data_ptr->val.val = val;
> +	data_ptr->val.source_count = source_count;
>  	data_ptr->kind = EXPR_ID_DATA__VALUE;
>  
>  	ret = hashmap__set(ctx->ids, id, data_ptr,
> @@ -244,7 +255,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
>  
>  	switch (data->kind) {
>  	case EXPR_ID_DATA__VALUE:
> -		pr_debug2("lookup(%s): val %f\n", id, data->val);
> +		pr_debug2("lookup(%s): val %f\n", id, data->val.val);
>  		break;
>  	case EXPR_ID_DATA__REF:
>  		pr_debug2("lookup(%s): ref metric name %s\n", id,
> @@ -255,7 +266,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
>  			pr_debug("%s failed to count\n", id);
>  			return -1;
>  		}
> -		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
> +		pr_debug("processing metric: %s EXIT: %f\n", id, data->ref.val);
>  		break;
>  	case EXPR_ID_DATA__REF_VALUE:
>  		pr_debug2("lookup(%s): ref val %f metric name %s\n", id,
> @@ -370,11 +381,17 @@ int expr__find_ids(const char *expr, const char *one,
>  double expr_id_data__value(const struct expr_id_data *data)
>  {
>  	if (data->kind == EXPR_ID_DATA__VALUE)
> -		return data->val;
> +		return data->val.val;
>  	assert(data->kind == EXPR_ID_DATA__REF_VALUE);
>  	return data->ref.val;
>  }
>  
> +double expr_id_data__source_count(const struct expr_id_data *data)
> +{
> +	assert(data->kind == EXPR_ID_DATA__VALUE);
> +	return data->val.source_count;
> +}
> +
>  double expr__get_literal(const char *literal)
>  {
>  	static struct cpu_topology *topology;
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index a6ab7f2b23d1..bd2116983bbb 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -40,6 +40,8 @@ void expr__ctx_free(struct expr_parse_ctx *ctx);
>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> +int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
> +				double val, int source_count);
>  int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>  		 struct expr_id_data **data);
> @@ -55,6 +57,7 @@ int expr__find_ids(const char *expr, const char *one,
>  		   struct expr_parse_ctx *ids);
>  
>  double expr_id_data__value(const struct expr_id_data *data);
> +double expr_id_data__source_count(const struct expr_id_data *data);
>  double expr__get_literal(const char *literal);
>  
>  #endif
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index cf6e3c710502..0a13eb20c814 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -107,6 +107,7 @@ max		{ return MAX; }
>  min		{ return MIN; }
>  if		{ return IF; }
>  else		{ return ELSE; }
> +source_count	{ return SOURCE_COUNT; }
>  {literal}	{ return literal(yyscanner); }
>  {number}	{ return value(yyscanner); }
>  {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index ba6c6dbf30c8..d5d10f21097a 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -3,6 +3,7 @@
>  #define YYDEBUG 1
>  #include <assert.h>
>  #include <math.h>
> +#include <stdlib.h>
>  #include "util/debug.h"
>  #define IN_EXPR_Y 1
>  #include "expr.h"
> @@ -36,7 +37,7 @@
>  	} ids;
>  }
>  
> -%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO EXPR_ERROR
> +%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT EXPR_ERROR
>  %left MIN MAX IF
>  %left '|'
>  %left '^'
> @@ -82,6 +83,40 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
>  	return result;
>  }
>  
> +static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
> +			    bool compute_ids, bool source_count)
> +{
> +	struct ids result;
> +	if (!compute_ids) {
> +		/*
> +		 * Compute the event's value from ID. If the ID isn't known then
> +		 * it isn't used to compute the formula so set to NAN.
> +		 */
> +		struct expr_id_data *data;
> +
> +		result.val = NAN;
> +		if (expr__resolve_id(ctx, id, &data) == 0) {
> +			result.val = source_count
> +				? expr_id_data__source_count(data)
> +				: expr_id_data__value(data);
> +		}
> +		result.ids = NULL;
> +		free(id);
> +	} else {
> +		/*
> +		 * Set the value to BOTTOM to show that any value is possible
> +		 * when the event is computed. Create a set of just the ID.
> +		 */
> +		result.val = BOTTOM;
> +		result.ids = ids__new();
> +		if (!result.ids || ids__insert(result.ids, id)) {
> +			pr_err("Error creating IDs for '%s'", id);
> +			free(id);
> +		}
> +	}

could you please put the move of handle_id into separate patch?
it''ll be easier to review the actual changes

thanks,
jirka

> +	return result;
> +}
> +
>  /*
>   * If we're not computing ids or $1 and $3 are constants, compute the new
>   * constant value using OP. Its invariant that there are no ids.  If computing
> @@ -167,32 +202,8 @@ expr: NUMBER
>  	$$.val = $1;
>  	$$.ids = NULL;
>  }
> -| ID
> -{
> -	if (!compute_ids) {
> -		/*
> -		 * Compute the event's value from ID. If the ID isn't known then
> -		 * it isn't used to compute the formula so set to NAN.
> -		 */
> -		struct expr_id_data *data;
> -
> -		$$.val = NAN;
> -		if (expr__resolve_id(ctx, $1, &data) == 0)
> -			$$.val = expr_id_data__value(data);
> -
> -		$$.ids = NULL;
> -		free($1);
> -	} else {
> -		/*
> -		 * Set the value to BOTTOM to show that any value is possible
> -		 * when the event is computed. Create a set of just the ID.
> -		 */
> -		$$.val = BOTTOM;
> -		$$.ids = ids__new();
> -		if (!$$.ids || ids__insert($$.ids, $1))
> -			YYABORT;
> -	}
> -}
> +| ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
> +| SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
>  | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
>  | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
>  | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 69f3cf3b4a44..ce0ce8ac2874 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -828,10 +828,12 @@ static int prepare_metric(struct evsel **metric_events,
>  		struct saved_value *v;
>  		struct stats *stats;
>  		u64 metric_total = 0;
> +		int source_count;
>  
>  		if (!strcmp(metric_events[i]->name, "duration_time")) {
>  			stats = &walltime_nsecs_stats;
>  			scale = 1e-9;
> +			source_count = 1;
>  		} else {
>  			v = saved_value_lookup(metric_events[i], cpu, false,
>  					       STAT_NONE, 0, st,
> @@ -840,6 +842,7 @@ static int prepare_metric(struct evsel **metric_events,
>  				break;
>  			stats = &v->stats;
>  			scale = 1.0;
> +			source_count = evsel__source_count(metric_events[i]);
>  
>  			if (v->metric_other)
>  				metric_total = v->metric_total;
> @@ -848,7 +851,9 @@ static int prepare_metric(struct evsel **metric_events,
>  		if (!n)
>  			return -ENOMEM;
>  
> -		expr__add_id_val(pctx, n, metric_total ? : avg_stats(stats) * scale);
> +		expr__add_id_val_source_count(pctx, n,
> +					metric_total ? : avg_stats(stats) * scale,
> +					source_count);
>  	}
>  
>  	for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
> 

