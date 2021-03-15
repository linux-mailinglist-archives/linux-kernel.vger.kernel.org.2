Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD933C9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhCOXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232661AbhCOXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4BkiJzMuTVAJA3cYXXYZCbKZg3oS9NpekVRQsni4UgM=;
        b=ADxUaMn0wwo+RiaUBy/4gsvrgxi85MvXsFtnA1/UP5XwmE5LrVk0c7sG11wJEdHQfik+RX
        S2dQ90PMTSe02no5T6EOc/4LgI61QUgaiub6pf94xq0n/vH/e2dy9A4FJ7yAtFG+WDbojC
        paRLIVl0dnX2FCniT9h5/R5prvuIYmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-9NNzMw_5PQqxCEbIGCFuqA-1; Mon, 15 Mar 2021 19:05:00 -0400
X-MC-Unique: 9NNzMw_5PQqxCEbIGCFuqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA18381426F;
        Mon, 15 Mar 2021 23:04:58 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6B505D9D3;
        Mon, 15 Mar 2021 23:04:56 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:04:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 17/27] perf evsel: Adjust hybrid event and global
 event mixed group
Message-ID: <YE/oF4pOkyQmm0rI@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-18-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-18-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:32PM +0800, Jin Yao wrote:
> A group mixed with hybrid event and global event is allowed. For example,
> group leader is 'cpu-clock' and the group member is 'cpu_atom/cycles/'.
> 
> e.g.
> perf stat -e '{cpu-clock,cpu_atom/cycles/}' -a
> 
> The challenge is their available cpus are not fully matched.
> For example, 'cpu-clock' is available on CPU0-CPU23, but 'cpu_core/cycles/'
> is available on CPU16-CPU23.
> 
> When getting the group id for group member, we must be very careful
> because the cpu for 'cpu-clock' is not equal to the cpu for 'cpu_atom/cycles/'.
> Actually the cpu here is the index of evsel->core.cpus, not the real CPU ID.
> e.g. cpu0 for 'cpu-clock' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.
> 
> Another challenge is for group read. The events in group may be not
> available on all cpus. For example the leader is a software event and
> it's available on CPU0-CPU1, but the group member is a hybrid event and
> it's only available on CPU1. For CPU0, we have only one event, but for CPU1
> we have two events. So we need to change the read size according to
> the real number of events on that cpu.

ugh, this is really bad.. do we really want to support it? ;-)
I guess we need that for metrics..

SNIP

> 
>    Performance counter stats for 'system wide':
> 
>            24,059.14 msec cpu-clock                 #   23.994 CPUs utilized
>        6,406,677,892      cpu_atom/cycles/          #  266.289 M/sec
> 
>          1.002699058 seconds time elapsed
> 
> For cpu_atom/cycles/, cpu16-cpu23 are set with valid group fd (cpu-clock's fd
> on that cpu). For counting results, cpu-clock has 24 cpus aggregation and
> cpu_atom/cycles/ has 8 cpus aggregation. That's expected.
> 
> But if the event order is changed, e.g. '{cpu_atom/cycles/,cpu-clock}',
> there leaves more works to do.
> 
>   root@ssp-pwrt-002:~# ./perf stat -e '{cpu_atom/cycles/,cpu-clock}' -a -vvv -- sleep 1

what id you add the other hybrid pmu event? or just cycles?


SNIP
  
> +static int hybrid_read_size(struct evsel *leader, int cpu, int *nr_members)
> +{
> +	struct evsel *pos;
> +	int nr = 1, back, new_size = 0, idx;
> +
> +	for_each_group_member(pos, leader) {
> +		idx = evsel_cpuid_match(leader, pos, cpu);
> +		if (idx != -1)
> +			nr++;
> +	}
> +
> +	if (nr != leader->core.nr_members) {
> +		back = leader->core.nr_members;
> +		leader->core.nr_members = nr;
> +		new_size = perf_evsel__read_size(&leader->core);
> +		leader->core.nr_members = back;
> +	}
> +
> +	*nr_members = nr;
> +	return new_size;
> +}
> +
>  static int evsel__read_group(struct evsel *leader, int cpu, int thread)
>  {
>  	struct perf_stat_evsel *ps = leader->stats;
>  	u64 read_format = leader->core.attr.read_format;
>  	int size = perf_evsel__read_size(&leader->core);
> +	int new_size, nr_members;
>  	u64 *data = ps->group_data;
>  
>  	if (!(read_format & PERF_FORMAT_ID))
>  		return -EINVAL;

I wonder if we do not find some reasonable generic way to process
this, porhaps we should make some early check that this evlist has
hybrid event and the move the implementation in some separated
hybrid-XXX object, so we don't confuse the code

jirka

