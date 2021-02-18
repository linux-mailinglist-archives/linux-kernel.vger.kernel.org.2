Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE931F092
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBRT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBRTbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:31:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0BB364E22;
        Thu, 18 Feb 2021 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613676655;
        bh=lnUB2bONZeJO5S0p4iu2vLKyPBpgxp21eol/4JgnczE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUX0OEC/R1kLWJddDeZ6/qdwP+N7FS3ddLDaBQg6zQ+MDBTA/BNR1Djir8i5uzPzy
         /w0LwqdLaCiA9aI4PZRpGkzWpq+GN9Sw7VWrMInTKtP33/rHCQBjtL9lXtY/XB8KQg
         RPw1qvk/UnxVJUw73hUuQHgeyvaguQny50RPtTgAddoLw23eHG+Z5sVSIzI+uvv4Ol
         rYGvTGrAawuh+b6prNb30wOWsgP3EDRa3SiCtLNeFdcmyRTzeZ8tJJ9mBlWbU9JCyU
         AxXlodMkcc6nYFaBigaOb/8wRyGFyTlbUSzNa1PkuKny5CYMJ9GLMr64fYGVLPUaBR
         Bb+UBZkTrUOkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B29CE40CD9; Thu, 18 Feb 2021 16:30:52 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:30:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] perf test: Output sub testing result in cs-etm
Message-ID: <YC7AbM4fPBs7DxVo@kernel.org>
References: <20210215115944.535986-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215115944.535986-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 15, 2021 at 07:59:42PM +0800, Leo Yan escreveu:
> The "perf test" can be integrated into testing framework, e.g. Linux
> kernel functional testing (LKFT) [1].  We are not satisfied with only
> outputting the summarized result for Arm CoreSight testing but lacking
> more detailed result for sub testing.
> 
> This patch set is to output sub testing result in cs-etm.  Thus the
> testing framework can extract the detailed info and generates reports
> for which sub cases causes failure.
> 
> This patch set is cleanly applied on perf/core branch with:
> 
>   commit 6db59d357e8e ("perf arm64/s390: Fix printf conversion specifier for IP addresses")
> 
> After applied the patches, which is tested on Arm Juno-r2 board with
> option '-v', the output result is shown in below; the introduced sub
> testing result has the format like:

Thanks, applied.

- Arnaldo

 
>   "CoreSight path testing (CPU0 -> tmc_etf0): PASS".
> 
> 
>   # perf test 73 -v
>   73: Check Arm CoreSight trace data recording and synthesized samples:
>   --- start ---
>   test child forked, pid 17423
>   Recording trace (only user mode) with path: CPU0 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:       
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:     
>   CoreSight path testing (CPU0 -> tmc_etf0): PASS   
>   Recording trace (only user mode) with path: CPU0 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:       
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:     
>   CoreSight path testing (CPU0 -> tmc_etr0): PASS   
>   Recording trace (only user mode) with path: CPU1 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:       
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:     
>   CoreSight path testing (CPU1 -> tmc_etf0): PASS   
>   Recording trace (only user mode) with path: CPU1 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:     
>   CoreSight path testing (CPU1 -> tmc_etr0): PASS   
>   Recording trace (only user mode) with path: CPU2 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:     
>   CoreSight path testing (CPU2 -> tmc_etf0): PASS   
>   Recording trace (only user mode) with path: CPU2 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:                  
>   CoreSight path testing (CPU2 -> tmc_etr0): PASS        
>   Recording trace (only user mode) with path: CPU3 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU3 -> tmc_etf0): PASS
>   Recording trace (only user mode) with path: CPU3 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU3 -> tmc_etr0): PASS
>   Recording trace (only user mode) with path: CPU4 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU4 -> tmc_etf0): PASS
>   Recording trace (only user mode) with path: CPU4 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU4 -> tmc_etr0): PASS
>   Recording trace (only user mode) with path: CPU5 => tmc_etf0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU5 -> tmc_etf0): PASS
>   Recording trace (only user mode) with path: CPU5 => tmc_etr0
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight path testing (CPU5 -> tmc_etr0): PASS
>   Recording trace with system wide mode
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight system wide testing: PASS
>   Recording trace with snapshot mode
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight snapshot testing: PASS
>   test child finished with 0
>   ---- end ----
>   Check Arm CoreSight trace data recording and synthesized samples: Ok
> 
> [1] https://lkft.linaro.org/
> 
> 
> Leo Yan (2):
>   perf test: Suppress logs in cs-etm testing
>   perf test: Output the sub testing result in cs-etm
> 
>  tools/perf/tests/shell/test_arm_coresight.sh | 45 ++++++++++----------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 

- Arnaldo
