Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10D3BF17F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGGVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhGGVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:46:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YNgeYfPK9ovjzJBwdzS6vQtuS1rTuTNOeG0uEP7N+Hs=; b=XUMof7cikcltAkqq+p07WegWcy
        V1qVaWoe+R1LEbgOqNC0dhBbawBP+h4WUf7SdbOtF9Eeeg5rPS9EyFoTbwElisx8l8tmmEbHkpStd
        4vZ5+Kyj/VGfHZ9GJG9/bRHgQpTgWiXTyhyMzMf/ylGbwAdVeeTL7glQJUy0HbvTOZhAetJZMuXdg
        xB9YVmZnn+qGgOgBVLJXwD1omedUOHAh9N30BcAVjZo7nLYNgnBq8+j+iIQ6sjx7WLKzPvIXXprBU
        twhJg6qSx13Gp6RyO9aqP2Oq/GlxQBt26LUuVAgQak75dl+WbwwH0i9iO5+BiWNjaab6Nnt0sj0C5
        vu4W4cWg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.82])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1FKP-00FmXL-GY; Wed, 07 Jul 2021 21:43:33 +0000
Subject: Re: [PATCH v2] ASoC: atmel: ATMEL drivers depend on HAS_DMA
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Codrin.Ciubotariu@microchip.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, broonie@kernel.org, mirq-linux@rere.qmqm.pl
References: <20210628211158.30273-1-rdunlap@infradead.org>
 <5613542b-a530-ebd8-11c6-ea515cb3f8a9@microchip.com>
 <YOYDjtStnw9CO5dR@piout.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb33b720-14c1-9346-82ac-0da2e8fd0584@infradead.org>
Date:   Wed, 7 Jul 2021 14:43:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOYDjtStnw9CO5dR@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 12:42 PM, Alexandre Belloni wrote:
> On 07/07/2021 16:40:34+0000, Codrin.Ciubotariu@microchip.com wrote:
>> On 29.06.2021 00:11, Randy Dunlap wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
>>> is not set, several ATMEL ASoC drivers select symbols that cause
>>> kconfig warnings. There is one "depends on HAS_DMA" here but several
>>> more are needed to prevent kconfig warnings since 'select' does not
>>> recognize any dependencies.
>>>
>>> Fix the following kconfig warnings:
>>>
>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>>>    Selected by [m]:
>>>    - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
>>>    - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
>>>
>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
>>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>>>    Selected by [m]:
>>>    - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
>>>
>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
>>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>>>    Selected by [m]:
>>>    - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
>>>
>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
>>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>>>    Selected by [m]:
>>>    - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
>>>    - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
>>
>> Hi Randy,
>>
>> Sorry about my delayed response. I think it would be better to just 
>> remove HAS_DMA from SND_ATMEL_SOC_PDC, since it seems to compile fine 
>> without it. This should fix all the problems...
>>
> 
> I bet this is correct since m32r is gone.

Yes, that builds for me with no problems.
I'll submit that patch soon.

Thanks.

