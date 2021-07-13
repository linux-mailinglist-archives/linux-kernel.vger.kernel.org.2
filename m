Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314893C6E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGMK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:26:27 -0400
Received: from foss.arm.com ([217.140.110.172]:40110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhGMK00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:26:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C666D;
        Tue, 13 Jul 2021 03:23:36 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898223F7D8;
        Tue, 13 Jul 2021 03:23:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: display: rockchip: Add compatible for
 rk3568 HDMI
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
 <20210707120323.401785-2-benjamin.gaignard@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <da42fa57-6763-b57d-fc5a-82f14ce7b8e3@arm.com>
Date:   Tue, 13 Jul 2021 11:23:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707120323.401785-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-07 13:03, Benjamin Gaignard wrote:
> Define a new compatible for rk3568 HDMI.
> This version of HDMI hardware block needs two new clocks hclk_vio and hclk
> to provide phy reference clocks.

Do you know what hclk_vio is and whether it's actually necessary? I 
don't see any mention of it downstream, and based on previous experience 
I'm suspicious that it might be just the parent of hclk, and thus should 
not need to be explicitly claimed by the device or baked into it's binding.

Robin.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Add the clocks needed for the phy.
> 
>   .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> index 75cd9c686e985..cb8643b3a8b84 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> @@ -23,6 +23,7 @@ properties:
>         - rockchip,rk3288-dw-hdmi
>         - rockchip,rk3328-dw-hdmi
>         - rockchip,rk3399-dw-hdmi
> +      - rockchip,rk3568-dw-hdmi
>   
>     reg-io-width:
>       const: 4
> @@ -51,8 +52,11 @@ properties:
>             - vpll
>         - enum:
>             - grf
> +          - hclk_vio
> +          - vpll
> +      - enum:
> +          - hclk
>             - vpll
> -      - const: vpll
>   
>     ddc-i2c-bus:
>       $ref: /schemas/types.yaml#/definitions/phandle
> 
