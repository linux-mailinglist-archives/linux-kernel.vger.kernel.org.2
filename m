Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB440BDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhIODI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:08:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33224 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229758AbhIODI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:08:26 -0400
X-UUID: b270f9c4b47d466ab45eaf3a6575f242-20210915
X-UUID: b270f9c4b47d466ab45eaf3a6575f242-20210915
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 578152907; Wed, 15 Sep 2021 11:07:04 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Sep 2021 11:07:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Sep
 2021 11:07:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 11:07:02 +0800
Message-ID: <7a1af556bf3b7dda9f1be848d2631448a1155ec6.camel@mediatek.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Add missing of_node_put()
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Bixuan Cui <cuibixuan@huawei.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>
Date:   Wed, 15 Sep 2021 11:07:02 +0800
In-Reply-To: <20210911081246.33867-1-cuibixuan@huawei.com>
References: <20210911081246.33867-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bixuan,

Thanks for catching that.
I found there are other usages of of_parse_phandle() in the file.
Will you handle them together?
If not, I will prepare a patch to fix them after this patch is merged.

Thanks,
Trevor

On Sat, 2021-09-11 at 16:12 +0800, Bixuan Cui wrote:
> The platform_node is returned by of_parse_phandle() should have
> of_node_put() before return.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> index c97ace7387b4..8cd8450409e8 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> @@ -1041,8 +1041,10 @@ static int
> mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	if (!priv) {
> +		of_node_put(platform_node);
>  		return -ENOMEM;
> +	}
>  
>  	snd_soc_card_set_drvdata(card, priv);
>  
> @@ -1050,6 +1052,8 @@ static int
> mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
>  	if (ret)
>  		dev_err(&pdev->dev, "%s snd_soc_register_card fail
> %d\n",
>  			__func__, ret);
> +
> +	of_node_put(platform_node);
>  	return ret;
>  }
>  

