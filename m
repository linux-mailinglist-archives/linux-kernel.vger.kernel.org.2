Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807739178B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhEZMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232367AbhEZMkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A46D613D6;
        Wed, 26 May 2021 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622032756;
        bh=oQ8Y88NUgW++dwoJ0hBFVHS7FsRdti+xRnyGs2vEAuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDF+bttZVYcsRfoFRiX6jSCwT1LzjmFJGrJNZ/moJ6KkXfgMTH1fSex4DaEFIa9d8
         wiIrnuuSvNfXoIl606dGskA/AT26l2vraY1No+BgyYnhMIlluAR+0WnjJpVawSJ9xE
         6Iy+k6Xb2PJRT83w+ANB3thr1UGobJPfreyup5lGqIZZx6pVwsFoOk741lUGlUKYpL
         rf8ZjNkbeOaaN+t/8pwHzrkhHhSIbQWUejN9/Q5QTti/GPp6JyYWzGTmO65ZWDhVSs
         1u+6EQfbwcLGibPfoPftZTB1NBNtvesF8LsAw7htwPmoSjZJuG2C4aGzNy2uZTZuHY
         8sbVEXh15iIrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A3074011C; Wed, 26 May 2021 09:39:13 -0300 (-03)
Date:   Wed, 26 May 2021 09:39:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf inject: Call dso__put() even if dso->hit is set
Message-ID: <YK5BcQ32CoYLaM7v@kernel.org>
References: <20210524225051.1190486-1-namhyung@kernel.org>
 <YK47d3S4wGIr3lu6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK47d3S4wGIr3lu6@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 26, 2021 at 02:13:43PM +0200, Jiri Olsa escreveu:
> On Mon, May 24, 2021 at 03:50:50PM -0700, Namhyung Kim wrote:
> > Otherwise it'll leak the refcount for the DSO.  As dso__put() can
> > handle a NULL dso pointer, we can just call it unconditionally.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> for the patchset
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-inject.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 102cafb0c0b3..8bbaa46eb7e6 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -383,8 +383,8 @@ static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
> >  	if (dso && !dso->hit) {
> >  		dso->hit = 1;
> >  		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
> > -		dso__put(dso);
> >  	}
> > +	dso__put(dso);
> >  
> >  	return perf_event__repipe(tool, event, sample, machine);
> >  }
> > @@ -447,8 +447,8 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
> >  		dso->hit = 1;
> >  		dso__inject_build_id(dso, tool, machine, sample->cpumode,
> >  				     event->mmap2.flags);
> > -		dso__put(dso);
> >  	}
> > +	dso__put(dso);
> >  
> >  	perf_event__repipe(tool, event, sample, machine);
> >  
> > -- 
> > 2.31.1.818.g46aad6cb9e-goog
> > 
> 

-- 

- Arnaldo
