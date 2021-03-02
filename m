Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CF32A7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839686AbhCBQhs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 11:37:48 -0500
Received: from aposti.net ([89.234.176.197]:60046 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448163AbhCBORc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:17:32 -0500
Date:   Tue, 02 Mar 2021 14:16:26 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] ASoC: codec: Omit superfluous error message in 
 jz4760_codec_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Message-Id: <EBICPQ.45RCN3X3PJUR1@crapouillou.net>
In-Reply-To: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
References: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 2 mars 2021 à 21:56, Tang Bin <tangbin@cmss.chinamobile.com> a 
écrit :
> The function devm_platform_ioremap_resource has already contained
> error message, so remove the redundant dev_err here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!

Cheers,
-Paul

> ---
> Changes from v1
>  - to streamline the code.
> ---
>  sound/soc/codecs/jz4760.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
> index e8f28ccc145a..5ae0e312bcfc 100644
> --- a/sound/soc/codecs/jz4760.c
> +++ b/sound/soc/codecs/jz4760.c
> @@ -841,11 +841,8 @@ static int jz4760_codec_probe(struct 
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
>  					&jz4760_codec_regmap_config);
> --
> 2.18.2
> 
> 
> 


