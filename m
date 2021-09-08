Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19DF403457
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhIHGk7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Sep 2021 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345901AbhIHGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:40:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:39:49 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mNrF7-000821-T7; Wed, 08 Sep 2021 08:39:33 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mNrF3-00031K-86; Wed, 08 Sep 2021 08:39:29 +0200
Message-ID: <5ffef736524f3d7fb69f97332576ee9913032bcd.camel@pengutronix.de>
Subject: Re: [PATCH v10 07/17] dt-bindings: display: mediatek: merge: add
 additional prop for mt8195
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
Date:   Wed, 08 Sep 2021 08:39:29 +0200
In-Reply-To: <20210908060312.24007-8-jason-jh.lin@mediatek.com>
References: <20210908060312.24007-1-jason-jh.lin@mediatek.com>
         <20210908060312.24007-8-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 2021-09-08 at 14:03 +0800, jason-jh.lin wrote:
> add MERGE additional properties description for mt8195:
> 1. async clock
> 2. fifo setting enable
> 3. reset controller
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../display/mediatek/mediatek,merge.yaml      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> index 75beeb207ceb..0fe204d9ad2c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> @@ -38,6 +38,19 @@ properties:
>    clocks:
>      items:
>        - description: MERGE Clock
> +      - description: MERGE Async Clock
> +          Controlling the synchronous process between MERGE and other display
> +          function blocks cross clock domain.
> +
> +  mediatek,merge-fifo-en:
> +    description:
> +      The setting of merge fifo is mainly provided for the display latency
> +      buffer to ensure that the back-end panel display data will not be
> +      underrun, a little more data is needed in the fifo.
> +      According to the merge fifo settings, when the water level is detected
> +      to be insufficient, it will trigger RDMA sending ultra and preulra
> +      command to SMI to speed up the data rate.
> +    type: boolean
>  
>    mediatek,gce-client-reg:
>      description:
> @@ -50,6 +63,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>  
> +  resets:
> +    description: reset controller
> +      See Documentation/devicetree/bindings/reset/reset.txt for details.

From the example this looks like it could have a maxItems: 1.

> +
>  required:
>    - compatible
>    - reg

Should the resets property be required for "mediatek,mt8195-disp-merge"?

> @@ -67,3 +84,16 @@ examples:
>          power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>          clocks = <&mmsys CLK_MM_DISP_MERGE>;
>      };
> +
> +    merge5: disp_vpp_merge5@1c110000 {
> +        compatible = "mediatek,mt8195-disp-merge";
> +        reg = <0 0x1c110000 0 0x1000>;
> +        interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&vdosys1 CLK_VDO1_VPP_MERGE4>,
> +                 <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
> +        clock-names = "merge","merge_async";
> +        power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +        mediatek,gce-client-reg = <&gce1 SUBSYS_1c11XXXX 0x0000 0x1000>;
> +        mediatek,merge-fifo-en = <1>;
> +        resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC>;
> +    };

regards
Philipp
