Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC332C017
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386461AbhCCSPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:15:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452562AbhCCPwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:52:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4662464EC4;
        Wed,  3 Mar 2021 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786679;
        bh=TBbYz6H3CPAIf21cIzfYtGetVkxPAqqs7jsInkFOpYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWmVyprpCbePXoLXJ5JiimohDIKytYNvYXoLtf+jkjL0no7pVEGPgjrF8nYk8oiv0
         0xI7GjvaoIcJNrR4kok26VNYHCxH2hEB3iH6m7fxwPjt+x9m2Knk+TsrRJDRjm3DyZ
         74K0c+EC3KNclJ2H3zZiZ90OQdbh3ly0sxot8hyDX5dxC6KsiPh/BNnntHVRPg754t
         RH3z3ZIClpV9+zCy+5/b9aq9sGVAvZRndvxYaqsk5HGVWjWuJ0/DLQCg/HZ0BYIlL4
         YENVQ6AsLCyyIEMTX+b+QW5B11ej7GXIgd3YKPbGDiHEhx4xJXBHgwqVcZLhXbwVp2
         sJmLoALLfjNxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 215A740CD9; Wed,  3 Mar 2021 12:51:17 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:51:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] libperf: Add perf_evlist__reset_id_hash()
Message-ID: <YD+wdRa5mW6uaXp7@kernel.org>
References: <20210225035148.778569-1-namhyung@kernel.org>
 <YDfMdQCfO6ivN71v@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDfMdQCfO6ivN71v@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 25, 2021 at 05:12:37PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 25, 2021 at 12:51:47PM +0900, Namhyung Kim wrote:
> > Add the perf_evlist__reset_id_hash() function as an internal function
> > so that it can be called by perf to reset the hash table.  This is
> > necessary for perf stat to run the workload multiple times.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> for the patchset
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
 
> thanks,

Thanks, applied.

- Arnaldo

> jirka
 
> 
> > ---
> >  tools/lib/perf/evlist.c                  | 13 +++++++++----
> >  tools/lib/perf/include/internal/evlist.h |  2 ++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 17465d454a0e..a0aaf385cbb5 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -26,13 +26,10 @@
> >  
> >  void perf_evlist__init(struct perf_evlist *evlist)
> >  {
> > -	int i;
> > -
> > -	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
> > -		INIT_HLIST_HEAD(&evlist->heads[i]);
> >  	INIT_LIST_HEAD(&evlist->entries);
> >  	evlist->nr_entries = 0;
> >  	fdarray__init(&evlist->pollfd, 64);
> > +	perf_evlist__reset_id_hash(evlist);
> >  }
> >  
> >  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> > @@ -237,6 +234,14 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
> >  	hlist_add_head(&sid->node, &evlist->heads[hash]);
> >  }
> >  
> > +void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
> > +		INIT_HLIST_HEAD(&evlist->heads[i]);
> > +}
> > +
> >  void perf_evlist__id_add(struct perf_evlist *evlist,
> >  			 struct perf_evsel *evsel,
> >  			 int cpu, int thread, u64 id)
> > diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> > index 2d0fa02b036f..212c29063ad4 100644
> > --- a/tools/lib/perf/include/internal/evlist.h
> > +++ b/tools/lib/perf/include/internal/evlist.h
> > @@ -124,4 +124,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
> >  			   struct perf_evsel *evsel,
> >  			   int cpu, int thread, int fd);
> >  
> > +void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
> > +
> >  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> > -- 
> > 2.30.0.617.g56c4b15f3c-goog
> > 
> 

-- 

- Arnaldo
