Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8635A040
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhDINrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDINrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpTfXGFKyz1diVOzgdPAPH9E7hvu3BcDdZAa4ecGkbE=;
        b=PROsX8E8fRvVtf8N5qknjMxZ+p+gT7LiSJn6bgNmLm67D5UlNFVoujDDza328v4L9SAeCu
        QdXGjDTlRGcWcI0mVEEh+JrcMo+mtLYJhQiURAe7dccPGWBtjQRjUztWVaj1gn4SUvzozG
        1WMdYBj1j7zJEkt+l9lLhIV/RcIuUvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-9hNmXChQM3OTNXwc2RZD-g-1; Fri, 09 Apr 2021 09:47:08 -0400
X-MC-Unique: 9hNmXChQM3OTNXwc2RZD-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADB1A107ACCD;
        Fri,  9 Apr 2021 13:47:06 +0000 (UTC)
Received: from krava (unknown [10.40.195.216])
        by smtp.corp.redhat.com (Postfix) with SMTP id 812C85D9E3;
        Fri,  9 Apr 2021 13:47:04 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:47:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
Message-ID: <YHBa15BWne4zgv/A@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329070046.8815-13-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:00:31PM +0800, Jin Yao wrote:

SNIP

> +			   struct parse_events_state *parse_state)
>  {
>  	struct perf_event_attr attr;
>  	LIST_HEAD(config_terms);
> @@ -521,7 +526,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  
>  	i = parse_events__add_cache_hybrid(list, idx, &attr,
>  					   config_name ? : name, &config_terms,
> -					   &hybrid);
> +					   &hybrid, parse_state);
>  	if (hybrid)
>  		return i;
>  
> @@ -1481,7 +1486,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	struct perf_pmu *pmu;
>  	struct evsel *evsel;
>  	struct parse_events_error *err = parse_state->error;
> -	bool use_uncore_alias;
> +	bool use_uncore_alias, found = false;
>  	LIST_HEAD(config_terms);
>  
>  	if (verbose > 1) {
> @@ -1530,8 +1535,28 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		}
>  	}
>  
> -	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
> +	if (!parse_state->fake_pmu &&
> +	    perf_pmu__check_alias(pmu, head_config, &info, &found)) {
>  		return -EINVAL;
> +	}
> +

ok, let's not polute surronding functions and make strict check
on what we want in here.. we are after following events:

	cpu_xxx/L1-dcache/
	cpu_xxx/l1-d|/
        ...
right?

so we are after events with single term in head_config that has name in:

	L1-dcache|l1-d|l1d|L1-data              |
	L1-icache|l1-i|l1i|L1-instruction       |
	LLC|L2                                  |
	dTLB|d-tlb|Data-TLB                     |
	iTLB|i-tlb|Instruction-TLB              |
	branch|branches|bpu|btb|bpc             |
	node

I think that with such direct check the code will be more straight
forward, also let's move it to parse-events-hybrid

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

do we need to call the parsing again? could we just call
parse_events__add_cache_hybrid?

jirka


> +			if (found)
> +				return ret;
> +		}
> +	}
>  
>  	if (verbose > 1) {
>  		fprintf(stderr, "After aliases, add event pmu '%s' with '",
> @@ -1605,6 +1630,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  	struct perf_pmu *pmu = NULL;
>  	int ok = 0;
>  

SNIP

