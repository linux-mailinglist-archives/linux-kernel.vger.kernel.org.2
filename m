Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEF33D53E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhCPNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235566AbhCPNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615902828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fjg9zTn3hH4sazhIpCESgskhJWxtQP+Lj93o8a/n5Q0=;
        b=Ig1vRLjQ3Zv33epZh7GrSy46ciRpBJLev9HyX+/SC88ZFVHF82l+T0mZCiSFQO540E5qfZ
        dmw8Ucp66mXCiRV3D0Z0BGviWgP4eFUoK48X3tcnYM9ppSHN24GTWSp/aRQ1R+2X0xmQc4
        /R8RWPEOlfmnvCm0cC1TWBwuEWVZg00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-KWfOWIm7ODeS5FviAlH32g-1; Tue, 16 Mar 2021 09:53:45 -0400
X-MC-Unique: KWfOWIm7ODeS5FviAlH32g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248AF84B9AB;
        Tue, 16 Mar 2021 13:53:44 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDAFC5C1A1;
        Tue, 16 Mar 2021 13:53:42 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:53:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] perf stat: improve readability of shadow stats
Message-ID: <YFC4ZTOhm61QWDgh@krava>
References: <20210315143047.3867-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315143047.3867-1-changbin.du@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:30:47PM +0800, Changbin Du wrote:

SNIP

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 6ccf21a72f06..3f800e71126f 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -9,6 +9,7 @@
>  #include "expr.h"
>  #include "metricgroup.h"
>  #include "cgroup.h"
> +#include "units.h"
>  #include <linux/zalloc.h>
>  
>  /*
> @@ -1270,18 +1271,15 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> -		char unit = 'M';
> -		char unit_buf[10];
> +		char unit = ' ';
> +		char unit_buf[10] = "/sec";
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
> +		if (unit != ' ')
> +			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
>  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);

hum, does this still change the metric unit in the csv output? 'perf -a -x,'

jirka

>  	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
>  		print_smi_cost(config, cpu, out, st, &rsd);
> diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> index a46762aec4c9..32c39cfe209b 100644
> --- a/tools/perf/util/units.c
> +++ b/tools/perf/util/units.c

SNIP

