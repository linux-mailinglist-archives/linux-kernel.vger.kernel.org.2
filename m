Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33462329BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhCBBmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241386AbhCATVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614626366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DDkyV6tz+MJgp4h3wX2T3IUSZ6ae6unSWV8DQVGZ72E=;
        b=KXEWLGxjdKRznKUy5kMJh6vIUA1O1n8wOkxMfaMGDgH/WHDwS+kXr4BhUFmoVeHbChRCJ/
        yCQkDmNSKZ1rQ2BbPooPauk02btVauEIE0bPkE5PWwnm0f8vFbZ5+e7mr5yAvJbNMrUb4Z
        wlxSIAd/C6ygbdzNrBuLMUyzPbaAJyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-31VzmOtGPde7jHlvKBD1Xw-1; Mon, 01 Mar 2021 14:19:24 -0500
X-MC-Unique: 31VzmOtGPde7jHlvKBD1Xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1976585B664;
        Mon,  1 Mar 2021 19:19:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.173])
        by smtp.corp.redhat.com (Postfix) with SMTP id 50CD819D6C;
        Mon,  1 Mar 2021 19:19:21 +0000 (UTC)
Date:   Mon, 1 Mar 2021 20:19:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
Message-ID: <YD0+OAH9Ytii3b3V@krava>
References: <20210301172402.6794-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301172402.6794-1-changbin.du@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 01:24:02AM +0800, Changbin Du wrote:
> This does follow two changes:
>   1) Select appropriate unit between K/M/G.
>   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> 
> $ sudo ./perf stat -a -- sleep 1
> 
> Before: Unit 'M' is selected even the number is very small.
>  Performance counter stats for 'system wide':
> 
>           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
>             16,179      context-switches          #    0.004 M/sec
>                161      cpu-migrations            #    0.040 K/sec
>              4,699      page-faults               #    0.001 M/sec
>      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
>      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
>      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
>      4,720,130,587      instructions              #    0.77  insn per cycle
>                                                   #    1.23  stalled cycles per insn  (83.28%)
>        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
>         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> 
>        1.001283725 seconds time elapsed
> 
> After:
> $ sudo ./perf stat -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
>              9,768      context-switches          #    1.221 K/cpu-sec
>                164      cpu-migrations            #   20.492  /cpu-sec

should you remove also the leading '/' in ' /cpu-sec' ?


SNIP

> @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> -		char unit = 'M';
> +		char unit = ' ';
>  		char unit_buf[10];
>  
>  		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> -
>  		if (total)
> -			ratio = 1000.0 * avg / total;
> -		if (ratio < 0.001) {
> -			ratio *= 1000;
> -			unit = 'K';
> -		}
> -		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> +			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> +
> +		snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
>  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);

hum this will change -x output that people parse, so I don't think we can do that

>  	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
>  		print_smi_cost(config, cpu, out, st, &rsd);
> diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> index a46762aec4c9..ac13b5ecde31 100644
> --- a/tools/perf/util/units.c
> +++ b/tools/perf/util/units.c
> @@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
>  	return value;
>  }
>  
> +double convert_unit_double(double value, char *unit)
> +{
> +	*unit = ' ';
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'K';
> +	}
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'M';
> +	}
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'G';
> +	}
> +
> +	return value;
> +}

we have convert_unit function just above doing the same only with
unsigned long.. let's have one base function with double values and
another one casting the result to unsigned long

jirka

