Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05940422EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhJERG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhJERG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:06:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 10:04:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q201so7713985pgq.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vJL5RBBEPAojwwerfQWLbT4+3M48WLtJ2iAcE9/gfPM=;
        b=wMSoz7AmigptJAzkaB5Kg+8Z1cweBKisxtp6FIhKwkgpVbT7ORjA5oNCWuIIlGDsgJ
         13d/7oIbKEWwOzY+vMIAS9+znWyySt775cmEe95iS9XvXrP58kHl0XGpCKN012iaXGMD
         uo8flyGB5cEvhBwIVOON8WsL+HsUiQ7WCyq5Jwcul6xXKcstD9Vdg/6pexqjWMX9+NMZ
         9aTxyns8y85/fHXwy08bnecVp5BK7B7pYbYvG6SLsU9VmjRxRhTA2J9EmbKJUavgKyCZ
         R3OqpGDSJiWOGEYtwLRluF80NUjjcGd9Eow6esS9Vr4B4/U7GyYLOOEHXBPhOY8jyE4N
         uDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJL5RBBEPAojwwerfQWLbT4+3M48WLtJ2iAcE9/gfPM=;
        b=dc6f+YVYpwvUWkcA3vSLBYvXkBTTkfN7O/kKbsObf4poLrpiuCz6z9R5eWwXSPtHCQ
         O+J9t9+1dFSro3pWRpVMrwPQPjsves8EplpcFou99iLcaILJ1OZVoTh7ag3pZD62BpSg
         1deBsbTL4QK68kzt18rXSIr1CZjS1elnOrAKGgE0+hnKHm0pLjy7w1aKdB8JHlfrZoPV
         I//6J6miI/NBEBim/fLcmDdecnT8p3ZEm5OgqqY60ZdLxpeXwLZ6DtH+iGcfny8S0y13
         1GP1zjtdVuFa84plrLQaUo7k9xrek+hIUfdkzADL6vLuOas0j+Wcdg0CJOjTiWCzfXvE
         ueVA==
X-Gm-Message-State: AOAM530xJFhal8lnfDFZIdzrgJABUyGGQVQMS04M9m8b8OrGqYkSEeU0
        /LpzwbYEY2za+0c1TqkQfrkBCw==
X-Google-Smtp-Source: ABdhPJxfUrrdJ/BZRh9HLBnxEMp0pe5IGHfZw+LbMJc9PErjjA/pVchfRo6BtSNUCQTXerSTzd/vUg==
X-Received: by 2002:a62:8f8a:0:b0:44c:6e3c:4807 with SMTP id n132-20020a628f8a000000b0044c6e3c4807mr8831462pfd.68.1633453475764;
        Tue, 05 Oct 2021 10:04:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q2sm2685808pjo.27.2021.10.05.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:04:34 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:04:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 00/17] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211005170432.GB3311227@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:04PM +0100, Suzuki K Poulose wrote:
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
> The series applies on the self-hosted/trbe fixes posted here [0].
> A tree containing both the series is available here [1]
> 
>  [0] https://lkml.kernel.org/r/20210914102641.1852544-1-suzuki.poulose@arm.com
>  [1] git@git.gitlab.arm.com:linux-arm/linux-skp.git coresight/errata/trbe-tsb-n2-a710/v2
> 
> Changes since v1:
>  https://lkml.kernel.org/r/20210728135217.591173-1-suzuki.poulose@arm.com
>  - Added a fix to the TRBE driver handling of sink_specific data
>  - Added more description and ASCII art for overwrite in FILL mode
>    work around 
>  - Added another TRBE erratum to the list.
>   "TRBE may write to out-of-range address"
>   Patches from 12-17
>  - Added comment to list the expectations around TSB erratum workaround.
> 
> 
> Suzuki K Poulose (17):
>   coresight: trbe: Fix incorrect access of the sink specific data
>   coresight: trbe: Add infrastructure for Errata handling
>   coresight: trbe: Add a helper to calculate the trace generated
>   coresight: trbe: Add a helper to pad a given buffer area
>   coresight: trbe: Decouple buffer base from the hardware base
>   coresight: trbe: Allow driver to choose a different alignment
>   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
>   arm64: Add erratum detection for TRBE overwrite in FILL mode
>   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
>   arm64: Enable workaround for TRBE overwrite in FILL mode
>   arm64: errata: Add workaround for TSB flush failures
>   coresight: trbe: Add a helper to fetch cpudata from perf handle
>   coresight: trbe: Add a helper to determine the minimum buffer size
>   coresight: trbe: Make sure we have enough space
>   arm64: Add erratum detection for TRBE write to out-of-range
>   coresight: trbe: Work around write to out of range
>   arm64: Advertise TRBE erratum workaround for write to out-of-range address
> 
>  Documentation/arm64/silicon-errata.rst       |  12 +
>  arch/arm64/Kconfig                           | 109 ++++++
>  arch/arm64/include/asm/barrier.h             |  16 +-
>  arch/arm64/include/asm/cputype.h             |   4 +
>  arch/arm64/kernel/cpu_errata.c               |  64 ++++
>  arch/arm64/tools/cpucaps                     |   3 +
>  drivers/hwtracing/coresight/coresight-trbe.c | 339 +++++++++++++++++--
>  7 files changed, 510 insertions(+), 37 deletions(-)

Patches 04 to 11 and 13 to 17:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I am done reviewing this set.

Thanks,
Mathieu

> 
> -- 
> 2.24.1
> 
