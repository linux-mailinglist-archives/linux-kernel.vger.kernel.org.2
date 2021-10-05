Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6051422311
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhJEKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:08:12 -0400
Received: from foss.arm.com ([217.140.110.172]:37840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhJEKIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:08:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784BD6D;
        Tue,  5 Oct 2021 03:06:16 -0700 (PDT)
Received: from [10.1.31.140] (e127744.cambridge.arm.com [10.1.31.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A86A3F766;
        Tue,  5 Oct 2021 03:06:13 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
Date:   Tue, 5 Oct 2021 11:06:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211004062638.GB174271@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 04/10/2021 07:26, Leo Yan wrote:
> Hi James,
>
> On Thu, Sep 30, 2021 at 04:08:52PM +0100, James Clark wrote:
>> On 23/09/2021 15:23, Leo Yan wrote:
>>> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
> [...]
> I'd like to use the comparison method for the test:
> We should enable PID tracing and capture in the perf.data, when decode
> the trace data, we can based on context packet and based on the switch
> events to generate out two results, so we can check how the difference
> between these results.

Yesterday we did some testing and found that there seems to be an exact
match between using context packets and switch events. However this only
applies when tracing in userspace (by adding the 'u' suffix to the perf
event). Otherwise we still see as much as 2% of events having the wrong
PID around the time of the switch.

In order to measure this I applied Namhyung's patch and James's patch
from [1]. Then added a printf line to the function arm_spe_prep_sample
where I have access to both PID values, as a quick way to compare them
later in a perf-report run. This is the diff of the printf patch:

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 41385ab96fbc..591985c66ac4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -247,6 +247,8 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
    event->sample.header.type = PERF_RECORD_SAMPLE;
    event->sample.header.misc = sample->cpumode;
    event->sample.header.size = sizeof(struct perf_event_header);
+
+       printf(">>>>>> %d / %lu\n", speq->tid, record->context_id & 0x7fff);
 }

The differences obtained as error % were obtained by running the
following perf-record commands for different configurations:

$ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/u -a -- sleep 60
$ sudo ./perf report --stdio \
    | grep ">>>>>>" \
    | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'

Error: 0% out of 11839328 samples

$ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/ -a -- sleep 10
$ sudo ./perf report --stdio \
    | grep ">>>>>>" \
    | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'

Error: 1.30624% out of 3418731 samples

>> German Gomez actually starting looking into the switch events for SPE at the
>> same time, so I've CCd him and maybe he can do some testing of the patch.
> Cool!  German is welcome to continue the related work; since I am in
> holiday this week, I will try this as well, if I have any conclusion
> will get back to you guys.
>
> If the test result shows good enough, I personally think we need finish
> below items:
>
> - Enable PID tracing and decode with context packets;
> - Provide interface to user space so perf tool knows if should use
>   hardware PID or rollback to context switch events;
> - Merge Namhyung's patch for using switch events for samples.
>
> Thanks,
> Leo

I think the fallback to using switch when we can't use the CONTEXTIDR
register is a viable option for userspace events, but maybe not so much
for non-userspace.

Thanks,
German

[1] https://www.spinics.net/lists/linux-perf-users/msg12543.html
