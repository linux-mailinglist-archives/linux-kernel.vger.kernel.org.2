Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD83805F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhENJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:15:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhENJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:15:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 843B41F43112
Subject: Re: [PATCH v2] arm64: dts: mt8183: Add power-domains properity to
 mfgcfg
To:     Ikjoon Jang <ikjn@chromium.org>, linux-mediatek@lists.infradead.org
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210414073108.3899082-1-ikjn@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d10d1edc-f79e-7fa4-93ca-e896d3ea6cba@collabora.com>
Date:   Fri, 14 May 2021 11:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210414073108.3899082-1-ikjn@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ikjoon,

Thank you for your patch.

On 14/4/21 9:31, Ikjoon Jang wrote:
> mfgcfg clock is under MFG_ASYNC power domain
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> 
> Changes in v2:
> Fix a wrong power domain reference (scpsys to spm).
> 
> Link(v1): https://patchwork.kernel.org/project/linux-mediatek/patch/20210224091742.1060508-1-ikjn@chromium.org/#23997681
> 
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 0ff7b67a6806..64813634c3df 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1116,6 +1116,7 @@ mfgcfg: syscon@13000000 {
>  			compatible = "mediatek,mt8183-mfgcfg", "syscon";
>  			reg = <0 0x13000000 0 0x1000>;
>  			#clock-cells = <1>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
>  		};
>  
>  		mmsys: syscon@14000000 {
> 
