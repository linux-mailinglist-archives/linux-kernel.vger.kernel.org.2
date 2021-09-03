Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737093FFC71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbhICI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:56:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhICI4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:56:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C2D9D6E;
        Fri,  3 Sep 2021 01:55:41 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1CF3F694;
        Fri,  3 Sep 2021 01:55:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on
 TRCIDR1
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org
Cc:     acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-3-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d2379e72-a285-c63f-8c32-806e412458a3@arm.com>
Date:   Fri, 3 Sep 2021 09:55:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210806134109.1182235-3-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 14:41, James Clark wrote:
> Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
> onwards this should be ARCH_AA64.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 187c038caa19..787b19642e78 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>   	return 0;
>   }
>   
> +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)

minor nit: Please add a blank line here

> +static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
> +{
> +	/*
> +	 * For ETMv4 if the trace minor version is 4 or more then we can assume
> +	 * the architecture is ARCH_AA64 rather than just V8.
> +	 * ARCH_V8 = V8 architecture
> +	 * ARCH_AA64 = Min v8r3 plus additional AA64 PE features

Does this need to be >= 3 then, to be accurate ?

The comment "reads", minimum v8.3 and any additional features.

Otherwise looks good to me.

Suzuki
