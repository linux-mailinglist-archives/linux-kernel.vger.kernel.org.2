Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F2330EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCHNPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCHNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615209289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elYv3u6ByCeI5rhesd+IetH8Zfo/QbBmOMDByurjQ5k=;
        b=e2CDhJgJlkKls08IJeGlK0PP8L0GCQ7VzqxyO8JtuokBqLsnEfh/C4OXc1WVfztBZVHCz+
        yZIZGO031OhyoaOn20Vr0Os/y6wvxMr0QCm+swu4OtVJfozmHeiyUeDGiN0SEFr4WxK2Ih
        1jC0vLHYGr6w0kJXkOc/lUJ2SukWe3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-TKbhoZiqO7aEXCm2Xhta3g-1; Mon, 08 Mar 2021 08:14:45 -0500
X-MC-Unique: TKbhoZiqO7aEXCm2Xhta3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5C68018A1;
        Mon,  8 Mar 2021 13:14:43 +0000 (UTC)
Received: from krava (unknown [10.40.195.248])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8517410023AC;
        Mon,  8 Mar 2021 13:14:41 +0000 (UTC)
Date:   Mon, 8 Mar 2021 14:14:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YEYjQOYI7utqnCq6@krava>
References: <20210308031506.23019-1-yao.jin@linux.intel.com>
 <YEX91MTGMU41zeuF@krava>
 <c06cdd0d-fee2-ab6d-1d22-49a6590996ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06cdd0d-fee2-ab6d-1d22-49a6590996ea@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 08:57:49PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 3/8/2021 6:35 PM, Jiri Olsa wrote:
> > On Mon, Mar 08, 2021 at 11:15:06AM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 44ef28302fc7..03ab1e6d0418 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -1812,3 +1812,39 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
> > >   	return nr_caps;
> > >   }
> > > +
> > > +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> > > +				   char *name)
> > > +{
> > > +	struct perf_pmu_format *format;
> > > +	__u64 masks = 0, bits;
> > > +	char buf[100];
> > > +	unsigned int i;
> > > +
> > > +	list_for_each_entry(format, &pmu->format, list)	{
> > > +		/*
> > > +		 * Skip extra configs such as config1/config2.
> > > +		 */
> > > +		if (format->value > 0)
> > > +			continue;
> > 
> > sorry I did not notice before, but could you please use more direct
> > approach like:
> > 
> > 		if (format->value == PERF_PMU_FORMAT_VALUE_CONFIG) {
> > 			break;
> > 		}
> > 
> > this will be more obvious, also no need for the comment.. I spent some
> > time looking what's the value for ;-)
> > 
> > thanks,
> > jirka
> > 
> 
> Oh, yes, using PERF_PMU_FORMAT_VALUE_CONFIG is much more obvious. Sorry about that!
> 
> While it can't break the loop, because we need to iterate over the whole
> list to get the total valid bits. So like:
> 
> if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
> 	continue;
> 
> Is it right?

sure, what I meant was to process only PERF_PMU_FORMAT_VALUE_CONFIG
and then call break, because there's no need to iterate further

jirka

