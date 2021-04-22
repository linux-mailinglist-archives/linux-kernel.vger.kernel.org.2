Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88C5367E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhDVK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235802AbhDVK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619087196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdNX81TA2nsY/g2eFhNoJTLXu0bpy7LKXmWqnDKmCf0=;
        b=AomGu56poyY3CqnKQpJfyGdOgruXqcsAOmnV9gU3zA7jA96MOiBmPutldZPQdub4TYO2R0
        RLg+gt/Hj65rut/F2PIGCmXhk5V0LlK6GfC5UivDavxq45pXvsfP0xKUMf1YU3lnLrMmg4
        SegnfDm5toZaKNKtf3Y67JT0VKdNQ38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-BMDoKYB2NRmvajXvcqf-AQ-1; Thu, 22 Apr 2021 06:26:30 -0400
X-MC-Unique: BMDoKYB2NRmvajXvcqf-AQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3F7107ACCD;
        Thu, 22 Apr 2021 10:26:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 88F33610F3;
        Thu, 22 Apr 2021 10:26:23 +0000 (UTC)
Date:   Thu, 22 Apr 2021 12:26:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 15/25] perf stat: Filter out unmatched aggregation for
 hybrid event
Message-ID: <YIFPTrp/Fw8uEYQg@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-16-yao.jin@linux.intel.com>
 <YIBvJLAvL0rWGhhP@krava>
 <1da39794-bdc3-2a9d-4038-9e95e2c02660@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da39794-bdc3-2a9d-4038-9e95e2c02660@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:10:54AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> > On Fri, Apr 16, 2021 at 10:05:07PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 5255d78b1c30..15eafd249e46 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -643,6 +643,20 @@ static void aggr_cb(struct perf_stat_config *config,
> > >   	}
> > >   }
> > > +static bool aggr_id_hybrid_matched(struct perf_stat_config *config,
> > > +				   struct evsel *counter, struct aggr_cpu_id id)
> > > +{
> > > +	struct aggr_cpu_id s;
> > > +
> > > +	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
> > > +		s = config->aggr_get_id(config, evsel__cpus(counter), i);
> > > +		if (cpu_map__compare_aggr_cpu_id(s, id))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > >   static void print_counter_aggrdata(struct perf_stat_config *config,
> > >   				   struct evsel *counter, int s,
> > >   				   char *prefix, bool metric_only,
> > > @@ -656,6 +670,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> > >   	double uval;
> > >   	ad.id = id = config->aggr_map->map[s];
> > > +
> > > +	if (perf_pmu__has_hybrid() &&
> > > +	    !aggr_id_hybrid_matched(config, counter, id)) {
> > > +		return;
> > > +	}
> > > +
> > >   	ad.val = ad.ena = ad.run = 0;
> > >   	ad.nr = 0;
> > >   	if (!collect_data(config, counter, aggr_cb, &ad))
> > 
> > there's same check in aggr_cb, so it seems like we could just make check in here:
> > 
> > 	if (perf_pmu__has_hybrid() && ad.ena == 0)
> > 		return;
> > 
> > without another extra loop
> > 
> > jirka
> > 
> 
> I guess you recommended the patch like this:
> 
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
>                                    char *prefix, bool metric_only,
> @@ -670,17 +656,14 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         double uval;
> 
>         ad.id = id = config->aggr_map->map[s];
>         ad.val = ad.ena = ad.run = 0;
>         ad.nr = 0;
>         if (!collect_data(config, counter, aggr_cb, &ad))
>                 return;
> 
> +       if (perf_pmu__has_hybrid() && ad.ena == 0)
> +               return;
> +
>         nr = ad.nr;
>         ena = ad.ena;
>         run = ad.run;
> 
> Yes, it works. The test log is,

ok, great

thanks,
jirka

> 
> # perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0           2          2,341,923      cpu_core/cycles/
> S0-D0-C4           2          1,707,933      cpu_core/cycles/
> S0-D0-C8           2            845,805      cpu_core/cycles/
> S0-D0-C12          2          1,001,961      cpu_core/cycles/
> S0-D0-C16          2            932,004      cpu_core/cycles/
> S0-D0-C20          2          1,778,603      cpu_core/cycles/
> S0-D0-C24          2            804,448      cpu_core/cycles/
> S0-D0-C28          2            178,360      cpu_core/cycles/
> 
>        1.002264168 seconds time elapsed
> 
> Thanks
> Jin Yao
> 

