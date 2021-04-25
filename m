Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D636A856
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhDYQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhDYQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619367466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCKeUvXeTZX1BgRSAq5x3vtIP3wNNmJXj+bQKNsHfzE=;
        b=E4dXbC/wp1TyVjujkrCdJuzpVdzbY44DhCrV8gHsKlsF5QXe6Mac61V7g/2LHKKtCjfTW+
        srWS5E2oPstIAGYAp0dVJ4E0DpJu38bVeQMeqVh9H/jTN9N8F19iGnPlln1Np09QHYcNuT
        cwQF6qdSxZ/Ur3pEOszYczjIfi3sjKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Zhec5cJ-NYG_YcWLmFMRwQ-1; Sun, 25 Apr 2021 12:17:42 -0400
X-MC-Unique: Zhec5cJ-NYG_YcWLmFMRwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B811005582;
        Sun, 25 Apr 2021 16:17:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCADB18B5E;
        Sun, 25 Apr 2021 16:17:38 +0000 (UTC)
Date:   Sun, 25 Apr 2021 18:17:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 12/26] perf parse-events: Support event inside hybrid
 pmu
Message-ID: <YIWWISXCQl7fPUFo@krava>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
 <20210423053541.12521-13-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423053541.12521-13-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:35:27PM +0800, Jin Yao wrote:

SNIP

> +static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_state,
> +					   struct list_head *list, char *name,
> +					   struct list_head *head_config)
> +{
> +	struct parse_events_term *term;
> +	int ret = -1;
> +
> +	if (parse_state->fake_pmu || !head_config || list_empty(head_config) ||
> +	    !perf_pmu__is_hybrid(name)) {
> +		return -1;
> +	}
> +
> +	/*
> +	 * More than one term in list.
> +	 */
> +	if (head_config->next && head_config->next->next != head_config)
> +		return -1;
> +
> +	term = list_first_entry(head_config, struct parse_events_term, list);
> +	if (term && term->config && strcmp(term->config, "event")) {

so 'event' is set only for HW events, I don't see it being for other
types.. also should the check be !strcmp ?

also please add some tests for cache events with pmu syntax

jirka

> +		ret = parse_events__with_hybrid_pmu(parse_state, term->config,
> +						    name, list);
> +	}
> +
> +	return ret;
> +}
> +
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *list, char *name,
>  			 struct list_head *head_config,
> @@ -1567,6 +1598,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
>  		return -ENOMEM;
>  
> +	if (!parse_events__inside_hybrid_pmu(parse_state, list, name,
> +					     head_config)) {
> +		return 0;
> +	}
> +
>  	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
>  		struct evsel_config_term *pos, *tmp;
>  
> @@ -2183,6 +2219,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
>  	return ret;
>  }
>  
> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> +					 const char *str, char *pmu_name,
> +					 struct list_head *list)
> +{
> +	struct parse_events_state ps = {
> +		.list            = LIST_HEAD_INIT(ps.list),
> +		.stoken          = PE_START_EVENTS,
> +		.hybrid_pmu_name = pmu_name,
> +		.idx             = parse_state->idx,
> +	};
> +	int ret;
> +
> +	ret = parse_events__scanner(str, &ps);
> +	perf_pmu__parse_cleanup();
> +
> +	if (!ret) {
> +		if (!list_empty(&ps.list)) {
> +			list_splice(&ps.list, list);
> +			parse_state->idx = ps.idx;
> +			return 0;
> +		} else
> +			return -1;
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

