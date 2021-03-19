Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE443417F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhCSJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:07:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCSJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:07:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4E55E1F465F9
Subject: Re: [PATCH v4 2/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-juniper
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
 <20210319035245.2751911-2-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8b444ea2-0052-23e8-ea52-de07c1a2907d@collabora.com>
Date:   Fri, 19 Mar 2021 10:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319035245.2751911-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

On 19/3/21 4:52, Hsin-Yi Wang wrote:
> mt8183-kukui-jacuzzi-juniper board also known as Acer Chromebook Spin 311,
> using mediatek mt8183 SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index a86716cdd408..edee2c3f8620 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -129,6 +129,11 @@ properties:
>          items:
>            - const: google,damu
>            - const: mediatek,mt8183
> +      - description: Google Juniper (Acer Chromebook Spin 311)
> +        items:
> +          - const: google,juniper-sku16
> +          - const: google,juniper
> +          - const: mediatek,mt8183
>  
>  additionalProperties: true
>  
> 
