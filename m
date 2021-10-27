Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6243BFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhJ0CaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:30:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:32858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230243AbhJ0CaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:30:16 -0400
X-UUID: f2817962a0034ec18e81db4f9785dd8d-20211027
X-UUID: f2817962a0034ec18e81db4f9785dd8d-20211027
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 173063964; Wed, 27 Oct 2021 10:27:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Oct 2021 10:27:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Oct 2021 10:27:45 +0800
Message-ID: <9e36d2353aadb293ee277329eed84c4015bc0277.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mfd: change naming of mediatek rpmsg
 property
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Benson Leung" <bleung@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>, <devicetree@vger.kernel.org>
Date:   Wed, 27 Oct 2021 10:27:45 +0800
In-Reply-To: <1634578358.531021.2612842.nullmailer@robh.at.kernel.org>
References: <20211018115111.14096-1-tinghan.shen@mediatek.com>
         <1634578358.531021.2612842.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-18 at 12:32 -0500, Rob Herring wrote:
> On Mon, 18 Oct 2021 19:51:11 +0800, Tinghan Shen wrote:
> > Change from "mtk,rpmsg-name" to "mediatek,rpmsg-name" to sync with
> > the
> > vendor name defined in vendor-prefixes.yaml.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for
> dtbs_check.
> This will change in the future.
> 
> Full log is available here: 
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1542563__;!!CTRNKA9wMg0ARbw!yQGrJgf_q0cFKm4GiKGqWF4eFuMbBE3w_p4r9ipndPFZMOYDBfs0oAwGpZa6mKdIggI$
>  
> 
> 
> cros_ec: 'mtk,rpmsg-name' does not match any of the regexes:
> '^extcon[0-9]*$', '^i2c-tunnel[0-9]*$', '^regulator@[0-9]+$',
> 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> burnet.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> fennel14.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku6.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> 

Hi Rob,

Thanks for your reviewing. I'm sorry that forget to mention the
dependency of this patch.

This patch is introduced because of this change,

https://lore.kernel.org/all/20210924033935.2127-7-tinghan.shen@mediatek.com/

I will resend this patch to mention the dependency.

Best regards,
TingHan


