Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1690434F39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJTPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:44:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB95DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:42:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c29so3306048pfp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c+xPgYkrWTMdjLrIsHan+BrpvJlj3eKlilQPqn/bZSY=;
        b=RAzdANXkgkI+Gok9tMLYGIzwZ1/HQKiIDh199K0ieSqbROzxL43eoyRpHcQP0VHou2
         dbSzFg/B28dqPTYQZ6p0rxyhXD6ypkyqnwcpNUZL7ON4RGi+4q0xDUJbBYs5hY2elxZy
         uwbHGOdH7dtp8EtnURxI9aK/tpdUbzLZ2uWCl5sqKBmus2zHD5eP/Bl2w2yiQ0Mv0hwS
         WmFwlG1p5n9RjQ1qweBEe+2Id5lIlqP0AiUU0EuoVkG8bWxIUB6LKdEbz2O45gb0NA4z
         jln0Or9OAAI3uc5YMfH32ax7qGBsYtJM9iTT9B2VtzGULL7zHVerBP+VlZBXgTOgxfeq
         A63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+xPgYkrWTMdjLrIsHan+BrpvJlj3eKlilQPqn/bZSY=;
        b=eNEmfpD64xv/EngZkTiJIXL9nh8sy/nGGT8W9c6w2eelSFI5nA8vInO71A/l8U0TA2
         1lkQJELRyGuemqFYpbk3d85n3IcIQjb5LxPYBZwnN26lULFke3K2jbsVtA9RGoH9LmFx
         pHhjv9NAUjQ0K8Ue4XPXPqU4IyYTSNcJMTjiu/5I1SrRHyPwcs/KvoUEjqvCEVLXrTdB
         m6r0yjPdTdEPipvOk5LExaPdKGmexgP/ia3JBTAGrBzmk9ptCYvUAP3ejNuaW59DV5DN
         wn1cmUwwCAdsU101wgJvdGFKS90OndsNbvXEFPL7ytKlFH+0/lqYpi6OXkyzALRf5F6W
         bJjA==
X-Gm-Message-State: AOAM530SIKfl0LTpxZD7M1L0GDUmnl0bcU20fBKTbq9657Nem5nDQwK7
        ZmLUzmiukhf2/+IzUmBmrB2YaQ==
X-Google-Smtp-Source: ABdhPJzwfDWiZNvP0Rx+LYgr7dgiWMYUGS2WfEOnCVY9FBhQbJFG5NvOK3iQm4blGTKKzuyBN/2n3A==
X-Received: by 2002:a05:6a00:1829:b0:44d:df1f:5624 with SMTP id y41-20020a056a00182900b0044ddf1f5624mr596231pfa.27.1634744531128;
        Wed, 20 Oct 2021 08:42:11 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d21sm3242747pfl.135.2021.10.20.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:42:09 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:42:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211020154207.GA3456574@p14s>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019163153.3692640-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> 
