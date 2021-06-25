Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DD3B3FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhFYJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:00:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54072 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:00:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 625721F44485
Subject: Re: [RESEND PATCH v2 2/4] dt-bindings: power: Add MT8195 power
 domains
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210616000659.28347-1-chun-jie.chen@mediatek.com>
 <20210616000659.28347-3-chun-jie.chen@mediatek.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d55142b4-082b-7fbc-dc9a-3dd2d1fca645@collabora.com>
Date:   Fri, 25 Jun 2021 10:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616000659.28347-3-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie Chen,

Thank you for your patch.

On 16/6/21 2:06, Chun-Jie Chen wrote:
> Add power domains dt-bindings for MT8195.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  .../power/mediatek,power-controller.yaml      |  2 +
>  include/dt-bindings/power/mt8195-power.h      | 51 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8195-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index f234a756c193..d6ebd77d28a7 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -27,6 +27,7 @@ properties:
>        - mediatek,mt8173-power-controller
>        - mediatek,mt8183-power-controller
>        - mediatek,mt8192-power-controller
> +      - mediatek,mt8195-power-controller
>  
>    '#power-domain-cells':
>      const: 1
> @@ -64,6 +65,7 @@ patternProperties:
>                "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> +              "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
>          maxItems: 1
>  
>        clocks:
> diff --git a/include/dt-bindings/power/mt8195-power.h b/include/dt-bindings/power/mt8195-power.h
> new file mode 100644
> index 000000000000..43fd36e1f538
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8195-power.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8195_POWER_H
> +#define _DT_BINDINGS_POWER_MT8195_POWER_H
> +
> +#define MT8195_POWER_DOMAIN_PCIE_MAC_P0		0
> +#define MT8195_POWER_DOMAIN_PCIE_MAC_P1		1
> +#define MT8195_POWER_DOMAIN_PCIE_PHY		2
> +#define MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY	3
> +#define MT8195_POWER_DOMAIN_CSI_RX_TOP		4
> +#define MT8195_POWER_DOMAIN_ETHER		5
> +#define MT8195_POWER_DOMAIN_ADSP		6
> +#define MT8195_POWER_DOMAIN_AUDIO		7
> +#define MT8195_POWER_DOMAIN_AUDIO_ASRC		8
> +#define MT8195_POWER_DOMAIN_NNA			9
> +#define MT8195_POWER_DOMAIN_NNA0		10
> +#define MT8195_POWER_DOMAIN_NNA1		11
> +#define MT8195_POWER_DOMAIN_MFG0		12
> +#define MT8195_POWER_DOMAIN_MFG1		13
> +#define MT8195_POWER_DOMAIN_MFG2		14
> +#define MT8195_POWER_DOMAIN_MFG3		15
> +#define MT8195_POWER_DOMAIN_MFG4		16
> +#define MT8195_POWER_DOMAIN_MFG5		17
> +#define MT8195_POWER_DOMAIN_MFG6		18
> +#define MT8195_POWER_DOMAIN_VPPSYS0		19
> +#define MT8195_POWER_DOMAIN_VDOSYS0		20
> +#define MT8195_POWER_DOMAIN_VPPSYS1		21
> +#define MT8195_POWER_DOMAIN_VDOSYS1		22
> +#define MT8195_POWER_DOMAIN_DP_TX		23
> +#define MT8195_POWER_DOMAIN_EPD_TX		24
> +#define MT8195_POWER_DOMAIN_HDMI_TX		25
> +#define MT8195_POWER_DOMAIN_HDMI_RX		26
> +#define MT8195_POWER_DOMAIN_WPESYS		27
> +#define MT8195_POWER_DOMAIN_VDEC0		28
> +#define MT8195_POWER_DOMAIN_VDEC1		29
> +#define MT8195_POWER_DOMAIN_VDEC2		30
> +#define MT8195_POWER_DOMAIN_VENC		31
> +#define MT8195_POWER_DOMAIN_VENC_CORE1		32
> +#define MT8195_POWER_DOMAIN_IMG			33
> +#define MT8195_POWER_DOMAIN_DIP			34
> +#define MT8195_POWER_DOMAIN_IPE			35
> +#define MT8195_POWER_DOMAIN_CAM			36
> +#define MT8195_POWER_DOMAIN_CAM_RAWA		37
> +#define MT8195_POWER_DOMAIN_CAM_RAWB		38
> +#define MT8195_POWER_DOMAIN_CAM_MRAW		39
> +
> +#endif /* _DT_BINDINGS_POWER_MT8195_POWER_H */
> 
