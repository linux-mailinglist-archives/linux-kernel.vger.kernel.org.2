Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DB38DEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 03:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEXBJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 21:09:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:31729 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhEXBJr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 21:09:47 -0400
IronPort-SDR: BIzFKj052T5Nek5R6ozwgSoctpj8DILReCrFgGjilsmzIW0rEDjWY1ZiNHttxyaRMMtlMpsRMc
 Z+nIrjQVEBWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201877554"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201877554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 18:08:17 -0700
IronPort-SDR: c2jwz1Hgpn3It494k7ri9oMB2oith5OTFoaGsEyDBB1cWhYgPcfE2qWxwPDlZvoJHtzfFLHpsi
 1CphJh4+2CSw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="475598439"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 18:08:15 -0700
Subject: Re: [PATCH 1/4] perf vendor events: Add core event list for Icelake
 Server
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
References: <20210510012438.6293-1-yao.jin@linux.intel.com>
 <20210510012438.6293-2-yao.jin@linux.intel.com>
 <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
 <YKgMz52O9mVjPH3K@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c0f27643-bebb-2912-56ed-f7abec7dbde3@linux.intel.com>
Date:   Mon, 24 May 2021 09:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKgMz52O9mVjPH3K@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 5/22/2021 3:41 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 20, 2021 at 09:08:37AM -0700, Ian Rogers escreveu:
>> On Sun, May 9, 2021 at 6:26 PM Jin Yao<yao.jin@linux.intel.com>  wrote:
>>> Add JSON core events for Icelake Server to perf.
>>>
>>> Based on JSON list v1.04
>>> https://download.01.org/perfmon/ICX/
>>>
>>> Signed-off-by: Jin Yao<yao.jin@linux.intel.com>
>>> Reviewed-by: Andi Kleen<ak@linux.intel.com>
>> Acked-by: Ian Rogers<irogers@google.com>
> ⬢[acme@toolbox perf]$ am
> Applying: perf vendor events: Add core event list for Icelake Server
> error: corrupt patch at line 2771
> Patch failed at 0001 perf vendor events: Add core event list for Icelake Server
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf]$
> ⬢[acme@toolbox perf]$ git diff
> ⬢[acme@toolbox perf]$ git am --abort
> ⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/pmu-events/arch/x86/icelakex/cache.json
> patching file tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> patching file tools/perf/pmu-events/arch/x86/icelakex/frontend.json
> patching file tools/perf/pmu-events/arch/x86/icelakex/memory.json
> patching file tools/perf/pmu-events/arch/x86/icelakex/other.json
> patching file tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> patch: **** malformed patch at line 1927:   less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
> 
> ⬢[acme@toolbox perf]$
> 
> Please check.
> 
> - Arnaldo
>   

Could you pull the top 4 patches from "https://github.com/yaoj/icx-events.git"?

perf vendor events: Update event list for Icelake Client
perf vendor events: Add metrics for Icelake Server
perf vendor events: Add uncore event list for Icelake Server
perf vendor events: Add core event list for Icelake Server

The patch is too big and it's possibly corrupted by mailing system.

Thanks
Jin Yao
