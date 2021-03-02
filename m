Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5032A672
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384550AbhCBPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444811AbhCBMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6B4164F0D;
        Tue,  2 Mar 2021 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688565;
        bh=aIU8ufo2x+haijSAUpLIr8X8Yfx2CeP0Z0v54Zc1His=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvlAIbDDGqpyHt1/I0gE+IzgvV8cMbvrtpyqL+omBoz9+g7MUwc47tJWF6NsdxDdJ
         wL5uDQQWVZzEf1UXDmoxU0aLwdE6WVq/VsgsQ+WpdXSKmjmT9U2xWXwyiHz/IHrsJC
         bzfUPGVdeGcS4wNfhZO9dBWrWrANeUKV0fv1KoUZmjnw1sqSo37DwCTkbk1A0mqFA4
         6bTVA+PXOHdWbn7MYrcqvlsqsFHGsNPSKMvKXRBCoE0NOZgQ5tx1m4dERmpYcgMKXO
         z3YAXo8zDixfLGFJr8S+9oPTKUQ4C/CIIIcJYOSsO/xE9KJJyKgUTS97lefeUz2YmO
         /Y76PIpxBdmrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD82B40CD9; Tue,  2 Mar 2021 09:36:02 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:36:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf trace: Ensure read cmdlines are null terminated.
Message-ID: <YD4xMrrbRqhIuLmV@kernel.org>
References: <20210226221431.1985458-1-irogers@google.com>
 <CAM9d7ci2GpSuj88qAphQxBSEvaOoQg=9r8ah5GjrdFojSQ-28w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2GpSuj88qAphQxBSEvaOoQg=9r8ah5GjrdFojSQ-28w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 01, 2021 at 04:50:50PM +0900, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Sat, Feb 27, 2021 at 7:14 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Issue detected by address sanitizer.
> >
> > Fixes: cd4ceb63438e (perf util: Save pid-cmdline mapping into tracing header)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/trace-event-read.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
> > index f507dff713c9..8a01af783310 100644
> > --- a/tools/perf/util/trace-event-read.c
> > +++ b/tools/perf/util/trace-event-read.c
> > @@ -361,6 +361,7 @@ static int read_saved_cmdline(struct tep_handle *pevent)
> >                 pr_debug("error reading saved cmdlines\n");
> >                 goto out;
> >         }
> > +       buf[ret] = '\0';
> >
> >         parse_saved_cmdline(pevent, buf, size);
> >         ret = 0;
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >

-- 

- Arnaldo
