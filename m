Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830FC341911
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCSKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhCSKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616148037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MASLsHZEGznQuLxLfCT/6H7rGDKVDCQg93xYWYYSzU=;
        b=I4GIOo1623JuG+lfCzokBaJKQ4DaurAcwIe+hWXvpUYLaMjAGUtj+1XjcKKd/0X+AOOfEc
        DU3i1euFk9j5neSAtZoRqcsj6S2nM46gOlOJJmtcNNtd9++hUcNxnQ8E/u2fqehGRiTLKS
        P4if+Y3Lgj/u7+lKAVj1lIWUXg4Tg5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-dynOwjQtM3aL8w5x97ZipQ-1; Fri, 19 Mar 2021 06:00:33 -0400
X-MC-Unique: dynOwjQtM3aL8w5x97ZipQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCB81007476;
        Fri, 19 Mar 2021 10:00:32 +0000 (UTC)
Received: from krava (unknown [10.40.195.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9652D4F3C6;
        Fri, 19 Mar 2021 10:00:30 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:00:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND PATCH v2] perf stat: improve readability of shadow stats
Message-ID: <YFR2PbJ+zRLunsR1@krava>
References: <20210315143047.3867-1-changbin.du@gmail.com>
 <YFC4ZTOhm61QWDgh@krava>
 <20210318151240.ms4ic6xfa4xx7t2u@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318151240.ms4ic6xfa4xx7t2u@mail.google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:12:40PM +0800, Changbin Du wrote:
> On Tue, Mar 16, 2021 at 02:53:41PM +0100, Jiri Olsa wrote:
> > On Mon, Mar 15, 2021 at 10:30:47PM +0800, Changbin Du wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > > index 6ccf21a72f06..3f800e71126f 100644
> > > --- a/tools/perf/util/stat-shadow.c
> > > +++ b/tools/perf/util/stat-shadow.c
> > > @@ -9,6 +9,7 @@
> > >  #include "expr.h"
> > >  #include "metricgroup.h"
> > >  #include "cgroup.h"
> > > +#include "units.h"
> > >  #include <linux/zalloc.h>
> > >  
> > >  /*
> > > @@ -1270,18 +1271,15 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> > >  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> > >  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> > >  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > > -		char unit = 'M';
> > > -		char unit_buf[10];
> > > +		char unit = ' ';
> > > +		char unit_buf[10] = "/sec";
> > >  
> > >  		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > > -
> > >  		if (total)
> > > -			ratio = 1000.0 * avg / total;
> > > -		if (ratio < 0.001) {
> > > -			ratio *= 1000;
> > > -			unit = 'K';
> > > -		}
> > > -		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > > +			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > > +
> > > +		if (unit != ' ')
> > > +			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > >  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> > 
> > hum, does this still change the metric unit in the csv output? 'perf -a -x,'
> >
> The unit is changed in csv format, too. See below.
> 
> before:
> $ sudo ./perf stat -a -x, -- sleep 1
> 8037.85,msec,cpu-clock,8037851596,100.00,7.999,CPUs utilized
> 714,,context-switches,8037838466,100.00,0.089,K/sec
> 11,,cpu-migrations,8037832590,100.00,0.001,K/sec
> 71,,page-faults,8037824974,100.00,0.009,K/sec
> 84033551,,cycles,8037750471,100.00,0.010,GHz
> 22563553,,instructions,8037733879,100.00,0.27,insn per cycle
> 4685736,,branches,8037708301,100.00,0.583,M/sec
> 356327,,branch-misses,8037667950,100.00,7.60,of all branches
> 
> after:
> $ sudo ./perf stat -a -x, -- sleep 1
> 8026.19,msec,cpu-clock,8026194365,100.00,7.983,CPUs utilized
> 621,,context-switches,8026178186,100.00,77.372,/sec
> 16,,cpu-migrations,8026172135,100.00,1.993,/sec
> 73,,page-faults,8026142626,100.00,9.095,/sec
> 92645028,,cycles,8026066285,100.00,0.012,GHz
> 56268285,,instructions,8026048894,100.00,0.61,insn per cycle
> 10979859,,branches,8026022127,100.00,1.368,M/sec
> 441719,,branch-misses,8025981169,100.00,4.02,of all branches
> 
> But is this a real problem?

perhaps not, Andi, any idea about this?

thanks,
jirka

