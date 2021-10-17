Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AC430C62
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhJQVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:48:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54190 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344648AbhJQVsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:48:13 -0400
Received: from p508fd4f7.dip0.t-ipconnect.de ([80.143.212.247] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mcDyg-0004up-B7; Sun, 17 Oct 2021 23:45:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, kishon@ti.com, vkoul@kernel.org
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip: remove usb-phy fallback string for rk3066a/rk3188
Date:   Sun, 17 Oct 2021 23:45:57 +0200
Message-ID: <2801784.XqmsWqfj7A@phil>
In-Reply-To: <20210828111218.10026-1-jbx6244@gmail.com>
References: <20210828111218.10026-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod, Kishon,

Am Samstag, 28. August 2021, 13:12:17 CEST schrieb Johan Jonker:
> With the conversion of rockchip-usb-phy.yaml a long time used fallback
> string for rk3066a/rk3188 was added. The linux driver doesn't do much with
> the GRF phy address range, however the u-boot driver rockchip_usb2_phy.c
> does. The bits in GRF_UOC0_CON2 for rk3066a/rk3188 and rk3288 for example
> don't match. Remove the usb-phy fallback string for rk3066a/rk3188
> to prevent possible strange side effects.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

are you picking up this patch or can I get an Ack to just apply it
together with the dts patch2?

Thanks
Heiko

> ---
>  .../devicetree/bindings/phy/rockchip-usb-phy.yaml     | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> index f0fc8275d..499d55131 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
> @@ -11,13 +11,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    oneOf:
> -      - const: rockchip,rk3288-usb-phy
> -      - items:
> -          - enum:
> -              - rockchip,rk3066a-usb-phy
> -              - rockchip,rk3188-usb-phy
> -          - const: rockchip,rk3288-usb-phy
> +    enum:
> +      - rockchip,rk3066a-usb-phy
> +      - rockchip,rk3188-usb-phy
> +      - rockchip,rk3288-usb-phy
>  
>    "#address-cells":
>      const: 1
> 




