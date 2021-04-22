Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27C367E98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhDVK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235800AbhDVK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619087135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tAr4cbHX1kFNkbpcO64MqXs1SkyHznjECtrNCMwaGw=;
        b=OaNvweDX55n3zL7ypdqypncsSbNCkWFgY+ZwWETMuNpFlahMtcS613xc8hgqfcW7oIhbdw
        3am0Cn/5sxMv3cAuxz6SouMD+0UvcBqJOMPtSFlZKkSuF/q4DgzyFYmzYDPrMJ5SNL7HJM
        bbET/pvGWm+YIuCKBGtCfQ/N7OUnt7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-TIHJWnvmNHmgjquXhutEzw-1; Thu, 22 Apr 2021 06:25:32 -0400
X-MC-Unique: TIHJWnvmNHmgjquXhutEzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA8F1006C8B;
        Thu, 22 Apr 2021 10:25:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 745695C1D5;
        Thu, 22 Apr 2021 10:25:28 +0000 (UTC)
Date:   Thu, 22 Apr 2021 12:25:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 14/25] perf stat: Add default hybrid events
Message-ID: <YIFPF/RFVJmztd5b@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-15-yao.jin@linux.intel.com>
 <YIBvGk7qZiqMHxkt@krava>
 <59ded117-6f3c-f11f-8fe3-6b0e8f68c823@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ded117-6f3c-f11f-8fe3-6b0e8f68c823@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:12:49AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> > On Fri, Apr 16, 2021 at 10:05:06PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 1255af4751c2..0351b99d17a7 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -1145,6 +1145,13 @@ static int parse_stat_cgroups(const struct option *opt,
> > >   	return parse_cgroups(opt, str, unset);
> > >   }
> > > +static int add_default_hybrid_events(struct evlist *evlist)
> > > +{
> > > +	struct parse_events_error err;
> > > +
> > > +	return parse_events(evlist, "cycles,instructions,branches,branch-misses", &err);
> > > +}
> > > +
> > >   static struct option stat_options[] = {
> > >   	OPT_BOOLEAN('T', "transaction", &transaction_run,
> > >   		    "hardware transaction statistics"),
> > > @@ -1626,6 +1633,12 @@ static int add_default_attributes(void)
> > >     { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
> > >     { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
> > > +};
> > > +	struct perf_event_attr default_sw_attrs[] = {
> > > +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
> > > +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
> > > +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
> > > +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
> > 
> > hum, why not use default_attrs0, it's the same, no?
> > 
> 
> The default_attrs0 has one more item " {.type = PERF_TYPE_HARDWARE, .config
> = PERF_COUNT_HW_CPU_CYCLES },"
> 
> So I have to only pick out the sw attrs and save them to default_sw_attrs.
> 
> > >   };
> > >   /*
> > > @@ -1863,6 +1876,14 @@ static int add_default_attributes(void)
> > >   	}
> > >   	if (!evsel_list->core.nr_entries) {
> > > +		if (perf_pmu__has_hybrid()) {
> > > +			if (evlist__add_default_attrs(evsel_list,
> > > +						      default_sw_attrs) < 0) {
> > > +				return -1;
> > > +			}
> > > +			return add_default_hybrid_events(evsel_list);
> > 
> > please do it the same way like when topdown calls parse events,
> > we don't need to check for cycles, but please check result and
> > display the error
> > 
> 
> Something like this?
> 
> err = parse_events(evsel_list, "cycles,instructions,branches,branch-misses", &errinfo);
> if (err) {
> 	fprintf(stderr,...);
> 	parse_events_print_error(&errinfo, ...);
> 	return -1;
> }

yes

jirka

