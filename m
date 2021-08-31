Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE05D3FCDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhHaTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231952AbhHaTZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630437901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+mfiKI+dVq/0fOyIQdZHURaT6pEsc/teGujD3MLQREU=;
        b=MrVfgwjtQh9JwCMwGV4ch8OLp64FfquUy1cAFUl/gsyCG6gsXaIgCUIFa9BGzBBJKMQ8HT
        qz/YG81Z5pyKizPz7ySO28fkmVWnBPukxiaxiqMFvCVEVJeM6McJCI7p1qHkPnwPzPbUcG
        9m5WKBkcL3WrrLv7eXOnW8+S8oeW7jI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-goDaUdy2OsG55QO-tauYlw-1; Tue, 31 Aug 2021 15:25:00 -0400
X-MC-Unique: goDaUdy2OsG55QO-tauYlw-1
Received: by mail-wr1-f69.google.com with SMTP id 102-20020adf82ef000000b001576e345169so168395wrc.7
        for <Linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mfiKI+dVq/0fOyIQdZHURaT6pEsc/teGujD3MLQREU=;
        b=sOy9TR/bZF20jXgq0mR+dHEA2kPXzHbqVV0fc+H6RWGtwJDcC/gGU/rGkgXsK632DH
         9FxWvUzIPIsT6FhkIXrldZUUVjBOOj1CNm2c/00nNkSJ+FHapcQM3Z1J2As72Er433bn
         OwP0BO14FaQwiGME94RyCBs3xyowigodWC+VsxDUG+D1khz/YzV8r5AtKARPRwfw+PKE
         KwThA75Z3+h4WEJQCFXrIcyVZoeGenLUZMA++uMlm2myW4H9Lc7NW2B5rSm3QZKTw2a8
         pOIbFG9tPPIc+rmyLpwBXFFXn3eomgB3ERL472M1/7UpcDpU6H7C4KCqI4ALmdfpv186
         Cciw==
X-Gm-Message-State: AOAM5304ntiAkiX+ahA7apweLrgHaHe+D/GhDO6pmPNrNMiF/vYp7HRH
        W8wxAoI0QVOa5J6X9hOQdpMMmOn5kGs/Rlc7W3gDrSRHQh1PMixw0aNGVV4RkvSAGbj1TeqrPwC
        GOojYomMA+bwztAyd3F2DwX6u
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr12262668wrb.288.1630437899248;
        Tue, 31 Aug 2021 12:24:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUVGowJrtnaxcQbQMyQXH6CiWJxED7wCvN+o9zdMRdCvgtWUW8DRXAcVVXhRQ6qagQLIpbZw==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr12262647wrb.288.1630437899049;
        Tue, 31 Aug 2021 12:24:59 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id z14sm3201145wmi.24.2021.08.31.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:24:58 -0700 (PDT)
Date:   Tue, 31 Aug 2021 21:24:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, john.garry@huawei.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v5 1/2] perf pmu: Add PMU alias support
Message-ID: <YS6CCNpd3+557fQZ@krava>
References: <20210817051933.16978-1-yao.jin@linux.intel.com>
 <20210817051933.16978-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817051933.16978-2-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:19:32PM +0800, Jin Yao wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf uncore PMU may have two PMU names, a real name and an alias. The
> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
> The perf tool should support the alias as well.
> 
> Add alias_name in the struct perf_pmu to store the alias. For the PMU
> which doesn't have an alias. It's NULL.
> 
> Introduce two X86 specific functions to retrieve the real name and the
> alias separately.
> 
> Only go through the sysfs to retrieve the mapping between the real name
> and the alias once. The result is cached in a list, uncore_pmu_list.
> 
> Nothing changed for the other ARCHs.
> 
> With the patch, the perf tool can monitor the PMU with either the real
> name or the alias.
> 
> Use the real name,
>  $ perf stat -e uncore_cha_2/event=1/ -x,
>    4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
> 
> Use the alias,
>  $ perf stat -e uncore_type_0_2/event=1/ -x,
>    3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
> 
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

SNIP

