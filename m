Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088D933C9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhCOXEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232624AbhCOXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wF58ZLyY2L8Hfyy4C3sq5G7vT6xQpblGhcrQQ/9ieOw=;
        b=Yg9Lb6EteuHi0lyw2SUQVGsvXSQT5dlRGcVyxnXk2GiCV52TzAHjWETRLQ5coSR1+Qk6zZ
        e7Qr1GjKVH3E7D8/8oSDvRhTMbNYnWd4mE0jSwbf3qodybSOPW7J0GRqkAq/DydXJ3znml
        i4Ww8QKIQCvJ8cbtDGanO4j5e81ZG4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-5Qc631ESOwGL37_rINcUoA-1; Mon, 15 Mar 2021 19:04:14 -0400
X-MC-Unique: 5Qc631ESOwGL37_rINcUoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C562B107ACCD;
        Mon, 15 Mar 2021 23:04:12 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE22260C0F;
        Mon, 15 Mar 2021 23:04:10 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:04:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 08/27] perf stat: Uniquify hybrid event name
Message-ID: <YE/n6euYqv7XBFht@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-9-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-9-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:23PM +0800, Jin Yao wrote:
> It would be useful to tell user the pmu which the event belongs to.
> perf-stat has supported '--no-merge' option and it can print the pmu
> name after the event name, such as:
> 
> "cycles [cpu_core]"
> 
> Now this option is enabled by default for hybrid platform but change
> the format to:
> 
> "cpu_core/cycles/"
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c      |  3 +++
>  tools/perf/util/stat-display.c | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 68ecf68699a9..6c0a21323814 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2390,6 +2390,9 @@ int cmd_stat(int argc, const char **argv)
>  
>  	evlist__check_cpu_maps(evsel_list);
>  
> +	if (perf_pmu__hybrid_exist())
> +		stat_config.no_merge = true;
> +
>  	/*
>  	 * Initialize thread_map with comm names,
>  	 * so we could print it out on output.
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7f09cdaf5b60..ed37d8e7ea1a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -526,6 +526,7 @@ static void uniquify_event_name(struct evsel *counter)
>  {
>  	char *new_name;
>  	char *config;
> +	int ret;
>  
>  	if (counter->uniquified_name ||
>  	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> @@ -540,8 +541,15 @@ static void uniquify_event_name(struct evsel *counter)
>  			counter->name = new_name;
>  		}
>  	} else {
> -		if (asprintf(&new_name,
> -			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
> +		if (perf_pmu__hybrid_exist()) {

I'm still not sure about the whole thing, but should you
check in here jut for count->pmu_name instead for hybrid
globaly?

jirka

> +			ret = asprintf(&new_name, "%s/%s/",
> +				       counter->pmu_name, counter->name);
> +		} else {
> +			ret = asprintf(&new_name, "%s [%s]",
> +				       counter->name, counter->pmu_name);
> +		}
> +
> +		if (ret) {
>  			free(counter->name);
>  			counter->name = new_name;
>  		}
> -- 
> 2.17.1
> 

