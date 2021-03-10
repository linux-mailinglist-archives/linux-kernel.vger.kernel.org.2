Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AF333D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCJNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhCJNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:13:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 969B964FBC;
        Wed, 10 Mar 2021 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615382025;
        bh=ke4jEyPP8sT8DLKkeuLV1x+DQApFeRt1PwSOCCw1zGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHQCvYat2Ictm+EYego7G1s/4tNtHfa5ikRa+6h7by0ArmZAcKCHa/f8rmJPt12M8
         kLPQ56Q555cv/iivkNMReg9l7Br5+gUqYEkzVUbi+VR/T/+i6/x8dLRMOS22kRs/LB
         ShKRadokp3RaRVffbdbvb8vrI4VN+KBrmDXotohyEzKIF2QhBC+Q98EI+EqiQ7An4k
         yeKE5Rr9NYqINnotKMoQCRLL9+tm3q7Vvh5DwNpBqaXUWgsmLVBsHBuiCsyg/Pmj42
         xxpYiOPBENk8zPKyXJV4P6pC/9mkLMMqwx0t841ctKm2HGdZ6RKyJ7qMRpbTLcCtNO
         ARh2grQrMXZtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF77C40647; Wed, 10 Mar 2021 10:13:41 -0300 (-03)
Date:   Wed, 10 Mar 2021 10:13:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf synthetic events: Avoid write of uninitialized
 memory.
Message-ID: <YEjGBec1pCxMvg6T@kernel.org>
References: <20210309234945.419254-1-irogers@google.com>
 <YEiyFNEhMuZhXA30@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEiyFNEhMuZhXA30@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 10, 2021 at 12:48:36PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 09, 2021 at 03:49:45PM -0800, Ian Rogers wrote:
> > Account for alignment bytes in the zero-ing memset.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/synthetic-events.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index b698046ec2db..31bf3dd6a1e0 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -424,7 +424,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >  
> >  	while (!io.eof) {
> >  		static const char anonstr[] = "//anon";
> > -		size_t size;
> > +		size_t size, aligned_size;
> >  
> >  		/* ensure null termination since stack will be reused. */
> >  		event->mmap2.filename[0] = '\0';
> > @@ -484,11 +484,12 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >  		}
> >  
> >  		size = strlen(event->mmap2.filename) + 1;
> > -		size = PERF_ALIGN(size, sizeof(u64));
> > +		aligned_size = PERF_ALIGN(size, sizeof(u64));
> >  		event->mmap2.len -= event->mmap.start;
> >  		event->mmap2.header.size = (sizeof(event->mmap2) -
> > -					(sizeof(event->mmap2.filename) - size));
> > -		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
> > +					(sizeof(event->mmap2.filename) - aligned_size));
> > +		memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
> > +			(aligned_size - size));
> 
> so we did not zero the extra alignment bytes, nice ;-) looks good
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

That is really old:

Fixes: 1a853e36871b533c ("perf record: Allow specifying a pid to record")

Circa 2009, the PERF_RECORD_COMM is ok as TASK_COMM_LEN is 16.

But I think there are other places synthesizing PERF_RECORD_MMAP,
jitdump maybe:

tools/perf/bench/inject-buildid.c, but it uses memset to zero the whole
union, no problem.

tools/perf/util/jitdump.c
jit_repipe_code_load() but it uses calloc to allocate the union
perf_event, so no problem as well.

Thanks, applied.

- Arnaldo
