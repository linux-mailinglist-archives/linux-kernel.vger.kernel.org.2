Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212A43B7397
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhF2OBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:01:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33264 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233329AbhF2OBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=GE7y013gv+UJQ2wwu8UtEPjl7ZCtbs5UT/PDFigCAxs=; b=4gilTUTJK1UASaINjjFSWPJ23w
        WX+1ETjlJyIlT6bFeHKNzSMK/69EPcZWgSK4XQMC0q3OjknIqq3OBz4TM81sumIo78jQV6xzBgDYO
        hqUfxsMcK/FjmwBvk1Cv7cGObdvr9UfMH+lq+A95S+wrzNOhq/27GYf21uhn9uBzmLo4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lyEFr-00BXyW-Jn; Tue, 29 Jun 2021 15:58:23 +0200
Date:   Tue, 29 Jun 2021 15:58:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     robh+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH 1/3] include: dt-bindings: Add mscc-vsc8531 RGMII clock
 delay definitions
Message-ID: <YNsm/0dmpBgO8mqr@lunn.ch>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-2-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629094038.18610-2-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 03:10:36PM +0530, Harini Katakam wrote:
> Add RGMII clock delay definitions in mscc-phy-vsc8531 header.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  include/dt-bindings/net/mscc-phy-vsc8531.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
> index 9eb2ec2b2ea9..242eb4c7ede9 100644
> --- a/include/dt-bindings/net/mscc-phy-vsc8531.h
> +++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
> @@ -28,4 +28,13 @@
>  #define VSC8531_FORCE_LED_OFF           14
>  #define VSC8531_FORCE_LED_ON            15
>  
> +#define VSC8531_RGMII_CLK_DELAY_0_2_NS	0
> +#define VSC8531_RGMII_CLK_DELAY_0_8_NS	1
> +#define VSC8531_RGMII_CLK_DELAY_1_1_NS	2
> +#define VSC8531_RGMII_CLK_DELAY_1_7_NS	3
> +#define VSC8531_RGMII_CLK_DELAY_2_0_NS	4
> +#define VSC8531_RGMII_CLK_DELAY_2_3_NS	5
> +#define VSC8531_RGMII_CLK_DELAY_2_6_NS	6
> +#define VSC8531_RGMII_CLK_DELAY_3_4_NS	7

Using defines like this is no longer used. Please specify the delay in
pS and convert to a register value within the driver.

   Andrew
