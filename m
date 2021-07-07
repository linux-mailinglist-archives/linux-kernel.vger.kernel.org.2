Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF63BF067
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhGGTou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:44:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43869 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGGTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:44:49 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7DC16200003;
        Wed,  7 Jul 2021 19:42:06 +0000 (UTC)
Date:   Wed, 7 Jul 2021 21:42:06 +0200
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Codrin.Ciubotariu@microchip.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH v2] ASoC: atmel: ATMEL drivers depend on HAS_DMA
Message-ID: <YOYDjtStnw9CO5dR@piout.net>
References: <20210628211158.30273-1-rdunlap@infradead.org>
 <5613542b-a530-ebd8-11c6-ea515cb3f8a9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5613542b-a530-ebd8-11c6-ea515cb3f8a9@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2021 16:40:34+0000, Codrin.Ciubotariu@microchip.com wrote:
> On 29.06.2021 00:11, Randy Dunlap wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> > is not set, several ATMEL ASoC drivers select symbols that cause
> > kconfig warnings. There is one "depends on HAS_DMA" here but several
> > more are needed to prevent kconfig warnings since 'select' does not
> > recognize any dependencies.
> > 
> > Fix the following kconfig warnings:
> > 
> > WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> >    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >    Selected by [m]:
> >    - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
> >    - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> > 
> > WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
> >    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >    Selected by [m]:
> >    - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> > 
> > WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
> >    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >    Selected by [m]:
> >    - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> > 
> > WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
> >    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >    Selected by [m]:
> >    - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
> >    - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> 
> Hi Randy,
> 
> Sorry about my delayed response. I think it would be better to just 
> remove HAS_DMA from SND_ATMEL_SOC_PDC, since it seems to compile fine 
> without it. This should fix all the problems...
> 

I bet this is correct since m32r is gone.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
