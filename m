Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7A3BEDF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhGGSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhGGSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NrGcVRBBo+Z0eYxcvlX4IPWY2HOdWHb4cz21M2X2Wt8=;
        b=iLGSQ9F4L20c6DRdOiXLZtEYLKTezMliQTJ9urf8mPCP6dFBwv4A3MceZoHLmr2mu83zaL
        gZvC418lurvThFixZr/6xHy2JvKbM4cGl/XUSUYuWohyghp8rqXLzxzb1NO3CrlEFq5Z+5
        Ks57ft/8CBsBiX7kCxKTISgTY2CDjtU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-WAaFhbHvMaqjDGdeUGCbQQ-1; Wed, 07 Jul 2021 14:15:44 -0400
X-MC-Unique: WAaFhbHvMaqjDGdeUGCbQQ-1
Received: by mail-wm1-f70.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so2783220wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrGcVRBBo+Z0eYxcvlX4IPWY2HOdWHb4cz21M2X2Wt8=;
        b=XaexFrtYtzqgxXBh8zGSvAJ3AJMP/sz/Y6vNT5yYAOGMuKlqPfwULzuR+aNYl/qroZ
         /pG5Rkb2P7elTtGhxzAEXAg0jsLtn1KmlAZQn5q/iBakscuJQwh6GHo8XFV6h5ot+Cku
         OD4eQ6YdtdgEItGWX7JX6YpuoxDYX9Oey41XtafMw/R6f1ImYFVFX2oOEq5NT6t8I6NW
         Ocg3g2Gb332SmgVBVKuqtxeQONo8dWkvnvEcM1Qjp7ekJjw+kAQmmqGk66dRuE6xOSe7
         ZMpuIyzKzaOtRS5lnb3OPPqajBjEaHwtVlSzpaiSvioJT3upPmU3Z9Dm/F2XZSbcfBPf
         SQ5g==
X-Gm-Message-State: AOAM531uZ4Tp+oyXRO1zEA6ll0ini+SYMaxiMcYveJkpnAvnGEOnUwph
        mh5E4D1fEhtEkoewIfs8dyf+/6dugKyT15xcMShSg247J+QRoihNwXnXdrsUCtPKoRDDvmLrF/I
        gC6J/5QCaO37r3+kEEEpNdEg5
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr28542087wra.223.1625681743685;
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqhTb6ODPf1GGTRC0qV3o22LOaPlkQF9xV35mbGMXHfiCPSSivqTkDrWa9a3O+V+/sJ/IXBw==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr28542069wra.223.1625681743520;
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id c1sm20825838wrp.94.2021.07.07.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:15:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/7] libperF: Add group support to perf_evsel__open
Message-ID: <YOXvSpcxeAnrGBTi@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-7-jolsa@kernel.org>
 <YOXnq2yTVwklbrpO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXnq2yTVwklbrpO@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 02:43:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:17:03PM +0200, Jiri Olsa escreveu:
> > Adding support to set group_fd in perf_evsel__open
> > call and make it to follow the group setup.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/evsel.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 3e6638d27c45..9ebf7122d476 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/string.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> > +#include <asm/bug.h>
> >  
> >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> >  		      int idx)
> > @@ -76,6 +77,25 @@ sys_perf_event_open(struct perf_event_attr *attr,
> >  	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
> >  }
> >  
> > +static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
> > +{
> > +	struct perf_evsel *leader = evsel->leader;
> > +	int fd;
> > +
> > +	if (evsel == leader)
> > +		return -1;
> > +
> > +	/*
> > +	 * Leader must be already processed/open,
> > +	 * if not it's a bug.
> > +	 */
> > +	BUG_ON(!leader->fd);
> 
> Humm, having panics in library code looks ugly, why can't we just return
> some errno and let the whatever is using the library to fail gracefully?

true, I took it from perf code, did not realize this,
I'll check what can we do in ehre

> 
> I applied the patches so far, will make them available at tmp.perf/core
> now.

great, I'll take the patches from there for my next change

thanks,
jirka

> 
> - Arnaldo
> 
> > +	fd = FD(leader, cpu, thread);
> > +	BUG_ON(fd == -1);
> > +	return fd;
> > +}
> > +
> >  int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >  		     struct perf_thread_map *threads)
> >  {
> > @@ -111,11 +131,13 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >  
> >  	for (cpu = 0; cpu < cpus->nr; cpu++) {
> >  		for (thread = 0; thread < threads->nr; thread++) {
> > -			int fd;
> > +			int fd, group_fd;
> > +
> > +			group_fd = get_group_fd(evsel, cpu, thread);
> >  
> >  			fd = sys_perf_event_open(&evsel->attr,
> >  						 threads->map[thread].pid,
> > -						 cpus->map[cpu], -1, 0);
> > +						 cpus->map[cpu], group_fd, 0);
> >  
> >  			if (fd < 0)
> >  				return -errno;
> > -- 
> > 2.31.1
> > 
> 
> -- 
> 
> - Arnaldo
> 

