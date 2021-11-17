Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61F454700
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhKQNQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhKQNQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:16:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB4161AAA;
        Wed, 17 Nov 2021 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637154811;
        bh=olbkXyELS0xNpjpLAmWhyjDXy2PWRcnXyZnSrKQnreY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwLwWuGBH3Sp49lkoeLNIyMUpmwAChGoBAqU3kw87YTbs7YqEuotoCtofD+yyBsZy
         8umJE5X8YJ558Xz30tMmqTBnjal+VqYGIaUVUd3FKKD7WY/fGXcYmRIeatRdrsoMML
         Za6kaNHkdLTmLUQ/XrSqkR2IyE+yrGxnLQ8AIycd/AdJ8STCu4POaFUDz3uzbKYWvF
         O39eOK4ysNTvjhHvcciX0gg02d8QM9FBxCBkru7nAbrltI1L40B2urlrFr3hlvqyr3
         +vGBIuTHTuEkkEq4JMKEt/CTdkYlgaqS7NtHeQcSwAO5h718zjEhwVjWrHHX8QXpWs
         O8a+TzW3hdJMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6929C4088E; Wed, 17 Nov 2021 10:13:28 -0300 (-03)
Date:   Wed, 17 Nov 2021 10:13:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [RFC 3/3] perf tools: Fix p_stage_cyc sort key behavior
Message-ID: <YZT/+K2YCsn0vUlN@kernel.org>
References: <20211105225617.151364-1-namhyung@kernel.org>
 <20211105225617.151364-3-namhyung@kernel.org>
 <5CF112C6-95B5-47C5-95B7-55129B5CB24B@linux.vnet.ibm.com>
 <YZPvWHiqmjAavQxZ@kernel.org>
 <BECFD6E5-8137-4FBD-BF4A-D8709B67650F@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BECFD6E5-8137-4FBD-BF4A-D8709B67650F@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 17, 2021 at 05:33:43PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 16-Nov-2021, at 11:20 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Tue, Nov 16, 2021 at 09:59:42PM +0530, Athira Rajeev escreveu:
