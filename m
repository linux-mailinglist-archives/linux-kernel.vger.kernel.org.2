Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88783B73C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhF2OJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:09:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33306 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhF2OJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=w0aRX+AVNRJPjlDg5QC6T0rQR3HiSguZvmev3Zp5piE=; b=WXGZ0/uFyApzN9diblYk6h+6Yv
        JfykksEXxmGiyInS8Vhtw/9UhuzqGFhMHQsznmeAnoEP8tQJ+VWr2rEmxuUGxwgLZypG+F+XQf15/
        5n8DnKvqothU3Lu+xHIEM41BYl9oBF5tnk5VN5kn+4oDeYpVQorcAQwYBHogf0yRCi1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lyEOJ-00BY2O-34; Tue, 29 Jun 2021 16:07:07 +0200
Date:   Tue, 29 Jun 2021 16:07:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     robh+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH 2/3] dt-bindings: mscc: Add RGMII RX and TX delay tuning
Message-ID: <YNspC065DnVpzADe@lunn.ch>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-3-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629094038.18610-3-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 03:10:37PM +0530, Harini Katakam wrote:
> Add optional properties to tune RGMII RX and TX delay.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../devicetree/bindings/net/mscc-phy-vsc8531.txt         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 87a27d775d48..e201d24d8e27 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -33,7 +33,14 @@ Optional properties:
>  			  VSC8531_DUPLEX_COLLISION (8).
>  - load-save-gpios	: GPIO used for the load/save operation of the PTP
>  			  hardware clock (PHC).
> -
> +- vsc8531,rx-delay	: RGMII RX delay. Allowed values are defined in
> +			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
> +			  Default value, set by the driver is
> +			  VSC8531_RGMII_CLK_DELAY_2_0_NS.
> +- vsc8531,tx-delay	: RGMII TX delay. Allowed values are defined in
> +			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
> +			  Default value, set by the driver is
> +			  VSC8531_RGMII_CLK_DELAY_2_0_NS.

The default values need better explanation. So you are saying they are
only used when 'rgmii' is not used. And they replace the default 2ns
delay, they don't add to the default 2ns delay.

       Andrew
