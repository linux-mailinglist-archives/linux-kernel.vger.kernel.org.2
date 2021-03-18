Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85993401F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCRJY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:24:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhCRJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:24:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 55FED1F45907
Subject: Re: [PATCH] arm64: dts: mt8173: fix wrong power-domain phandle of
 pmic
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1616048328-13579-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <49433ae0-0563-8783-f17e-98eaeba09c57@collabora.com>
Date:   Thu, 18 Mar 2021 10:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616048328-13579-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng Yun,

Thank you for the patch.

On 18/3/21 7:18, Chunfeng Yun wrote:
> Due to power domain controller is added, the power domain's
> phanle is also changed from 'scpsys' to 'spm', but forget to
> modify pmic node's
> 
> Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 6dffada2e66b..28aa634c9780 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -294,7 +294,7 @@
>  
>  &pwrap {
>  	/* Only MT8173 E1 needs USB power domain */
> -	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
> +	power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
>  
>  	pmic: mt6397 {
>  		compatible = "mediatek,mt6397";
> 
