Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154133115A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhBEWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:37:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:12377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232841AbhBEOwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:18 -0500
IronPort-SDR: g4zu5wZS16UMt35Za4sUEx2JCB5IJZmf1HhhkdaH1g2lvA++8Nmrwtw8n+dJB6Gc9+nlHd+aPG
 BV5AvKQfUhqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168552901"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168552901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:13:37 -0800
IronPort-SDR: f6xnWxVLISWM4A5zTjfYyRVrLrSHbKQlo4+kuMpKopIQIhRUAPym8i0ySLjQ35NrBM8epVI0Kp
 kKqVRC7CgMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="373411166"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2021 06:13:36 -0800
Received: from [10.254.80.1] (kliang2-MOBL.ccr.corp.intel.com [10.254.80.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 65DF8580689;
        Fri,  5 Feb 2021 06:13:35 -0800 (PST)
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7cjDYALhR-xd2n2vaL5cPBiMz8RukziQqsfqqYwqBc87yA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <33221095-5ef6-bec8-136e-34dc14ae7adb@linux.intel.com>
Date:   Fri, 5 Feb 2021 09:13:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjDYALhR-xd2n2vaL5cPBiMz8RukziQqsfqqYwqBc87yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2021 5:52 AM, Namhyung Kim wrote:
> On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> On the Intel Sapphire Rapids server, an auxiliary event has to be
>> enabled simultaneously with the load latency event to retrieve complete
>> Memory Info.
>>
>> Add X86 specific perf_mem_events__name() to handle the auxiliary event.
>> - Users are only interested in the samples of the mem-loads event.
>>    Sample read the auxiliary event.
>> - The auxiliary event must be in front of the load latency event in a
>>    group. Assume the second event to sample if the auxiliary event is the
>>    leader.
>> - Add a weak is_mem_loads_aux_event() to check the auxiliary event for
>>    X86. For other ARCHs, it always return false.
>>
>> Parse the unique event name, mem-loads-aux, for the auxiliary event.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/arch/x86/util/Build        |  1 +
>>   tools/perf/arch/x86/util/mem-events.c | 44 +++++++++++++++++++++++++++++++++++
>>   tools/perf/util/evsel.c               |  3 +++
>>   tools/perf/util/mem-events.c          |  5 ++++
>>   tools/perf/util/mem-events.h          |  2 ++
>>   tools/perf/util/parse-events.l        |  1 +
>>   tools/perf/util/record.c              |  5 +++-
>>   7 files changed, 60 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/perf/arch/x86/util/mem-events.c
>>
>> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
>> index 347c39b..d73f548 100644
>> --- a/tools/perf/arch/x86/util/Build
>> +++ b/tools/perf/arch/x86/util/Build
>> @@ -6,6 +6,7 @@ perf-y += perf_regs.o
>>   perf-y += topdown.o
>>   perf-y += machine.o
>>   perf-y += event.o
>> +perf-y += mem-events.o
>>
>>   perf-$(CONFIG_DWARF) += dwarf-regs.o
>>   perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
>> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
>> new file mode 100644
>> index 0000000..11b8469
>> --- /dev/null
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "util/pmu.h"
>> +#include "map_symbol.h"
>> +#include "mem-events.h"
>> +
>> +static char mem_loads_name[100];
>> +static bool mem_loads_name__init;
>> +
>> +#define MEM_LOADS_AUX          0x8203
>> +#define MEM_LOADS_AUX_NAME     "{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
>> +
>> +bool is_mem_loads_aux_event(struct evsel *leader)
>> +{
>> +       if (!pmu_have_event("cpu", "mem-loads-aux"))
>> +               return false;
>> +
>> +       return leader->core.attr.config == MEM_LOADS_AUX;
>> +}
>> +
>> +char *perf_mem_events__name(int i)
>> +{
>> +       struct perf_mem_event *e = perf_mem_events__ptr(i);
>> +
>> +       if (!e)
>> +               return NULL;
>> +
>> +       if (i == PERF_MEM_EVENTS__LOAD) {
>> +               if (mem_loads_name__init)
>> +                       return mem_loads_name;
>> +
>> +               mem_loads_name__init = true;
>> +
>> +               if (pmu_have_event("cpu", "mem-loads-aux")) {
>> +                       scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
>> +                                 MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
> 
> It changes "%u" to an actual latency value, right?
> What if the value takes 3 or more digits?
> I'm not sure scnprintf() will handle it properly.
>

Yes, you are right. We should use the sizeof(mem_loads_name) as below.
I will submit a patch to fix it.

diff --git a/tools/perf/arch/x86/util/mem-events.c 
b/tools/perf/arch/x86/util/mem-events.c
index 11b8469..588110f 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -31,7 +31,7 @@ char *perf_mem_events__name(int i)
  		mem_loads_name__init = true;

  		if (pmu_have_event("cpu", "mem-loads-aux")) {
-			scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
+			scnprintf(mem_loads_name, sizeof(mem_loads_name),
  				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
  		} else {
  			scnprintf(mem_loads_name, sizeof(mem_loads_name),




Thanks,
Kan

