Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0592035544C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhDFMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbhDFMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617713733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMmsc41eqctpVkzPL+JoDmYt5x6xCyCRYplYE68RQiQ=;
        b=NMyulwd7NU2Syfok57gX9T4+m6iyFeUXzHT4stlhrhsQv7BSEDN7kVbAGgQbXobwdGYUhz
        KzBZESndJ9DisbmjcoNm/9nZGw4l2c8kgOkw8XNyEz+z3ctNVG6oxNmD+rlNWt+TUdLiQR
        GYK1q1oSbzKcOjtZdSwmbX+aGI8X20o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-wnPWQRIdP3eCSTi9hvlIwQ-1; Tue, 06 Apr 2021 08:55:29 -0400
X-MC-Unique: wnPWQRIdP3eCSTi9hvlIwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E8E98189C7;
        Tue,  6 Apr 2021 12:55:27 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA49B1B528;
        Tue,  6 Apr 2021 12:55:23 +0000 (UTC)
Date:   Tue, 6 Apr 2021 14:55:22 +0200
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
Message-ID: <YGxaOnUZnNmDg/2P@krava>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-3-git-send-email-john.garry@huawei.com>
 <YGXPdEAecos4iPVc@krava>
 <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
 <YGxRbH0XWaj6AWfa@krava>
 <f5b209b2-1e9e-ebad-b2ed-eda9fe858ec8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b209b2-1e9e-ebad-b2ed-eda9fe858ec8@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:43:09PM +0100, John Garry wrote:
> On 06/04/2021 13:17, Jiri Olsa wrote:
> > > > > +			ref = &metric->metric_ref;
> > > > > +			ref->metric_name = pe->metric_name;
> > > > > +			ref->metric_expr = pe->metric_expr;
> > > > > +			list_add_tail(&metric->list, compound_list);
> > > > > +
> > > > > +			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > > Hi Jirka,
> > > 
> > > > so this might add new items to pctx->ids, I think you need
> > > > to restart the iteration as we do it in __resolve_metric
> > > > otherwise you could miss some new keys
> > > I thought that I was doing this. Indeed, this code is very much like
> > > __resolve_metric();)
> > > 
> > > So expr__find_other() may add a new item to pctx->ids, and we always iterate
> > > again, and try to lookup any pmu_events, *, above. If none exist, then we
> > hm, I don't see that.. so, what you do is:
> > 
> > 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> > 
> > 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > 	}
> > 
> > and what I think we need to do is:
> > 
> > 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> > 
> > 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> > 
> > 		break;	
> > 	}
> > 
> > each time you resolve another metric, you need to restart
> > the pctx->ids iteration, because there will be new items,
> > and we are in the middle of it
> 
> Sure, but we will restart anyway.

hum, where? you call expr__find_other and continue to next
pctx->ids item

> 
> Regardless of this, I don't think what I am doing is safe, i.e. adding new
> items in the middle of the iter, so I will change in the way you suggest.

it'll always add items in the middle of the iteration

jirka

> 
> Thanks,
> John
> 

