Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD132BFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579191AbhCCSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346583AbhCCQ1l (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:27:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0848664E74;
        Wed,  3 Mar 2021 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614788815;
        bh=KzB1FkJzW7nzVqL2o8kMys+kWZlxQ8E6TTgUap0HDIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4lM2ZdJ/8il4sUIDB+0SwFwoE8vVMBES3FgGSC0KhWyha5V6O+AxIu+IbNeNCuMO
         nmHGaOlOK0ncj8QVNGsiu8+jG3mJpdwTlkdw4W3EiN0XkExtiolVN1KoTnO5wUCZSS
         uI5cmqPK5DvudHtpqYNvGr6b4zsL46lbODMUBAVgij4a2RqBasMriaklcQT4XJGxFl
         K8tBH3ViFwgixAIYTvSGLzrgeTYbK+bnn9pz55LuOFn+VLaNbGBVq2M7MrB/IoFmqN
         BnX/fefAPMHCOPNrYRjfo8YMj+wOA/GF7vHua6YBZHtY9oc5LtjzX3ZE5rS7dun6ea
         ERYEn7yQBXYAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46A4C4038F; Wed,  3 Mar 2021 13:26:52 -0300 (-03)
Date:   Wed, 3 Mar 2021 13:26:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Create option to disable raw event ordering
Message-ID: <YD+4zN200OPIlqo0@kernel.org>
References: <20210219070005.12397-1-yao.jin@linux.intel.com>
 <YDQi+OxAq256vbKP@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDQi+OxAq256vbKP@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 22, 2021 at 10:32:40PM +0100, Jiri Olsa escreveu:
> On Fri, Feb 19, 2021 at 03:00:05PM +0800, Jin Yao wrote:
> > Warning "dso not found" is reported when using "perf report -D".
> > 
> >  66702781413407 0x32c0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x2): 28177/28177: 0x55e493e00563 period: 106578 addr: 0
> >   ... thread: perf:28177
> >   ...... dso: <not found>
> > 
> >  66702727832429 0x9dd8 [0x38]: PERF_RECORD_COMM exec: triad_loop:28177/28177
> > 
> > The PERF_RECORD_SAMPLE event (timestamp: 66702781413407) should be after the
> > PERF_RECORD_COMM event (timestamp: 66702727832429), but it's early processed.
> > 
> > So for most of cases, it makes sense to keep the event ordered even for dump
> > mode. But it would be also useful to disable ordered_events for reporting raw
> > dump to see events as they are stored in the perf.data file.
> > 
> > So now, set ordered_events by default to true and add a new option
> > 'disable-order' to disable it. For example,
> > 
> > perf report -D --disable-order
> > 
> > Fixes: 977f739b7126b ("perf report: Disable ordered_events for raw dump")
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/core.

- Arnaldo

 
> thanks,
> jirka
> 
> 
> > ---
> >  tools/perf/Documentation/perf-report.txt | 3 +++
> >  tools/perf/builtin-report.c              | 5 ++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > index f546b5e9db05..87112e8d904e 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -224,6 +224,9 @@ OPTIONS
> >  --dump-raw-trace::
> >          Dump raw trace in ASCII.
> >  
> > +--disable-order::
> > +	Disable raw trace ordering.
> > +
> >  -g::
> >  --call-graph=<print_type,threshold[,print_limit],order,sort_key[,branch],value>::
> >          Display call chains using type, min percent threshold, print limit,
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 2a845d6cac09..0d65c98794a8 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -84,6 +84,7 @@ struct report {
> >  	bool			nonany_branch_mode;
> >  	bool			group_set;
> >  	bool			stitch_lbr;
> > +	bool			disable_order;
> >  	int			max_stack;
> >  	struct perf_read_values	show_threads_values;
> >  	struct annotation_options annotation_opts;
> > @@ -1296,6 +1297,8 @@ int cmd_report(int argc, const char **argv)
> >  	OPTS_EVSWITCH(&report.evswitch),
> >  	OPT_BOOLEAN(0, "total-cycles", &report.total_cycles_mode,
> >  		    "Sort all blocks by 'Sampled Cycles%'"),
> > +	OPT_BOOLEAN(0, "disable-order", &report.disable_order,
> > +		    "Disable raw trace ordering"),
> >  	OPT_END()
> >  	};
> >  	struct perf_data data = {
> > @@ -1329,7 +1332,7 @@ int cmd_report(int argc, const char **argv)
> >  	if (report.mmaps_mode)
> >  		report.tasks_mode = true;
> >  
> > -	if (dump_trace)
> > +	if (dump_trace && report.disable_order)
> >  		report.tool.ordered_events = false;
> >  
> >  	if (quiet)
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