> +static char *__pmu_find_real_name(const char *name)
> +{
> +	struct perf_pmu_alias_name *pmu;
> +
> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +		if (!strcmp(name, pmu->alias))
> +			return pmu->name;
> +	}
> +
> +	return (char *)name;
> +}
> +
> +char *pmu_find_real_name(const char *name)
> +{
> +	static bool cached_list;
> +
> +	if (cached_list)
> +		return __pmu_find_real_name(name);
> +
> +	setup_pmu_alias_list();
> +	cached_list = true;
> +
> +	return __pmu_find_real_name(name);
> +}
> +
> +char *pmu_find_alias_name(const char *name)
> +{
> +	struct perf_pmu_alias_name *pmu;

should this one call setup_pmu_alias_list as well?

> +
> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +		if (!strcmp(name, pmu->name))
> +			return pmu->alias;
> +	}
> +	return NULL;
> +}
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 9321bd0e2f76..d94e48e1ff9b 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>  			if (!strncmp(name, "uncore_", 7) &&
>  			    strncmp($1, "uncore_", 7))
>  				name += 7;
> -			if (!perf_pmu__match(pattern, name, $1)) {
> +			if (!perf_pmu__match(pattern, name, $1) ||
> +			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>  				if (parse_events_copy_term_list(orig_terms, &terms))
>  					CLEANUP_YYABORT;
>  				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6cdbee8a12e7..9df874155370 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -945,6 +945,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>  	return NULL;
>  }
>  
> +char * __weak
> +pmu_find_real_name(const char *name)
> +{
> +	return (char *)name;
> +}
> +
> +char * __weak
> +pmu_find_alias_name(const char *name __maybe_unused)
> +{
> +	return NULL;
> +}
> +
>  static int pmu_max_precise(const char *name)
>  {
>  	char path[PATH_MAX];
> @@ -958,13 +970,15 @@ static int pmu_max_precise(const char *name)
>  	return max_precise;
>  }
>  
> -static struct perf_pmu *pmu_lookup(const char *name)
> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  {
>  	struct perf_pmu *pmu;
>  	LIST_HEAD(format);
>  	LIST_HEAD(aliases);
>  	__u32 type;
> +	char *name = pmu_find_real_name(lookup_name);
>  	bool is_hybrid = perf_pmu__hybrid_mounted(name);
> +	char *alias_name;
>  
>  	/*
>  	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
> @@ -995,6 +1009,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  
>  	pmu->cpus = pmu_cpumask(name);
>  	pmu->name = strdup(name);
> +	alias_name = pmu_find_alias_name(name);
> +	if (alias_name)
> +		pmu->alias_name = strdup(alias_name);

please add pmu->name and pmu->alias_name check

thanks,
jirka

>  	pmu->type = type;
>  	pmu->is_uncore = pmu_is_uncore(name);
>  	if (pmu->is_uncore)
> @@ -1023,9 +1040,11 @@ static struct perf_pmu *pmu_find(const char *name)
>  {
>  	struct perf_pmu *pmu;
>  
> -	list_for_each_entry(pmu, &pmus, list)
> -		if (!strcmp(pmu->name, name))
> +	list_for_each_entry(pmu, &pmus, list) {
> +		if (!strcmp(pmu->name, name) ||
> +		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>  			return pmu;
> +	}
>  
>  	return NULL;
>  }
> @@ -1919,6 +1938,9 @@ bool perf_pmu__has_hybrid(void)
>  
>  int perf_pmu__match(char *pattern, char *name, char *tok)
>  {
> +	if (!name)
> +		return -1;
> +
>  	if (fnmatch(pattern, name, 0))
>  		return -1;
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 033e8211c025..6b122f97acf3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -21,6 +21,7 @@ enum {
>  #define PERF_PMU_FORMAT_BITS 64
>  #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>  #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
> +#define MAX_PMU_NAME_LEN 128
>  
>  struct perf_event_attr;
>  
> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>  
>  struct perf_pmu {
>  	char *name;
> +	char *alias_name;
>  	char *id;
>  	__u32 type;
>  	bool selectable;
> @@ -136,4 +138,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  bool perf_pmu__has_hybrid(void);
>  int perf_pmu__match(char *pattern, char *name, char *tok);
>  
> +char *pmu_find_real_name(const char *name);
> +char *pmu_find_alias_name(const char *name);
> +
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

