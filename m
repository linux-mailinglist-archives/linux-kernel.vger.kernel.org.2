Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3779C351B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhDASG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234724AbhDARwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J59mviOinQtGL5knvSCm5IlcQ3vnWMamNF8NZHi8YX8=;
        b=fZfXPLpbm8pCVZs85AGWkDFp7+IKLrVvw2MyQg/3Td62LPZWXIbquRwe0+QEr8ddJHbkcH
        KNT2N3T+GpLR/jkug3yYVEA8GqT5VCYVGz1SDQYPOSJ0jPUGbrLuaFEyyZ7hM/r3MeN70/
        IZIRMH9w70Ik/VTwV3sdBmRWAOAncDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-1HT9BmJQP1SZUDCW7XGgkw-1; Thu, 01 Apr 2021 09:49:48 -0400
X-MC-Unique: 1HT9BmJQP1SZUDCW7XGgkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4348C1009E29;
        Thu,  1 Apr 2021 13:49:45 +0000 (UTC)
Received: from krava (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3A6B35C237;
        Thu,  1 Apr 2021 13:49:40 +0000 (UTC)
Date:   Thu, 1 Apr 2021 15:49:40 +0200
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
Message-ID: <YGXPdEAecos4iPVc@krava>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616668398-144648-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:33:14PM +0800, John Garry wrote:

SNIP

> +struct metric {
> +	struct list_head list;
> +	struct metric_ref metric_ref;
> +};
> +
> +static int resolve_metric_simple(struct expr_parse_ctx *pctx,
> +				 struct list_head *compound_list,
> +				 struct pmu_events_map *map,
> +				 const char *metric_name)
> +{
> +	struct hashmap_entry *cur, *cur_tmp;
> +	struct metric *metric, *tmp;
> +	size_t bkt;
> +	bool all;
> +	int rc;
> +
> +	do {
> +		all = true;
> +		hashmap__for_each_entry_safe((&pctx->ids), cur, cur_tmp, bkt) {
> +			struct metric_ref *ref;
> +			struct pmu_event *pe;
> +
> +			pe = metrcgroup_find_metric(cur->key, map);
> +			if (!pe)
> +				continue;
> +
> +			if (!strcmp(metric_name, (char *)cur->key)) {
> +				pr_warning("Recursion detected for metric %s\n", metric_name);
> +				rc = -1;
> +				goto out_err;
> +			}
> +
> +			all = false;
> +
> +			/* The metric key itself needs to go out.. */
> +			expr__del_id(pctx, cur->key);
> +
> +			metric = malloc(sizeof(*metric));
> +			if (!metric) {
> +				rc = -ENOMEM;
> +				goto out_err;
> +			}
> +
> +			ref = &metric->metric_ref;
> +			ref->metric_name = pe->metric_name;
> +			ref->metric_expr = pe->metric_expr;
> +			list_add_tail(&metric->list, compound_list);
> +
> +			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);

so this might add new items to pctx->ids, I think you need
to restart the iteration as we do it in __resolve_metric
otherwise you could miss some new keys

jirka

> +			if (rc)
> +				goto out_err;
> +		}
> +	} while (!all);
> +
> +	return 0;
> +
> +out_err:
> +	list_for_each_entry_safe(metric, tmp, compound_list, list)
> +		free(metric);
> +
> +	return rc;
> +
> +}

SNIP

