Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F824360B88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhDOOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233385AbhDOOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618495881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NU1blIdp8qXopnr1MonghOxm1YUKkdW29TuQp6K82vw=;
        b=ToIM5Ab9ex0Ss5kNGkByMJ1IMXIVUVM5VCM1XhbafHybJ9X++St7Avc1zEcb940YrtAJoR
        SX4LrbSUTzXxDx0Ol/q9gXpag24vG6oTggqvMfn3kh/LVsehsr6J05izWP/O3JbVDIs4/O
        H7k87fP5RqBXWUIjuAxXSd4dBufw0xU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-W2yOONYxPaSJkzZv_FDj5g-1; Thu, 15 Apr 2021 10:11:10 -0400
X-MC-Unique: W2yOONYxPaSJkzZv_FDj5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13C1E6D592;
        Thu, 15 Apr 2021 14:11:09 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3D13610A8;
        Thu, 15 Apr 2021 14:11:06 +0000 (UTC)
Date:   Thu, 15 Apr 2021 16:11:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
Message-ID: <YHhJeuYMA/0Jof55@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com>
 <YHgdixeqOu2NarkC@krava>
 <132fc848-7252-0d7f-4a5f-020e8f79012e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132fc848-7252-0d7f-4a5f-020e8f79012e@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:36:16PM +0800, Jin, Yao wrote:

SNIP

> > > +	int n = 0;
> > > +
> > > +	list_for_each(pos, list)
> > > +		n++;
> > > +
> > > +	return n;
> > > +}
> > > +
> > > +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
> > > +					 const char *str, char *pmu_name,
> > > +					 bool *found, struct list_head *list)
> > > +{
> > > +	struct parse_events_state ps = {
> > > +		.list           = LIST_HEAD_INIT(ps.list),
> > > +		.stoken         = PE_START_EVENTS,
> > > +		.pmu_name       = pmu_name,
> > > +		.idx            = parse_state->idx,
> > > +	};
> > 
> > could we add this pmu_name directly to __parse_events?
> > 
> 
> Do you suggest we directly call __parse_events()?
> 
> int __parse_events(struct evlist *evlist, const char *str,
> 		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
> 
> 	struct parse_events_state parse_state = {
> 		.list	  = LIST_HEAD_INIT(parse_state.list),
> 		.idx	  = evlist->core.nr_entries,
> 		.error	  = err,
> 		.evlist	  = evlist,
> 		.stoken	  = PE_START_EVENTS,
> 		.fake_pmu = fake_pmu,
> 	};
> 
> But for parse_events__with_hybrid_pmu, we don't have valid evlist. So if we
> switch to __parse_events, evlist processing may be a problem.

you should use parse_state->evlist no? but we can chec/make this
change in next itaration.. it's already lot of changes

jirka

