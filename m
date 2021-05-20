Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F538B40C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhETQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhETQKR (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:10:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB96C061574
        for <Linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:08:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so5558100wmf.1
        for <Linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1zFFFGsFzYD+EgjPSATCWF8XjQ314uLUCg4hj2NH1NM=;
        b=FyncQXu8G4YfJVWE0nMUQHBsFrWU+u8bmx5JTJ8DlA39HUi3PS5+0/UY8FJ8ZYpa4o
         e+wntk+Va+bN0zYR98j9yQBUbmVn/qcVxwtxoYE+iywU/cR1pyCaTOcANPWE9hR7oymo
         X2diNV76jzxGLzJ7CWoBPx4qEU/9HbZAz0neyljWBWxC3EWMIy2GqPAH/GSAJaYcgBXs
         UVGoIKP05RErCaisUykcgQdRTQ9y1vZQIg4PBNomCXWU0r8ZFa9uCwu7Z6aGmnEtkJIm
         jlch1izCHtewSNZJab96B2mnZCF0U0KkR7rMOt1oFHPErdOHuR1pvIJEkhbVkX71qwos
         kKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1zFFFGsFzYD+EgjPSATCWF8XjQ314uLUCg4hj2NH1NM=;
        b=gaN1+8s7i4MDBo8KkSDxtOk2ihJtp7ozA0URunVkJsoQ4jQJhltQ/t9bXVgwkM+r1T
         ssxGg/pcjYtgyRsAocOfZFdS8n0elQxXfhP6eJOUXyj+q+23rfu5mCnV4AP01gCxPHJV
         uAcBixorgpO4BBW2uJ3qWz4SKPUjRdrqiVoU8B6W+/RlleWLeaDR3t6kV4QBFhDiYBCQ
         baBRuhNLxUgh4M94T0PI70ORuhsQKDkgGuD+KwbsaogrsLLi0ZV9cRe5Skb3BPtYvMi7
         PUln+M1tAT3OX/B1bHcBQjQ25VIznF1PbDSlpiQyp4sEo36KtRNpZyMYrQDXy90MhXyk
         1qNg==
X-Gm-Message-State: AOAM532/PmUC8T+39P+mPShgcOSK1W2Q4SEWWy9rdB7FX0ARj6doL8sI
        bip3CKiY48pFkXPUU2+xsPHg4W5B3mJRDnHZ3q3ZISbc/AnoNA==
X-Google-Smtp-Source: ABdhPJw3gXo0MsYVWpjTYoW/vknqNpXHopk3TSen9moYAh4j681/4QrEwqJeagjbaU1uaQxEqJupVP6sXQJrI2FZW5k=
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr4778268wmb.58.1621526931766;
 Thu, 20 May 2021 09:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210510012438.6293-1-yao.jin@linux.intel.com> <20210510012438.6293-2-yao.jin@linux.intel.com>
In-Reply-To: <20210510012438.6293-2-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 May 2021 09:08:37 -0700
Message-ID: <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events: Add core event list for Icelake Server
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 9, 2021 at 6:26 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> Add JSON core events for Icelake Server to perf.
>
> Based on JSON list v1.04
> https://download.01.org/perfmon/ICX/
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/x86/icelakex/cache.json   | 706 +++++++++++++
>  .../arch/x86/icelakex/floating-point.json     |  95 ++
>  .../arch/x86/icelakex/frontend.json           | 469 +++++++++
>  .../pmu-events/arch/x86/icelakex/memory.json  | 291 ++++++
>  .../pmu-events/arch/x86/icelakex/other.json   | 181 ++++
>  .../arch/x86/icelakex/pipeline.json           | 972 ++++++++++++++++++
>  .../arch/x86/icelakex/virtual-memory.json     | 245 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +
>  8 files changed, 2961 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/floating-poin=
t.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/virtual-memor=
y.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/p=
erf/pmu-events/arch/x86/icelakex/cache.json
> new file mode 100644
> index 000000000000..624762008aaa
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
> @@ -0,0 +1,706 @@
> +[
> +    {
> +        "BriefDescription": "Demand Data Read miss L2, no rejects",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of demand Data Read requ=
ests that miss L2 cache. Only not rejected loads are counted.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x21"
> +    },
> +    {
> +        "BriefDescription": "RFO requests that miss L2 cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.RFO_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the RFO (Read-for-Ownership) reques=
ts that miss L2 cache.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x22"
> +    },
> +    {
> +        "BriefDescription": "L2 cache misses when fetching instructions"=
,
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.CODE_RD_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts L2 cache misses when fetching instr=
uctions.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x24"
> +    },
> +    {
> +        "BriefDescription": "Demand requests that miss L2 cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts demand requests that miss L2 cache.=
",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x27"
> +    },
> +    {
> +        "BriefDescription": "SW prefetch requests that miss L2 cache.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.SWPF_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts Software prefetch requests that mis=
s the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 inst=
ructions.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x28"
> +    },
> +    {
> +        "BriefDescription": "Demand Data Read requests that hit L2 cache=
",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of demand Data Read requ=
ests initiated by load instructions that hit L2 cache.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xc1"
> +    },
> +    {
> +        "BriefDescription": "RFO requests that hit L2 cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.RFO_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the RFO (Read-for-Ownership) reques=
ts that hit L2 cache.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xc2"
> +    },
> +    {
> +        "BriefDescription": "L2 cache hits when fetching instructions, c=
ode reads.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.CODE_RD_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts L2 cache hits when fetching instruc=
tions, code reads.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xc4"
> +    },
> +    {
> +        "BriefDescription": "SW prefetch requests that hit L2 cache.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.SWPF_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts Software prefetch requests that hit=
 the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 instr=
uctions.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xc8"
> +    },
> +    {
> +        "BriefDescription": "Demand Data Read requests",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of demand Data Read requ=
ests (including requests from L1D hardware prefetchers). These loads may hi=
t or miss L2 cache. Only non rejected loads are counted.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xe1"
> +    },
> +    {
> +        "BriefDescription": "RFO requests to L2 cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.ALL_RFO",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of RFO (read for o=
wnership) requests to L2 cache. L2 RFO requests include both L1D demand RFO=
 misses as well as L1D RFO prefetches.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xe2"
> +    },
> +    {
> +        "BriefDescription": "L2 code requests",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_RQSTS.ALL_CODE_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of L2 code request=
s.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0xe4"
> +    },
> +    {
> +        "BriefDescription": "Core-originated cacheable demand requests m=
issed L3",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts core-originated cacheable requests =
that miss the L3 cache (Longest Latency cache). Requests include data and c=
ode reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pr=
efetches from L1 and L2. It does not include all misses to the L3.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of L1D misses that are outstanding",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.PENDING",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts number of L1D misses that are outst=
anding in each cycle, that is each cycle the number of Fill Buffers (FB) ou=
tstanding required by Demand Reads. FB either is held by demand loads, or i=
t is held by non-demand loads and gets hit at least once by demand. The val=
id outstanding interval is defined until the FB deallocation by one of the =
following ways: from FB allocation, if FB is allocated by demand from the d=
emand Hit FB, if it is allocated by hardware or software prefetch. Note: In=
 the L1D, a Demand Read contains cacheable or noncacheable demand loads, in=
cluding ones causing cache-line splits and reads due to page walks resulted=
 from any request type.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles with L1D load Misses outstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts duration of L1D miss outstanding in=
 cycles.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of cycles a demand request has waite=
d due to L1D Fill Buffer (FB) unavailability.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.FB_FULL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts number of cycles a demand request h=
as waited due to L1D Fill Buffer (FB) unavailablability. Demand requests in=
clude cacheable/uncacheable demand load, store, lock or SW prefetch accesse=
s.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of phases a demand request has waite=
d due to L1D Fill Buffer (FB) unavailablability.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EdgeDetect": "1",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts number of phases a demand request h=
as waited due to L1D Fill Buffer (FB) unavailablability. Demand requests in=
clude cacheable/uncacheable demand load, store, lock or SW prefetch accesse=
s.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of cycles a demand request has waite=
d due to L1D due to lack of L2 resources.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.L2_STALL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts number of cycles a demand request h=
as waited due to L1D due to lack of L2 resources. Demand requests include c=
acheable/uncacheable demand load, store, lock or SW prefetch accesses.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cache lines replaced i=
n L1 data cache.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x51",
> +        "EventName": "L1D.REPLACEMENT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts L1D data line replacements includin=
g opportunistic replacements, and replacements that require stall-for-repla=
ce or block-for-replace.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "For every cycle where the core is waiting o=
n at least 1 outstanding Demand RFO request, increments by 1.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x60",
> +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RF=
O",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "For every cycle where the core is waiting =
on at least 1 outstanding demand RFO request, increments by 1.   RFOs are i=
nitiated by a core as part of a data store operation.  Demand RFO requests =
include RFOs, locks, and ItoM transactions.  Requests are considered outsta=
nding from the time they miss the core's L2 cache until the transaction com=
pletion message is sent to the requestor.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "For every cycle, increments by the number o=
f outstanding data read requests the core is waiting on.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x60",
> +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "For every cycle, increments by the number =
of outstanding data read requests the core is waiting on.  Data read reques=
ts include cacheable demand reads and L2 prefetches, but do not include RFO=
s, code reads or prefetches to the L3.  Reads due to page walks resulting f=
rom any request type will also be counted.  Requests are considered outstan=
ding from the time they miss the core's L2 cache until the transaction comp=
letion message is sent to the requestor.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "For every cycle where the core is waiting o=
n at least 1 outstanding demand data read request, increments by 1.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x60",
> +        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "For every cycle where the core is waiting =
on at least 1 outstanding data read request, increments by 1.  Data read re=
quests include cacheable demand reads and L2 prefetches, but do not include=
 RFOs, code reads or prefetches to the L3.  Reads due to page walks resulti=
ng from any request type will also be counted.  Requests are considered out=
standing from the time they miss the core's L2 cache until the transaction =
completion message is sent to the requestor.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Demand Data Read requests sent to uncore",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xb0",
> +        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the Demand Data Read requests sent =
to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to deter=
mine average latency in the uncore.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Demand and prefetch data reads",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB0",
> +        "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the demand and prefetch data reads.=
 All Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3=
 prefetchers). Counting also covers reads due to page walks resulted from a=
ny request type.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts memory transactions sent to the unco=
re.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB0",
> +        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts memory transactions sent to the unc=
ore including requests initiated by the core, all L3 prefetches, reads resu=
lting from page walks, and snoop responses.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions that miss the STL=
B.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions that true=
 miss the STLB.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x11"
> +    },
> +    {
> +        "BriefDescription": "Retired store instructions that miss the ST=
LB.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
> +        "L1_Hit_Indication": "1",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired store instructions that tru=
e miss the STLB.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x12"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions with locked acces=
s.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with lock=
ed access.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x21"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions that split across=
 a cacheline boundary.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions that spli=
t across a cacheline boundary.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x41"
> +    },
> +    {
> +        "BriefDescription": "Retired store instructions that split acros=
s a cacheline boundary.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
> +        "L1_Hit_Indication": "1",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired store instructions that spl=
it across a cacheline boundary.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x42"
> +    },
> +    {
> +        "BriefDescription": "All retired load instructions.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts all retired load instructions. This=
 event accounts for SW prefetch instructions for loads.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x81"
> +    },
> +    {
> +        "BriefDescription": "All retired store instructions.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.ALL_STORES",
> +        "L1_Hit_Indication": "1",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts all retired store instructions. Thi=
s event account for SW prefetch instructions and PREFETCHW instruction for =
stores.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x82"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions with L1 cache hit=
s as data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with at l=
east one uop that hit in the L1 data cache. This event includes all SW pref=
etches and lock instructions regardless of the data source.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions with L2 cache hit=
s as data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with L2 c=
ache hits as data sources.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions with L3 cache hit=
s as data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with at l=
east one uop that hit in the L3 cache.",
> +        "SampleAfterValue": "100021",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions missed L1 cache a=
s data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with at l=
east one uop that missed in the L1 cache.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions missed L2 cache a=
s data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions missed L2=
 cache as data sources.",
> +        "SampleAfterValue": "100021",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions missed L3 cache a=
s data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with at l=
east one uop that missed in the L3 cache.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Number of completed demand load requests th=
at missed the L1, but hit the FB(fill buffer), because a preceding miss to =
the same cacheline initiated the line to be brought into L1, but data is no=
t yet ready in L1.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions with at l=
east one uop was load missed in L1 but hit FB (Fill Buffers) due to precedi=
ng miss to the same cache line with data not ready.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Retired demand load instructions which miss=
ed L3 but serviced from local IXP memory as data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s were L3 hit and cross-core snoop missed in on-pkg core cache.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the retired load instructions whose=
 data sources were L3 hit and cross-core snoop missed in on-pkg core cache.=
",
> +        "SampleAfterValue": "20011",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "20011",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s were L3 and cross-core snoop hits in on-pkg core cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions whose dat=
a sources were L3 and cross-core snoop hits in on-pkg core cache.",
> +        "SampleAfterValue": "20011",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "20011",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s were HitM responses from shared L3",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions whose dat=
a sources were HitM responses from shared L3.",
> +        "SampleAfterValue": "20011",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s were hits in L3 without snoops required",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts retired load instructions whose dat=
a sources were hits in L3 without snoops required.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions which data source=
s missed L3 but serviced from local dram",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd3",
> +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Retired load instructions which data sourc=
es missed L3 but serviced from local DRAM.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions which data source=
s missed L3 but serviced from remote dram",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd3",
> +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s was remote HITM",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd3",
> +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Retired load instructions whose data sourc=
es was remote HITM.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions whose data source=
s was forwarded from a remote cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd3",
> +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Retired load instructions whose data sourc=
es was forwarded from a remote cache.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Retired demand load instructions which miss=
ed L3 but serviced from remote IXP memory as data sources",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd3",
> +        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Retired load instructions which data sourc=
e was serviced from L4",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "L2 writebacks that access L2 cache",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xF0",
> +        "EventName": "L2_TRANS.L2_WB",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts L2 writebacks that access L2 cache.=
",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "L2 cache lines filling L2",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xF1",
> +        "EventName": "L2_LINES_IN.ALL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of L2 cache lines fillin=
g the L2. Counting does not cover rejects.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1f"
> +    },
> +    {
> +        "BriefDescription": "Non-modified cache lines that are silently =
dropped by L2 cache when triggered by an L2 cache fill.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xF2",
> +        "EventName": "L2_LINES_OUT.SILENT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of lines that are silent=
ly dropped by L2 cache when triggered by an L2 cache fill. These lines are =
typically in Shared or Exclusive state. A non-threaded event.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cache lines that are evicted by L2 cache wh=
en triggered by an L2 cache fill.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xF2",
> +        "EventName": "L2_LINES_OUT.NON_SILENT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of lines that are evicte=
d by the L2 cache due to L2 cache fills.  Evicted lines are delivered to th=
e L3, which may or may not cache them, according to system load and priorit=
ies.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles the queue waiting for offcore respon=
ses is full.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xf4",
> +        "EventName": "SQ_MISC.SQ_FULL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the cycles for which the thread is =
active and the queue waiting for responses from the uncore cannot take any =
more entries.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json =
b/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> new file mode 100644
> index 000000000000..bcedcd985e84
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> @@ -0,0 +1,95 @@
> +[
> +    {
> +        "BriefDescription": "Counts all microcode FP assists.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc1",
> +        "EventName": "ASSISTS.FP",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts all microcode Floating Point assist=
s.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational scal=
ar double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SSE* and AVX* scalar double precision floating-point ins=
tructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instruc=
tions count twice as they perform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational scal=
ar single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SSE* and AVX* scalar single precision floating-point ins=
tructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/S=
UB instructions count twice as they perform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational 128-=
bit packed double precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 2 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed doubl=
e precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV M=
IN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twic=
e as they perform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of SSE/AVX computational 128-bit pac=
ked single precision floating-point instructions retired; some instructions=
 will count twice as noted below.  Each count represents 4 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQR=
T DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they =
perform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts number of SSE/AVX computational 128=
-bit packed single precision floating-point instructions retired; some inst=
ructions will count twice as noted below.  Each count represents 4 computat=
ion operations, one for each element.  Applies to SSE* and AVX* packed sing=
le precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV =
MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions=
 count twice as they perform 2 calculations per element.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational 256-=
bit packed double precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 4 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed doubl=
e precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV M=
IN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational 256-=
bit packed single precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 8 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed singl=
e precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV M=
IN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions =
count twice as they perform 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational 512-=
bit packed double precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 8 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed doubl=
e precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT=
14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perfor=
m 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts number of SSE/AVX computational 512-=
bit packed double precision floating-point instructions retired; some instr=
uctions will count twice as noted below.  Each count represents 16 computat=
ion operations, one for each element.  Applies to SSE* and AVX* packed doub=
le precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQR=
T14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perfo=
rm 2 calculations per element.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc7",
> +        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x80"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/tool=
s/perf/pmu-events/arch/x86/icelakex/frontend.json
> new file mode 100644
> index 000000000000..cc59cee1cd57
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
> @@ -0,0 +1,469 @@
> +[
> +    {
> +        "BriefDescription": "Uops delivered to Instruction Decode Queue =
(IDQ) from MITE path",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.MITE_UOPS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of uops delivered to Ins=
truction Decode Queue (IDQ) from the MITE path. This also means that uops a=
re not being delivered from the Decode Stream Buffer (DSB).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Cycles MITE is delivering optimal number of=
 Uops",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "5",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.MITE_CYCLES_OK",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of cycles where optimal =
number of uops was delivered to the Instruction Decode Queue (IDQ) from the=
 MITE (legacy decode pipeline) path. During these cycles uops are not being=
 delivered from the Decode Stream Buffer (DSB).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Cycles MITE is delivering any Uop",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.MITE_CYCLES_ANY",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of cycles uops were deli=
vered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pi=
peline) path. During these cycles uops are not being delivered from the Dec=
ode Stream Buffer (DSB).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Uops delivered to Instruction Decode Queue =
(IDQ) from the Decode Stream Buffer (DSB) path",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.DSB_UOPS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of uops delivered to Ins=
truction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Cycles DSB is delivering optimal number of =
Uops",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "5",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.DSB_CYCLES_OK",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of cycles where optimal =
number of uops was delivered to the Instruction Decode Queue (IDQ) from the=
 MITE (legacy decode pipeline) path. During these cycles uops are not being=
 delivered from the Decode Stream Buffer (DSB).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delive=
ring any Uop",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.DSB_CYCLES_ANY",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of cycles uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of switches from DSB or MITE to the =
MS",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EdgeDetect": "1",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.MS_SWITCHES",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Number of switches from DSB (Decode Stream=
 Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x30"
> +    },
> +    {
> +        "BriefDescription": "Uops delivered to IDQ while MS is busy",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x79",
> +        "EventName": "IDQ.MS_UOPS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of uops delivered =
by the Microcode Sequencer (MS). Any instruction over 4 uops will be delive=
red by the MS. Some instructions such as transcendentals may additionally g=
enerate uops from the MS.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x30"
> +    },
> +    {
> +        "BriefDescription": "Cycles where a code fetch is stalled due to=
 L1 instruction cache miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE_16B.IFDATA_STALL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles where a code line fetch is s=
talled due to an L1 instruction cache miss. The legacy decode pipeline work=
s at a 16 Byte granularity.",
> +        "SampleAfterValue": "500009",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Instruction fetch tag lookups that hit in t=
he instruction cache (L1I). Counts at 64-byte cache-line granularity.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x83",
> +        "EventName": "ICACHE_64B.IFTAG_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts instruction fetch tag lookups that =
hit in the instruction cache (L1I). Counts at 64-byte cache-line granularit=
y. Accounts for both cacheable and uncacheable accesses.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Instruction fetch tag lookups that miss in =
the instruction cache (L1I). Counts at 64-byte cache-line granularity.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x83",
> +        "EventName": "ICACHE_64B.IFTAG_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts instruction fetch tag lookups that =
miss in the instruction cache (L1I). Counts at 64-byte cache-line granulari=
ty. Accounts for both cacheable and uncacheable accesses.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles where a code fetch is stalled due to=
 L1 instruction cache tag miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x83",
> +        "EventName": "ICACHE_64B.IFTAG_STALL",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles where a code fetch is stalle=
d due to L1 instruction cache tag miss.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Uops not delivered by IDQ when backend of t=
he machine is not stalled",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of uops not delivered to=
 by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when=
 there was no back-end stalls. This event counts for one SMT thread in a gi=
ven cycle.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles when no uops are not delivered by th=
e IDQ when backend of the machine is not stalled",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "5",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of cycles when no uops w=
ere delivered by the Instruction Decode Queue (IDQ) to the back-end of the =
pipeline when there was no back-end stalls. This event counts for one SMT t=
hread in a given cycle.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles when optimal number of uops was deli=
vered to the back-end when the back-end is not stalled",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0x9C",
> +        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
> +        "Invert": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of cycles when the optim=
al number of uops were delivered by the Instruction Decode Queue (IDQ) to t=
he back-end of the pipeline when there was no back-end stalls. This event c=
ounts for one SMT thread in a given cycle.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xab",
> +        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache =
that holds translations of previously fetched instructions that were decode=
d by the legacy x86 decode pipeline (MITE). This event counts fetch penalty=
 cycles when a transition occurs from DSB to MITE.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transiti=
ons count.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EdgeDetect": "1",
> +        "EventCode": "0xab",
> +        "EventName": "DSB2MITE_SWITCHES.COUNT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of Decode Stream Buffer =
(DSB a.k.a. Uop Cache)-to-MITE speculative transitions.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Retired Instructions who experienced DSB mi=
ss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.DSB_MISS",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x11",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired Instructions that experienc=
ed DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired Instructions who experienced Instru=
ction L1 Cache true miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.L1I_MISS",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x12",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired Instructions who experience=
d Instruction L1 Cache true miss.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired Instructions who experienced Instru=
ction L2 Cache true miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.L2_MISS",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x13",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired Instructions who experience=
d Instruction L2 Cache true miss.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired Instructions who experienced iTLB t=
rue miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x14",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired Instructions that experienc=
ed iTLB (Instruction TLB) true miss.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired Instructions who experienced STLB (=
2nd level TLB) true miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.STLB_MISS",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x15",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired Instructions that experienc=
ed STLB (2nd level TLB) true miss.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions after front-end starva=
tion of at least 2 cycles",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x500206",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Retired instructions that are fetched afte=
r an interval where the front-end delivered no uops for a period of at leas=
t 2 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 4 cycles=
 which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x500406",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
4 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 8 cycles=
 which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x500806",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 8 cycles. During t=
his period the front-end delivered no uops.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 16 cycle=
s which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x501006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 16 cycles. During =
this period the front-end delivered no uops.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 32 cycle=
s which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x502006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 32 cycles. During =
this period the front-end delivered no uops.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 64 cycle=
s which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x504006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
64 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 128 cycl=
es which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x508006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
128 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 256 cycl=
es which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x510006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
256 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end delivered no uops for a period of 512 cycl=
es which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x520006",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
512 cycles which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions that are fetched after=
 an interval where the front-end had at least 1 bubble-slot for a period of=
 2 cycles which was not interrupted by a back-end stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x100206",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after the front-end had at least 1 bubble-slot for a p=
eriod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while ther=
e was no RAT stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Retired instructions after front-end starva=
tion of at least 1 cycle",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc6",
> +        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
> +        "MSRIndex": "0x3F7",
> +        "MSRValue": "0x500106",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Retired instructions that are fetched afte=
r an interval where the front-end delivered no uops for a period of at leas=
t 1 cycle which was not interrupted by a back-end stall.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number when the front end =
is resteered, mainly when the BPU cannot provide a correct prediction and t=
his is corrected by other branch handling mechanisms at the front end.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xe6",
> +        "EventName": "BACLEARS.ANY",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of times the front-end i=
s resteered when it finds a branch instruction in a fetch line. This occurs=
 for the first time a branch instruction is fetched or when the branch is n=
ot tracked by the BPU (Branch Prediction Unit) anymore.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/=
perf/pmu-events/arch/x86/icelakex/memory.json
> new file mode 100644
> index 000000000000..d319d448e2aa
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
> @@ -0,0 +1,291 @@
> +[
> +    {
> +        "BriefDescription": "Number of times a transactional abort was s=
ignaled due to a data conflict on a transactionally accessed address",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x54",
> +        "EventName": "TX_MEM.ABORT_CONFLICT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of times a TSX line had =
a cache conflict.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Speculatively counts the number of TSX abor=
ts due to a data capacity limitation for transactional writes.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x54",
> +        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Speculatively counts the number of Transac=
tional Synchronization Extensions (TSX) aborts due to a data capacity limit=
ation for transactional writes.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Speculatively counts the number of TSX abor=
ts due to a data capacity limitation for transactional reads",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x54",
> +        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Speculatively counts the number of Transac=
tional Synchronization Extensions (TSX) aborts due to a data capacity limit=
ation for transactional reads",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of times a class of instr=
uctions that may cause a transactional abort was executed inside a transact=
ional region",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x5d",
> +        "EventName": "TX_EXEC.MISC2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts Unfriendly TSX abort triggered by a=
 vzeroupper instruction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of times an instruction execution ca=
used the transactional nest count supported to be exceeded",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x5d",
> +        "EventName": "TX_EXEC.MISC3",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts Unfriendly TSX abort triggered by a=
 nest count that is too deep.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Execution stalls while L3 cache miss demand=
 load is outstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "6",
> +        "EventCode": "0xa3",
> +        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x6"
> +    },
> +    {
> +        "BriefDescription": "Number of machine clears due to memory orde=
ring conflicts.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of Machine Clears detect=
ed dye to memory ordering. Memory Ordering Machine Clears may apply when a =
memory read may not conform to the memory ordering rules of the x86 archite=
cture",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution started.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.START",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times we entered an R=
TM region. Does not count nested transactions.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution successful=
ly committed",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.COMMIT",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times RTM commit succ=
eeded.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution aborted.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.ABORTED",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times RTM abort was t=
riggered.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution aborted du=
e to various memory events (e.g. read/write capacity and conflicts)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.ABORTED_MEM",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times an RTM executio=
n aborted due to various memory events (e.g. read/write capacity and confli=
cts).",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution aborted du=
e to HLE-unfriendly instructions",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times an RTM executio=
n aborted due to HLE-unfriendly instructions.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution aborted du=
e to incompatible memory type",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times an RTM executio=
n aborted due to incompatible memory type.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Number of times an RTM execution aborted du=
e to none of the previous 4 categories (e.g. interrupt)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc9",
> +        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of times an RTM executio=
n aborted due to none of the previous 4 categories (e.g. interrupt).",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 4 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x4",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 4 cycles.  Reported=
 latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100003",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 8 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x8",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 8 cycles.  Reported=
 latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "50021",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 16 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x10",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 16 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "20011",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 32 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x20",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 32 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 64 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x40",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 64 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "2003",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 128 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x80",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 128 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "1009",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 256 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x100",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 256 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "503",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 512 cycles.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x200",
> +        "PEBS": "2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 512 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "101",
> +        "TakenAlone": "1",
> +        "UMask": "0x1"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/p=
erf/pmu-events/arch/x86/icelakex/other.json
> new file mode 100644
> index 000000000000..ef50d3a3392e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
> @@ -0,0 +1,181 @@
> +[
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "35",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PEBScounters": "35",
> +        "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Core cycles where the core was running in a=
 manner where Turbo may be clipped to the Non-AVX turbo schedule.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x28",
> +        "EventName": "CORE_POWER.LVL0_TURBO_LICENSE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts Core cycles where the core was runn=
ing with power-delivery for baseline license level 0.  This includes non-AV=
X codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x7"
> +    },
> +    {
> +        "BriefDescription": "Core cycles where the core was running in a=
 manner where Turbo may be clipped to the AVX2 turbo schedule.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x28",
> +        "EventName": "CORE_POWER.LVL1_TURBO_LICENSE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts Core cycles where the core was runn=
ing with power-delivery for license level 1.  This includes high current AV=
X 256-bit instructions as well as low current AVX 512-bit instructions.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x18"
> +    },
> +    {
> +        "BriefDescription": "Core cycles where the core was running in a=
 manner where Turbo may be clipped to the AVX512 turbo schedule.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x28",
> +        "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Core cycles where the core was running wit=
h power-delivery for license level 2 (introduced in Skylake Server microarc=
htecture).  This includes high current AVX 512-bit instructions.",
> +        "SampleAfterValue": "200003",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHNTA instructions executed=
.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHNTA instructi=
ons executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT0 instructions executed.=
",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T0",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT0 instructio=
ns executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instruct=
ions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETC=
HT2 instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHW instructions executed."=
,
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHW instruction=
s executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical=
 processor. General counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.SLOTS_P",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of available slots for a=
n unhalted logical processor. The event increments by machine-width of the =
narrowest pipeline as employed by the Top-down Microarchitecture Analysis m=
ethod. The count is distributed among unhalted logical processors (hyper-th=
reads) who share the same physical core.",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "TMA slots where no uops were being issued d=
ue to lack of back-end resources.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of Top-down Microarchite=
cture Analysis (TMA) method's  slots where no micro-operations were being i=
ssued from front-end to back-end of the machine due to lack of back-end res=
ources.",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of occurrences where a microcode ass=
ist is invoked by hardware.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc1",
> +        "EventName": "ASSISTS.ANY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of occurrences where a m=
icrocode assist is invoked by hardware Examples include AD (page Access Dir=
ty), FP and AVX related assists.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x7"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheli=
ne in the L3 where a snoop hit in another cores caches, data forwarding is =
required as the data is modified.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only wi=
th a specific pair of event select and counter MSR, and with specific event=
 codes and predefine mask bit value in a dedicated MSR to specify attribute=
s of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheli=
ne in the L3 where a snoop hit in another cores caches which forwarded the =
unmodified data to the requesting core.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only wi=
th a specific pair of event select and counter MSR, and with specific event=
 codes and predefine mask bit value in a dedicated MSR to specify attribute=
s of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts writes that generate a demand reads =
for ownership (RFO) request and software prefetches for exclusive ownership=
 (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another co=
res caches, data forwarding is required as the data is modified.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only wi=
th a specific pair of event select and counter MSR, and with specific event=
 codes and predefine mask bit value in a dedicated MSR to specify attribute=
s of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores that have any type =
of response.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10800",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only wi=
th a specific pair of event select and counter MSR, and with specific event=
 codes and predefine mask bit value in a dedicated MSR to specify attribute=
s of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/icelakex/pipeline.json
> new file mode 100644
> index 000000000000..3cc71244e699
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> @@ -0,0 +1,972 @@
> +[
> +    {
> +        "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "32",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "PEBScounters": "32",
> +        "PublicDescription": "Counts the number of instructions retired =
- an Architectural PerfMon event. Counting continues during hardware interr=
upts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is coun=
ted by a designated fixed counter freeing up programmable counters to count=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Precise instruction retired event with a re=
duced effect of PEBS shadow in IP distribution",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "32",
> +        "EventName": "INST_RETIRED.PREC_DIST",
> +        "PEBS": "1",
> +        "PEBScounters": "32",
> +        "PublicDescription": "A version of INST_RETIRED that allows for =
a more unbiased distribution of samples across instructions retired. It uti=
lizes the Precise Distribution of Instructions Retired (PDIR) feature to mi=
tigate some bias in how retired instructions get sampled. Use on Fixed Coun=
ter 0.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "33",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD",
> +        "PEBScounters": "33",
> +        "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "34",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "PEBScounters": "34",
> +        "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the eight programmable count=
ers available for other events. Note: On all current platforms this event s=
tops counting during 'throttling (TM)' states duty off periods the processo=
r is 'halted'.  The counter update is done at a lower clock rate then the c=
ore clock the overflow status bit for this counter may appear 'sticky'.  Af=
ter the counter has overflowed and software clears the overflow status bit =
and resets the counter to less than MAX. The reset value to the counter is =
not clocked immediately so the overflow status bit will flip 'high (1)' and=
 generate another PMI (if enabled) after which the reset value gets clocked=
 into the counter. Therefore, software will get the interrupt, read the ove=
rflow status bit '1 for bit 34 while the counter value is less than MAX. So=
ftware should ignore this case.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x3"
> +    },
> +    {
> +        "BriefDescription": "Loads blocked due to overlapping with a pre=
ceding store that cannot be forwarded.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of times where store for=
warding was prevented for a load operation. The most common case is a load =
blocked due to the address of memory access (partially) overlapping with a =
preceding uncompleted store. Note: See the table of not supported store for=
wards in the Optimization Guide.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "The number of times that split load operati=
ons are temporarily blocked because all resources for handling the split ac=
cesses are in use.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.NO_SR",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of times that split load=
 operations are temporarily blocked because all resources for handling the =
split accesses are in use.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "False dependencies due to partial compare o=
n address.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x07",
> +        "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of times a load got bloc=
ked due to false dependencies due to partial compare on address.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Core cycles the allocator was stalled due t=
o recovery from earlier clear event for this thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x0D",
> +        "EventName": "INT_MISC.RECOVERY_CYCLES",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts core cycles when the Resource alloc=
ator was stalled due to recovery from an earlier branch misprediction or ma=
chine clear event.",
> +        "SampleAfterValue": "500009",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles the Backend cluster is recovering af=
ter a miss-speculation or a Store Buffer or Load Buffer drain stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0x0D",
> +        "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles the Backend cluster is recov=
ering after a miss-speculation or a Store Buffer or Load Buffer drain stall=
.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x3"
> +    },
> +    {
> +        "BriefDescription": "TMA slots where uops got dropped",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x0d",
> +        "EventName": "INT_MISC.UOP_DROPPING",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Estimated number of Top-down Microarchitec=
ture Analysis slots that got dropped due to non front-end reasons",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts cycles after recovery from a branch =
misprediction or machine clear till the first uop is issued from the restee=
red path.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x0d",
> +        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles after recovery from a branch mispre=
diction or machine clear till the first uop is issued from the resteered pa=
th.",
> +        "SampleAfterValue": "500009",
> +        "Speculative": "1",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Uops that RAT issues to RS",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x0e",
> +        "EventName": "UOPS_ISSUED.ANY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of uops that the Resourc=
e Allocation Table (RAT) issues to the Reservation Station (RS).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles when RAT does not issue Uops to RS f=
or the thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0x0E",
> +        "EventName": "UOPS_ISSUED.STALL_CYCLES",
> +        "Invert": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles during which the Resource Al=
location Table (RAT) does not issue any Uops to the reservation station (RS=
) for the current thread.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Uops inserted at issue-stage in order to pr=
eserve upper bits of vector registers.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x0e",
> +        "EventName": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of Blend Uops issued by =
the Resource Allocation Table (RAT) to the reservation station (RS) in orde=
r to preserve upper bits of vector registers. Starting with the Skylake mic=
roarchitecture, these Blend uops are needed since every Intel SSE instructi=
on executed in Dirty Upper State needs to preserve bits 128-255 of the dest=
ination register. For more information, refer to Mixing Intel AVX and Intel=
 SSE Code section of the Optimization Guide.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles when divide unit is busy executing d=
ivide or square root operations.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0x14",
> +        "EventName": "ARITH.DIVIDER_ACTIVE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles when divide unit is busy exe=
cuting divide or square root operations. Accounts for integer and floating-=
point operations.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x9"
> +    },
> +    {
> +        "BriefDescription": "Thread cycles when thread is not in halt st=
ate",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x3C",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "This is an architectural event that counts=
 the number of thread cycles while the thread is not in a halt state. The t=
hread enters the halt state when it is running the HLT instruction. The cor=
e frequency may change from time to time due to power or thermal throttling=
. For this reason, this event may have a changing ratio with regards to wal=
l clock time.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1"
> +    },
> +    {
> +        "BriefDescription": "Core crystal clock cycles when the thread i=
s unhalted.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x3C",
> +        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts core crystal clock cycles when the =
thread is unhalted.",
> +        "SampleAfterValue": "25003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Core crystal clock cycles when this thread =
is unhalted and the other thread is halted.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x3C",
> +        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts Core crystal clock cycles when curr=
ent thread is unhalted and the other thread is halted.",
> +        "SampleAfterValue": "25003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Core crystal clock cycles. Cycle counts are=
 evenly distributed between active threads in the Core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "This event distributes Core crystal clock =
cycle counts between active hyperthreads, i.e., those in C0 sleep-state. A =
hyperthread becomes inactive when it executes the HLT or MWAIT instructions=
. If one thread is active in a core, all counts are attributed to this hype=
rthread. To obtain the full count when the Core is active, sum the counts f=
rom each hyperthread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of demand load dispatches=
 that hit L1D fill buffer (FB) allocated for software prefetch.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x4c",
> +        "EventName": "LOAD_HIT_PREFETCH.SWPF",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts all not software-prefetch load disp=
atches that hit the fill buffer (FB) allocated for the software prefetch. I=
t can also be incremented by some lock instructions. So it should only be u=
sed with profiling so that the locks can be excluded by ASM (Assembly File)=
 inspection of the nearby instructions.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles when Reservation Station (RS) is emp=
ty for the thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x5e",
> +        "EventName": "RS_EVENTS.EMPTY_CYCLES",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles during which the reservation=
 station (RS) is empty for this logical processor. This is usually caused w=
hen the front-end pipeline runs into stravation periods (e.g. branch mispre=
dictions or i-cache misses)",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts end of periods where the Reservation=
 Station (RS) was empty.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EdgeDetect": "1",
> +        "EventCode": "0x5E",
> +        "EventName": "RS_EVENTS.EMPTY_END",
> +        "Invert": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts end of periods where the Reservatio=
n Station (RS) was empty. Could be useful to closely sample on front-end la=
tency issues (see the FRONTEND_RETIRED event of designated precise events)"=
,
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Stalls caused by changing prefix length of =
the instruction.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x87",
> +        "EventName": "ILD_STALL.LCP",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles that the Instruction Length =
decoder (ILD) stalls occurred due to dynamically changing prefix length of =
the decoded instruction (by operand size prefix instruction 0x66, address s=
ize prefix instruction 0x67 or REX.W for Intel64). Count is proportional to=
 the number of prefixes in a 16B-line. This may result in a three-cycle pen=
alty for each LCP (Length changing prefix) in a 16-byte chunk.",
> +        "SampleAfterValue": "500009",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 0",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_0",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to port 0.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 1",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to port 1.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 2 and 3",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_2_3",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to ports 2 and 3.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 4 and 9",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_4_9",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to ports 5 and 9.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 5",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_5",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to port 5.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 6",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_6",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to port 6.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Number of uops executed on port 7 and 8",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa1",
> +        "EventName": "UOPS_DISPATCHED.PORT_7_8",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts, on the per-thread basis, cycles du=
ring which at least one uop is dispatched from the Reservation Station (RS)=
 to ports 7 and 8.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts cycles where the pipeline is stalled=
 due to serializing operations.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa2",
> +        "EventName": "RESOURCE_STALLS.SCOREBOARD",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles stalled due to no store buffers avai=
lable. (not including draining form sync).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa2",
> +        "EventName": "RESOURCE_STALLS.SB",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts allocation stall cycles caused by t=
he store buffer (SB) being full. This counts cycles that the pipeline back-=
end blocked uop delivery from the front-end.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Cycles while L2 cache miss demand load is o=
utstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0xA3",
> +        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Total execution stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "4",
> +        "EventCode": "0xa3",
> +        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Execution stalls while L2 cache miss demand=
 load is outstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "5",
> +        "EventCode": "0xa3",
> +        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Cycles while L1 cache miss demand load is o=
utstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "8",
> +        "EventCode": "0xA3",
> +        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Execution stalls while L1 cache miss demand=
 load is outstanding.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "12",
> +        "EventCode": "0xA3",
> +        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0xc"
> +    },
> +    {
> +        "BriefDescription": "Cycles while memory subsystem has an outsta=
nding load.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "16",
> +        "EventCode": "0xA3",
> +        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Execution stalls while memory subsystem has=
 an outstanding load.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "20",
> +        "EventCode": "0xa3",
> +        "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x14"
> +    },
> +    {
> +        "BriefDescription": "Cycles total of 1 uop is executed on all po=
rts and Reservation Station was not empty.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa6",
> +        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles during which a total of 1 uo=
p was executed on all ports and Reservation Station (RS) was not empty.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles total of 2 uops are executed on all =
ports and Reservation Station was not empty.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa6",
> +        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles during which a total of 2 uo=
ps were executed on all ports and Reservation Station (RS) was not empty.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Cycles total of 3 uops are executed on all =
ports and Reservation Station was not empty.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa6",
> +        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles total of 3 uops are executed on all=
 ports and Reservation Station (RS) was not empty.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Cycles total of 4 uops are executed on all =
ports and Reservation Station was not empty.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa6",
> +        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles total of 4 uops are executed on all=
 ports and Reservation Station (RS) was not empty.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Cycles where the Store Buffer was full and =
no loads caused an execution stall.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "2",
> +        "EventCode": "0xA6",
> +        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles where the Store Buffer was f=
ull and no loads caused an execution stall.",
> +        "SampleAfterValue": "1000003",
> +        "Speculative": "1",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Number of Uops delivered by the LSD.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xa8",
> +        "EventName": "LSD.UOPS",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of uops delivered to the=
 back-end by the LSD(Loop Stream Detector).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles Uops delivered by the LSD, but didn'=
t come from the decoder.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0xA8",
> +        "EventName": "LSD.CYCLES_ACTIVE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the cycles when at least one uop is=
 delivered by the LSD (Loop-stream detector).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles optimal number of Uops delivered by =
the LSD, but did not come from the decoder.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "5",
> +        "EventCode": "0xa8",
> +        "EventName": "LSD.CYCLES_OK",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the cycles when optimal number of u=
ops is delivered by the LSD (Loop-stream detector).",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops to be executed pe=
r-thread each cycle.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xb1",
> +        "EventName": "UOPS_EXECUTED.THREAD",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts number of cycles no uops were dispat=
ched to be executed on this thread.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
> +        "Invert": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles during which no uops were di=
spatched from the Reservation Station (RS) per thread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles where at least 1 uop was executed pe=
r-thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0xb1",
> +        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles where at least 1 uop was executed p=
er-thread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles where at least 2 uops were executed =
per-thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "2",
> +        "EventCode": "0xb1",
> +        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles where at least 2 uops were executed=
 per-thread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles where at least 3 uops were executed =
per-thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "3",
> +        "EventCode": "0xb1",
> +        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles where at least 3 uops were executed=
 per-thread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles where at least 4 uops were executed =
per-thread",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "4",
> +        "EventCode": "0xb1",
> +        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Cycles where at least 4 uops were executed=
 per-thread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Cycles at least 1 micro-op is executed from=
 any thread on physical core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles when at least 1 micro-op is =
executed from any thread on physical core.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles at least 2 micro-op is executed from=
 any thread on physical core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "2",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles when at least 2 micro-ops ar=
e executed from any thread on physical core.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles at least 3 micro-op is executed from=
 any thread on physical core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "3",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles when at least 3 micro-ops ar=
e executed from any thread on physical core.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Cycles at least 4 micro-op is executed from=
 any thread on physical core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "4",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts cycles when at least 4 micro-ops ar=
e executed from any thread on physical core.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of x87 uops dispatched.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xB1",
> +        "EventName": "UOPS_EXECUTED.X87",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of x87 uops executed.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Number of instructions retired. General Cou=
nter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of instructions retired =
- an Architectural PerfMon event. Counting continues during hardware interr=
upts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is coun=
ted by a designated fixed counter freeing up programmable counters to count=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> +        "SampleAfterValue": "2000003"
> +    },
> +    {
> +        "BriefDescription": "Cycles with less than 10 actually retired u=
ops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "10",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
> +        "Invert": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of cycles using always t=
rue condition (uops_ret &amp;lt; 16) applied to non PEBS uops retired event=
.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Retirement slots used.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the retirement slots used each cycl=
e.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of machine clears (nukes) of any typ=
e.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "CounterMask": "1",
> +        "EdgeDetect": "1",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.COUNT",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of machine clears (nukes=
) of any type.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Self-modifying code (SMC) detected.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.SMC",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts self-modifying code (SMC) detected,=
 which causes a machine clear.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "All branch instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts all branch instructions retired.",
> +        "SampleAfterValue": "400009"
> +    },
> +    {
> +        "BriefDescription": "Taken conditional branch instructions retir=
ed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.COND_TAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts taken conditional branch instructio=
ns retired.",
> +        "SampleAfterValue": "400009",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Direct and indirect near call instructions =
retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_CALL",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts both direct and indirect near call =
instructions retired.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Return instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts return instructions retired.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Not taken branch instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts not taken branch instructions retir=
ed.",
> +        "SampleAfterValue": "400009",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Conditional branch instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.COND",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts conditional branch instructions ret=
ired.",
> +        "SampleAfterValue": "400009",
> +        "UMask": "0x11"
> +    },
> +    {
> +        "BriefDescription": "Taken branch instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts taken branch instructions retired."=
,
> +        "SampleAfterValue": "400009",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Far branch instructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts far branch instructions retired.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "All indirect branch instructions retired (e=
xcluding RETs. TSX aborts are considered indirect branch).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.INDIRECT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts all indirect branch instructions re=
tired (excluding RETs. TSX aborts is considered indirect branch).",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "All mispredicted branch instructions retire=
d.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts all the retired branch instructions=
 that were mispredicted by the processor. A branch misprediction occurs whe=
n the processor incorrectly predicts the destination of the branch.  When t=
he misprediction is discovered at execution, all the instructions executed =
in the wrong (speculative) path must be discarded, and the processor must s=
tart fetching from the correct path.",
> +        "SampleAfterValue": "50021"
> +    },
> +    {
> +        "BriefDescription": "number of branch instructions retired that =
were mispredicted and taken. Non PEBS",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts taken conditional mispredicted bran=
ch instructions retired.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Mispredicted non-taken conditional branch i=
nstructions retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of conditional branch in=
structions retired that were mispredicted and the branch direction was not =
taken.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Mispredicted conditional branch instruction=
s retired.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.COND",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts mispredicted conditional branch ins=
tructions retired.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x11"
> +    },
> +    {
> +        "BriefDescription": "Number of near branch instructions retired =
that were mispredicted and taken.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts number of near branch instructions =
retired that were mispredicted and taken.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "All miss-predicted indirect branch instruct=
ions retired (excluding RETs. TSX aborts is considered indirect branch).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.INDIRECT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts all miss-predicted indirect branch =
instructions retired (excluding RETs. TSX aborts is considered indirect bra=
nch).",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Number of retired PAUSE instructions. This =
event is not supported on first SKL and KBL products.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xcc",
> +        "EventName": "MISC_RETIRED.PAUSE_INST",
> +        "PublicDescription": "Counts number of retired PAUSE instruction=
s. This event is not supported on first SKL and KBL products.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Cycle counts are evenly distributed between=
 active threads in the Core.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xec",
> +        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "This event distributes cycle counts betwee=
n active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive w=
hen it executes the HLT or MWAIT instructions.  If all other hyperthreads a=
re inactive (or disabled or do not exist), all counts are attributed to thi=
s hyperthread. To obtain the full count when the Core is active, sum the co=
unts from each hyperthread.",
> +        "SampleAfterValue": "2000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
> new file mode 100644
> index 000000000000..1b9d03039c53
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
> @@ -0,0 +1,245 @@
> +[
> +    {
> +        "BriefDescription": "Page walks completed due to a demand data l=
oad to a 4K page.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (4K sizes) ca=
used by demand data loads. This implies address translations missed in the =
DTLB and further levels of TLB. The page walk can end with or without a fau=
lt.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Page walks completed due to a demand data l=
oad to a 2M/4M page.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (2M/4M sizes)=
 caused by demand data loads. This implies address translations missed in t=
he DTLB and further levels of TLB. The page walk can end with or without a =
fault.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Load miss in all TLB levels causes a page w=
alk that completes. (All page sizes)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (all page siz=
es) caused by demand data loads. This implies it missed in the DTLB and fur=
ther levels of TLB. The page walk can end with or without a fault.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Number of page walks outstanding for a dema=
nd load in the PMH each cycle.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of page walks outstandin=
g for a demand load in the PMH (Page Miss Handler) each cycle.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Cycles when at least one PMH is busy with a=
 page walk for a demand load.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles when at least one PMH (Page =
Miss Handler) is busy with a page walk for a demand load.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Loads that miss the DTLB and hit the STLB."=
,
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts loads that miss the DTLB (Data TLB)=
 and hit the STLB (Second level TLB).",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Page walks completed due to a demand data s=
tore to a 4K page.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (4K sizes) ca=
used by demand data stores. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Page walks completed due to a demand data s=
tore to a 2M/4M page.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (2M/4M sizes)=
 caused by demand data stores. This implies address translations missed in =
the DTLB and further levels of TLB. The page walk can end with or without a=
 fault.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Store misses in all TLB levels causes a pag=
e walk that completes. (All page sizes)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks  (all page siz=
es) caused by demand data stores. This implies it missed in the DTLB and fu=
rther levels of TLB. The page walk can end with or without a fault.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Number of page walks outstanding for a stor=
e in the PMH each cycle.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of page walks outstandin=
g for a store in the PMH (Page Miss Handler) each cycle.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Cycles when at least one PMH is busy with a=
 page walk for a store.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles when at least one PMH (Page =
Miss Handler) is busy with a page walk for a store.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Stores that miss the DTLB and hit the STLB.=
",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts stores that miss the DTLB (Data TLB=
) and hit the STLB (2nd Level TLB).",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Code miss in all TLB levels causes a page w=
alk that completes. (4K)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks (4K page sizes=
) caused by a code fetch. This implies it missed in the ITLB (Instruction T=
LB) and further levels of TLB. The page walk can end with or without a faul=
t.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Code miss in all TLB levels causes a page w=
alk that completes. (2M/4M)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks (2M/4M page si=
zes) caused by a code fetch. This implies it missed in the ITLB (Instructio=
n TLB) and further levels of TLB. The page walk can end with or without a f=
ault.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Code miss in all TLB levels causes a page w=
alk that completes. (All page sizes)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts completed page walks (all page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Number of page walks outstanding for an out=
standing code request in the PMH each cycle.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_PENDING",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of page walks outstandin=
g for an outstanding code (instruction fetch) request in the PMH (Page Miss=
 Handler) each cycle.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Cycles when at least one PMH is busy with a=
 page walk for code (instruction fetch) request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "CounterMask": "1",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_ACTIVE",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts cycles when at least one PMH (Page =
Miss Handler) is busy with a page walk for a code (instruction fetch) reque=
st.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Instruction fetch requests that miss the IT=
LB and hit the STLB.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.STLB_HIT",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts instruction fetch requests that mis=
s the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "DTLB flush attempts of the thread-specific =
entries",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xBD",
> +        "EventName": "TLB_FLUSH.DTLB_THREAD",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of DTLB flush attempts o=
f the thread-specific entries.",
> +        "SampleAfterValue": "100007",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "STLB flush attempts",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xBD",
> +        "EventName": "TLB_FLUSH.STLB_ANY",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of any STLB flush attemp=
ts (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
> +        "SampleAfterValue": "100007",
> +        "Speculative": "1",
> +        "UMask": "0x20"
> +    }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 0a6a8c7f937f..5f5df6560202 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -38,6 +38,8 @@ GenuineIntel-6-7D,v1,icelake,core
>  GenuineIntel-6-7E,v1,icelake,core
>  GenuineIntel-6-8[CD],v1,icelake,core
>  GenuineIntel-6-A7,v1,icelake,core
> +GenuineIntel-6-6A,v1,icelakex,core
> +GenuineIntel-6-6C,v1,icelakex,core
>  GenuineIntel-6-86,v1,tremontx,core
>  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
>  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> --
> 2.17.1
>
