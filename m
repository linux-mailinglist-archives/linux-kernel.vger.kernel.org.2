Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F60403627
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbhIHIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348328AbhIHIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:34:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C39C061575;
        Wed,  8 Sep 2021 01:33:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 34E781F43198
Subject: Re: [PATCH v10 01/17] dt-bindings: arm: mediatek: mmsys: add power
 and gce properties
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20210908060312.24007-1-jason-jh.lin@mediatek.com>
 <20210908060312.24007-2-jason-jh.lin@mediatek.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8de99666-f9be-320d-96c0-b9e140d3d4b4@collabora.com>
Date:   Wed, 8 Sep 2021 10:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210908060312.24007-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thank you for your patch. One small comment below.

On 8/9/21 8:02, jason-jh.lin wrote:
> Power:
> 1. Add description for power-domains property.
> 
> GCE:
> 1. Add description for mboxes property.
> 2. Add description for mediatek,gce-client-reg property.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 2d4ff0ce387b..a2e7bddfed03 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -39,6 +39,30 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.
> +
> +  mboxes:
> +    description:
> +      Using mailbox to communicate with GCE, it should have this
> +      property and list of phandle, mailbox specifiers. See
> +      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 arguments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function blocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +
>    "#clock-cells":
>      const: 1
>  
> @@ -53,6 +77,10 @@ examples:
>    - |
>      mmsys: syscon@14000000 {
>          compatible = "mediatek,mt8173-mmsys", "syscon";
> -        reg = <0x14000000 0x1000>;
> +        reg = <0 0x14000000 0 0x1000>;

Why this change?

Thanks,
  Enric


> +        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>          #clock-cells = <1>;
> +        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>      };
> 
