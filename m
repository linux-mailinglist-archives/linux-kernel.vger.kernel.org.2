Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C1638CE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhEUTmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237076AbhEUTm3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:42:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BFD9613D9;
        Fri, 21 May 2021 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621626066;
        bh=Ad05XWld4TNCKlQq7LEe/VtfnKMmVM6B00+sSw1OEWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCbd4rCASWytW8pg4PEWjRFRR/9ZLULGoTj/8rmbx5UR0kZbNkKBIZTawmpVIoM9e
         eqhoNLpBX3/aInXvNxPlrzY1FwzDh4161QCkg2HqEo8mAHaQdWDUhT/nhLrPtjx8k6
         UAYJwRXE57GAKvfEcem8y46PBGaWQHvewy5Vcw3ncxRQSZq33ATrsuLCTIMN37YYSi
         A+OPIP5ff5jeRsspz57gPd/+azSm1m4j7q6XGZHkZGqaJ1FRkjO2lpwztxMrsoCSZV
         K58In00VlD/HfRu8FN0qKZajl5tqpesYaTH/VNIDr6Em9fd9Rfnje0YxUsSsyRsRcs
         3bvMagO0guQJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EF914011C; Fri, 21 May 2021 16:41:03 -0300 (-03)
Date:   Fri, 21 May 2021 16:41:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH 1/4] perf vendor events: Add core event list for Icelake
 Server
Message-ID: <YKgMz52O9mVjPH3K@kernel.org>
References: <20210510012438.6293-1-yao.jin@linux.intel.com>
 <20210510012438.6293-2-yao.jin@linux.intel.com>
 <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 20, 2021 at 09:08:37AM -0700, Ian Rogers escreveu:
> On Sun, May 9, 2021 at 6:26 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> >
> > Add JSON core events for Icelake Server to perf.
> >
> > Based on JSON list v1.04
> > https://download.01.org/perfmon/ICX/
> >
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
>=20
> Acked-by: Ian Rogers <irogers@google.com>