> This series adds CPU erratum work arounds related to the self-hosted
> tracing. The list of affected errata handled in this series are :
> 
>  * TRBE may overwrite trace in FILL mode
>    - Arm Neoverse-N2	#2139208
>    - Cortex-A710	#211985
> 
>  * A TSB instruction may not flush the trace completely when executed
>    in trace prohibited region.
> 
>    - Arm Neoverse-N2	#2067961
>    - Cortex-A710	#2054223
> 
>  * TRBE may write to out-of-range address
>    - Arm Neoverse-N2	#2253138
>    - Cortex-A710	#2224489
> 
> The series applies on coresight/next. The series has been reordered
> to make it easier to merge the patches via arm64 tree and the coresight
> tree.
> 
> Patches 1-4 are could be picked up via arm64 tree. The rest can go via
> the coresight tree. The Kconfig items for the TRBE errata are initially
> dropped in with dependency on COMPILE_TEST. These are dropped only after
> the driver is equipped with the work around in later patches.
> 
> 
> A tree is available here :
> 
> git@git.gitlab.arm.com:linux-arm/linux-skp.git  coresight/errata/trbe-tsb-n2-a710/v6
> 
> Changes since v5:
>  * https://lkml.kernel.org/r/20211014223125.2605031-1-suzuki.poulose@arm.com
>  - Fix typo in the Kconfig symbol usage in errata listing (Will)
>  - Fix typo in commit description for 
>    "arm64: errata: Add detection for TRBE overwrite in FILL mode"
>  - Fix commit description checkpatch warnings on column length for:
>     "arm64: errata: Add detection for TRBE write to out-of-range"
>  - Collected Reviews/Acks from Mathieu/Anshuman/Will
> 
> Changes since v4:
>  * https://lkml.kernel.org/r/20211012131743.2040596-1-suzuki.poulose@arm.com
> 
>  - Fix WARN on trbe driver probe on a hotplugged CPU, by making
>    sure that the arm_trbe_probe_cpu() is called from non-premptible
>    context. this_cpu_has_cap() doesn't like to be called from a
>    preemptible() context.
> 
>  - Fix Kconfig text issues pointed out by Randy
> 
> Changes since v3:
>  
>  - Fix missing Kconfig selection for TSB flush failure erratum (Will)
>    Merged the Kconfig changes to the core patch for TSB.
>  - Use COMPILE_TEST dependency for the TRBE work arounds instead of
>    delaying the Kconfig entries.
> 
> Changes since v2:
>  * https://lkml.kernel.org/r/20210921134121.2423546-1-suzuki.poulose@arm.com 
>  - Dropped patch adding a helper to reach cpudata from perf handle
>  - Split the TSB erratum work around patch to split the Kconfig/erratum
>    list update changes(pushed to the end of the series).
>  - Added wrappers to check the erratum :
>     trbe_has_erratum(cpudata, TRBE_ERRATUM_<TITLE>) -> trbe_may_<title>
>  - More ASCII art explanation on workaround.
> 
> Changes since v1:
>  * https://lkml.kernel.org/r/20210728135217.591173-1-suzuki.poulose@arm.com
>  - Added a fix to the TRBE driver handling of sink_specific data
>  - Added more description and ASCII art for overwrite in FILL mode
>    work around 
>  - Added another TRBE erratum to the list.
>   "TRBE may write to out-of-range address"
>   Patches from 12-17
>  - Added comment to list the expectations around TSB erratum workaround.
> 
> 
> 
> Suzuki K Poulose (15):
>   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
>   arm64: errata: Add detection for TRBE overwrite in FILL mode
>   arm64: errata: Add workaround for TSB flush failures
>   arm64: errata: Add detection for TRBE write to out-of-range
>   coresight: trbe: Add a helper to calculate the trace generated
>   coresight: trbe: Add a helper to pad a given buffer area
>   coresight: trbe: Decouple buffer base from the hardware base
>   coresight: trbe: Allow driver to choose a different alignment
>   coresight: trbe: Add infrastructure for Errata handling
>   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
>   coresight: trbe: Add a helper to determine the minimum buffer size
>   coresight: trbe: Make sure we have enough space
>   coresight: trbe: Work around write to out of range
>   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
>   arm64: errata: Enable TRBE workaround for write to out-of-range
>     address
> 
>  Documentation/arm64/silicon-errata.rst       |  12 +
>  arch/arm64/Kconfig                           | 111 ++++++
>  arch/arm64/include/asm/barrier.h             |  16 +-
>  arch/arm64/include/asm/cputype.h             |   4 +
>  arch/arm64/kernel/cpu_errata.c               |  64 +++
>  arch/arm64/tools/cpucaps                     |   3 +
>  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
>  7 files changed, 567 insertions(+), 37 deletions(-)

I have applied this set.

Thanks,
Mathieu

> 
> -- 
> 2.25.4
> 
