Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9F53A1E13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFIU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFIU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623270386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++GFETNdsOGFhkXv0JFB33F05MHm2xYiiYnrFDle7ks=;
        b=F0MVpxP65mUiYFrmHz15rjb6mPK6TWQpttC/2xry6GhPPTEpKOx89mAx2MjtLHvfnc0Lbc
        /rM8dWobgWWUvlog5IyDYDWqVMsuSfzlV79gmXBzbcmUwCJlPXbN2SZwHTvMoo/HKoZXmp
        DtGQOWVaUAFMKMTE400NkaWG+OVdEYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-O_swGaOeMwClOkMvzfpWfQ-1; Wed, 09 Jun 2021 16:26:23 -0400
X-MC-Unique: O_swGaOeMwClOkMvzfpWfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE8B80ED91;
        Wed,  9 Jun 2021 20:26:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5BBFE10016FE;
        Wed,  9 Jun 2021 20:26:19 +0000 (UTC)
Date:   Wed, 9 Jun 2021 22:26:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Disable NMI watchdog message on hybrid
Message-ID: <YMEj6vuPcEnCz6tr@krava>
References: <20210609050600.7308-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609050600.7308-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:06:00PM +0800, Jin Yao wrote:
> If we run a single workload that only runs on big core, there is always a
> ugly message about disabling the NMI watchdog because the atom is not
> counted.
> 
> Before:
> 
>   # ./perf stat true
> 
>    Performance counter stats for 'true':
> 
>                 0.43 msec task-clock                #    0.396 CPUs utilized
>                    0      context-switches          #    0.000 /sec
>                    0      cpu-migrations            #    0.000 /sec
>                   45      page-faults               #  103.918 K/sec
>              639,634      cpu_core/cycles/          #    1.477 G/sec
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>              643,498      cpu_core/instructions/    #    1.486 G/sec
>        <not counted>      cpu_atom/instructions/                                        (0.00%)
>              123,715      cpu_core/branches/        #  285.694 M/sec
>        <not counted>      cpu_atom/branches/                                            (0.00%)
>                4,094      cpu_core/branch-misses/   #    9.454 M/sec
>        <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>          0.001092407 seconds time elapsed
> 
>          0.001144000 seconds user
>          0.000000000 seconds sys
> 
>   Some events weren't counted. Try disabling the NMI watchdog:
>           echo 0 > /proc/sys/kernel/nmi_watchdog
>           perf stat ...
>           echo 1 > /proc/sys/kernel/nmi_watchdog
> 
>   # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> 
>    Performance counter stats for 'true':
> 
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>        <not counted>      msr/tsc/                                                      (0.00%)
> 
>          0.001904106 seconds time elapsed
> 
>          0.001947000 seconds user
>          0.000000000 seconds sys
> 
>   Some events weren't counted. Try disabling the NMI watchdog:
>           echo 0 > /proc/sys/kernel/nmi_watchdog
>           perf stat ...
>           echo 1 > /proc/sys/kernel/nmi_watchdog
>   The events in group usually have to be from the same PMU. Try reorganizing the group.
> 
> Now we disable the NMI watchdog message on hybrid, otherwise there
> are too many false positives.
> 
> After:
> 
>   # ./perf stat true
> 
>    Performance counter stats for 'true':
> 
>                 0.79 msec task-clock                #    0.419 CPUs utilized
>                    0      context-switches          #    0.000 /sec
>                    0      cpu-migrations            #    0.000 /sec
>                   48      page-faults               #   60.889 K/sec
>              777,692      cpu_core/cycles/          #  986.519 M/sec
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>              669,147      cpu_core/instructions/    #  848.828 M/sec
>        <not counted>      cpu_atom/instructions/                                        (0.00%)
>              128,635      cpu_core/branches/        #  163.176 M/sec
>        <not counted>      cpu_atom/branches/                                            (0.00%)
>                4,089      cpu_core/branch-misses/   #    5.187 M/sec
>        <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>          0.001880649 seconds time elapsed
> 
>          0.001935000 seconds user
>          0.000000000 seconds sys
> 
>   # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> 
>    Performance counter stats for 'true':
> 
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>        <not counted>      msr/tsc/                                                      (0.00%)
> 
>          0.000963319 seconds time elapsed
> 
>          0.000999000 seconds user
>          0.000000000 seconds sys
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>  - If the group was mixed with hybrid event and non-hybrid event,
>    the NMI watchdog message was still reported. V2 adds checking
>    for hybrid event mixed group.
> 
> v1:
>  - Get ACK from Jiri.
> 
>  tools/perf/util/stat-display.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b759dfd633b4..c1314f13bc9a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -404,6 +404,19 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  	return false;
>  }
>  
> +static bool is_mixed_hybrid_group(struct evsel *counter)
> +{
> +	struct evlist *evlist = counter->evlist;
> +	struct evsel *pos;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (perf_pmu__is_hybrid(pos->pmu_name))
> +			return true;
> +	}

so we care if there's at least one hybrid event in the list right?
it can be all full with just hybrid events, but the function name
suggests it's mixed with normal events

jirka

> +
> +	return false;
> +}
> +
>  static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
>  		     struct evsel *counter, double uval,
>  		     char *prefix, u64 run, u64 ena, double noise,
> @@ -465,9 +478,12 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  			config->csv_sep);
>  
>  		if (counter->supported) {
> -			config->print_free_counters_hint = 1;
> -			if (is_mixed_hw_group(counter))
> -				config->print_mixed_hw_group_error = 1;
> +			if (!is_mixed_hybrid_group(counter)) {
> +				if (!perf_pmu__is_hybrid(counter->pmu_name))
> +					config->print_free_counters_hint = 1;
> +				if (is_mixed_hw_group(counter))
> +					config->print_mixed_hw_group_error = 1;
> +			}
>  		}
>  
>  		fprintf(config->output, "%-*s%s",
> -- 
> 2.17.1
> 

