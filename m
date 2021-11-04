Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F5444E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKDFMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKDFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B6C061714;
        Wed,  3 Nov 2021 22:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=hLeZuA6+y/h2sPtdQ9ys3jKZna0S4QwtHwdD34B2L7I=; b=dRCsoZMekVjAC7qCVkQCCMwTrK
        gIkXLDoLVjFBVyOYnY8ZOWoU6WZ03jFdPdfyZJKUyAPiswPO4/lk8qJU2i9BFQpqLf32zMRTD/QoI
        S+Xgd6vLZeu6PHyfVq2kt43OkDLyoFvUoyrrhKrFzAUSEKIt/YhHF1+L/mZ1PTZsCZKoXZfsP/7rk
        /Ib+VlhrKeZ3s/EgEjaEvJPAhTUL+evCJIBE22CwuHd/b7CaJTmuOKqXQ6E++DVj+f1Ck/jI0Ozz7
        tKA1+jLmCV84U2md3OOQwNlaYfIOdlBOwKXp5751mFGKBZSj7PDaBLCnkC8WoQZChgRvTCAtqu0Ok
        tcEbsjZg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miV0A-007s3x-Tu; Thu, 04 Nov 2021 05:09:27 +0000
Subject: Re: [PATCH v4 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <480a3ab57b45f4483612db1211dd25d424d90ec5.1635993377.git.qinjian@cqplus1.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7bf26448-4014-f03d-7c9a-3fbd41358095@infradead.org>
Date:   Wed, 3 Nov 2021 22:09:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <480a3ab57b45f4483612db1211dd25d424d90ec5.1635993377.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 7:57 PM, Qin Jian wrote:
> diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
> new file mode 100644
> index 000000000..f7ad76959
> --- /dev/null
> +++ b/arch/arm/mach-sunplus/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +config SOC_SP7021
> +	bool "Sunplus SP7021 SoC support"
> +	default y
> +	select CPU_V7
> +	select ARM_GIC
> +	select SUNPLUS_SP7021_INTC
> +	select HAVE_SMP
> +	select ARM_PSCI
> +	select COMMON_CLK_SP7021
> +	select PINCTRL
> +	select PINCTRL_SPPCTL
> +	select OF_OVERLAY
> +	select GPIOLIB
> +	help
> +	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
> +	  Cotex-A7 with various peripherals (ex: I2C, SPI, SDIO,

Is that   Cortex-A7
?

> +	  Ethernet and etc.), FPGA interface,  chip-to-chip bus.
> +	  It is designed for industrial control.


-- 
~Randy
