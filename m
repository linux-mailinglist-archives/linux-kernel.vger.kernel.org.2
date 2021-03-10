Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6ED333AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhCJKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:53:35 -0500
Received: from foss.arm.com ([217.140.110.172]:43812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhCJKxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:53:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0351FB;
        Wed, 10 Mar 2021 02:53:15 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B54B3F85F;
        Wed, 10 Mar 2021 02:53:13 -0800 (PST)
Subject: Re: [PATCH] arm64: perf: Fix 64-bit event counter read truncation
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20210310004412.1450128-1-robh@kernel.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <cad9892b-b20e-99c2-677a-4f8bed35d217@arm.com>
Date:   Wed, 10 Mar 2021 10:53:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210310004412.1450128-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/10/21 12:44 AM, Rob Herring wrote:
> Commit 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection") changed
> armv8pmu_read_evcntr() to return a u32 instead of u64. The result is
> silent truncation of the event counter when using 64-bit counters. Given
> the offending commit appears to have passed thru several folks, it seems
> likely this was a bad rebase after v8.5 PMU 64-bit counters landed.

Thank you for the fix, it does seem that I made a mistake when rebasing the
series. Version v4 of the PMU NMI series was sent in 2019, then patch 8673e02e5841
("arm64: perf: Add support for ARMv8.5-PMU 64-bit counters") from March 2020
changed the read of PMEVCNTR_EL0 to return an u64, then version v5 from June 2020
changed it back to returning an u32.

The result of read_pmvevcntr() is returned by armv8pmu_read_evcntr(), and it is an
unsigned long which is 64bits for arm64, so the patch looks good to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Fixes: 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection")
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 7d2318f80955..4658fcf88c2b 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -460,7 +460,7 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
>  	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
>  }
>  
> -static inline u32 armv8pmu_read_evcntr(int idx)
> +static inline u64 armv8pmu_read_evcntr(int idx)
>  {
>  	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>  
