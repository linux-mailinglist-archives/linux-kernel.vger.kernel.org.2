Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CA344F02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCVSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhCVSsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:48:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B0C061574;
        Mon, 22 Mar 2021 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1bXBxLjsd8gmmpt9JoINY3mS7WqLO90NR1EkxxG5W+s=; b=MX/Zo3zPmaBavFnRNBIyCoEE0Z
        KGC0Qbqopibj/GZOpudJnYv+dRNJxJ6SDXTTokiit9VQyiSI4ULarBt1Gj6vOv72gY/eL8QDnYI3X
        geON5IyE6D9Ev8rj4zx0fF8U6gtUooaPEub7eOYpz3+SGqHfHjpEeBu98x3dzb9EbqeoTT64xri+d
        3F0BXeVa5E7AfxSybexCusDSYV5fX1IyXz9hXuoLeGsn4Gb7SRoQLwlEG9BzAb+C0oLqpFN3sUu/2
        I0Dclb/N3/PbdkJz8gGtiLcWIe/xdsB+ftttUU3ujK+Ayb4giG3h9UEGzQps0035diCg9a4AZjb7F
        jgVKchyA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPZa-008w1V-IR; Mon, 22 Mar 2021 18:47:02 +0000
Subject: Re: [PATCH] devicetree: replace invalid kernel-doc comment headers
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210322072343.19993-1-lukas.bulwahn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba94e5f1-8219-716d-2a6b-9cb2dd434ed8@infradead.org>
Date:   Mon, 22 Mar 2021 11:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322072343.19993-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 12:23 AM, Lukas Bulwahn wrote:
> The opening comment mark '/**' is used for indicating the beginning of
> kernel-doc comments.
> 
> Replace uses of '/**' for invalid cases in dt-binding headers and dts.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Rob, please pick this quick kernel-doc cleanup patch.
> 
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi       | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 2 +-
>  include/dt-bindings/reset/hisi,hi6220-resets.h | 2 +-
>  include/dt-bindings/reset/snps,hsdk-reset.h    | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> index 369b69b17b91..3d3d52bf41f5 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D02 Development Board
>   *
>   * Copyright (C) 2014,2015 Hisilicon Ltd.
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> index 4aed8d440b3a..5161e3476531 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D02 Development Board
>   *
>   * Copyright (C) 2014,2015 Hisilicon Ltd.
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> index 9f4a930e734d..97aa42a86fd9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D03 Development Board
>   *
>   * Copyright (C) 2016 Hisilicon Ltd.
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index 7deca5f763d5..d86ee1d25ab8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D03 Development Board
>   *
>   * Copyright (C) 2016 Hisilicon Ltd.
> @@ -315,7 +315,7 @@
>  		};
>  	};
>  
> -	/**
> +	/*
>  	 *  HiSilicon erratum 161010801: This describes the limitation
>  	 *  of HiSilicon platforms hip06/hip07 to support the SMMUv3
>  	 *  mappings for PCIe MSI transactions.
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> index 81a2312c8a26..57debca7b1ac 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D05 Development Board
>   *
>   * Copyright (C) 2016 Hisilicon Ltd.
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 2172d8071181..553f7c5209ad 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * dts file for Hisilicon D05 Development Board
>   *
>   * Copyright (C) 2016 Hisilicon Ltd.
> diff --git a/include/dt-bindings/reset/hisi,hi6220-resets.h b/include/dt-bindings/reset/hisi,hi6220-resets.h
> index 63aff7d8aa45..c67f479eede7 100644
> --- a/include/dt-bindings/reset/hisi,hi6220-resets.h
> +++ b/include/dt-bindings/reset/hisi,hi6220-resets.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * This header provides index for the reset controller
>   * based on hi6220 SoC.
>   */
> diff --git a/include/dt-bindings/reset/snps,hsdk-reset.h b/include/dt-bindings/reset/snps,hsdk-reset.h
> index e1a643e4bc91..6a331c8d834d 100644
> --- a/include/dt-bindings/reset/snps,hsdk-reset.h
> +++ b/include/dt-bindings/reset/snps,hsdk-reset.h
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * This header provides index for the HSDK reset controller.
>   */
>  #ifndef _DT_BINDINGS_RESET_CONTROLLER_SNPS_HSDK
> 


-- 
~Randy

