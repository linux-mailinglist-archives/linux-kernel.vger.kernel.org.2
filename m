Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CB3FC0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhHaC6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhHaC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:58:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6bWlZrjczUiP7EZOqide7LZDeaMc6AyGD2CmjTuWKWY=; b=vGqMtn6YJ7xkPoqIo6XDG75UYF
        jNnCxOkBlk3zRUx9esaU2FbGYJ4iMvQphHkgoNIFMohCar2nZ51uO8LLDS0IPR3e+je1m5k7hc2Z/
        xzkVmLblKIX5gv0KG8FazKFvNz9SE8FOKAovUv2gzVhr29CEJG08LAZ0F7zK/CZwYrOwFNy0Wa7C3
        Go8Pbcjs4iM2x4qE9FFesTuLkMlx1L9nlEroO7GN6N0gddid0OEe3CmBh6U737C/qWZNLDGCN61Lc
        QyJY6TvkusHCYgeTnw1eEsg/fgDsIESb6bOo3SqsFABhehond4c2IgDhEqpxZFyfwo+ykQq7kOHge
        6CAua5Dg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKtyC-0011vi-EV; Tue, 31 Aug 2021 02:57:52 +0000
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add MTK_PMIC_WRAP dependency
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210831021303.5230-1-trevor.wu@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1630c5bd-7f9a-ef63-0476-74c6077adb7f@infradead.org>
Date:   Mon, 30 Aug 2021 19:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831021303.5230-1-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 7:13 PM, Trevor Wu wrote:
> randconfig builds show the warning below,
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MT6359
>     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
>     Selected by [y]:
>     - SND_SOC_MT8195_MT6359_RT1019_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8195 [=y]
> 
> Add a dependency to avoid it.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
>   sound/soc/mediatek/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index cf567a89f421..f6bf0f9c91e3 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -197,7 +197,7 @@ config SND_SOC_MT8195
>   config SND_SOC_MT8195_MT6359_RT1019_RT5682
>   	tristate "ASoC Audio driver for MT8195 with MT6359 RT1019 RT5682 codec"
>   	depends on I2C
> -	depends on SND_SOC_MT8195
> +	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
>   	select SND_SOC_MT6359
>   	select SND_SOC_RT1015P
>   	select SND_SOC_RT5682_I2C
> 


-- 
~Randy

