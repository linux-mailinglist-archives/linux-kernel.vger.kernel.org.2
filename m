Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A15355543
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbhDFNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243941AbhDFNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617716069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0Jdnzafbs6n+Z5KUUUKvvir1l+H0uK55dPK2XrwHg8=;
        b=YYeIPdXgCeXgJr7dge274/7OP7FhwVNkWqu3vIOJjHxRlDtGu+4/1Ya1aK9B8VGGsaXirs
        fusfovCxweIIKsy29IuISSunVvbX7aq1CU9NYVgfH/zJ8WcRUvE/rbSSU/4QFjvqb+1FO+
        ntI/ZlSSNfk22ek6WoFj8kp1WkcHiNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-JUHMKNzwPgWPqXPg9zEL_g-1; Tue, 06 Apr 2021 09:34:25 -0400
X-MC-Unique: JUHMKNzwPgWPqXPg9zEL_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1338C612AB;
        Tue,  6 Apr 2021 13:34:22 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB56D6EF42;
        Tue,  6 Apr 2021 13:34:17 +0000 (UTC)
Date:   Tue, 6 Apr 2021 15:34:16 +0200
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
Message-ID: <YGxjWNdZGqWqL87r@krava>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-3-git-send-email-john.garry@huawei.com>
 <YGXPdEAecos4iPVc@krava>
 <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
 <YGxRbH0XWaj6AWfa@krava>
 <f5b209b2-1e9e-ebad-b2ed-eda9fe858ec8@huawei.com>
 <YGxaOnUZnNmDg/2P@krava>
 <49025439-f9e3-0d32-b0a3-ff9f9ff71835@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49025439-f9e3-0d32-b0a3-ff9f9ff71835@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 02:21:11PM +0100, John Garry wrote:
> On 06/04/2021 13:55, Jiri Olsa wrote:
> > > > > So expr__find_other() may add a new item to pctx->ids, and we always iterate
> > > > > again, and try to lookup any pmu_events, *, above. If none exist, then we
> > > > hm, I don't see that.. so, what you do is:
> > > > 
> > > > 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> > > > 
> > > > 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > > > 	}
> > > > 
> > > > and what I think we need to do is:
> > > > 
> > > > 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> > > > 
> > > > 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > > > 
> > > > 		break;	
> > > > 	}
> > > > 
> > > > each time you resolve another metric, you need to restart
> > > > the pctx->ids iteration, because there will be new items,
> > > > and we are in the middle of it
> > > Sure, but we will restart anyway.
> > hum, where? you call expr__find_other and continue to next
> > pctx->ids item
> 
> We have:
> 
> resolve_metric_simple()
> {
> 	bool all;
> 
> 	do {
> 		all = true;
> 
> 		hashmap__for_each_entry_safe(&pctx->ids, ...) {
> 
> 			pe = metricgroup_find_metric(cur->key, map);
> 			if (!pe)
> 				continue;
> 
> 			...
> 			all = false;
> 
> 			expr_del_id(pctx, cur->key);
> 
> 			...
> 			rc = expr__find_other(pe->metric_expr, pctx);
> 			if (rc)
> 				goto out_err;
> 		}
> 
> 	} while (!all);
> 
> }
> 
> So once we evaluate a pmu_event in pctx->ids in @pe, @all is set false, and
> we would loop again in the do-while loop, regardless of what
> expr__find_other() does (apart from erroring), and so call
> hashmap__for_each_entry_safe(&pctx->ids, ) again.

ah ok, so it finishes the hash iteration first and
then restarts it.. ok, I missed that, then it's fine

> 
> This is really what is done in __resolve_metric() - indeed, I would use that
> function directly, but it looks hard to extract that from metricgroup.c .

yea, it's another world ;-) it's better to keep it separated

thanks,
jirka

> 
> Thanks,
> John
> 
> > 
> > > Regardless of this, I don't think what I am doing is safe, i.e. adding new
> > > items in the middle of the iter, so I will change in the way you suggest.
> > it'll always add items in the middle of the iteration
> 

