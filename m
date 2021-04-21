Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF831367294
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbhDUSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235723AbhDUSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtGtYNFtNAebLz2pgKqQah+fAXQ7o/bJBdongF2UrwY=;
        b=bk2qBoeaLwpD2LwmtpWUperRm+9c1Cunam97fB1lt8xVJLL0KZceqNBlWkzqWD+2M9wMc6
        YeNf+GWrdN+z7XIY2qtNHkYzlpVzyt1OpKzWPdOcylF8uFm5HnQH0VMVplTUBMOsGcsYih
        LmQhwpTVk9+DHFUtV4sGMraXrh1iqNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-r_aH-naCNO2wyBNc55BI9Q-1; Wed, 21 Apr 2021 14:30:13 -0400
X-MC-Unique: r_aH-naCNO2wyBNc55BI9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2FCB8542F4;
        Wed, 21 Apr 2021 18:29:59 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD5C05C1B4;
        Wed, 21 Apr 2021 18:29:57 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 15/25] perf stat: Filter out unmatched aggregation for
 hybrid event
Message-ID: <YIBvJLAvL0rWGhhP@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-16-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-16-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:07PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 5255d78b1c30..15eafd249e46 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -643,6 +643,20 @@ static void aggr_cb(struct perf_stat_config *config,
>  	}
>  }
>  
> +static bool aggr_id_hybrid_matched(struct perf_stat_config *config,
> +				   struct evsel *counter, struct aggr_cpu_id id)
> +{
> +	struct aggr_cpu_id s;
> +
> +	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
> +		s = config->aggr_get_id(config, evsel__cpus(counter), i);
> +		if (cpu_map__compare_aggr_cpu_id(s, id))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>  				   struct evsel *counter, int s,
>  				   char *prefix, bool metric_only,
> @@ -656,6 +670,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  	double uval;
>  
>  	ad.id = id = config->aggr_map->map[s];
> +
> +	if (perf_pmu__has_hybrid() &&
> +	    !aggr_id_hybrid_matched(config, counter, id)) {
> +		return;
> +	}
> +
>  	ad.val = ad.ena = ad.run = 0;
>  	ad.nr = 0;
>  	if (!collect_data(config, counter, aggr_cb, &ad))

there's same check in aggr_cb, so it seems like we could just make check in here:

	if (perf_pmu__has_hybrid() && ad.ena == 0)
		return;

without another extra loop

jirka

