Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB4360B94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhDOOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:14:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233216AbhDOOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:14:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D334B106F;
        Thu, 15 Apr 2021 07:13:39 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21233F694;
        Thu, 15 Apr 2021 07:13:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] perf arm-spe: Remove unused enum value
 ARM_SPE_PER_CPU_MMAPS
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-2-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <882e13d1-c793-88c6-0b1e-629462fb99ac@arm.com>
Date:   Thu, 15 Apr 2021 17:13:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412091006.468557-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2021 12:10, Leo Yan wrote:
> The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.

Hi Leo,

I think this causes an error when attempting to open a newly recorded file
with an old version of perf. The value ARM_SPE_AUXTRACE_PRIV_MAX is used here:

	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
	struct perf_record_time_conv *tc = &session->time_conv;
	struct arm_spe *spe;
	int err;

	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
					min_sz)
		return -EINVAL;

And removing ARM_SPE_PER_CPU_MMAPS changes the value of ARM_SPE_AUXTRACE_PRIV_MAX.

At least I think that's what's causing the problem. I get this error:

	./perf report -i per-thread-spe-time.data
	0x1c0 [0x18]: failed to process type: 70 [Invalid argument]
	Error:
	failed to process sample
	# To display the perf.data header info, please use --header/--header-only options.
	#

James

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
> index 98d3235781c3..105ce0ea0a01 100644
> --- a/tools/perf/util/arm-spe.h
> +++ b/tools/perf/util/arm-spe.h
> @@ -11,7 +11,6 @@
>  
>  enum {
>  	ARM_SPE_PMU_TYPE,
> -	ARM_SPE_PER_CPU_MMAPS,
>  	ARM_SPE_AUXTRACE_PRIV_MAX,
>  };
>  
> 
