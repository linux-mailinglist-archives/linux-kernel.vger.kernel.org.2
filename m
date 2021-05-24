Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD4038F22C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhEXRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232645AbhEXRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621876774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKYjemjoCmOsqRiW6ANZi0VIXYmEh86/KyzDB1m1OKY=;
        b=VLGES1B+kS+SsqoEBhBmZT//i4scSCoHEG+o5x0OmGGEH8XbuA2c56+Aq2MyTMyiVV1cmi
        e/JKVSRmA9TYUqE4xLvm1muvchedvlP8B8DePSRlL32N8/SaSmOdvDazrEPoZFspfXJLve
        XibVAtpzl1qqr0QsJ6AiFIh0XFmgnmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-yhUQhqHuPG6nb5KgnWnP5g-1; Mon, 24 May 2021 13:19:30 -0400
X-MC-Unique: yhUQhqHuPG6nb5KgnWnP5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A09451A8;
        Mon, 24 May 2021 17:19:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id 683105D9D3;
        Mon, 24 May 2021 17:19:26 +0000 (UTC)
Date:   Mon, 24 May 2021 19:19:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 3/5] perf tools: Check if mem_events is supported for
 hybrid
Message-ID: <YKvgHfNdi7U/sEVg@krava>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520070040.710-4-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:00:38PM +0800, Jin Yao wrote:
> Check if the mem_events ('mem-loads' and 'mem-stores') exist
> in the sysfs path.
> 
> For Alderlake, the hybrid cpu pmu are "cpu_core" and "cpu_atom".
> Check the existing of following paths:
> /sys/devices/cpu_atom/events/mem-loads
> /sys/devices/cpu_atom/events/mem-stores
> /sys/devices/cpu_core/events/mem-loads
> /sys/devices/cpu_core/events/mem-stores
> 
> If the patch exists, the mem_event is supported.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/mem-events.c | 43 +++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index c736eaded06c..e8f6e745eaf0 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -12,14 +12,16 @@
>  #include "mem-events.h"
>  #include "debug.h"
>  #include "symbol.h"
> +#include "pmu.h"
> +#include "pmu-hybrid.h"
>  
>  unsigned int perf_mem_events__loads_ldlat = 30;
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
>  static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> -	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
> -	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
> +	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
> +	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
>  	E(NULL,			NULL,				NULL),

so this was generic place, now it's x86 specific, I wonder we should
move it under arch/x86 to avoid confusion

>  };
>  #undef E
> @@ -100,6 +102,18 @@ int perf_mem_events__parse(const char *str)
>  	return -1;
>  }
>  
> +static bool perf_mem_events__supported(const char *mnt, char *sysfs_name)
> +{
> +	char path[PATH_MAX];
> +	struct stat st;
> +
> +	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> +	if (!stat(path, &st))
> +		return true;
> +
> +	return false;

could be just 'return !stat(path, &st);' right?

> +}
> +
>  int perf_mem_events__init(void)
>  {
>  	const char *mnt = sysfs__mount();
> @@ -110,9 +124,10 @@ int perf_mem_events__init(void)
>  		return -ENOENT;
>  
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		char path[PATH_MAX];
>  		struct perf_mem_event *e = perf_mem_events__ptr(j);
> -		struct stat st;
> +		struct perf_pmu *pmu;
> +		char sysfs_name[100];
> +		int unsupported = 0;
>  
>  		/*
>  		 * If the event entry isn't valid, skip initialization
> @@ -121,11 +136,23 @@ int perf_mem_events__init(void)
>  		if (!e->tag)
>  			continue;
>  
> -		scnprintf(path, PATH_MAX, "%s/devices/%s",
> -			  mnt, e->sysfs_name);
> +		if (!perf_pmu__has_hybrid()) {
> +			scnprintf(sysfs_name, sizeof(sysfs_name),
> +				  e->sysfs_name, "cpu");
> +			e->supported = perf_mem_events__supported(mnt, sysfs_name);
> +		} else {
> +			perf_pmu__for_each_hybrid_pmu(pmu) {
> +				scnprintf(sysfs_name, sizeof(sysfs_name),
> +					  e->sysfs_name, pmu->name);
> +				if (!perf_mem_events__supported(mnt, sysfs_name))
> +					unsupported++;
> +			}
> +
> +			e->supported = (unsupported == 0) ? true : false;

could you just do in the above loop:
			e->supported |= perf_mem_events__supported(mnt, sysfs_name);

jirka

> +		}
>  
> -		if (!stat(path, &st))
> -			e->supported = found = true;
> +		if (e->supported)
> +			found = true;
>  	}
>  
>  	return found ? 0 : -ENOENT;
> -- 
> 2.17.1
> 

