Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD333C176D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhGHQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGHQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:53:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638FDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=rRjw0MD5mNTCw5c7zVuaZpo/EngGyn3l6moiSAMWrZo=; b=dEEI2DJ2/5DjEr22QVGqIT5SK6
        cjFeYoY3XcdnNfSHkj2TkppKM5DwnQLrFLNoN1FohaDoUyekGg8vbQgM+a27yQsz6wi/G6gkKOuQ4
        eIFXNUwtRCZ9B24WAMX7oqppvjF5gd9Et55yKh6LjMghEtDPU5Q0+ukPJjyPJ4llJf2xJrxK90zu3
        NuPf21AmwPMZHxCkqRP/0KKpdRYcyiDYruJJf7Iz7IybeZt2wBdFCuPxY0PkqyY0dlLzL02wlBQDl
        hAZZ2ViJqfx6R2FrqAFNLC3tT0vUGiy0oUEPqfCFUsl9J7JTjYyIeSekGwgjI/zw12vZmz6z6l3eS
        rO8SL2tg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1XEi-00HX04-FP; Thu, 08 Jul 2021 16:50:52 +0000
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
To:     Codrin.Ciubotariu@microchip.com, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl,
        alexandre.belloni@free-electrons.com
References: <20210707214752.3831-1-rdunlap@infradead.org>
 <fca8f952-2be0-5c57-d60d-5c4f025abc4d@microchip.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <49495ab9-5039-f332-2895-1a79c034f58d@infradead.org>
Date:   Thu, 8 Jul 2021 09:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fca8f952-2be0-5c57-d60d-5c4f025abc4d@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/21 1:19 AM, Codrin.Ciubotariu@microchip.com wrote:
> On 08.07.2021 00:47, Randy Dunlap wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
>> is not set, several ATMEL ASoC drivers select symbols that cause
>> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
>> needed. Dropping it eliminates the kconfig warnings and still builds
>> with no problems reported.
>>
>> Fix the following kconfig warnings:
>>
>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>>    Selected by [m]:
>>    - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
>>    - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
>>
>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>>    Selected by [m]:
>>    - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
>>
>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>>    Selected by [m]:
>>    - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
>>
>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>>    Selected by [m]:
>>    - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
>>    - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
>>
>> Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
>> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
>> Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> 
> I am not sure about these fixes tags. As Alexandre mentioned, it looks 
> like the reason for HAS_DMA in the first place was the COMPILE_TEST with 
> m32r arch. I dig a bit, and, if any, I think we should use:
> Fixes: eb17726b00b3 ("m32r: add simple dma")
> since this commit adds dummy DMA support for m32r and seems to fix the 
> HAS_DMA dependency.

Ah, I forgot to update the Fixes: tag(s).

I won't disagree with your Fixes: suggestion (good digging) but
I would probably have used 8d7d11005e930:
  ASoC: atmel: fix build failure
which is the commit that added "depends on HAS_DMA".

>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Other than that:
> Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thanks.  I'll send a v4 with your Fixes: suggestion.

