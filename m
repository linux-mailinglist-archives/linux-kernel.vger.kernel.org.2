Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0991535537A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbhDFMSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhDFMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617711479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wprcRBvRmy1yb6AHqmns5Q7Gv5cKrN3fWQQ2B1NHdTE=;
        b=BMhepTJ456eaxu9k2rNnKX7nUsGmn765nnTfDgH0kjxbn5bT2ipxJsjeSXeo56lR2gDvdm
        Gf6+6oNRpt0077uLc/ANaTFyglIdSZcKpdkFe6C/+xQ4gWuOxOqj02W5R2WdlTa6d5zBji
        YZ6yyr62HZWf4E/z/zKnkPS/IO1GPjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-SWRcYkQpNX67MADB_OtpMw-1; Tue, 06 Apr 2021 08:17:55 -0400
X-MC-Unique: SWRcYkQpNX67MADB_OtpMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2360612A2;
        Tue,  6 Apr 2021 12:17:52 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 01EC1610F0;
        Tue,  6 Apr 2021 12:17:48 +0000 (UTC)
Date:   Tue, 6 Apr 2021 14:17:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, linuxarm@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, pc@us.ibm.com
Subject: Re: [PATCH v2 2/6] perf test: Handle metric reuse in pmu-events
 parsing test
Message-ID: <YGxRbH0XWaj6AWfa@krava>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-3-git-send-email-john.garry@huawei.com>
 <YGXPdEAecos4iPVc@krava>
 <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:00:27PM +0100, John Garry wrote:
> On 01/04/2021 14:49, Jiri Olsa wrote:
> > On Thu, Mar 25, 2021 at 06:33:14PM +0800, John Garry wrote:
> > 
> > SNIP
> > 
> > > +struct metric {
> > > +	struct list_head list;
> > > +	struct metric_ref metric_ref;
> > > +};
> > > +
> > > +static int resolve_metric_simple(struct expr_parse_ctx *pctx,
> > > +				 struct list_head *compound_list,
> > > +				 struct pmu_events_map *map,
> > > +				 const char *metric_name)
> > > +{
> > > +	struct hashmap_entry *cur, *cur_tmp;
> > > +	struct metric *metric, *tmp;
> > > +	size_t bkt;
> > > +	bool all;
> > > +	int rc;
> > > +
> > > +	do {
> > > +		all = true;
> > > +		hashmap__for_each_entry_safe((&pctx->ids), cur, cur_tmp, bkt) {
> > > +			struct metric_ref *ref;
> > > +			struct pmu_event *pe;
> > > +
> > > +			pe = metrcgroup_find_metric(cur->key, map);
> 
> *
> 
> > > +			if (!pe)
> > > +				continue;
> > > +
> > > +			if (!strcmp(metric_name, (char *)cur->key)) {
> > > +				pr_warning("Recursion detected for metric %s\n", metric_name);
> > > +				rc = -1;
> > > +				goto out_err;
> > > +			}
> > > +
> > > +			all = false;
> > > +
> > > +			/* The metric key itself needs to go out.. */
> > > +			expr__del_id(pctx, cur->key);
> > > +
> > > +			metric = malloc(sizeof(*metric));
> > > +			if (!metric) {
> > > +				rc = -ENOMEM;
> > > +				goto out_err;
> > > +			}
> > > +
> > > +			ref = &metric->metric_ref;
> > > +			ref->metric_name = pe->metric_name;
> > > +			ref->metric_expr = pe->metric_expr;
> > > +			list_add_tail(&metric->list, compound_list);
> > > +
> > > +			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > 
> 
> Hi Jirka,
> 
> > so this might add new items to pctx->ids, I think you need
> > to restart the iteration as we do it in __resolve_metric
> > otherwise you could miss some new keys
> 
> I thought that I was doing this. Indeed, this code is very much like
> __resolve_metric() ;)
> 
> So expr__find_other() may add a new item to pctx->ids, and we always iterate
> again, and try to lookup any pmu_events, *, above. If none exist, then we

hm, I don't see that.. so, what you do is:

	hashmap__for_each_entry_safe((&pctx->ids) ....) {

		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
	}

and what I think we need to do is:

	hashmap__for_each_entry_safe((&pctx->ids) ....) {

		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);

		break;	
	}

each time you resolve another metric, you need to restart
the pctx->ids iteration, because there will be new items,
and we are in the middle of it

jirka


> have broken down pctx into primitive events aliases and unresolvable
> metrics, and stop iterating. And then unresolvable metrics would be found in
> check_parse_cpu().
> 
> As an example, we can deal with metric test1, below, which references 2x
> other metrics:
> 
>     {
>         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( (
> CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /
> CPU_CLK_UNHALTED.REF_XCLK ) )))",
>       "MetricName": "Frontend_Bound",
>     },
>     {
>         "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *
> INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
>         "MetricName": "Bad_Speculation",
>     },
>     {
>         "MetricExpr": "Bad_Speculation + Frontend_Bound",
>         "MetricName": "test1",
>     },
> 
> Does that satisfy your concern, or have I missed something?
> 
> Thanks,
> John
> 
> > 
> > jirka
> > 
> > > +			if (rc)
> > > +				goto out_err;
> > > +		}
> > > +	} while (!all);
> > > +
> > > +	return 0;
> > > +
> > > +out_err:
> > > +	list_for_each_entry_safe(metric, tmp, compound_list, list)
> > > +		free(metric);
> > > +
> > > +	return rc;
> > > +
> > > +}
> > 
> > SNIP
> > 
> > .
> > 
> 

