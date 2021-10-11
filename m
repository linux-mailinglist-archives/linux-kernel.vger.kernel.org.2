Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4B428AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhJKKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235843AbhJKKVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F8A60F3A;
        Mon, 11 Oct 2021 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633947542;
        bh=/3CWonXKLKUO2i8NasauuWwAB2FQLx48kpn8CBarvWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXtwrwiZsFdRb6MYzqZfRCeufrslzG2BxxqlJ13YXu3UyPpA8SCinTz1v3/yVgnVy
         wc4wjj6tPXKDV02H0eBHLxIKYZxAos49W7iuiueOM2Kih8bKwzw3dq0LjeV6kGsTQ7
         SUP9NJRSQ3h/mVatcifhTMWopgIOjEae0cUFhMXmPq3mV0Ni0e45jyMKG8jK9zHYSw
         kWt0daDZO84eanoFjDaOHAd3cGuudKO9QsBRlKRXFzYsqe38hYm1+k3Vijv6awg1ac
         FjcEK0jq02QRkk6xnUEeAYSU/s7SVw74FLP3+j5iB5yp7roh4t5zMxa6xHkknW9hwD
         aQqTSzMTwXOuw==
Date:   Mon, 11 Oct 2021 11:18:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com
Subject: Re: [PATCH v3 15/16] arm64: errata: Advertise the workaround for TSB
 flush failures
Message-ID: <20211011101851.GC3681@willie-the-truck>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
 <20211008182906.1688009-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008182906.1688009-16-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 07:29:05PM +0100, Suzuki K Poulose wrote:
> Advertise the workaround for the TSB flush failures via
> Kconfig entries.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since previous:
>   - Split the Kconfig/erratum updates to keep the conflicts
>     minimal with the other Kconfig updates in TRBE errata
>     I have retained the tags
> ---
>  Documentation/arm64/silicon-errata.rst |  4 ++++
>  arch/arm64/Kconfig                     | 31 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 2f99229d993c..569a92411dcd 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -94,6 +94,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1349291        | N/A                         |
> @@ -102,6 +104,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eac4030322df..0764774e12bb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -705,6 +705,37 @@ config ARM64_ERRATUM_2139208
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
> +	bool
> +
> +config ARM64_ERRATUM_2054223
> +	bool "Cortex-A710: 2054223: workaround TSB instruction failing to flush trace"
> +	default y
> +	help
> +	  Enable workaround for ARM Cortex-A710 erratum 2054223
> +
> +	  Affected cores may fail to flush the trace data on a TSB instruction, when
> +	  the PE is in trace prohibited state. This will cause losing a few bytes
> +	  of the trace cached.
> +
> +	  Workaround is to issue two TSB consecutively on affected cores.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2067961
> +	bool "Neoverse-N2: 2067961: workaround TSB instruction failing to flush trace"
> +	default y
> +	help
> +	  Enable workaround for ARM Neoverse-N2 erratum 2067961
> +
> +	  Affected cores may fail to flush the trace data on a TSB instruction, when
> +	  the PE is in trace prohibited state. This will cause losing a few bytes
> +	  of the trace cached.
> +
> +	  Workaround is to issue two TSB consecutively on affected cores.
> +
> +	  If unsure, say Y.

Shouldn't these two be selecting the workaround?

Will
