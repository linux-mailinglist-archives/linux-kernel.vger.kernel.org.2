Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCD30C66D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhBBQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:48:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2484 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbhBBQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:45:22 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVVtq3MRRz67kL5;
        Wed,  3 Feb 2021 00:41:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 17:44:36 +0100
Received: from [10.47.3.41] (10.47.3.41) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 16:44:35 +0000
Subject: Re: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
Date:   Tue, 2 Feb 2021 16:43:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2021 12:51, Shunsuke Nakamura wrote:
> From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> 
> This patch series supports A64FX PMU event v1.2.
> 
> The first patch adds a common and microarchitecture event, which can be
> referenced from CPU JSONs.
> This patch uses part of John's patch.[1]
> 
> The second patch add more common and microarchitecture events.
> 
> The third patch fixes the lexical definition of event name so that
> perf can recognize event name that start with a number.
> 
> The fourth patch adds PMU events for A64FX.

Just some things to note:
- please pick up and apply reviewed-by tags granted from previous 
reviews if explicitly granted, subject to making any trivial changes 
requested
If any significant changes are made, then don't pick up theses tags or 
drop them (if they were picked up earlier)
- I'd say that it's best not to send my patch in 1/4, but better to 
mention the series which this is based on in your cover letter
Sending my patch is only going to make the maintainers (Arnaldo) life 
more difficult to track these things.

Apart from that, I think that we're a bit uncertain about patch 3/4

Thanks,
john


> 
> 
> Changes in v4:
>   - Add arm64 to the subjects of the second and fourth patches.
>   - Add reference URLs to the body of the second patch.
> 
> Changes in v3:
>   - Add linux-arm-kernel mailing list to cc.
> 
> Changes in v2:
>   - Added armv8-common-and-microarch based on John's patch.[1]
>   - Fixed A64FX Json to refer to standard events in armv8-common-and-microarch.
> 
> 
> [1] https://lore.kernel.org/lkml/1611835236-34696-3-git-send-email-john.garry@huawei.com/
> 
> 
> John Garry (1):
>    perf vendor events arm64: Add common and uarch event JSON
> 
> Shunsuke Nakamura (3):
>    perf vendor events arm64: Add common and uarch event JSON
>    perf vendor events arm64: Add more common and uarch events
>    perf tools: Fix lexical definition of event name
>    perf vendor events arm64: Add Fujitsu A64FX pmu event
> 
>   .../arch/arm64/armv8-common-and-microarch.json     | 476 +++++++++++++++++++++
>   .../arch/arm64/fujitsu/a64fx/branch.json           |   8 +
>   .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 +++
>   .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 128 ++++++
>   .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   5 +
>   .../arch/arm64/fujitsu/a64fx/exception.json        |  29 ++
>   .../arch/arm64/fujitsu/a64fx/instruction.json      | 131 ++++++
>   .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
>   .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 ++++++++
>   .../arch/arm64/fujitsu/a64fx/pipeline.json         | 194 +++++++++
>   .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 110 +++++
>   tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
>   tools/perf/util/parse-events.l                     |   2 +-
>   13 files changed, 1341 insertions(+), 1 deletion(-)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
> 

