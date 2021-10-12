Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7336342A849
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhJLPd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhJLPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:33:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7BBC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=crGo3IJeu2AWugy840L5gvlRk7QUJYknB+m72k6ptUM=; b=zYdgf8FKWiGsD7WoFQn7MQijwy
        +GULQMWcUpjKYpZKlVDKE1Keemvq/SYQbxPQmK5YoG2podcp4Lx9ggE7BXdl/efvvl/ry7abPdrfu
        3h24kbgJnfKQI21CQRTKamD5CQHucOENq7yU+LKQLIP9ly3iQilodpSp0dSCBR3Zuyx5HQ7aa6K9x
        kmsPYbCWQFl6iZDtQN9F5fSqcowkSA6Xlgbu1jFl9kL3zq6j4syPTHktlEcdOAxKiaUYpenHUBMwV
        0Rq4bEYPuLfgTq3jUH/R+SDwWYvyLD7vczbBAXmTEQj0fjXuS9sTJLViB60u+uMwrAtFH6ONiKSkx
        FBmDso5w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maJkO-00DLWQ-Ck; Tue, 12 Oct 2021 15:31:20 +0000
Subject: Re: [PATCH v4 02/15] arm64: errata: Add detection for TRBE overwrite
 in FILL mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
 <20211012131743.2040596-3-suzuki.poulose@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50b26f6c-d0d3-b8bc-085d-1e274bb42a96@infradead.org>
Date:   Tue, 12 Oct 2021 08:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012131743.2040596-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/21 6:17 AM, Suzuki K Poulose wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 077f2ec4eeb2..404f56e87e93 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -666,6 +666,47 @@ config ARM64_ERRATUM_1508412
>   
>   	  If unsure, say Y.
>   
> +config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	bool
> +
> +config ARM64_ERRATUM_2119858
> +	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
> +	default y
> +	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
> +	depends on CORESIGHT_TRBE
> +	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	help
> +	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
> +
> +	  Affected Cortex-A710 cores could overwrite upto 3 cache lines of trace

	                                             up to

> +	  data at the base of the buffer (ponited by TRBASER_EL1) in FILL mode in

	                                  pointed to by

> +	  the event of a WRAP event.
> +
> +	  Work around the issue by always making sure we move the TRBPTR_EL1 by
> +	  256bytes before enabling the buffer and filling the first 256bytes of

	  256 bytes                                                 256 bytes

> +	  the buffer with ETM ignore packets upon disabling.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2139208
> +	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
> +	default y
> +	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
> +	depends on CORESIGHT_TRBE
> +	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +	help
> +	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
> +
> +	  Affected Neoverse-N2 cores could overwrite upto 3 cache lines of trace

	                                             up to

> +	  data at the base of the buffer (ponited by TRBASER_EL1) in FILL mode in

	                                  pointed to by

> +	  the event of a WRAP event.
> +
> +	  Work around the issue by always making sure we move the TRBPTR_EL1 by
> +	  256bytes before enabling the buffer and filling the first 256bytes of

	  256 bytes                                                 256 bytes

> +	  the buffer with ETM ignore packets upon disabling.
> +
> +	  If unsure, say Y.


-- 
~Randy
