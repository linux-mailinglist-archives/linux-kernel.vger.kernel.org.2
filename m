Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920604445AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhKCQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhKCQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:18:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AOsyCgZE6MJ4p0vyz+bhHBA8QhVxzWHGR03f3rBg+1o=; b=aLUGp44NafpCSUm7Qy08z/kw24
        JYbtsX4n3idfMynbyx+Ae0BkGO6EH5tXIvw4qEA1eLFv1p8d1udn77qtqLznUegSLR86nracRJ17X
        kqQ0OKaQSS8t5AZipevuRJmIUSGOVLF1RCJtLPX95u/PJTsK1wcX2cAdW4vnDHscpyk141TsqF/+H
        BEGDQaBiJK2BQXW/NJlBgTMeAPOTisz4FTFVCFSk+EqUek/2nRRaJb5Jq9iSk8Q2tanfzce6//erL
        3KJW3KQ0FTVLYb9h3PsYKZFi1qT0x1FADtVEEo1JKTy99FUlKi/xQIY3jJUJ67aPVCydODa40kpRY
        MXZ4PsFA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miIvM-005hxE-TK; Wed, 03 Nov 2021 16:15:41 +0000
Subject: Re: [PATCH] ASoC: amd: vangogh: add SPI dependency
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211019191453.3047514-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b2a01d9f-7012-3e7c-5792-2620acce8967@infradead.org>
Date:   Wed, 3 Nov 2021 09:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019191453.3047514-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/21 12:14 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_SPI, this fails to build:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_CS35L41_SPI
>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SPI_MASTER [=n]
>    Selected by [m]:
>    - SND_SOC_AMD_VANGOGH_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP5x [=m] && I2C [=y]
> ERROR: modpost: "spi_setup" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!
> ERROR: modpost: "__devm_regmap_init_spi" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!
> 
> Fixes: 96792fdd77cd ("ASoC: amd: enable vangogh platform machine driver build")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/amd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index d91a9399777c..edee2098c82e 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -68,7 +68,7 @@ config SND_SOC_AMD_VANGOGH_MACH
>   	tristate "AMD Vangogh support for NAU8821 CS35L41"
>   	select SND_SOC_NAU8821
>   	select SND_SOC_CS35L41_SPI
> -	depends on SND_SOC_AMD_ACP5x && I2C
> +	depends on SND_SOC_AMD_ACP5x && I2C && SPI
>   	help
>   	  This option enables machine driver for Vangogh platform
>   	  using NAU8821 and CS35L41 codecs.
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Just had this build error in linux-next-20211103
so this patch is needed there.

Thanks.

-- 
~Randy
