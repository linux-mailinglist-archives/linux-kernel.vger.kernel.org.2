Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2063C91C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhGNUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:07:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43942 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242214AbhGNUAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:00:21 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m3l0X-0007dL-3M; Wed, 14 Jul 2021 21:57:25 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     cl@rock-chips.com, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH v1 2/3] dt-binding: mfd: syscon: add rk3568 QoS register compatible
Date:   Wed, 14 Jul 2021 21:57:24 +0200
Message-ID: <5440081.dumfJixkPq@diego>
In-Reply-To: <20210624114719.1685-3-cl@rock-chips.com>
References: <20210624114719.1685-1-cl@rock-chips.com> <20210624114719.1685-3-cl@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Juni 2021, 13:47:18 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> Document rk3568 compatible for QoS registers.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

@Lee: I guess this one is yours :-)


> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index f14ae6da0068..206f73ffc249 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -48,6 +48,7 @@ properties:
>                - rockchip,rk3066-qos
>                - rockchip,rk3288-qos
>                - rockchip,rk3399-qos
> +              - rockchip,rk3568-qos
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> 




