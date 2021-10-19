Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E903B432D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhJSGCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:02:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSGCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:02:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613222F;
        Mon, 18 Oct 2021 23:00:36 -0700 (PDT)
Received: from [10.163.74.241] (unknown [10.163.74.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C043F73D;
        Mon, 18 Oct 2021 23:00:32 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] arm64: errata: Enable TRBE workaround for write
 to out-of-range address
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-16-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <378825b9-8cea-27b4-f5f5-bff187834f3d@arm.com>
Date:   Tue, 19 Oct 2021 11:30:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014223125.2605031-16-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 4:01 AM, Suzuki K Poulose wrote:
> With the TRBE driver workaround available, enable the config symbols
> to be built without COMPILE_TEST
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f72fa44d6182..d6383ef05871 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -743,7 +743,6 @@ config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
>  
>  config ARM64_ERRATUM_2253138
>  	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE
>  	default y
>  	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> @@ -762,7 +761,6 @@ config ARM64_ERRATUM_2253138
>  
>  config ARM64_ERRATUM_2224489
>  	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE
>  	default y
>  	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> 
