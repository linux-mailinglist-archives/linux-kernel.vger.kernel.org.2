Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964494024D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbhIGIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:01:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39262 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231366AbhIGIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:01:48 -0400
X-UUID: 289a8e123b5d49daab79ec2ce6a8031d-20210907
X-UUID: 289a8e123b5d49daab79ec2ce6a8031d-20210907
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 312245765; Tue, 07 Sep 2021 16:00:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Sep 2021 16:00:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Sep
 2021 16:00:37 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Sep 2021 16:00:37 +0800
Message-ID: <27ca1a1e99193b543102df03f7c256063468f693.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Fix unused initialization of
 pointer etdm_data
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 7 Sep 2021 16:00:37 +0800
In-Reply-To: <20210903114928.11743-1-colin.king@canonical.com>
References: <20210903114928.11743-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 12:49 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer etdm_data is being inintialized with a value that is
> never
> read, it is later being re-assigned a new value. Remove the redundant
> initialization.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
> b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
> index 7378e42f2766..ac591d453e1e 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
> @@ -2094,7 +2094,7 @@ static int mtk_dai_etdm_set_sysclk(struct
> snd_soc_dai *dai,
>  {
>  	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
>  	struct mt8195_afe_private *afe_priv = afe->platform_priv;
> -	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai-
> >id];
> +	struct mtk_dai_etdm_priv *etdm_data;
>  	int dai_id;
>  
>  	dev_dbg(dai->dev, "%s id %d freq %u, dir %d\n",

Acked-by: Trevor Wu <trevor.wu@mediatek.com>

Thanks.

