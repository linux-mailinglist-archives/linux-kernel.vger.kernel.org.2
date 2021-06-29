Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412AF3B7401
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhF2OOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:14:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33390 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhF2OOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7ObJSRSuHN+MA7ZvW6xKZmT6lRaUAOxEM0Gf6yOQ90U=; b=GKS5AYdhZsSVl6B8uK2VN7XjBk
        IFP2ierQijzZQBk/uevyncHpdW3dwKWyUpja9d9ufybUF/0wh07BTrIrzF+/U6u8pXSP3GrIVEMp/
        5+CewPy5GSS9q9/Qv+gPKtywQ132SipwUlzSFIgQLgjgS34h+aoWl9fjiRURbqT1R7Kk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lyESm-00BY9x-Jo; Tue, 29 Jun 2021 16:11:44 +0200
Date:   Tue, 29 Jun 2021 16:11:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     robh+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH 3/3] phy: mscc: Add support for VSC8531_02 with RGMII
 tuning
Message-ID: <YNsqIIUZbA+JTl0a@lunn.ch>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-4-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629094038.18610-4-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -535,15 +535,16 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
>  	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
>  	u16 reg_val = 0;
>  	int rc;
> +	struct vsc8531_private *vsc8531 = phydev->priv;
  
reverse christmass tree.


>  	mutex_lock(&phydev->lock);
>  
>  	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID ||
>  	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
> -		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_rx_delay_pos;
> +		reg_val |= vsc8531->rx_delay << rgmii_rx_delay_pos;
>  	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
>  	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
> -		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_tx_delay_pos;
> +		reg_val |= vsc8531->tx_delay << rgmii_tx_delay_pos;
>  
>  	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
>  			      rgmii_cntl,
> @@ -1820,6 +1821,17 @@ static int vsc85xx_config_init(struct phy_device *phydev)
>  {
>  	int rc, i, phy_id;
>  	struct vsc8531_private *vsc8531 = phydev->priv;
> +	struct device_node *of_node = phydev->mdio.dev.of_node;
> +
> +	rc = of_property_read_u32(of_node, "vsc8531,rx-delay",
> +				  &vsc8531->rx_delay);
> +	if (rc < 0)
> +		vsc8531->rx_delay = RGMII_CLK_DELAY_2_0_NS;

of_property_read_u32() is guaranteed not to touch the result value, if
it is not in device tree. So you can simplify this to:

	vsc8531->rx_delay = RGMII_CLK_DELAY_2_0_NS;
	of_property_read_u32(of_node, "vsc8531,rx-delay", &vsc8531->rx_delay);

