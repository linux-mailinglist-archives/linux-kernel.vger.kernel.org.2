Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853B038949D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355628AbhESRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355604AbhESRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CECED60FDA;
        Wed, 19 May 2021 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621445072;
        bh=GhtCKNfDjj9bjr5Afs2sfVpusPivLdG/dNCrgzNQfz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP09HeVUn0tFvxfl7iyMbLjZS951mhQyzHQzTZXAarz+V2PXm/6hx1DJKyj2k3cjK
         uPa6Be6OWH1cYgQpA0Zp5RkA3rY4usPN39bh3qeEfB1ieTwxtzAkIzfOCvYh79DMN1
         VJgZhYGt9F07WCFL+nn72RuOStD7XVu2jA0VVYuk9BfFR2J9a/JYpe4a3Qop7tI55v
         lDYe5t+hZ1F28SPtjWxU1O9ZEJ3/ha2GCsOvwuYw/6pYczs5O8oKAzR83uPiMzo/dL
         NSplvQTGaFHCRMTY1FwVReQvknirUj+M0ckMDdnCuR8iKUH+As5dDldYTXD5QZQRks
         pm3iYR1QdcIig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E922C41084; Wed, 19 May 2021 14:24:28 -0300 (-03)
Date:   Wed, 19 May 2021 14:24:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 3/3] perf tools: Add 'cgroup-switches' software event
Message-ID: <YKVJzOdc80CeS0PB@kernel.org>
References: <20210210083327.22726-1-namhyung@kernel.org>
 <20210210083327.22726-3-namhyung@kernel.org>
 <CAM9d7cgWDNiKBj14TA0Yj_aOhAxzF-xGtstOVRJmQnM6RBDdYg@mail.gmail.com>
 <CAM9d7cg4C-fXEquFjttHnx0mqCKA2E1yL19ybKxqATGoPJ5AHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg4C-fXEquFjttHnx0mqCKA2E1yL19ybKxqATGoPJ5AHw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 05, 2021 at 10:53:16PM -0700, Namhyung Kim escreveu:
> On Mon, Apr 19, 2021 at 11:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Arnaldo,
> >
> > Could you please pick this up?  The kernel part is landed in the
> > tip.git already.
> 
> Ping!

Finally applied, will go via perf/urgent.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > On Wed, Feb 10, 2021 at 5:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > It counts how often cgroups are changed actually during the context
> > > switches.
> > >
> > >   # perf stat -a -e context-switches,cgroup-switches -a sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >               11,267      context-switches
> > >               10,950      cgroup-switches
> > >
> > >          1.015634369 seconds time elapsed
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/include/uapi/linux/perf_event.h | 1 +
> > >  tools/perf/util/parse-events.c        | 4 ++++
> > >  tools/perf/util/parse-events.l        | 1 +
> > >  3 files changed, 6 insertions(+)
> > >
> > > diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> > > index b15e3447cd9f..16b9538ad89b 100644
> > > --- a/tools/include/uapi/linux/perf_event.h
> > > +++ b/tools/include/uapi/linux/perf_event.h
> > > @@ -112,6 +112,7 @@ enum perf_sw_ids {
> > >         PERF_COUNT_SW_EMULATION_FAULTS          = 8,
> > >         PERF_COUNT_SW_DUMMY                     = 9,
> > >         PERF_COUNT_SW_BPF_OUTPUT                = 10,
> > > +       PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
> > >
> > >         PERF_COUNT_SW_MAX,                      /* non-ABI */
> > >  };
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 42c84adeb2fb..09ff678519f3 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
> > >                 .symbol = "bpf-output",
> > >                 .alias  = "",
> > >         },
> > > +       [PERF_COUNT_SW_CGROUP_SWITCHES] = {
> > > +               .symbol = "cgroup-switches",
> > > +               .alias  = "",
> > > +       },
> > >  };
> > >
> > >  #define __PERF_EVENT_FIELD(config, name) \
> > > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > > index 9db5097317f4..88f203bb6fab 100644
> > > --- a/tools/perf/util/parse-events.l
> > > +++ b/tools/perf/util/parse-events.l
> > > @@ -347,6 +347,7 @@ emulation-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
> > >  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
> > >  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> > >  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
> > > +cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
> > >
> > >         /*
> > >          * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
> > > --
> > > 2.30.0.478.g8a0d178c01-goog
> > >

-- 

- Arnaldo
