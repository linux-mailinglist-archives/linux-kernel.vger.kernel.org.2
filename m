Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497C33BF1C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhGGWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:01:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39587 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhGGWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:01:59 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BA1CFFF809;
        Wed,  7 Jul 2021 21:59:16 +0000 (UTC)
Date:   Wed, 7 Jul 2021 23:59:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
Message-ID: <YOYjtE5R2ApV4N9F@piout.net>
References: <20210707214752.3831-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210707214752.3831-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2021 14:47:52-0700, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> needed. Dropping it eliminates the kconfig warnings and still builds
> with no problems reported.
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
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: rebase & resend;
>     drop Cc: to Bo Shen <voice.shen@atmel.com> # bounced
> v3: drop "depends on HAS_DMA" (as suggested by Codrin; Thanks)
> 
> ---
>  sound/soc/atmel/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20210707.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20210707/sound/soc/atmel/Kconfig
> @@ -11,7 +11,6 @@ if SND_ATMEL_SOC
>  
>  config SND_ATMEL_SOC_PDC
>  	bool
> -	depends on HAS_DMA
>  
>  config SND_ATMEL_SOC_DMA
>  	bool

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