=E2=AC=A2[acme@toolbox perf]$ am
Applying: perf vendor events: Add core event list for Icelake Server
error: corrupt patch at line 2771
Patch failed at 0001 perf vendor events: Add core event list for Icelake Se=
rver
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
=E2=AC=A2[acme@toolbox perf]$
=E2=AC=A2[acme@toolbox perf]$ git diff
=E2=AC=A2[acme@toolbox perf]$ git am --abort
=E2=AC=A2[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/pmu-events/arch/x86/icelakex/cache.json
patching file tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
patching file tools/perf/pmu-events/arch/x86/icelakex/frontend.json
patching file tools/perf/pmu-events/arch/x86/icelakex/memory.json
patching file tools/perf/pmu-events/arch/x86/icelakex/other.json
patching file tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
patch: **** malformed patch at line 1927:   less than MAX. The reset value =
to the counter is not clocked immediately so the overflow status bit will f=
lip 'high (1)' and generate another PMI (if enabled) after which the reset =
value gets clocked into the counter. Therefore, software will get the inter=
rupt, read the overflow status bit '1 for bit 34 while the counter value is=
 less than MAX. Software should ignore this case.",

=E2=AC=A2[acme@toolbox perf]$

Please check.

- Arnaldo
=20
> Thanks,
> Ian
>=20
> > ---
> >  .../pmu-events/arch/x86/icelakex/cache.json   | 706 +++++++++++++
> >  .../arch/x86/icelakex/floating-point.json     |  95 ++
> >  .../arch/x86/icelakex/frontend.json           | 469 +++++++++
> >  .../pmu-events/arch/x86/icelakex/memory.json  | 291 ++++++
> >  .../pmu-events/arch/x86/icelakex/other.json   | 181 ++++
> >  .../arch/x86/icelakex/pipeline.json           | 972 ++++++++++++++++++
> >  .../arch/x86/icelakex/virtual-memory.json     | 245 +++++
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +
> >  8 files changed, 2961 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/floating-po=
int.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/frontend.js=
on
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/other.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/pipeline.js=
on
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/virtual-mem=
ory.json
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools=
/perf/pmu-events/arch/x86/icelakex/cache.json
> > new file mode 100644
> > index 000000000000..624762008aaa
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
> > @@ -0,0 +1,706 @@
> > +[
> > +    {
> > +        "BriefDescription": "Demand Data Read miss L2, no rejects",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of demand Data Read re=
quests that miss L2 cache. Only not rejected loads are counted.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x21"
> > +    },
> > +    {
> > +        "BriefDescription": "RFO requests that miss L2 cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.RFO_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the RFO (Read-for-Ownership) requ=
ests that miss L2 cache.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x22"
> > +    },
> > +    {
> > +        "BriefDescription": "L2 cache misses when fetching instruction=
s",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.CODE_RD_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts L2 cache misses when fetching ins=
tructions.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x24"
> > +    },
> > +    {
> > +        "BriefDescription": "Demand requests that miss L2 cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts demand requests that miss L2 cach=
e.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x27"
> > +    },
> > +    {
> > +        "BriefDescription": "SW prefetch requests that miss L2 cache.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.SWPF_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts Software prefetch requests that m=
iss the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 in=
structions.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x28"
> > +    },
> > +    {
> > +        "BriefDescription": "Demand Data Read requests that hit L2 cac=
he",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of demand Data Read re=
quests initiated by load instructions that hit L2 cache.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xc1"
> > +    },
> > +    {
> > +        "BriefDescription": "RFO requests that hit L2 cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.RFO_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the RFO (Read-for-Ownership) requ=
ests that hit L2 cache.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xc2"
> > +    },
> > +    {
> > +        "BriefDescription": "L2 cache hits when fetching instructions,=
 code reads.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.CODE_RD_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts L2 cache hits when fetching instr=
uctions, code reads.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xc4"
> > +    },
> > +    {
> > +        "BriefDescription": "SW prefetch requests that hit L2 cache.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.SWPF_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts Software prefetch requests that h=
it the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 ins=
tructions.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xc8"
> > +    },
> > +    {
> > +        "BriefDescription": "Demand Data Read requests",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of demand Data Read re=
quests (including requests from L1D hardware prefetchers). These loads may =
hit or miss L2 cache. Only non rejected loads are counted.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe1"
> > +    },
> > +    {
> > +        "BriefDescription": "RFO requests to L2 cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.ALL_RFO",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the total number of RFO (read for=
 ownership) requests to L2 cache. L2 RFO requests include both L1D demand R=
FO misses as well as L1D RFO prefetches.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe2"
> > +    },
> > +    {
> > +        "BriefDescription": "L2 code requests",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x24",
> > +        "EventName": "L2_RQSTS.ALL_CODE_RD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the total number of L2 code reque=
sts.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe4"
> > +    },
> > +    {
> > +        "BriefDescription": "Core-originated cacheable demand requests=
 missed L3",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x2e",
> > +        "EventName": "LONGEST_LAT_CACHE.MISS",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts core-originated cacheable request=
s that miss the L3 cache (Longest Latency cache). Requests include data and=
 code reads, Reads-for-Ownership (RFOs), speculative accesses and hardware =
prefetches from L1 and L2. It does not include all misses to the L3.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of L1D misses that are outstanding=
",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x48",
> > +        "EventName": "L1D_PEND_MISS.PENDING",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts number of L1D misses that are out=
standing in each cycle, that is each cycle the number of Fill Buffers (FB) =
outstanding required by Demand Reads. FB either is held by demand loads, or=
 it is held by non-demand loads and gets hit at least once by demand. The v=
alid outstanding interval is defined until the FB deallocation by one of th=
e following ways: from FB allocation, if FB is allocated by demand from the=
 demand Hit FB, if it is allocated by hardware or software prefetch. Note: =
In the L1D, a Demand Read contains cacheable or noncacheable demand loads, =
including ones causing cache-line splits and reads due to page walks result=
ed from any request type.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles with L1D load Misses outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x48",
> > +        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts duration of L1D miss outstanding =
in cycles.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of cycles a demand request has wai=
ted due to L1D Fill Buffer (FB) unavailability.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x48",
> > +        "EventName": "L1D_PEND_MISS.FB_FULL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts number of cycles a demand request=
 has waited due to L1D Fill Buffer (FB) unavailablability. Demand requests =
include cacheable/uncacheable demand load, store, lock or SW prefetch acces=
ses.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of phases a demand request has wai=
ted due to L1D Fill Buffer (FB) unavailablability.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EdgeDetect": "1",
> > +        "EventCode": "0x48",
> > +        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts number of phases a demand request=
 has waited due to L1D Fill Buffer (FB) unavailablability. Demand requests =
include cacheable/uncacheable demand load, store, lock or SW prefetch acces=
ses.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of cycles a demand request has wai=
ted due to L1D due to lack of L2 resources.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x48",
> > +        "EventName": "L1D_PEND_MISS.L2_STALL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts number of cycles a demand request=
 has waited due to L1D due to lack of L2 resources. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of cache lines replaced=
 in L1 data cache.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x51",
> > +        "EventName": "L1D.REPLACEMENT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts L1D data line replacements includ=
ing opportunistic replacements, and replacements that require stall-for-rep=
lace or block-for-replace.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "For every cycle where the core is waiting=
 on at least 1 outstanding Demand RFO request, increments by 1.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x60",
> > +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_=
RFO",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "For every cycle where the core is waitin=
g on at least 1 outstanding demand RFO request, increments by 1.   RFOs are=
 initiated by a core as part of a data store operation.  Demand RFO request=
s include RFOs, locks, and ItoM transactions.  Requests are considered outs=
tanding from the time they miss the core's L2 cache until the transaction c=
ompletion message is sent to the requestor.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "For every cycle, increments by the number=
 of outstanding data read requests the core is waiting on.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x60",
> > +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "For every cycle, increments by the numbe=
r of outstanding data read requests the core is waiting on.  Data read requ=
ests include cacheable demand reads and L2 prefetches, but do not include R=
FOs, code reads or prefetches to the L3.  Reads due to page walks resulting=
 from any request type will also be counted.  Requests are considered outst=
anding from the time they miss the core's L2 cache until the transaction co=
mpletion message is sent to the requestor.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "For every cycle where the core is waiting=
 on at least 1 outstanding demand data read request, increments by 1.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x60",
> > +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD=
",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "For every cycle where the core is waitin=
g on at least 1 outstanding data read request, increments by 1.  Data read =
requests include cacheable demand reads and L2 prefetches, but do not inclu=
de RFOs, code reads or prefetches to the L3.  Reads due to page walks resul=
ting from any request type will also be counted.  Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Demand Data Read requests sent to uncore",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xb0",
> > +        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the Demand Data Read requests sen=
t to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to det=
ermine average latency in the uncore.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Demand and prefetch data reads",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB0",
> > +        "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the demand and prefetch data read=
s. All Core Data Reads include cacheable 'Demands' and L2 prefetchers (not =
L3 prefetchers). Counting also covers reads due to page walks resulted from=
 any request type.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts memory transactions sent to the un=
core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB0",
> > +        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts memory transactions sent to the u=
ncore including requests initiated by the core, all L3 prefetches, reads re=
sulting from page walks, and snoop responses.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions that miss the S=
TLB.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions that tr=
ue miss the STLB.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x11"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired store instructions that miss the =
STLB.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
> > +        "L1_Hit_Indication": "1",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired store instructions that t=
rue miss the STLB.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x12"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions with locked acc=
ess.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with lo=
cked access.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x21"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions that split acro=
ss a cacheline boundary.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions that sp=
lit across a cacheline boundary.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x41"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired store instructions that split acr=
oss a cacheline boundary.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
> > +        "L1_Hit_Indication": "1",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired store instructions that s=
plit across a cacheline boundary.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x42"
> > +    },
> > +    {
> > +        "BriefDescription": "All retired load instructions.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts all retired load instructions. Th=
is event accounts for SW prefetch instructions for loads.",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x81"
> > +    },
> > +    {
> > +        "BriefDescription": "All retired store instructions.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd0",
> > +        "EventName": "MEM_INST_RETIRED.ALL_STORES",
> > +        "L1_Hit_Indication": "1",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts all retired store instructions. T=
his event account for SW prefetch instructions and PREFETCHW instruction fo=
r stores.",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x82"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions with L1 cache h=
its as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with at=
 least one uop that hit in the L1 data cache. This event includes all SW pr=
efetches and lock instructions regardless of the data source.",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions with L2 cache h=
its as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with L2=
 cache hits as data sources.",
> > +        "SampleAfterValue": "200003",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions with L3 cache h=
its as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with at=
 least one uop that hit in the L3 cache.",
> > +        "SampleAfterValue": "100021",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions missed L1 cache=
 as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with at=
 least one uop that missed in the L1 cache.",
> > +        "SampleAfterValue": "200003",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions missed L2 cache=
 as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions missed =
L2 cache as data sources.",
> > +        "SampleAfterValue": "100021",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions missed L3 cache=
 as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with at=
 least one uop that missed in the L3 cache.",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of completed demand load requests =
that missed the L1, but hit the FB(fill buffer), because a preceding miss t=
o the same cacheline initiated the line to be brought into L1, but data is =
not yet ready in L1.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions with at=
 least one uop was load missed in L1 but hit FB (Fill Buffers) due to prece=
ding miss to the same cache line with data not ready.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired demand load instructions which mi=
ssed L3 but serviced from local IXP memory as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd1",
> > +        "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces were L3 hit and cross-core snoop missed in on-pkg core cache.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the retired load instructions who=
se data sources were L3 hit and cross-core snoop missed in on-pkg core cach=
e.",
> > +        "SampleAfterValue": "20011",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "This event is deprecated. Refer to new ev=
ent MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "20011",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces were L3 and cross-core snoop hits in on-pkg core cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions whose d=
ata sources were L3 and cross-core snoop hits in on-pkg core cache.",
> > +        "SampleAfterValue": "20011",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "This event is deprecated. Refer to new ev=
ent MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "20011",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces were HitM responses from shared L3",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions whose d=
ata sources were HitM responses from shared L3.",
> > +        "SampleAfterValue": "20011",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces were hits in L3 without snoops required",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd2",
> > +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts retired load instructions whose d=
ata sources were hits in L3 without snoops required.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions which data sour=
ces missed L3 but serviced from local dram",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd3",
> > +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Retired load instructions which data sou=
rces missed L3 but serviced from local DRAM.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions which data sour=
ces missed L3 but serviced from remote dram",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd3",
> > +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces was remote HITM",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd3",
> > +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Retired load instructions whose data sou=
rces was remote HITM.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired load instructions whose data sour=
ces was forwarded from a remote cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd3",
> > +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Retired load instructions whose data sou=
rces was forwarded from a remote cache.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired demand load instructions which mi=
ssed L3 but serviced from remote IXP memory as data sources",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xd3",
> > +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Retired load instructions which data sou=
rce was serviced from L4",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "L2 writebacks that access L2 cache",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xF0",
> > +        "EventName": "L2_TRANS.L2_WB",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts L2 writebacks that access L2 cach=
e.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "L2 cache lines filling L2",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xF1",
> > +        "EventName": "L2_LINES_IN.ALL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of L2 cache lines fill=
ing the L2. Counting does not cover rejects.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1f"
> > +    },
> > +    {
> > +        "BriefDescription": "Non-modified cache lines that are silentl=
y dropped by L2 cache when triggered by an L2 cache fill.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xF2",
> > +        "EventName": "L2_LINES_OUT.SILENT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of lines that are sile=
ntly dropped by L2 cache when triggered by an L2 cache fill. These lines ar=
e typically in Shared or Exclusive state. A non-threaded event.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cache lines that are evicted by L2 cache =
when triggered by an L2 cache fill.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xF2",
> > +        "EventName": "L2_LINES_OUT.NON_SILENT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of lines that are evic=
ted by the L2 cache due to L2 cache fills.  Evicted lines are delivered to =
the L3, which may or may not cache them, according to system load and prior=
ities.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles the queue waiting for offcore resp=
onses is full.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xf4",
> > +        "EventName": "SQ_MISC.SQ_FULL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the cycles for which the thread i=
s active and the queue waiting for responses from the uncore cannot take an=
y more entries.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> > new file mode 100644
> > index 000000000000..bcedcd985e84
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> > @@ -0,0 +1,95 @@
> > +[
> > +    {
> > +        "BriefDescription": "Counts all microcode FP assists.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc1",
> > +        "EventName": "ASSISTS.FP",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts all microcode Floating Point assi=
sts.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational sc=
alar double precision floating-point instructions retired; some instruction=
s will count twice as noted below.  Each count represents 1 computational o=
peration. Applies to SSE* and AVX* scalar double precision floating-point i=
nstructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational sc=
alar single precision floating-point instructions retired; some instruction=
s will count twice as noted below.  Each count represents 1 computational o=
peration. Applies to SSE* and AVX* scalar single precision floating-point i=
nstructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD=
/SUB instructions count twice as they perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational 12=
8-bit packed double precision floating-point instructions retired; some ins=
tructions will count twice as noted below.  Each count represents 2 computa=
tion operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV=
 MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of SSE/AVX computational 128-bit p=
acked single precision floating-point instructions retired; some instructio=
ns will count twice as noted below.  Each count represents 4 computation op=
erations, one for each element.  Applies to SSE* and AVX* packed single pre=
cision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts number of SSE/AVX computational 1=
28-bit packed single precision floating-point instructions retired; some in=
structions will count twice as noted below.  Each count represents 4 comput=
ation operations, one for each element.  Applies to SSE* and AVX* packed si=
ngle precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DI=
V MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructio=
ns count twice as they perform 2 calculations per element.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational 25=
6-bit packed double precision floating-point instructions retired; some ins=
tructions will count twice as noted below.  Each count represents 4 computa=
tion operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV=
 MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they =
perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational 25=
6-bit packed single precision floating-point instructions retired; some ins=
tructions will count twice as noted below.  Each count represents 8 computa=
tion operations, one for each element.  Applies to SSE* and AVX* packed sin=
gle precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV=
 MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instruction=
s count twice as they perform 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational 51=
2-bit packed double precision floating-point instructions retired; some ins=
tructions will count twice as noted below.  Each count represents 8 computa=
tion operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQ=
RT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of SSE/AVX computational 51=
2-bit packed double precision floating-point instructions retired; some ins=
tructions will count twice as noted below.  Each count represents 16 comput=
ation operations, one for each element.  Applies to SSE* and AVX* packed do=
uble precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RS=
QRT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they per=
form 2 calculations per element.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc7",
> > +        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x80"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/frontend.json
> > new file mode 100644
> > index 000000000000..cc59cee1cd57
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
> > @@ -0,0 +1,469 @@
> > +[
> > +    {
> > +        "BriefDescription": "Uops delivered to Instruction Decode Queu=
e (IDQ) from MITE path",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.MITE_UOPS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of uops delivered to I=
nstruction Decode Queue (IDQ) from the MITE path. This also means that uops=
 are not being delivered from the Decode Stream Buffer (DSB).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles MITE is delivering optimal number =
of Uops",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "5",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.MITE_CYCLES_OK",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of cycles where optima=
l number of uops was delivered to the Instruction Decode Queue (IDQ) from t=
he MITE (legacy decode pipeline) path. During these cycles uops are not bei=
ng delivered from the Decode Stream Buffer (DSB).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles MITE is delivering any Uop",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.MITE_CYCLES_ANY",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of cycles uops were de=
livered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode =
pipeline) path. During these cycles uops are not being delivered from the D=
ecode Stream Buffer (DSB).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Uops delivered to Instruction Decode Queu=
e (IDQ) from the Decode Stream Buffer (DSB) path",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.DSB_UOPS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of uops delivered to I=
nstruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles DSB is delivering optimal number o=
f Uops",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "5",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.DSB_CYCLES_OK",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of cycles where optima=
l number of uops was delivered to the Instruction Decode Queue (IDQ) from t=
he MITE (legacy decode pipeline) path. During these cycles uops are not bei=
ng delivered from the Decode Stream Buffer (DSB).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deli=
vering any Uop",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.DSB_CYCLES_ANY",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of cycles uops were de=
livered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DS=
B) path.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of switches from DSB or MITE to th=
e MS",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EdgeDetect": "1",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.MS_SWITCHES",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Number of switches from DSB (Decode Stre=
am Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x30"
> > +    },
> > +    {
> > +        "BriefDescription": "Uops delivered to IDQ while MS is busy",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x79",
> > +        "EventName": "IDQ.MS_UOPS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the total number of uops delivere=
d by the Microcode Sequencer (MS). Any instruction over 4 uops will be deli=
vered by the MS. Some instructions such as transcendentals may additionally=
 generate uops from the MS.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x30"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x80",
> > +        "EventName": "ICACHE_16B.IFDATA_STALL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles where a code line fetch is=
 stalled due to an L1 instruction cache miss. The legacy decode pipeline wo=
rks at a 16 Byte granularity.",
> > +        "SampleAfterValue": "500009",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Instruction fetch tag lookups that hit in=
 the instruction cache (L1I). Counts at 64-byte cache-line granularity.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x83",
> > +        "EventName": "ICACHE_64B.IFTAG_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts instruction fetch tag lookups tha=
t hit in the instruction cache (L1I). Counts at 64-byte cache-line granular=
ity. Accounts for both cacheable and uncacheable accesses.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Instruction fetch tag lookups that miss i=
n the instruction cache (L1I). Counts at 64-byte cache-line granularity.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x83",
> > +        "EventName": "ICACHE_64B.IFTAG_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts instruction fetch tag lookups tha=
t miss in the instruction cache (L1I). Counts at 64-byte cache-line granula=
rity. Accounts for both cacheable and uncacheable accesses.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache tag miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x83",
> > +        "EventName": "ICACHE_64B.IFTAG_STALL",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles where a code fetch is stal=
led due to L1 instruction cache tag miss.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Uops not delivered by IDQ when backend of=
 the machine is not stalled",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x9c",
> > +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of uops not delivered =
to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline wh=
en there was no back-end stalls. This event counts for one SMT thread in a =
given cycle.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when no uops are not delivered by =
the IDQ when backend of the machine is not stalled",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "5",
> > +        "EventCode": "0x9c",
> > +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of cycles when no uops=
 were delivered by the Instruction Decode Queue (IDQ) to the back-end of th=
e pipeline when there was no back-end stalls. This event counts for one SMT=
 thread in a given cycle.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when optimal number of uops was de=
livered to the back-end when the back-end is not stalled",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x9C",
> > +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
> > +        "Invert": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of cycles when the opt=
imal number of uops were delivered by the Instruction Decode Queue (IDQ) to=
 the back-end of the pipeline when there was no back-end stalls. This event=
 counts for one SMT thread in a given cycle.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xab",
> > +        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cach=
e that holds translations of previously fetched instructions that were deco=
ded by the legacy x86 decode pipeline (MITE). This event counts fetch penal=
ty cycles when a transition occurs from DSB to MITE.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transi=
tions count.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EdgeDetect": "1",
> > +        "EventCode": "0xab",
> > +        "EventName": "DSB2MITE_SWITCHES.COUNT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of Decode Stream Buffe=
r (DSB a.k.a. Uop Cache)-to-MITE speculative transitions.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired Instructions who experienced DSB =
miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.DSB_MISS",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x11",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired Instructions that experie=
nced DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired Instructions who experienced Inst=
ruction L1 Cache true miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.L1I_MISS",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x12",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired Instructions who experien=
ced Instruction L1 Cache true miss.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired Instructions who experienced Inst=
ruction L2 Cache true miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.L2_MISS",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x13",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired Instructions who experien=
ced Instruction L2 Cache true miss.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired Instructions who experienced iTLB=
 true miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x14",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired Instructions that experie=
nced iTLB (Instruction TLB) true miss.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired Instructions who experienced STLB=
 (2nd level TLB) true miss.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.STLB_MISS",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x15",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired Instructions that experie=
nced STLB (2nd level TLB) true miss.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions after front-end star=
vation of at least 2 cycles",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x500206",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Retired instructions that are fetched af=
ter an interval where the front-end delivered no uops for a period of at le=
ast 2 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 4 cycl=
es which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x500406",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period o=
f 4 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 8 cycl=
es which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x500806",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 8 cycles. During=
 this period the front-end delivered no uops.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 16 cyc=
les which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x501006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 16 cycles. Durin=
g this period the front-end delivered no uops.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 32 cyc=
les which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x502006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 32 cycles. Durin=
g this period the front-end delivered no uops.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 64 cyc=
les which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x504006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period o=
f 64 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 128 cy=
cles which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x508006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period o=
f 128 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 256 cy=
cles which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x510006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period o=
f 256 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 512 cy=
cles which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x520006",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period o=
f 512 cycles which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end had at least 1 bubble-slot for a period =
of 2 cycles which was not interrupted by a back-end stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x100206",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after the front-end had at least 1 bubble-slot for a=
 period of 2 cycles. A bubble-slot is an empty issue-pipeline slot while th=
ere was no RAT stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Retired instructions after front-end star=
vation of at least 1 cycle",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc6",
> > +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
> > +        "MSRIndex": "0x3F7",
> > +        "MSRValue": "0x500106",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Retired instructions that are fetched af=
ter an interval where the front-end delivered no uops for a period of at le=
ast 1 cycle which was not interrupted by a back-end stall.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the total number when the front en=
d is resteered, mainly when the BPU cannot provide a correct prediction and=
 this is corrected by other branch handling mechanisms at the front end.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xe6",
> > +        "EventName": "BACLEARS.ANY",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of times the front-end=
 is resteered when it finds a branch instruction in a fetch line. This occu=
rs for the first time a branch instruction is fetched or when the branch is=
 not tracked by the BPU (Branch Prediction Unit) anymore.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tool=
s/perf/pmu-events/arch/x86/icelakex/memory.json
> > new file mode 100644
> > index 000000000000..d319d448e2aa
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
> > @@ -0,0 +1,291 @@
> > +[
> > +    {
> > +        "BriefDescription": "Number of times a transactional abort was=
 signaled due to a data conflict on a transactionally accessed address",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x54",
> > +        "EventName": "TX_MEM.ABORT_CONFLICT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of times a TSX line ha=
d a cache conflict.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Speculatively counts the number of TSX ab=
orts due to a data capacity limitation for transactional writes.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x54",
> > +        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Speculatively counts the number of Trans=
actional Synchronization Extensions (TSX) aborts due to a data capacity lim=
itation for transactional writes.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Speculatively counts the number of TSX ab=
orts due to a data capacity limitation for transactional reads",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x54",
> > +        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Speculatively counts the number of Trans=
actional Synchronization Extensions (TSX) aborts due to a data capacity lim=
itation for transactional reads",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of times a class of ins=
tructions that may cause a transactional abort was executed inside a transa=
ctional region",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x5d",
> > +        "EventName": "TX_EXEC.MISC2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts Unfriendly TSX abort triggered by=
 a vzeroupper instruction.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an instruction execution =
caused the transactional nest count supported to be exceeded",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x5d",
> > +        "EventName": "TX_EXEC.MISC3",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts Unfriendly TSX abort triggered by=
 a nest count that is too deep.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Execution stalls while L3 cache miss dema=
nd load is outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "6",
> > +        "EventCode": "0xa3",
> > +        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x6"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of machine clears due to memory or=
dering conflicts.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc3",
> > +        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of Machine Clears dete=
cted dye to memory ordering. Memory Ordering Machine Clears may apply when =
a memory read may not conform to the memory ordering rules of the x86 archi=
tecture",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution started.=
",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.START",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times we entered an=
 RTM region. Does not count nested transactions.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution successf=
ully committed",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.COMMIT",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times RTM commit su=
cceeded.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution aborted.=
",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.ABORTED",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times RTM abort was=
 triggered.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution aborted =
due to various memory events (e.g. read/write capacity and conflicts)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.ABORTED_MEM",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to various memory events (e.g. read/write capacity and conf=
licts).",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution aborted =
due to HLE-unfriendly instructions",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to HLE-unfriendly instructions.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution aborted =
due to incompatible memory type",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to incompatible memory type.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of times an RTM execution aborted =
due to none of the previous 4 categories (e.g. interrupt)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc9",
> > +        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to none of the previous 4 categories (e.g. interrupt).",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 4 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x4",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 4 cycles.  Report=
ed latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "100003",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 8 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x8",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 8 cycles.  Report=
ed latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "50021",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 16 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x10",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 16 cycles.  Repor=
ted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "20011",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 32 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x20",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 32 cycles.  Repor=
ted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "100007",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 64 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x40",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 64 cycles.  Repor=
ted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "2003",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 128 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x80",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 128 cycles.  Repo=
rted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "1009",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 256 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x100",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 256 cycles.  Repo=
rted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "503",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 512 cycles.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "Data_LA": "1",
> > +        "EventCode": "0xcd",
> > +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
> > +        "MSRIndex": "0x3F6",
> > +        "MSRValue": "0x200",
> > +        "PEBS": "2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 512 cycles.  Repo=
rted latency may be longer than just the memory latency.",
> > +        "SampleAfterValue": "101",
> > +        "TakenAlone": "1",
> > +        "UMask": "0x1"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools=
/perf/pmu-events/arch/x86/icelakex/other.json
> > new file mode 100644
> > index 000000000000..ef50d3a3392e
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
> > @@ -0,0 +1,181 @@
> > +[
> > +    {
> > +        "BriefDescription": "TMA slots available for an unhalted logic=
al processor. Fixed counter - architectural event",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "35",
> > +        "EventName": "TOPDOWN.SLOTS",
> > +        "PEBScounters": "35",
> > +        "PublicDescription": "Number of available slots for an unhalte=
d logical processor. The event increments by machine-width of the narrowest=
 pipeline as employed by the Top-down Microarchitecture Analysis method (TM=
A). The count is distributed among unhalted logical processors (hyper-threa=
ds) who share the same physical core. Software can use this event as the de=
nominator for the top-level metrics of the TMA method. This architectural e=
vent is counted on a designated fixed counter (Fixed Counter 3).",
> > +        "SampleAfterValue": "10000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x28",
> > +        "EventName": "CORE_POWER.LVL0_TURBO_LICENSE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts Core cycles where the core was ru=
nning with power-delivery for baseline license level 0.  This includes non-=
AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x7"
> > +    },
> > +    {
> > +        "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the AVX2 turbo schedule.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x28",
> > +        "EventName": "CORE_POWER.LVL1_TURBO_LICENSE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts Core cycles where the core was ru=
nning with power-delivery for license level 1.  This includes high current =
AVX 256-bit instructions as well as low current AVX 512-bit instructions.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x18"
> > +    },
> > +    {
> > +        "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the AVX512 turbo schedule.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x28",
> > +        "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Core cycles where the core was running w=
ith power-delivery for license level 2 (introduced in Skylake Server microa=
rchtecture).  This includes high current AVX 512-bit instructions.",
> > +        "SampleAfterValue": "200003",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of PREFETCHNTA instructions execut=
ed.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x32",
> > +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of PREFETCHNTA instruc=
tions executed.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of PREFETCHT0 instructions execute=
d.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x32",
> > +        "EventName": "SW_PREFETCH_ACCESS.T0",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of PREFETCHT0 instruct=
ions executed.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instru=
ctions executed.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x32",
> > +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of PREFETCHT1 or PREFE=
TCHT2 instructions executed.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of PREFETCHW instructions executed=
=2E",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x32",
> > +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of PREFETCHW instructi=
ons executed.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "TMA slots available for an unhalted logic=
al processor. General counter - architectural event",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa4",
> > +        "EventName": "TOPDOWN.SLOTS_P",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of available slots for=
 an unhalted logical processor. The event increments by machine-width of th=
e narrowest pipeline as employed by the Top-down Microarchitecture Analysis=
 method. The count is distributed among unhalted logical processors (hyper-=
threads) who share the same physical core.",
> > +        "SampleAfterValue": "10000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "TMA slots where no uops were being issued=
 due to lack of back-end resources.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa4",
> > +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of Top-down Microarchi=
tecture Analysis (TMA) method's  slots where no micro-operations were being=
 issued from front-end to back-end of the machine due to lack of back-end r=
esources.",
> > +        "SampleAfterValue": "10000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of occurrences where a microcode a=
ssist is invoked by hardware.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc1",
> > +        "EventName": "ASSISTS.ANY",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of occurrences where a=
 microcode assist is invoked by hardware Examples include AD (page Access D=
irty), FP and AVX related assists.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x7"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts demand data reads that hit a cache=
line in the L3 where a snoop hit in another cores caches, data forwarding i=
s required as the data is modified.",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB7, 0xBB",
> > +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> > +        "MSRIndex": "0x1a6,0x1a7",
> > +        "MSRValue": "0x10003C0001",
> > +        "Offcore": "1",
> > +        "PublicDescription": "Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts demand data reads that hit a cache=
line in the L3 where a snoop hit in another cores caches which forwarded th=
e unmodified data to the requesting core.",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB7, 0xBB",
> > +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> > +        "MSRIndex": "0x1a6,0x1a7",
> > +        "MSRValue": "0x8003C0001",
> > +        "Offcore": "1",
> > +        "PublicDescription": "Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts writes that generate a demand read=
s for ownership (RFO) request and software prefetches for exclusive ownersh=
ip (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another =
cores caches, data forwarding is required as the data is modified.",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB7, 0xBB",
> > +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> > +        "MSRIndex": "0x1a6,0x1a7",
> > +        "MSRValue": "0x10003C0002",
> > +        "Offcore": "1",
> > +        "PublicDescription": "Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts streaming stores that have any typ=
e of response.",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xB7, 0xBB",
> > +        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
> > +        "MSRIndex": "0x1a6,0x1a7",
> > +        "MSRValue": "0x10800",
> > +        "Offcore": "1",
> > +        "PublicDescription": "Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/pipeline.json
> > new file mode 100644
> > index 000000000000..3cc71244e699
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> > @@ -0,0 +1,972 @@
> > +[
> > +    {
> > +        "BriefDescription": "Number of instructions retired. Fixed Cou=
nter - architectural event",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "32",
> > +        "EventName": "INST_RETIRED.ANY",
> > +        "PEBS": "1",
> > +        "PEBScounters": "32",
> > +        "PublicDescription": "Counts the number of instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> > +        "SampleAfterValue": "2000003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Precise instruction retired event with a =
reduced effect of PEBS shadow in IP distribution",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "32",
> > +        "EventName": "INST_RETIRED.PREC_DIST",
> > +        "PEBS": "1",
> > +        "PEBScounters": "32",
> > +        "PublicDescription": "A version of INST_RETIRED that allows fo=
r a more unbiased distribution of samples across instructions retired. It u=
tilizes the Precise Distribution of Instructions Retired (PDIR) feature to =
mitigate some bias in how retired instructions get sampled. Use on Fixed Co=
unter 0.",
> > +        "SampleAfterValue": "2000003",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Core cycles when the thread is not in hal=
t state",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "33",
> > +        "EventName": "CPU_CLK_UNHALTED.THREAD",
> > +        "PEBScounters": "33",
> > +        "PublicDescription": "Counts the number of core cycles while t=
he thread is not in a halt state. The thread enters the halt state when it =
is running the HLT instruction. This event is a component in many key event=
 ratios. The core frequency may change from time to time due to transitions=
 associated with Enhanced Intel SpeedStep Technology or TM2. For this reaso=
n this event may have a changing ratio with regards to time. When the core =
frequency is constant, this event can approximate elapsed time while the co=
re was not in the halt state. It is counted on a dedicated fixed counter, l=
eaving the eight programmable counters available for other events.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Reference cycles when the core is not in =
halt state.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "34",
> > +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> > +        "PEBScounters": "34",
> > +        "PublicDescription": "Counts the number of reference cycles wh=
en the core is not in a halt state. The core enters the halt state when it =
is running the HLT instruction or the MWAIT instruction. This event is not =
affected by core frequency changes (for example, P states, TM2 transitions)=
 but has the same incrementing frequency as the time stamp counter. This ev=
ent can approximate elapsed time while the core was not in a halt state. Th=
is event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It =
is counted on a dedicated fixed counter, leaving the eight programmable cou=
nters available for other events. Note: On all current platforms this event=
 stops counting during 'throttling (TM)' states duty off periods the proces=
sor is 'halted'.  The counter update is done at a lower clock rate then the=
 core clock the overflow status bit for this counter may appear 'sticky'.  =
After the counter has overflowed and software clears the overflow status bi=
t and resets the counter to less than MAX. The reset value to the counter i=
s not clocked immediately so the overflow status bit will flip 'high (1)' a=
nd generate another PMI (if enabled) after which the reset value gets clock=
ed into the counter. Therefore, software will get the interrupt, read the o=
verflow status bit '1 for bit 34 while the counter value is less than MAX. =
Software should ignore this case.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x3"
> > +    },
> > +    {
> > +        "BriefDescription": "Loads blocked due to overlapping with a p=
receding store that cannot be forwarded.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x03",
> > +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of times where store f=
orwarding was prevented for a load operation. The most common case is a loa=
d blocked due to the address of memory access (partially) overlapping with =
a preceding uncompleted store. Note: See the table of not supported store f=
orwards in the Optimization Guide.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "The number of times that split load opera=
tions are temporarily blocked because all resources for handling the split =
accesses are in use.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x03",
> > +        "EventName": "LD_BLOCKS.NO_SR",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of times that split lo=
ad operations are temporarily blocked because all resources for handling th=
e split accesses are in use.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "False dependencies due to partial compare=
 on address.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x07",
> > +        "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of times a load got bl=
ocked due to false dependencies due to partial compare on address.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Core cycles the allocator was stalled due=
 to recovery from earlier clear event for this thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x0D",
> > +        "EventName": "INT_MISC.RECOVERY_CYCLES",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts core cycles when the Resource all=
ocator was stalled due to recovery from an earlier branch misprediction or =
machine clear event.",
> > +        "SampleAfterValue": "500009",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles the Backend cluster is recovering =
after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x0D",
> > +        "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles the Backend cluster is rec=
overing after a miss-speculation or a Store Buffer or Load Buffer drain sta=
ll.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x3"
> > +    },
> > +    {
> > +        "BriefDescription": "TMA slots where uops got dropped",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x0d",
> > +        "EventName": "INT_MISC.UOP_DROPPING",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Estimated number of Top-down Microarchit=
ecture Analysis slots that got dropped due to non front-end reasons",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts cycles after recovery from a branc=
h misprediction or machine clear till the first uop is issued from the rest=
eered path.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x0d",
> > +        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles after recovery from a branch misp=
rediction or machine clear till the first uop is issued from the resteered =
path.",
> > +        "SampleAfterValue": "500009",
> > +        "Speculative": "1",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Uops that RAT issues to RS",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x0e",
> > +        "EventName": "UOPS_ISSUED.ANY",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of uops that the Resou=
rce Allocation Table (RAT) issues to the Reservation Station (RS).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when RAT does not issue Uops to RS=
 for the thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x0E",
> > +        "EventName": "UOPS_ISSUED.STALL_CYCLES",
> > +        "Invert": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles during which the Resource =
Allocation Table (RAT) does not issue any Uops to the reservation station (=
RS) for the current thread.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Uops inserted at issue-stage in order to =
preserve upper bits of vector registers.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x0e",
> > +        "EventName": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of Blend Uops issued b=
y the Resource Allocation Table (RAT) to the reservation station (RS) in or=
der to preserve upper bits of vector registers. Starting with the Skylake m=
icroarchitecture, these Blend uops are needed since every Intel SSE instruc=
tion executed in Dirty Upper State needs to preserve bits 128-255 of the de=
stination register. For more information, refer to Mixing Intel AVX and Int=
el SSE Code section of the Optimization Guide.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when divide unit is busy executing=
 divide or square root operations.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x14",
> > +        "EventName": "ARITH.DIVIDER_ACTIVE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles when divide unit is busy e=
xecuting divide or square root operations. Accounts for integer and floatin=
g-point operations.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x9"
> > +    },
> > +    {
> > +        "BriefDescription": "Thread cycles when thread is not in halt =
state",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x3C",
> > +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "This is an architectural event that coun=
ts the number of thread cycles while the thread is not in a halt state. The=
 thread enters the halt state when it is running the HLT instruction. The c=
ore frequency may change from time to time due to power or thermal throttli=
ng. For this reason, this event may have a changing ratio with regards to w=
all clock time.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1"
> > +    },
> > +    {
> > +        "BriefDescription": "Core crystal clock cycles when the thread=
 is unhalted.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x3C",
> > +        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts core crystal clock cycles when th=
e thread is unhalted.",
> > +        "SampleAfterValue": "25003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Core crystal clock cycles when this threa=
d is unhalted and the other thread is halted.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x3C",
> > +        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts Core crystal clock cycles when cu=
rrent thread is unhalted and the other thread is halted.",
> > +        "SampleAfterValue": "25003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Core crystal clock cycles. Cycle counts a=
re evenly distributed between active threads in the Core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x3c",
> > +        "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "This event distributes Core crystal cloc=
k cycle counts between active hyperthreads, i.e., those in C0 sleep-state. =
A hyperthread becomes inactive when it executes the HLT or MWAIT instructio=
ns. If one thread is active in a core, all counts are attributed to this hy=
perthread. To obtain the full count when the Core is active, sum the counts=
 from each hyperthread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of demand load dispatch=
es that hit L1D fill buffer (FB) allocated for software prefetch.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x4c",
> > +        "EventName": "LOAD_HIT_PREFETCH.SWPF",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts all not software-prefetch load di=
spatches that hit the fill buffer (FB) allocated for the software prefetch.=
 It can also be incremented by some lock instructions. So it should only be=
 used with profiling so that the locks can be excluded by ASM (Assembly Fil=
e) inspection of the nearby instructions.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when Reservation Station (RS) is e=
mpty for the thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x5e",
> > +        "EventName": "RS_EVENTS.EMPTY_CYCLES",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles during which the reservati=
on station (RS) is empty for this logical processor. This is usually caused=
 when the front-end pipeline runs into stravation periods (e.g. branch misp=
redictions or i-cache misses)",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts end of periods where the Reservati=
on Station (RS) was empty.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EdgeDetect": "1",
> > +        "EventCode": "0x5E",
> > +        "EventName": "RS_EVENTS.EMPTY_END",
> > +        "Invert": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts end of periods where the Reservat=
ion Station (RS) was empty. Could be useful to closely sample on front-end =
latency issues (see the FRONTEND_RETIRED event of designated precise events=
)",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Stalls caused by changing prefix length o=
f the instruction.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x87",
> > +        "EventName": "ILD_STALL.LCP",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles that the Instruction Lengt=
h decoder (ILD) stalls occurred due to dynamically changing prefix length o=
f the decoded instruction (by operand size prefix instruction 0x66, address=
 size prefix instruction 0x67 or REX.W for Intel64). Count is proportional =
to the number of prefixes in a 16B-line. This may result in a three-cycle p=
enalty for each LCP (Length changing prefix) in a 16-byte chunk.",
> > +        "SampleAfterValue": "500009",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 0",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_0",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to port 0.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 1",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to port 1.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 2 and 3",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_2_3",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to ports 2 and 3.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 4 and 9",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_4_9",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to ports 5 and 9.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 5",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_5",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to port 5.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 6",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_6",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to port 6.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of uops executed on port 7 and 8",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa1",
> > +        "EventName": "UOPS_DISPATCHED.PORT_7_8",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station (R=
S) to ports 7 and 8.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts cycles where the pipeline is stall=
ed due to serializing operations.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa2",
> > +        "EventName": "RESOURCE_STALLS.SCOREBOARD",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles stalled due to no store buffers av=
ailable. (not including draining form sync).",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa2",
> > +        "EventName": "RESOURCE_STALLS.SB",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts allocation stall cycles caused by=
 the store buffer (SB) being full. This counts cycles that the pipeline bac=
k-end blocked uop delivery from the front-end.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles while L2 cache miss demand load is=
 outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0xA3",
> > +        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Total execution stalls.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "4",
> > +        "EventCode": "0xa3",
> > +        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Execution stalls while L2 cache miss dema=
nd load is outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "5",
> > +        "EventCode": "0xa3",
> > +        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x5"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles while L1 cache miss demand load is=
 outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "8",
> > +        "EventCode": "0xA3",
> > +        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Execution stalls while L1 cache miss dema=
nd load is outstanding.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "12",
> > +        "EventCode": "0xA3",
> > +        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0xc"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles while memory subsystem has an outs=
tanding load.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "16",
> > +        "EventCode": "0xA3",
> > +        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Execution stalls while memory subsystem h=
as an outstanding load.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "20",
> > +        "EventCode": "0xa3",
> > +        "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x14"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles total of 1 uop is executed on all =
ports and Reservation Station was not empty.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa6",
> > +        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles during which a total of 1 =
uop was executed on all ports and Reservation Station (RS) was not empty.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles total of 2 uops are executed on al=
l ports and Reservation Station was not empty.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa6",
> > +        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles during which a total of 2 =
uops were executed on all ports and Reservation Station (RS) was not empty.=
",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles total of 3 uops are executed on al=
l ports and Reservation Station was not empty.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa6",
> > +        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles total of 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles total of 4 uops are executed on al=
l ports and Reservation Station was not empty.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xa6",
> > +        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles total of 4 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where the Store Buffer was full an=
d no loads caused an execution stall.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "2",
> > +        "EventCode": "0xA6",
> > +        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles where the Store Buffer was=
 full and no loads caused an execution stall.",
> > +        "SampleAfterValue": "1000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of Uops delivered by the LSD.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xa8",
> > +        "EventName": "LSD.UOPS",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of uops delivered to t=
he back-end by the LSD(Loop Stream Detector).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles Uops delivered by the LSD, but did=
n't come from the decoder.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0xA8",
> > +        "EventName": "LSD.CYCLES_ACTIVE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the cycles when at least one uop =
is delivered by the LSD (Loop-stream detector).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles optimal number of Uops delivered b=
y the LSD, but did not come from the decoder.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "5",
> > +        "EventCode": "0xa8",
> > +        "EventName": "LSD.CYCLES_OK",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the cycles when optimal number of=
 uops is delivered by the LSD (Loop-stream detector).",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of uops to be executed =
per-thread each cycle.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xb1",
> > +        "EventName": "UOPS_EXECUTED.THREAD",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts number of cycles no uops were disp=
atched to be executed on this thread.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
> > +        "Invert": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles during which no uops were =
dispatched from the Reservation Station (RS) per thread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where at least 1 uop was executed =
per-thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0xb1",
> > +        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles where at least 1 uop was executed=
 per-thread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where at least 2 uops were execute=
d per-thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "2",
> > +        "EventCode": "0xb1",
> > +        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles where at least 2 uops were execut=
ed per-thread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where at least 3 uops were execute=
d per-thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "3",
> > +        "EventCode": "0xb1",
> > +        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles where at least 3 uops were execut=
ed per-thread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles where at least 4 uops were execute=
d per-thread",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "4",
> > +        "EventCode": "0xb1",
> > +        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Cycles where at least 4 uops were execut=
ed per-thread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles at least 1 micro-op is executed fr=
om any thread on physical core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles when at least 1 micro-op i=
s executed from any thread on physical core.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles at least 2 micro-op is executed fr=
om any thread on physical core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "2",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles when at least 2 micro-ops =
are executed from any thread on physical core.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles at least 3 micro-op is executed fr=
om any thread on physical core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "3",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles when at least 3 micro-ops =
are executed from any thread on physical core.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles at least 4 micro-op is executed fr=
om any thread on physical core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "4",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts cycles when at least 4 micro-ops =
are executed from any thread on physical core.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of x87 uops dispatched.=
",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xB1",
> > +        "EventName": "UOPS_EXECUTED.X87",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of x87 uops executed.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of instructions retired. General C=
ounter - architectural event",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc0",
> > +        "EventName": "INST_RETIRED.ANY_P",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> > +        "SampleAfterValue": "2000003"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles with less than 10 actually retired=
 uops.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "10",
> > +        "EventCode": "0xc2",
> > +        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
> > +        "Invert": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of cycles using always=
 true condition (uops_ret &amp;lt; 16) applied to non PEBS uops retired eve=
nt.",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Retirement slots used.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc2",
> > +        "EventName": "UOPS_RETIRED.SLOTS",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the retirement slots used each cy=
cle.",
> > +        "SampleAfterValue": "2000003",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of machine clears (nukes) of any t=
ype.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "CounterMask": "1",
> > +        "EdgeDetect": "1",
> > +        "EventCode": "0xc3",
> > +        "EventName": "MACHINE_CLEARS.COUNT",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of machine clears (nuk=
es) of any type.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Self-modifying code (SMC) detected.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc3",
> > +        "EventName": "MACHINE_CLEARS.SMC",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts self-modifying code (SMC) detecte=
d, which causes a machine clear.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "All branch instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts all branch instructions retired.",
> > +        "SampleAfterValue": "400009"
> > +    },
> > +    {
> > +        "BriefDescription": "Taken conditional branch instructions ret=
ired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.COND_TAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts taken conditional branch instruct=
ions retired.",
> > +        "SampleAfterValue": "400009",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Direct and indirect near call instruction=
s retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.NEAR_CALL",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts both direct and indirect near cal=
l instructions retired.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Return instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts return instructions retired.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x8"
> > +    },
> > +    {
> > +        "BriefDescription": "Not taken branch instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts not taken branch instructions ret=
ired.",
> > +        "SampleAfterValue": "400009",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Conditional branch instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.COND",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts conditional branch instructions r=
etired.",
> > +        "SampleAfterValue": "400009",
> > +        "UMask": "0x11"
> > +    },
> > +    {
> > +        "BriefDescription": "Taken branch instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts taken branch instructions retired=
=2E",
> > +        "SampleAfterValue": "400009",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Far branch instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts far branch instructions retired.",
> > +        "SampleAfterValue": "100007",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "All indirect branch instructions retired =
(excluding RETs. TSX aborts are considered indirect branch).",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.INDIRECT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts all indirect branch instructions =
retired (excluding RETs. TSX aborts is considered indirect branch).",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "All mispredicted branch instructions reti=
red.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts all the retired branch instructio=
ns that were mispredicted by the processor. A branch misprediction occurs w=
hen the processor incorrectly predicts the destination of the branch.  When=
 the misprediction is discovered at execution, all the instructions execute=
d in the wrong (speculative) path must be discarded, and the processor must=
 start fetching from the correct path.",
> > +        "SampleAfterValue": "50021"
> > +    },
> > +    {
> > +        "BriefDescription": "number of branch instructions retired tha=
t were mispredicted and taken. Non PEBS",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts taken conditional mispredicted br=
anch instructions retired.",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "Mispredicted non-taken conditional branch=
 instructions retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts the number of conditional branch =
instructions retired that were mispredicted and the branch direction was no=
t taken.",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Mispredicted conditional branch instructi=
ons retired.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.COND",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts mispredicted conditional branch i=
nstructions retired.",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x11"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of near branch instructions retire=
d that were mispredicted and taken.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts number of near branch instruction=
s retired that were mispredicted and taken.",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "All miss-predicted indirect branch instru=
ctions retired (excluding RETs. TSX aborts is considered indirect branch).",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc5",
> > +        "EventName": "BR_MISP_RETIRED.INDIRECT",
> > +        "PEBS": "1",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "Counts all miss-predicted indirect branc=
h instructions retired (excluding RETs. TSX aborts is considered indirect b=
ranch).",
> > +        "SampleAfterValue": "50021",
> > +        "UMask": "0x80"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of retired PAUSE instructions. Thi=
s event is not supported on first SKL and KBL products.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xcc",
> > +        "EventName": "MISC_RETIRED.PAUSE_INST",
> > +        "PublicDescription": "Counts number of retired PAUSE instructi=
ons. This event is not supported on first SKL and KBL products.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x40"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycle counts are evenly distributed betwe=
en active threads in the Core.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xec",
> > +        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
> > +        "PEBScounters": "0,1,2,3,4,5,6,7",
> > +        "PublicDescription": "This event distributes cycle counts betw=
een active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive=
 when it executes the HLT or MWAIT instructions.  If all other hyperthreads=
 are inactive (or disabled or do not exist), all counts are attributed to t=
his hyperthread. To obtain the full count when the Core is active, sum the =
counts from each hyperthread.",
> > +        "SampleAfterValue": "2000003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
> > new file mode 100644
> > index 000000000000..1b9d03039c53
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
> > @@ -0,0 +1,245 @@
> > +[
> > +    {
> > +        "BriefDescription": "Page walks completed due to a demand data=
 load to a 4K page.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (4K sizes) =
caused by demand data loads. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Page walks completed due to a demand data=
 load to a 2M/4M page.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (2M/4M size=
s) caused by demand data loads. This implies address translations missed in=
 the DTLB and further levels of TLB. The page walk can end with or without =
a fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Load miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data loads. This implies it missed in the DTLB and f=
urther levels of TLB. The page walk can end with or without a fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of page walks outstanding for a de=
mand load in the PMH each cycle.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of page walks outstand=
ing for a demand load in the PMH (Page Miss Handler) each cycle.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for a demand load.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles when at least one PMH (Pag=
e Miss Handler) is busy with a page walk for a demand load.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Loads that miss the DTLB and hit the STLB=
=2E",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x08",
> > +        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts loads that miss the DTLB (Data TL=
B) and hit the STLB (Second level TLB).",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Page walks completed due to a demand data=
 store to a 4K page.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (4K sizes) =
caused by demand data stores. This implies address translations missed in t=
he DTLB and further levels of TLB. The page walk can end with or without a =
fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Page walks completed due to a demand data=
 store to a 2M/4M page.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (2M/4M size=
s) caused by demand data stores. This implies address translations missed i=
n the DTLB and further levels of TLB. The page walk can end with or without=
 a fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Store misses in all TLB levels causes a p=
age walk that completes. (All page sizes)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data stores. This implies it missed in the DTLB and =
further levels of TLB. The page walk can end with or without a fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of page walks outstanding for a st=
ore in the PMH each cycle.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of page walks outstand=
ing for a store in the PMH (Page Miss Handler) each cycle.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for a store.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles when at least one PMH (Pag=
e Miss Handler) is busy with a page walk for a store.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Stores that miss the DTLB and hit the STL=
B.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x49",
> > +        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts stores that miss the DTLB (Data T=
LB) and hit the STLB (2nd Level TLB).",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (4K)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks (4K page siz=
es) caused by a code fetch. This implies it missed in the ITLB (Instruction=
 TLB) and further levels of TLB. The page walk can end with or without a fa=
ult.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x2"
> > +    },
> > +    {
> > +        "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (2M/4M)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks (2M/4M page =
sizes) caused by a code fetch. This implies it missed in the ITLB (Instruct=
ion TLB) and further levels of TLB. The page walk can end with or without a=
 fault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x4"
> > +    },
> > +    {
> > +        "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts completed page walks (all page si=
zes) caused by a code fetch. This implies it missed in the ITLB (Instructio=
n TLB) and further levels of TLB. The page walk can end with or without a f=
ault.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0xe"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of page walks outstanding for an o=
utstanding code request in the PMH each cycle.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.WALK_PENDING",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of page walks outstand=
ing for an outstanding code (instruction fetch) request in the PMH (Page Mi=
ss Handler) each cycle.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for code (instruction fetch) request.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "CounterMask": "1",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.WALK_ACTIVE",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts cycles when at least one PMH (Pag=
e Miss Handler) is busy with a page walk for a code (instruction fetch) req=
uest.",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x10"
> > +    },
> > +    {
> > +        "BriefDescription": "Instruction fetch requests that miss the =
ITLB and hit the STLB.",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x85",
> > +        "EventName": "ITLB_MISSES.STLB_HIT",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts instruction fetch requests that m=
iss the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
> > +        "SampleAfterValue": "100003",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    },
> > +    {
> > +        "BriefDescription": "DTLB flush attempts of the thread-specifi=
c entries",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xBD",
> > +        "EventName": "TLB_FLUSH.DTLB_THREAD",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of DTLB flush attempts=
 of the thread-specific entries.",
> > +        "SampleAfterValue": "100007",
> > +        "Speculative": "1",
> > +        "UMask": "0x1"
> > +    },
> > +    {
> > +        "BriefDescription": "STLB flush attempts",
> > +        "CollectPEBSRecord": "2",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0xBD",
> > +        "EventName": "TLB_FLUSH.STLB_ANY",
> > +        "PEBScounters": "0,1,2,3",
> > +        "PublicDescription": "Counts the number of any STLB flush atte=
mpts (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
> > +        "SampleAfterValue": "100007",
> > +        "Speculative": "1",
> > +        "UMask": "0x20"
> > +    }
> > +]
> > \ No newline at end of file
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pm=
u-events/arch/x86/mapfile.csv
> > index 0a6a8c7f937f..5f5df6560202 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -38,6 +38,8 @@ GenuineIntel-6-7D,v1,icelake,core
> >  GenuineIntel-6-7E,v1,icelake,core
> >  GenuineIntel-6-8[CD],v1,icelake,core
> >  GenuineIntel-6-A7,v1,icelake,core
> > +GenuineIntel-6-6A,v1,icelakex,core
> > +GenuineIntel-6-6C,v1,icelakex,core
> >  GenuineIntel-6-86,v1,tremontx,core
> >  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
> >  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> > --
> > 2.17.1
> >

--=20

- Arnaldo
