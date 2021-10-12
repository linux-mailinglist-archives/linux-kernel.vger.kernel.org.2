Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2534042A859
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhJLPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbhJLPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:37:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFCC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=O2xtcWCEyqdJSQ4zVA90oDniqNFbqCM2lhNUZWtnECg=; b=2ovVw3A2IErGOiUh6XYHIZ5hxc
        8PSL9LAS/Fvt0P/5gk6bkP1cuXIw+alpqBNJqpTJ2WZ9VdZCHU66xEKARwcxQJyxUO4q7XYx6CjHB
        ixwVsBlVHQSu+9oVMq2dD0V/Gx0efdqIvuurFuQSn2LMh1w6VPhhKagQlRqqNVptTCJmgvt6PIonh
        vVrnnaxrHCxqmobRdOrAf3lYn0OgvhfRYB5yBxGZrBM0G5rOKE9AoRCJmaP1xyQ2AxgukOxN4flMM
        Vs8kzMOG6JVX6xgoQnTSxT3ZrhXjB+X4URk1AROU1Zwp+ZkFl5GVOVX981dSonufYw7+guY5uSZ56
        n2swPjUQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maJoN-00DM4V-Ne; Tue, 12 Oct 2021 15:35:27 +0000
Subject: Re: [PATCH v4 04/15] arm64: errata: Add detection for TRBE write to
 out-of-range
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
 <20211012131743.2040596-5-suzuki.poulose@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e38945ac-caef-6b18-fb27-62dd381caf44@infradead.org>
Date:   Tue, 12 Oct 2021 08:35:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012131743.2040596-5-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 6:17 AM, Suzuki K Poulose wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b9b181470f0f..87a07e895db9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -740,6 +740,47 @@ config ARM64_ERRATUM_2067961
>   
>   	  If unsure, say Y.
>   
> +config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +	bool
> +
> +config ARM64_ERRATUM_2253138
> +	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
> +	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
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

	  (i.e.,

> +
> +	  We work around this in the driver by, always making sure that there is a

	  Work around this in the driver by always making sure that there is a

> +	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2224489
> +	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
> +	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
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

	  (i.e.,

> +
> +	  We work around this in the driver by, always making sure that there is a

	  Work around this in the driver by always making sure that there is a

> +	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
> +
> +	  If unsure, say Y.


-- 
~Randy
