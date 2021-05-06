Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1075A375066
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhEFHwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:52:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60528 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhEFHwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:52:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C59E200824;
        Thu,  6 May 2021 09:51:46 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EA73203213;
        Thu,  6 May 2021 09:51:46 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A500202F7;
        Thu,  6 May 2021 09:51:46 +0200 (CEST)
Date:   Thu, 6 May 2021 10:51:46 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/4] dt-bindings: power: Add defines for i.MX8MM
 BLK-CTL power domains
Message-ID: <20210506075146.tucm2ahouzzvi3op@fsr-ub1664-175>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
 <20210506041555.10719-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506041555.10719-2-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-06 12:15:52, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Adding the defines for i.MX8MM BLK-CTL power domains.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
> index fc9c2e16aadc..510e383d1953 100644
> --- a/include/dt-bindings/power/imx8mm-power.h
> +++ b/include/dt-bindings/power/imx8mm-power.h
> @@ -19,4 +19,15 @@
>  #define IMX8MM_POWER_DOMAIN_DISPMIX	10
>  #define IMX8MM_POWER_DOMAIN_MIPI	11
>  
> +#define IMX8MM_BLK_CTL_G2_PD		0
> +#define IMX8MM_BLK_CTL_G1_PD		1
> +#define IMX8MM_BLK_CTL_H1_PD		2
> +#define IMX8MM_BLK_CTL_MAX_PD		3

Put the PD before the G2, like so:

IMX8MM_BLK_CTL_PD_G2

Same for the other ones.

> +
> +#define IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE	0
> +#define IMX8MM_BLK_CTL_DISPMIX_LCDIF		1
> +#define IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI		2
> +#define IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI		3
> +#define IMX8MM_BLK_CTL_DISPMIX_MAX_PD		4
> +
>  #endif
> -- 
> 2.30.0
> 
