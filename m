Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D132E70A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCELLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:11:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2622 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCELLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:11:20 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsQ125bBNz67jwS;
        Fri,  5 Mar 2021 19:07:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 12:11:19 +0100
Received: from [10.47.8.182] (10.47.8.182) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 11:11:17 +0000
Subject: Re: [PATCH v8 3/3] perf vendor events arm64: Add "_" to the event
 name, which starts with a number
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210305101841.3133721-1-nakamura.shun@fujitsu.com>
 <20210305101841.3133721-4-nakamura.shun@fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b140182c-3250-8c28-c28a-9dc3cefc89a2@huawei.com>
Date:   Fri, 5 Mar 2021 11:09:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210305101841.3133721-4-nakamura.shun@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.182]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2021 10:18, Shunsuke Nakamura wrote:
> The perf parser does not support event names that start with a number.
> This patch adds "_" to the event name, which starts with a number.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

I think that this can be folded into patch 2/3, and my reveiwed-by tag 
still stands for patch 2/3.

Thanks

> ---
>   .../pmu-events/arch/arm64/fujitsu/a64fx/other.json     | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> index 68b8e46d6140..10c823ac26cc 100644
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> @@ -98,31 +98,31 @@
>     {
>       "PublicDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only.",
>       "EventCode": "0x190",
> -    "EventName": "0INST_COMMIT",
> +    "EventName": "_0INST_COMMIT",
>       "BriefDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only."
>     },
>     {
>       "PublicDescription": "This event counts every cycle that one instruction is committed.",
>       "EventCode": "0x191",
> -    "EventName": "1INST_COMMIT",
> +    "EventName": "_1INST_COMMIT",
>       "BriefDescription": "This event counts every cycle that one instruction is committed."
>     },
>     {
>       "PublicDescription": "This event counts every cycle that two instructions are committed.",
>       "EventCode": "0x192",
> -    "EventName": "2INST_COMMIT",
> +    "EventName": "_2INST_COMMIT",
>       "BriefDescription": "This event counts every cycle that two instructions are committed."
>     },
>     {
>       "PublicDescription": "This event counts every cycle that three instructions are committed.",
>       "EventCode": "0x193",
> -    "EventName": "3INST_COMMIT",
> +    "EventName": "_3INST_COMMIT",
>       "BriefDescription": "This event counts every cycle that three instructions are committed."
>     },
>     {
>       "PublicDescription": "This event counts every cycle that four instructions are committed.",
>       "EventCode": "0x194",
> -    "EventName": "4INST_COMMIT",
> +    "EventName": "_4INST_COMMIT",
>       "BriefDescription": "This event counts every cycle that four instructions are committed."
>     },
>     {
> 

