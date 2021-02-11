Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5B318B90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhBKNGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:06:06 -0500
Received: from foss.arm.com ([217.140.110.172]:51388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231801AbhBKMjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:39:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A402211B3;
        Thu, 11 Feb 2021 04:38:35 -0800 (PST)
Received: from [10.57.48.86] (unknown [10.57.48.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82E9D3F73B;
        Thu, 11 Feb 2021 04:38:31 -0800 (PST)
Subject: Re: [PATCH v3 8/8] Documentation: coresight: Add PID tracing
 description
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-9-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <de0be10d-3baf-6d3c-0f1d-2a9f45444e84@arm.com>
Date:   Thu, 11 Feb 2021 12:38:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210206150833.42120-9-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 3:08 PM, Leo Yan wrote:
> After support the PID tracing for the kernel in EL1 or EL2, the usage
> gets more complicated.
> 
> This patch gives description for the PMU formats of contextID configs,
> this can help users to understand how to control the knobs for PID
> tracing when the kernel is in different ELs.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   Documentation/trace/coresight/coresight.rst | 32 +++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 0b73acb44efa..169749efd8d1 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -512,6 +512,38 @@ The --itrace option controls the type and frequency of synthesized events
>   Note that only 64-bit programs are currently supported - further work is
>   required to support instruction decode of 32-bit Arm programs.
>   
> +2.2) Tracing PID
> +
> +The kernel can be built to write the PID value into the PE ContextID registers.
> +For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.  A PE may
> +implement Arm Virtualization Host Extensions (VHE), which the kernel can
> +run at EL2 as a virtualisation host; in this case, the PID value is stored in
> +CONTEXTIDR_EL2.
> +
> +perf provides PMU formats that program the ETM to insert these values into the
> +trace data; the PMU formats are defined as below:
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
> +perf will always enable PID tracing at the relevant EL, this is accomplished by
> +automatically enable the "contextid" config - but for EL2 it is possible to make
> +specific adjustments using configs "contextid1" and "contextid2", E.g. if a user
> +wants to trace PIDs for both host and guest, the two configs "contextid1" and
> +"contextid2" can be set at the same time:
> +
> +  perf record -e cs_etm/contextid1,contextid2/u -- vm
> +
>   


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
