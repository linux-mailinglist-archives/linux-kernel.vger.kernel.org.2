Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12727365EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhDTRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhDTRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618939887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCnO9SMNXtq3N/cBHfFZ4OlAcq+Y22z5ByVxA35w6dg=;
        b=bOSPI2fwFnUfugPyTyo0fvGdNkIjLp9MJsBEom+CM0yqkr4b99ZSr/OXGIA5o/0NUASM7N
        F2jk7VNykDAu4zSEDpPV/LvBWAltSJWTcSxMKv9lAAE/3MgsDwn56bP0PK3fp/tI7VU6W9
        3NsdY2UZdCuY6R3CFy8Au/sp/VZz2u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-ij-8fh4bOSab0eh2HCKxew-1; Tue, 20 Apr 2021 13:31:22 -0400
X-MC-Unique: ij-8fh4bOSab0eh2HCKxew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2DF2835B4B;
        Tue, 20 Apr 2021 17:31:20 +0000 (UTC)
Received: from krava (unknown [10.40.196.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C0BF5D9C0;
        Tue, 20 Apr 2021 17:31:19 +0000 (UTC)
Date:   Tue, 20 Apr 2021 19:31:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YH8P5ol5JRr5JO5v@krava>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419203649.164121-4-song@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:

SNIP

>  	if (stat_config.initial_delay < 0) {
> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (affinity__setup(&affinity) < 0)
>  		return -1;
>  
> -	if (target__has_bpf(&target)) {
> -		evlist__for_each_entry(evsel_list, counter) {
> -			if (bpf_counter__load(counter, &target))
> -				return -1;
> -		}
> +	evlist__for_each_entry(evsel_list, counter) {
> +		if (bpf_counter__load(counter, &target))
> +			return -1;
> +		if (!evsel__is_bpf(counter))
> +			all_counters_use_bpf = false;

could be done in bpf_counter__load, check below:

>  	}
>  
>  	evlist__for_each_cpu (evsel_list, i, cpu) {
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 5de991ab46af9..33b1888103dfa 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
>  {
>  	if (target->bpf_str)
>  		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> -	else if (target->use_bpf)
> +	else if (target->use_bpf ||
> +		 evsel__match_bpf_counter_events(evsel->name))
>  		evsel->bpf_counter_ops = &bperf_ops;

with:
	else
		all_counters_use_bpf = false;

I was also thinking of oving it to evlist, but it's sat specific,
so I think it's good as static.. thanks for changing the implementation

jirka

>  
>  	if (evsel->bpf_counter_ops)
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 6bcb5ef221f8c..63d472b336de2 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -18,6 +18,7 @@
>  #include "util/hist.h"  /* perf_hist_config */
>  #include "util/llvm-utils.h"   /* perf_llvm_config */
>  #include "util/stat.h"  /* perf_stat__set_big_num */
> +#include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
>  #include "build-id.h"
>  #include "debug.h"
>  #include "config.h"
> @@ -460,6 +461,9 @@ static int perf_stat_config(const char *var, const char *value)
>  	if (!strcmp(var, "stat.no-csv-summary"))
>  		perf_stat__set_no_csv_summary(perf_config_bool(var, value));
>  
> +	if (!strcmp(var, "stat.bpf-counter-events"))
> +		evsel__bpf_counter_events = strdup(value);
> +
>  	/* Add other config variables here. */
>  	return 0;
>  }

SNIP

