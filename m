Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87B033C998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhCOXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232624AbhCOXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qk6puFgySAsEPr/cSYK1Hq9ltxcgcswO8VpEvxEzRDI=;
        b=PMQXkygCKXPsKd61m0d0bkos7VmPC1UNU+YcTt2DyuEnzrz9ZXW5vEjSrev0j0Xb4H0Vet
        Qoy1TtDVr3g4HaX5gbHCTXYTs1DZ1fs1rB4D6IR9Dl1vdwM2EYt9tPLrAkodSZHrdcChEf
        qFzR3IYNTugfbSNSGhIpIdjk3iFWVJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-gfNvQ079MwGldCB-KtrAag-1; Mon, 15 Mar 2021 19:03:57 -0400
X-MC-Unique: gfNvQ079MwGldCB-KtrAag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87278030B5;
        Mon, 15 Mar 2021 23:03:55 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 888DE1F04A;
        Mon, 15 Mar 2021 23:03:53 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:03:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 16/27] perf evlist: Warn as events from different
 hybrid PMUs in a group
Message-ID: <YE/n2BW1ifH42/o6@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-17-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-17-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:31PM +0800, Jin Yao wrote:

SNIP

>  				goto try_again;
>  			}
> +
> +			if (errno == EINVAL && perf_pmu__hybrid_exist())
> +				evlist__warn_hybrid_group(evlist);
>  			rc = -errno;
>  			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
>  			ui__error("%s\n", msg);
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7a732508b2b4..6f780a039db0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -239,6 +239,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>  	struct evsel *evsel, *pos, *leader;
>  	char buf[1024];
>  
> +	if (evlist__hybrid_exist(evlist))
> +		return;

this should be in separate patch and explained

> +
>  	evlist__for_each_entry(evlist, evsel) {
>  		leader = evsel->leader;
>  
> @@ -726,6 +729,10 @@ enum counter_recovery {
>  static enum counter_recovery stat_handle_error(struct evsel *counter)
>  {
>  	char msg[BUFSIZ];
> +
> +	if (perf_pmu__hybrid_exist() && errno == EINVAL)
> +		evlist__warn_hybrid_group(evsel_list);
> +
>  	/*
>  	 * PPC returns ENXIO for HW counters until 2.6.37
>  	 * (behavior changed with commit b0a873e).
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f139151b9433..5ec891418cdd 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2224,3 +2224,47 @@ void evlist__invalidate_all_cpus(struct evlist *evlist)
>  	perf_cpu_map__put(evlist->core.all_cpus);
>  	evlist->core.all_cpus = perf_cpu_map__empty_new(1);
>  }
> +
> +static bool group_hybrid_conflict(struct evsel *leader)
> +{
> +	struct evsel *pos, *prev = NULL;
> +
> +	for_each_group_evsel(pos, leader) {
> +		if (!pos->pmu_name || !perf_pmu__is_hybrid(pos->pmu_name))
> +			continue;
> +
> +		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
> +			return true;
> +
> +		prev = pos;
> +	}
> +
> +	return false;
> +}
> +
> +void evlist__warn_hybrid_group(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel__is_group_leader(evsel) &&
> +		    evsel->core.nr_members > 1 &&

hm, could we just iterate all the members and make sure the first found
hybrid event's pmu matches the pmu of the rest hybrid events in the list?

> +		    group_hybrid_conflict(evsel)) {
> +			WARN_ONCE(1, "WARNING: Group has events from "
> +				     "different hybrid PMUs\n");
> +			return;
> +		}
> +	}
> +}
> +
> +bool evlist__hybrid_exist(struct evlist *evlist)

evlist__has_hybrid seems better


jirka

