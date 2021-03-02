Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD26032A5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447660AbhCBNmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 08:42:18 -0500
Received: from aposti.net ([89.234.176.197]:46128 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbhCBMY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:24:28 -0500
Date:   Tue, 02 Mar 2021 12:23:08 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: codec: Omit superfluous error message in
 jz4760_codec_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Message-Id: <K2DCPQ.25EEALUNZ4K3@crapouillou.net>
In-Reply-To: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
References: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tang,

Le mar. 2 mars 2021 à 20:11, Tang Bin <tangbin@cmss.chinamobile.com> a 
écrit :
> The function devm_platform_ioremap_resource has already contained 
> error
> message, so remove the redundant dev_err here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/codecs/jz4760.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
> index e8f28ccc145a..c2d8a107f159 100644
> --- a/sound/soc/codecs/jz4760.c
> +++ b/sound/soc/codecs/jz4760.c
> @@ -843,7 +843,6 @@ static int jz4760_codec_probe(struct 
> platform_device *pdev)
>  	codec->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(codec->base)) {
>  		ret = PTR_ERR(codec->base);
> -		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
>  		return ret;
>  	}

Indeed, you are right.

I guess you do this instead:

if (IS_ERR(codec->base))
    return PTR_ERR(codec->base);

Cheers,
-Paul



