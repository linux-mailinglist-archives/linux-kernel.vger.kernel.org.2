Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2B3302C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCGPyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Mar 2021 10:54:02 -0500
Received: from aposti.net ([89.234.176.197]:34004 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhCGPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:53:22 -0500
Date:   Sun, 07 Mar 2021 15:53:04 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: codecs/jz4770: Remove superfluous error message
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Message-Id: <G4WLPQ.USQXU1D7YOL61@crapouillou.net>
In-Reply-To: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
References: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 7 mars 2021 à 15:21, Tang Bin <tangbin@cmss.chinamobile.com> a 
écrit :
> The function devm_platform_ioremap_resource has already contained
> error message if failed, so remove superfluous dev_err here.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Looks good.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/codecs/jz4770.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
> index 298689a07..5a24471a5 100644
> --- a/sound/soc/codecs/jz4770.c
> +++ b/sound/soc/codecs/jz4770.c
> @@ -900,11 +900,8 @@ static int jz4770_codec_probe(struct 
> platform_device *pdev)
>  	codec->dev = dev;
> 
>  	codec->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(codec->base)) {
> -		ret = PTR_ERR(codec->base);
> -		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(codec->base))
> +		return PTR_ERR(codec->base);
> 
>  	codec->regmap = devm_regmap_init(dev, NULL, codec,
>  					&jz4770_codec_regmap_config);
> --
> 2.20.1.windows.1
> 
> 
> 


