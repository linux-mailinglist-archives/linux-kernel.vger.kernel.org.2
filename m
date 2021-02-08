Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A39314048
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhBHUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235124AbhBHS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:56:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 670DA64E73;
        Mon,  8 Feb 2021 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612810525;
        bh=xhFP9GSGK/CCvBx4NRTqNj6Q/dvVhOhNAfn1uKyICM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKJhXP3BRw7iboFOLbjE9S/A6jd4IHTli14jvMHezxHDx+QhjBehzA/IuYoRs1Pck
         W9VkNkoDKAvkGW38ADqz9/3SjQC5Vmzvi+1lEJ99q4cpsOaqDPN32cmR5ewWPtZYTH
         cQr2zAm7w6kqakfL5ht3lOHyVwHBRj2faAUCtyfN5x3FvmS6n+JWDybHZsgYw62pNJ
         2H1FlYozsxAbuckzHUGCsEhLQvezzmYtGLD9XH6Pu0ECasfZ1jS/DTDrAuadlpDTq+
         Hp10iRgm8sQcUrJSJn2gISomnV15jiKDDfXepZ2LT7W7uVPXX50N3jSXGParu78FWX
         BCeerifwhrzlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E09C40513; Mon,  8 Feb 2021 15:55:21 -0300 (-03)
Date:   Mon, 8 Feb 2021 15:55:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 28/49] perf pmu: Save detected hybrid pmus to a global
 pmu list
Message-ID: <20210208185521.GJ920417@kernel.org>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-29-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-29-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 07:25:25AM -0800, kan.liang@linux.intel.com escreveu:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> We identify the cpu_core pmu and cpu_atom pmu by explicitly
> checking following files:
> 
> For cpu_core, check:
> "/sys/bus/event_source/devices/cpu_core/cpus"
> 
> For cpu_atom, check:
> "/sys/bus/event_source/devices/cpu_atom/cpus"
> 
> If the 'cpus' file exists, the pmu exists.
> 
> But in order not to hardcode the "cpu_core" and "cpu_atom",
> and make the code generic, if the path
> "/sys/bus/event_source/devices/cpu_xxx/cpus" exists, the hybrid
> pmu exists. All the detected hybrid pmus are linked to a
> global list 'perf_pmu__hybrid_pmus' and then next we just need
> to iterate the list by using perf_pmu__for_each_hybrid_pmus.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/pmu.c | 21 +++++++++++++++++++++
>  tools/perf/util/pmu.h |  7 +++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0c25457..e97b121 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -27,6 +27,7 @@
>  #include "fncache.h"
>  
>  struct perf_pmu perf_pmu__fake;
> +LIST_HEAD(perf_pmu__hybrid_pmus);
>  
>  struct perf_pmu_format {
>  	char *name;
> @@ -633,11 +634,27 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
>  	return NULL;
>  }
>  
> +static bool pmu_is_hybrid(const char *name)
> +{
> +	char path[PATH_MAX];
> +	const char *sysfs;
> +
> +	if (strncmp(name, "cpu_", 4))
> +		return false;
> +
> +	sysfs = sysfs__mountpoint();

Its extremely unlikely that sysfs isn't mounted, but if so, this will
NULL deref, so please do as other sysfs__mountpoint() uses in
tools/perf/util/pmu.c and check if sysfs is NULL, returning false, i.e.
file isn't available.

> +	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
> +	return file_available(path);
> +}
> +
>  static bool pmu_is_uncore(const char *name)
>  {
>  	char path[PATH_MAX];
>  	const char *sysfs;
>  
> +	if (pmu_is_hybrid(name))
> +		return false;
> +
>  	sysfs = sysfs__mountpoint();
>  	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
>  	return file_available(path);
> @@ -951,6 +968,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  	pmu->is_uncore = pmu_is_uncore(name);
>  	if (pmu->is_uncore)
>  		pmu->id = pmu_id(name);
> +	pmu->is_hybrid = pmu_is_hybrid(name);
>  	pmu->max_precise = pmu_max_precise(name);
>  	pmu_add_cpu_aliases(&aliases, pmu);
>  	pmu_add_sys_aliases(&aliases, pmu);
> @@ -962,6 +980,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  	list_splice(&aliases, &pmu->aliases);
>  	list_add_tail(&pmu->list, &pmus);
>  
> +	if (pmu->is_hybrid)
> +		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
> +
>  	pmu->default_config = perf_pmu__get_default_config(pmu);
>  
>  	return pmu;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 0e724d5..99bdb5d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -5,6 +5,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/compiler.h>
>  #include <linux/perf_event.h>
> +#include <linux/list.h>
>  #include <stdbool.h>
>  #include "parse-events.h"
>  #include "pmu-events/pmu-events.h"
> @@ -34,6 +35,7 @@ struct perf_pmu {
>  	__u32 type;
>  	bool selectable;
>  	bool is_uncore;
> +	bool is_hybrid;
>  	bool auxtrace;
>  	int max_precise;
>  	struct perf_event_attr *default_config;
> @@ -42,9 +44,11 @@ struct perf_pmu {
>  	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>  	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>  	struct list_head list;    /* ELEM */
> +	struct list_head hybrid_list;
>  };
>  
>  extern struct perf_pmu perf_pmu__fake;
> +extern struct list_head perf_pmu__hybrid_pmus;
>  
>  struct perf_pmu_info {
>  	const char *unit;
> @@ -124,4 +128,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  
>  int perf_pmu__caps_parse(struct perf_pmu *pmu);
>  
> +#define perf_pmu__for_each_hybrid_pmus(pmu)	\

singular, i.e.

#define perf_pmu__for_each_hybrid_pmu(pmu)	\

> +	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
> +
>  #endif /* __PMU_H */
> -- 
> 2.7.4
> 

-- 

- Arnaldo
