Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0233C9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhCOXFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232651AbhCOXFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7+nnaPVrrdVEtIwt0CqsHHrdPcXjWXlYsoQsNIZMCA=;
        b=i4t+oFYv7RquplqL2/Wjuus7kmjByItdQZO26M9txcf3UouhzziZFyNGkuLu9VNYqsRdF6
        jZOYz2nLZS+Cw2u6hbRwJRYLB4HKeoPANUBVmuoQcg9u5pPiuH+3bNc2EilSJiQDbKtlCi
        PXqmkL5wXMqzsj/hctB+e7UbBy2P0jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-JmB4z9-gNUmH_fdNYe1xYw-1; Mon, 15 Mar 2021 19:05:09 -0400
X-MC-Unique: JmB4z9-gNUmH_fdNYe1xYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105EB1934103;
        Mon, 15 Mar 2021 23:05:08 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 07E77627DD;
        Mon, 15 Mar 2021 23:05:05 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:05:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 09/27] perf parse-events: Create two hybrid hardware
 events
Message-ID: <YE/oIQq9XHIsKVIj@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-10-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-10-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:24PM +0800, Jin Yao wrote:
> For hardware events, they have pre-defined configs. The kernel
> needs to know where the event comes from (e.g. from cpu_core pmu
> or from cpu_atom pmu). But the perf type 'PERF_TYPE_HARDWARE'
> can't carry pmu information.
> 
> So the kernel introduces a new type 'PERF_TYPE_HARDWARE_PMU'.
> The new attr.config layout for PERF_TYPE_HARDWARE_PMU is:
> 
> 0xDD000000AA
> AA: original hardware event ID
> DD: PMU type ID
> 
> PMU type ID is retrieved from sysfs. For example,
> 
>   cat /sys/devices/cpu_atom/type
>   10
> 
>   cat /sys/devices/cpu_core/type
>   4
> 
> When enabling a hybrid hardware event without specified pmu, such as,
> 'perf stat -e cycles -a', two events are created automatically. One
> is for atom, the other is for core.

ok I think I understand the need for this (and the following) patch
the perf_hw_id counters could be global, so when you specify only
event like:

   -e cycles

you want all the cycles, which on hybrid system means cycles from
more than one pmus

SNIP

> @@ -1416,6 +1475,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  {
>  	struct perf_event_attr attr;
>  	LIST_HEAD(config_terms);
> +	bool hybrid;
> +	int ret;
>  
>  	memset(&attr, 0, sizeof(attr));
>  	attr.type = type;
> @@ -1430,6 +1491,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			return -ENOMEM;
>  	}
>  
> +	/*
> +	 * Skip the software dummy event.
> +	 */
> +	if (type != PERF_TYPE_SOFTWARE) {
> +		if (!perf_pmu__hybrid_exist())
> +			perf_pmu__scan(NULL);

this could be checked in the following add_hybrid_numeric call

> +
> +		ret = add_hybrid_numeric(parse_state, list, &attr, &hybrid);
> +		if (hybrid)
> +			return ret;
> +	}

could we add this to separate object.. hybrid.c or maybe parse-events-hybrid.c,

there's already global __add_event wrapper - parse_events__add_event 


jirka

> +
>  	return add_event(list, &parse_state->idx, &attr,
>  			 get_config_name(head_config), &config_terms);
>  }
> -- 
> 2.17.1
> 