> >> 
> >> 
> >>> On 06-Nov-2021, at 4:26 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>> 
> >>> Like weight and local_weight, the p_stage_cyc (for pipeline stage
> >>> cycles) should be handled the same way.  Not sure it also needs
> >>> the local and global variants.
> >> 
> >> Hi Namhyung,
> >> 
> >> Thanks for the fixes. I could test the fix for "weight" and "ins_lat" in powerpc.
> >> Also it makes sense to have global variant for p_stage_cyc as well. Thanks for pointing that. I will post fix to have both the variants for the p_stage_cyc.
> >> 
> >> Thanks
> >> Athira
> > 
> > So I'm going to wait for Namhyung's patch with some extra touches? Or is
> > thie one below good to go and you can send the other fixes in a followup
> > patch?
> > 
> > Please advise.
> > 
> > - Arnaldo
> 
> Hi Arnaldo,
> 
> Yes, this patch series looks good to me.
> 
> For this patch series,
> Reviewed-and-Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo

 
> I will send the other fixes ( for adding both variants for p_stage_cyc ) in a separate follow up patch.
> 
> Thanks,
> Athira
> > 
> >>> 
> >>> But I couldn't test it actually because I don't have the machine.
> >>> 
> >>> Cc: Kan Liang <kan.liang@linux.intel.com>
> >>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>> ---
> >>> tools/perf/util/hist.c | 12 ++++--------
> >>> tools/perf/util/sort.c |  4 ++--
> >>> tools/perf/util/sort.h |  2 +-
> >>> 3 files changed, 7 insertions(+), 11 deletions(-)
> >>> 
> >>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> >>> index 54fe97dd191c..b776465e04ef 100644
> >>> --- a/tools/perf/util/hist.c
> >>> +++ b/tools/perf/util/hist.c
> >>> @@ -289,12 +289,10 @@ static long hist_time(unsigned long htime)
> >>> 	return htime;
> >>> }
> >>> 
> >>> -static void he_stat__add_period(struct he_stat *he_stat, u64 period,
> >>> -				u64 p_stage_cyc)
> >>> +static void he_stat__add_period(struct he_stat *he_stat, u64 period)
> >>> {
> >>> 	he_stat->period		+= period;
> >>> 	he_stat->nr_events	+= 1;
> >>> -	he_stat->p_stage_cyc	+= p_stage_cyc;
> >>> }
> >>> 
> >>> static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
> >>> @@ -305,7 +303,6 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
> >>> 	dest->period_guest_sys	+= src->period_guest_sys;
> >>> 	dest->period_guest_us	+= src->period_guest_us;
> >>> 	dest->nr_events		+= src->nr_events;
> >>> -	dest->p_stage_cyc	+= src->p_stage_cyc;
> >>> }
> >>> 
> >>> static void he_stat__decay(struct he_stat *he_stat)
> >>> @@ -593,7 +590,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >>> 	struct hist_entry *he;
> >>> 	int64_t cmp;
> >>> 	u64 period = entry->stat.period;
> >>> -	u64 p_stage_cyc = entry->stat.p_stage_cyc;
> >>> 	bool leftmost = true;
> >>> 
> >>> 	p = &hists->entries_in->rb_root.rb_node;
> >>> @@ -612,11 +608,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >>> 
> >>> 		if (!cmp) {
> >>> 			if (sample_self) {
> >>> -				he_stat__add_period(&he->stat, period, p_stage_cyc);
> >>> +				he_stat__add_period(&he->stat, period);
> >>> 				hist_entry__add_callchain_period(he, period);
> >>> 			}
> >>> 			if (symbol_conf.cumulate_callchain)
> >>> -				he_stat__add_period(he->stat_acc, period, p_stage_cyc);
> >>> +				he_stat__add_period(he->stat_acc, period);
> >>> 
> >>> 			/*
> >>> 			 * This mem info was allocated from sample__resolve_mem
> >>> @@ -726,7 +722,6 @@ __hists__add_entry(struct hists *hists,
> >>> 		.stat = {
> >>> 			.nr_events = 1,
> >>> 			.period	= sample->period,
> >>> -			.p_stage_cyc = sample->p_stage_cyc,
> >>> 		},
> >>> 		.parent = sym_parent,
> >>> 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
> >>> @@ -741,6 +736,7 @@ __hists__add_entry(struct hists *hists,
> >>> 		.time = hist_time(sample->time),
> >>> 		.weight = sample->weight,
> >>> 		.ins_lat = sample->ins_lat,
> >>> +		.p_stage_cyc = sample->p_stage_cyc,
> >>> 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
> >>> 
> >>> 	if (!hists->has_callchains && he && he->callchain_size != 0)
> >>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> >>> index adc0584695d6..a111065b484e 100644
> >>> --- a/tools/perf/util/sort.c
> >>> +++ b/tools/perf/util/sort.c
> >>> @@ -1394,13 +1394,13 @@ struct sort_entry sort_global_ins_lat = {
> >>> static int64_t
> >>> sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
> >>> {
> >>> -	return left->stat.p_stage_cyc - right->stat.p_stage_cyc;
> >>> +	return left->p_stage_cyc - right->p_stage_cyc;
> >>> }
> >>> 
> >>> static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
> >>> 					size_t size, unsigned int width)
> >>> {
> >>> -	return repsep_snprintf(bf, size, "%-*u", width, he->stat.p_stage_cyc);
> >>> +	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
> >>> }
> >>> 
> >>> struct sort_entry sort_p_stage_cyc = {
> >>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> >>> index 22ae7c6ae398..7b7145501933 100644
> >>> --- a/tools/perf/util/sort.h
> >>> +++ b/tools/perf/util/sort.h
> >>> @@ -49,7 +49,6 @@ struct he_stat {
> >>> 	u64			period_us;
> >>> 	u64			period_guest_sys;
> >>> 	u64			period_guest_us;
> >>> -	u64			p_stage_cyc;
> >>> 	u32			nr_events;
> >>> };
> >>> 
> >>> @@ -109,6 +108,7 @@ struct hist_entry {
> >>> 	u64			code_page_size;
> >>> 	u64			weight;
> >>> 	u64			ins_lat;
> >>> +	u64			p_stage_cyc;
> >>> 	u8			cpumode;
> >>> 	u8			depth;
> >>> 
> >>> -- 
> >>> 2.34.0.rc0.344.g81b53c2807-goog
> >>> 
> > 
> > -- 
> > 
> > - Arnaldo
> 

-- 

- Arnaldo
