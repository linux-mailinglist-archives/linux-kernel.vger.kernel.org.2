Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6033C99B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhCOXEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232632AbhCOXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePjYhzTM+IV1p35DPdjcqxa6QQVfdncPNyzo8YHJDY0=;
        b=eL9wRgrIiKpLvM87CsgBPmSvRx9/JphHMyeknQRWIgl8CxU+3+y3z2DAAVps6DFSPHHx9h
        Q23u2aBXL9HOHg/JhbnZZFWtGQQar0K6/gBvoQmdWt2kbPCLAz9JBY/E6i9oSdY4ifgU+5
        lcBAG5ljSt2UvXyqQc09H0rOqF9ymCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-qYLTSeW_OoyhPaUgJ7VoYQ-1; Mon, 15 Mar 2021 19:04:04 -0400
X-MC-Unique: qYLTSeW_OoyhPaUgJ7VoYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96C1292507;
        Mon, 15 Mar 2021 23:04:02 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8CCB25C5E0;
        Mon, 15 Mar 2021 23:04:00 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:03:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 04/27] perf pmu: Save pmu name
Message-ID: <YE/n3yfo37V+cigN@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-5-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:19PM +0800, Jin Yao wrote:
> On hybrid platform, one event is available on one pmu
> (such as, available on cpu_core or on cpu_atom).
> 
> This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
> Then next we can know the pmu which the event can be available on.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/pmu.c | 10 +++++++++-
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 54e586bf19a5..45d8db1af8d2 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -283,6 +283,7 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>  	zfree(&newalias->str);
>  	zfree(&newalias->metric_expr);
>  	zfree(&newalias->metric_name);
> +	zfree(&newalias->pmu);
>  	parse_events_terms__purge(&newalias->terms);
>  	free(newalias);
>  }
> @@ -297,6 +298,10 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>  
>  	list_for_each_entry(a, alist, list) {
>  		if (!strcasecmp(newalias->name, a->name)) {
> +			if (newalias->pmu && a->pmu &&
> +			    !strcasecmp(newalias->pmu, a->pmu)) {
> +				continue;
> +			}
>  			perf_pmu_update_alias(a, newalias);
>  			perf_pmu_free_alias(newalias);
>  			return true;
> @@ -314,7 +319,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  	int num;
>  	char newval[256];
>  	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
> -	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL;
> +	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL,
> +	     *pmu = NULL;
>  
>  	if (pe) {
>  		long_desc = (char *)pe->long_desc;
> @@ -324,6 +330,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  		metric_expr = (char *)pe->metric_expr;
>  		metric_name = (char *)pe->metric_name;
>  		deprecated = (char *)pe->deprecated;
> +		pmu = (char *)pe->pmu;
>  	}
>  
>  	alias = malloc(sizeof(*alias));
> @@ -389,6 +396,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  	}
>  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>  	alias->str = strdup(newval);
> +	alias->pmu = pmu ? strdup(pmu) : NULL;
>  
>  	if (deprecated)
>  		alias->deprecated = true;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 8164388478c6..0e724d5b84c6 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -72,6 +72,7 @@ struct perf_pmu_alias {
>  	bool deprecated;
>  	char *metric_expr;
>  	char *metric_name;
> +	char *pmu;

please use pmu_name

thanks,
jirka

