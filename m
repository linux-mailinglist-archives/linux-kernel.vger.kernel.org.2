Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8ED30CFDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhBBXZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:25:52 -0500
Received: from foss.arm.com ([217.140.110.172]:59928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhBBXZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:25:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB3731B;
        Tue,  2 Feb 2021 15:25:03 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9093F694;
        Tue,  2 Feb 2021 15:25:00 -0800 (PST)
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing
 description
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-8-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <451d58bd-e79d-5fb4-a67f-962da02a3937@arm.com>
Date:   Tue, 2 Feb 2021 23:24:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202163842.134734-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 4:38 PM, Leo Yan wrote:
> After support the PID tracing for the kernel in EL1 or EL2, the usage
> gets more complicated.
> 
> This patch gives description for the PMU formats of contextID configs,
> this can help users to understand how to control the knobs for PID
> tracing when the kernel is in different ELs.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   Documentation/trace/coresight/coresight.rst | 37 +++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 0b73acb44efa..771558f22938 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -512,6 +512,43 @@ The --itrace option controls the type and frequency of synthesized events
>   Note that only 64-bit programs are currently supported - further work is
>   required to support instruction decode of 32-bit Arm programs.
>   
> +2.2) Tracing PID
> +
> +When the kernel is running at EL2 with Virtualization Host Extensions (VHE),
> +perf records CONTEXTIDR_EL2 in the trace data and can be used as PID when
> +decoding; and if the kernel is running at EL1 with nVHE, CONTEXTIDR_EL1 is
> +traced for PID.
> +
> +To support tracing PID for the kernel runs at different exception levels,
> +the PMU formats are defined as follow:
> +
> +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> +                kernel is running at EL1, "contextid1" enables the PID
> +                tracing; when the kernel is running at EL2, this enables
> +                tracing the PID of guest applications.
> +
> +  "contextid2": Only usable when the kernel is running at EL2.  When
> +                selected, enables PID tracing on EL2 kernel.
> +
> +  "contextid":  Will be an alias for the option that enables PID
> +                tracing.  I.e,
> +                contextid == contextid1, on EL1 kernel.
> +                contextid == contextid2, on EL2 kernel.
> +
> +The perf tool automatically sets corresponding bit for the "contextid" config,
> +therefore, the user doesn't have to bother which EL the kernel is running.
> +
> +  i.e, perf record -e cs_etm/contextid/u -- uname
> +    or perf record -e cs_etm//u -- uname
> +
> +will always do the "PID" tracing, independent of the kernel EL.
> +
> +When the kernel is running at EL2 with VHE, if user wants to trace both the
> +PIDs for both host and guest, the two configs "contextid1" and "contextid2"
> +can be set at the same time:
> +
> +  perf record -e cs_etm/contextid1,contextid2/u -- uname
> +

To make this case clear, we could change the command from uname to
something like:

     perf record -e cs_etm/contextid1,contextid2/u -- vm

Otherwise looks good to me.

With the above fixed,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
