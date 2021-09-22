Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F1414733
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhIVLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:04:09 -0400
Received: from foss.arm.com ([217.140.110.172]:47162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhIVLEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:04:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4EAD11B3;
        Wed, 22 Sep 2021 04:02:38 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 410913F719;
        Wed, 22 Sep 2021 04:02:35 -0700 (PDT)
Subject: Re: [PATCH v2 17/17] arm64: Advertise TRBE erratum workaround for
 write to out-of-range address
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-18-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ed452d52-83bc-2e1f-db75-00865ef97ba5@arm.com>
Date:   Wed, 22 Sep 2021 16:33:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-18-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> Add Kconfig entries for the errata workarounds for TRBE writing
> to an out-of-range address.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  Documentation/arm64/silicon-errata.rst |  4 +++
>  arch/arm64/Kconfig                     | 39 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 569a92411dcd..5342e895fb60 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -96,6 +96,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1349291        | N/A                         |
> @@ -106,6 +108,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0764774e12bb..611ae02aabbd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -736,6 +736,45 @@ config ARM64_ERRATUM_2067961
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +	bool
> +
> +config ARM64_ERRATUM_2253138
> +	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
> +	depends on CORESIGHT_TRBE
> +	default y
> +	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +	help
> +	  This option adds the workaround for ARM Neoverse-N2 erratum 2253138.
> +
> +	  Affected Neoverse-N2 cores might write to an out-of-range address, not reserved
> +	  for TRBE. Under some conditions, the TRBE might generate a write to the next
> +	  virtually addressed page following the last page of the TRBE address space
> +	  (i.e, the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
> +
> +	  We work around this in the driver by, always making sure that there is a
> +	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2224489
> +	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
> +	depends on CORESIGHT_TRBE
> +	default y
> +	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +	help
> +	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
> +
> +	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
> +	  for TRBE. Under some conditions, the TRBE might generate a write to the next
> +	  virtually addressed page following the last page of the TRBE address space
> +	  (i.e, the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
> +
> +	  We work around this in the driver by, always making sure that there is a
> +	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
> +
> +	  If unsure, say Y.
> +
>  config CAVIUM_ERRATUM_22375
>  	bool "Cavium erratum 22375, 24313"
>  	default y
> 
