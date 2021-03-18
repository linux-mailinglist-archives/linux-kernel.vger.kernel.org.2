Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0198B3404FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCRLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhCRLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616068377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90h+1E2sAdBMnvKo/W6WXH2g+bl3xXKAkJKNk3akQ2I=;
        b=F/TlgpeNfq+GeSDbXEiuimD1xXz0Z1oo8YZ9CDgTjdBvPv9FvWgUbqaskFU3gmLdqYJ8Yk
        a0PZvzSxg7ew0FxFT28UT+2bpGB/Q/tkCHsEOGZh+PMZ2Z7EBrbCYrVHsz5dvRihMOeZmA
        b+H2AhpHjOhYoJ1vSY1R1KmLvDGfNi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-N_SZlK5YPkm4XrNfj80Tww-1; Thu, 18 Mar 2021 07:52:53 -0400
X-MC-Unique: N_SZlK5YPkm4XrNfj80Tww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8A2961180;
        Thu, 18 Mar 2021 11:52:51 +0000 (UTC)
Received: from krava (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0506118A50;
        Thu, 18 Mar 2021 11:52:48 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:52:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 16/27] perf evlist: Warn as events from different
 hybrid PMUs in a group
Message-ID: <YFM/EBq3gAZTh4m3@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-17-yao.jin@linux.intel.com>
 <YE/n2BW1ifH42/o6@krava>
 <020eaabf-abdb-4458-a883-2abbd4bbfbbd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020eaabf-abdb-4458-a883-2abbd4bbfbbd@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:25:29PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 3/16/2021 7:03 AM, Jiri Olsa wrote:
> > On Thu, Mar 11, 2021 at 03:07:31PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > >   				goto try_again;
> > >   			}
> > > +
> > > +			if (errno == EINVAL && perf_pmu__hybrid_exist())
> > > +				evlist__warn_hybrid_group(evlist);
> > >   			rc = -errno;
> > >   			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> > >   			ui__error("%s\n", msg);
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 7a732508b2b4..6f780a039db0 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -239,6 +239,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
> > >   	struct evsel *evsel, *pos, *leader;
> > >   	char buf[1024];
> > > +	if (evlist__hybrid_exist(evlist))
> > > +		return;
> > 
> > this should be in separate patch and explained
> > 
> 
> Now I have another idea. If a group consists of atom events and core events,
> we still follow current disabling group solution?
> 
> I mean removing following code:
> 
> if (evlist__hybrid_exist(evlist))
> 	return;
> 
> evlist__check_cpu_maps then continues running and disabling the group. But
> also report with a warning that says "WARNING: Group has events from
> different hybrid PMUs".
> 
> Do you like this way?

I'm not sure I follow completely.. would be best over the code

jirka

