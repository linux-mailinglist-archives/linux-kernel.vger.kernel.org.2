Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545B93DD2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhHBJeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:34:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232699AbhHBJeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F6A106F;
        Mon,  2 Aug 2021 02:33:54 -0700 (PDT)
Received: from [10.163.66.153] (unknown [10.163.66.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B2A83F70D;
        Mon,  2 Aug 2021 02:33:51 -0700 (PDT)
Subject: Re: [PATCH 09/10] arm64: Enable workaround for TRBE overwrite in FILL
 mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-10-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d07995fd-90a2-34d7-31c6-417ef1469a75@arm.com>
Date:   Mon, 2 Aug 2021 15:04:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728135217.591173-10-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
> Now that we have the work around implmented in the TRBE

				Typo ^^^^^

> driver, add the Kconfig entries and document the errata.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/arm64/silicon-errata.rst |  4 +++
>  arch/arm64/Kconfig                     | 39 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index d410a47ffa57..2f99229d993c 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -92,12 +92,16 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1349291        | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5b13a932561..ad301045dafc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -669,6 +669,45 @@ config ARM64_ERRATUM_1508412
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	bool

Should this be moved to the earlier patch (7/10) which detects the erratum ?
Might be better to add the definition in Kconfig (even though not selected)
when using it for the first time. 

> +
> +config ARM64_ERRATUM_2119858
> +	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
> +	default y
> +	depends on CORESIGHT_TRBE
> +	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	help
> +	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
> +
> +	  Affected Cortex-A710 cores could overwrite upto 3 cache lines of trace
> +	  data at the base of the buffer (ponited by TRBASER_EL1) in FILL mode in

				Typo	  ^^^^^^

> +	  the event of a WRAP event.
> +
> +	  Work around the issue by always making sure we move the TRBPTR_EL1 by
> +	  256bytes before enabling the buffer and filling the first 256bytes of

Nit:   space ^^							space ^^

> +	  the buffer with ETM ignore packets upon disabling.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2139208
> +	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
> +	default y
> +	depends on CORESIGHT_TRBE
> +	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	help
> +	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
> +
> +	  Affected Neoverse-N2 cores could overwrite upto 3 cache lines of trace
> +	  data at the base of the buffer (ponited by TRBASER_EL1) in FILL mode in

				Typo	  ^^^^^^

> +	  the event of a WRAP event.
> +
> +	  Work around the issue by always making sure we move the TRBPTR_EL1 by
> +	  256bytes before enabling the buffer and filling the first 256bytes of

Nit:   space ^^							space ^^

> +	  the buffer with ETM ignore packets upon disabling.
> +
> +	  If unsure, say Y.
> +
>  config CAVIUM_ERRATUM_22375
>  	bool "Cavium erratum 22375, 24313"
>  	default y
> 

Otherwise LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
