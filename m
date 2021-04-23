Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708DE369294
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhDWNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDWNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:01:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDCC061574;
        Fri, 23 Apr 2021 06:00:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1792A1F43BBD
Subject: Re: [PATCH] arm64: dts: mt8183: add mediatek,gce-events in mutex
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210423065327.1596075-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <846d2a7a-d9c2-7d9e-9d7e-843ff604be44@collabora.com>
Date:   Fri, 23 Apr 2021 15:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423065327.1596075-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

On 23/4/21 8:53, Hsin-Yi Wang wrote:
> mediatek,gce-events is read by mutex node.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Although I know this property is used and needed I didn't find documentation
about it. It would be really nice document in the bindings this mediatek property.

In any case this patch LGTM, so

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a..cf22d71161e5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1250,6 +1250,8 @@ mutex: mutex@14016000 {
>  			reg = <0 0x14016000 0 0x1000>;
>  			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
> +					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
>  		};
>  
>  		larb0: larb@14017000 {
> 
