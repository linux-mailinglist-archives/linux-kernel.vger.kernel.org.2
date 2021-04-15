Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B48360C13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhDOOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:43:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhDOOnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:43:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF10106F;
        Thu, 15 Apr 2021 07:43:27 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BEF43FA45;
        Thu, 15 Apr 2021 07:43:25 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] perf arm-spe: Enable timestamp
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
From:   James Clark <james.clark@arm.com>
Message-ID: <570051ef-eda0-ead2-96de-0e22ca226e0a@arm.com>
Date:   Thu, 15 Apr 2021 17:43:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

I was looking at testing this on N1SDP and I thought I would try the round trip with perf inject and
then perf report but saw that perf inject with SPE always results in an error (unrelated to your change)

	 -> ./perf report -i per-thread-spe-time.inject.data
	0x1328 [0x8]: failed to process type: 9 [Bad address]
	Error:
	failed to process sample


Do you have any test suggestions other than looking at the raw data?

Thanks
James

On 12/04/2021 12:10, Leo Yan wrote:
> This patch set is to enable timestamp for Arm SPE trace.  It reads out
> TSC parameters from the TIME_CONV event, the parameters are used for
> conversion between timer counter and kernel time and which is applied
> for Arm SPE samples.
> 
> This version dropped the change for adding hardware clock parameters
> into auxtrace info, alternatively, it utilizes the TIME_CONV event to
> extract the clock parameters which is used for timestamp calculation.
> 
> This patch set can be clearly applied on perf/core branch with:
> 
>   commit 2c0cb9f56020 ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
> 
> Ths patch series has been tested on Hisilicon D06 platform.
> 
> Changes from v3:
> * Let to be backwards-compatible for TIME_CONV event (Adrian).
> 
> Changes from v2:
> * Changed to use TIME_CONV event for extracting clock parameters (Al).
> 
> Changes from v1:
> * Rebased patch series on the latest perf/core branch;
> * Fixed the patch for dumping TSC parameters to support both the
>   older and new auxtrace info format.
> 
> 
> Leo Yan (6):
>   perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
>   perf arm-spe: Save clock parameters from TIME_CONV event
>   perf arm-spe: Convert event kernel time to counter value
>   perf arm-spe: Assign kernel time to synthesized event
>   perf arm-spe: Bail out if the trace is later than perf event
>   perf arm-spe: Don't wait for PERF_RECORD_EXIT event
> 
>  tools/perf/util/arm-spe.c | 74 +++++++++++++++++++++++++++++++++------
>  tools/perf/util/arm-spe.h |  1 -
>  2 files changed, 64 insertions(+), 11 deletions(-)
> 
