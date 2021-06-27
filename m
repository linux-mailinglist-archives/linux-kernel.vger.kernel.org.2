Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596B03B5584
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhF0Wbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhF0Wbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:31:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:To:References:Cc:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=d8svfUq3qYcrgyvvdRpE5dqBzOTIVqAR61eh/boxRkE=; b=USQpt8BrA9sN3c9kafC46ma2Fn
        BQdLtJSd4ZpOAeVBnjuNqL0Gp7drL8prMsaQ+ambM/+o1K5FApfPTBRdbno6bagj4BjP/8qDWR62O
        4oWyXWBuO6ey3K5IZN37yc7xnKrc466mFIyfcWp9kSMdqz+elf709NgQTwOZ/X1DZyC6tnAh0qpNX
        upZ80vWeQ9Sg01o7mnjcOCVCUDR2TcwDz+qv9M3KrB1GipRznx3ySDu85oyP8okxOMXrEzDjv4Bmj
        zBj3J47VDcv8WddrB9MAp5sGwQ5EQ+FJATdIRkupAeja9hW4cjSGOwXmTCMmZpKFU6dRtM39MgsLK
        zzx6mnVQ==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxdGu-006Efa-Fb; Sun, 27 Jun 2021 22:29:00 +0000
Subject: Re: [PATCH] ASoC: atmel: ATMEL drivers depend on HAS_DMA
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bo Shen <voice.shen@atmel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20210530204851.3372-1-rdunlap@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
Date:   Sun, 27 Jun 2021 15:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210530204851.3372-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding LKML]

ping?

thanks.

On 5/30/21 1:48 PM, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" here but several
> more are needed to prevent kconfig warnings since 'select' does not
> recognize any dependencies.
> 
> Fix the following kconfig warnings:
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
>   - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
>   - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> 
> Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Cc: alsa-devel@alsa-project.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bo Shen <voice.shen@atmel.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  sound/soc/atmel/Kconfig |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20210528.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20210528/sound/soc/atmel/Kconfig
> @@ -19,12 +19,14 @@ config SND_ATMEL_SOC_DMA
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_DMA
>  	select SND_ATMEL_SOC_PDC
>  
>  config SND_ATMEL_SOC_SSC_PDC
>  	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
>  	depends on ATMEL_SSC
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_PDC
>  	select SND_ATMEL_SOC_SSC
>  	help
> @@ -34,6 +36,7 @@ config SND_ATMEL_SOC_SSC_PDC
>  config SND_ATMEL_SOC_SSC_DMA
>  	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
>  	depends on ATMEL_SSC
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_DMA
>  	select SND_ATMEL_SOC_SSC
>  	help
> @@ -44,6 +47,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
>  	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_PDC
>  	select SND_SOC_WM8731
>  	help
> @@ -54,6 +58,7 @@ config SND_ATMEL_SOC_WM8904
>  	tristate "Atmel ASoC driver for boards using WM8904 codec"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && I2C
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_DMA
>  	select SND_SOC_WM8904
>  	help
> @@ -64,6 +69,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
>  	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_DMA
>  	select SND_SOC_WM8731
>  	help
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
