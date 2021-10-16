Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D665430386
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhJPPtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:49:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45776 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhJPPtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:49:53 -0400
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mbluM-0007VR-HD; Sat, 16 Oct 2021 17:47:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,cru property
Date:   Sat, 16 Oct 2021 17:47:37 +0200
Message-ID: <2915547.VsDhchvPPW@phil>
In-Reply-To: <20211016105354.116513-3-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com> <20211016105354.116513-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Oktober 2021, 12:53:51 CEST schrieb Nicolas Frattaroli:
> This property was only needed for a driver hack, which we can
> remove. Since the bindings were not in any kernel release yet, we
> are able to just drop the property instead of silently accepting
> and ignoring it.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for doing that change :-)
Heiko


> ---
>  .../bindings/sound/rockchip,i2s-tdm.yaml         | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> index ce3e18b50230..6a7c004bef17 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> @@ -82,12 +82,6 @@ properties:
>          - tx-m
>          - rx-m
>  
> -  rockchip,cru:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description:
> -      The phandle of the cru.
> -      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
> -
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -144,15 +138,6 @@ required:
>    - rockchip,grf
>    - "#sound-dai-cells"
>  
> -allOf:
> -  - if:
> -      properties:
> -        rockchip,trcm-sync-tx-only: false
> -        rockchip,trcm-sync-rx-only: false
> -    then:
> -      required:
> -        - rockchip,cru
> -
>  additionalProperties: false
>  
>  examples:
> @@ -177,7 +162,6 @@ examples:
>              resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
>              reset-names = "tx-m", "rx-m";
>              rockchip,trcm-sync-tx-only;
> -            rockchip,cru = <&cru>;
>              rockchip,grf = <&grf>;
>              #sound-dai-cells = <0>;
>              pinctrl-names = "default";
> 




