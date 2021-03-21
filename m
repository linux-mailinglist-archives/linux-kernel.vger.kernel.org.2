Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8C343443
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhCUTCl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 Mar 2021 15:02:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43256 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhCUTCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:02:19 -0400
Received: from p508fc3a3.dip0.t-ipconnect.de ([80.143.195.163] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lO3Kr-000710-FT; Sun, 21 Mar 2021 20:02:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Jonker <jbx6244@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Sun, 21 Mar 2021 20:02:00 +0100
Message-ID: <1851600.PYKUYFuaPT@phil>
In-Reply-To: <20210319051627.814-1-cnsztl@gmail.com>
References: <20210319051627.814-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 19. März 2021, 06:16:26 CET schrieb Tianling Shen:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S.
> 
> Changes in v6:
> - Fixed format of LED nodes
> 
> Changes in v5:
> - Dropped the empty PCIe node
> - Dropped useless `/delete-property/`
> - Renamed LED nodes
> 
> Changes in v4:
> - Correctly dropped `display-subsystem` node
> - Dropped meaningless `pwm-fan` node
> - Dropped wrong `sdmmc` node
> - Disabled `i2c4` and `uart0` as they don't exist in the design
> - Format fixes
> 
> Changes in v3:
> - Dropped non-existent node `display_subsystem`
> 
> Changes in v2:
> - Disable display for NanoPi R4S (reference commit: 74532de460ec)
> - Light "sys" LED on NanoPi R4S (reference commit: 833821eeab91)
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

In v4 you received a
Acked-by: Rob Herring <robh@kernel.org>

Please pick these up and carry them over into new versions
of your patchset. Otherwise Rob would needlessly review
things multiple times.


Heiko

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index c3036f95c7bc..4a6f772c1043 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -134,6 +134,7 @@ properties:
>                - friendlyarm,nanopi-m4
>                - friendlyarm,nanopi-m4b
>                - friendlyarm,nanopi-neo4
> +              - friendlyarm,nanopi-r4s
>            - const: rockchip,rk3399
>  
>        - description: GeekBuying GeekBox
> 




