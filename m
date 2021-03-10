Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23596333A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhCJKob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:44:31 -0500
Received: from foss.arm.com ([217.140.110.172]:43610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232459AbhCJKo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:44:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 350F81FB;
        Wed, 10 Mar 2021 02:44:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.52.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272EA3F85F;
        Wed, 10 Mar 2021 02:44:27 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:44:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] arm64: perf: Fix 64-bit event counter read truncation
Message-ID: <20210310104348.GA19001@C02TD0UTHF1T.local>
References: <20210310004412.1450128-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310004412.1450128-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:44:12PM -0700, Rob Herring wrote:
> Commit 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection") changed
> armv8pmu_read_evcntr() to return a u32 instead of u64. The result is
> silent truncation of the event counter when using 64-bit counters. Given
> the offending commit appears to have passed thru several folks, it seems
> likely this was a bad rebase after v8.5 PMU 64-bit counters landed.

IIRC I wrote the indirection patch first, so this does sound like an
oversight when rebasing or reworking the patch.

Comparing against commit 0fdf1bb75953, this does appear to be the only
point of truncation given read_pmevcntrn() directly returns the result
of read_sysreg(), so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, could you pick this up?

Thanks,
Mark.

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
> -- 
> 2.27.0
> 
