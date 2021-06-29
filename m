Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4F3B70DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhF2KoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhF2KoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:44:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C090C061574;
        Tue, 29 Jun 2021 03:41:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so25242097wrs.12;
        Tue, 29 Jun 2021 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Atx/bMQYGRd73n1ITTzWnqXySXI0bjGGZE/sFbrr9go=;
        b=N2qkQhXet97dMBuOsiFNcbisTGZ3Ldq7aVLaYQpA4ph3cqZqStBSEt5qOFp59nwk6t
         xTqTgP5GagDFj9ehg+T5iVW8qnpA/pFHqZcefWXrQetkSTRyQ4BW9/i0wPvi5oJr2FZ5
         T2BI7rwVr/sCAq77QTwD0SlhyTL8dTMOH2t37kXVql6jBX74thc5zgphUftxs+7bYNRs
         Mkp8ed8f5bNZzewA/6ewn7Rm+DHRlKXhqXZnu9ClnJp/zH/S7ObipoXrTw50KDxNRqk7
         uH9767umTI7/gTmhbdOVZK9iVunEThlD7AG1+9hUwGIuLH5imzi8JnPZ2gDuhBSjrMR6
         nOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Atx/bMQYGRd73n1ITTzWnqXySXI0bjGGZE/sFbrr9go=;
        b=PiooNMWPvRTbWmVSNgzgHXLCA4YrjtI5yLmH7DgsI82+vNAHHyWXv4dczNw7psiBpk
         hgAxc7Z8QH2wDj4A3lS/jUlKGtmr208HdQjUKK+UQ7GRtsxUv8wP5s1htvhbuDFFA5Ua
         Xv2BLf0f1AHTdw1mlE/MUPVMhevy+CS/B6KzefTHJHuYtjKcIGjffF7vC8SwGSDV6hPK
         U5zyrxHE9mFAdvbsc3aiBsCYInz2XNMjvYX47qHPyCJt5GdbyBTV7m8DMvLuiN32Avvo
         wH1eKnAsZFsVgU15L5H/x9I1Z3Ka6CC3vAQin1sS6Z5YpneJEzdXDR1fuc3mb65Uq5zW
         MpiQ==
X-Gm-Message-State: AOAM531joUosMb7aC+6j+i3xKoYcJdY+IBAVFEB/9X+d3YcpAi2UlO8a
        CUtcQlVvgY2nyj6YbzNBjsI=
X-Google-Smtp-Source: ABdhPJz5uyTKaLRGlOrYLj+qSU+CwsQk2rsgIDtz7TW4sKf/zJgBeQ8Q6Hjo64iRb6EoQ3JNeqGNEQ==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr33549277wrt.14.1624963295162;
        Tue, 29 Jun 2021 03:41:35 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:3800:c1b9:29e2:4232:d74a? (p200300ea8f293800c1b929e24232d74a.dip0.t-ipconnect.de. [2003:ea:8f29:3800:c1b9:29e2:4232:d74a])
        by smtp.googlemail.com with ESMTPSA id t16sm3492365wrx.89.2021.06.29.03.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 03:41:34 -0700 (PDT)
To:     Harini Katakam <harini.katakam@xilinx.com>, robh+dt@kernel.org,
        andrew@lunn.ch, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com,
        michal.simek@xilinx.com, radhey.shyam.pandey@xilinx.com
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-4-harini.katakam@xilinx.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 3/3] phy: mscc: Add support for VSC8531_02 with RGMII
 tuning
Message-ID: <453afad0-4e4b-f1bf-6ec5-5675d2c9c1b6@gmail.com>
Date:   Tue, 29 Jun 2021 12:41:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629094038.18610-4-harini.katakam@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2021 11:40, Harini Katakam wrote:
> Add support for VSC8531_02 (Rev 2) device.
> Add support for optional RGMII RX and TX delay tuning via devicetree.
> The hierarchy is:
> - Retain the defaul 0.2ns delay when RGMII tuning is not set.
> - Retain the default 2ns delay when RGMII tuning is set and DT delay
> property is NOT specified.
> - Use the DT delay value when RGMII tuning is set and a DT delay
> property is specified.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/net/phy/mscc/mscc.h      |  3 +++
>  drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
> index a50235fdf7d9..5a26eba0ace0 100644
> --- a/drivers/net/phy/mscc/mscc.h
> +++ b/drivers/net/phy/mscc/mscc.h
> @@ -281,6 +281,7 @@ enum rgmii_clock_delay {
>  #define PHY_ID_VSC8514			  0x00070670
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
> +#define PHY_ID_VSC8531_02		  0x00070572
>  #define PHY_ID_VSC8540			  0x00070760
>  #define PHY_ID_VSC8541			  0x00070770
>  #define PHY_ID_VSC8552			  0x000704e0
> @@ -373,6 +374,8 @@ struct vsc8531_private {
>  	 * package.
>  	 */
>  	unsigned int base_addr;
> +	u32 rx_delay;
> +	u32 tx_delay;
>  
>  #if IS_ENABLED(CONFIG_MACSEC)
>  	/* MACsec fields:
> diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> index 6e32da28e138..2b501824c802 100644
> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -535,15 +535,16 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
>  	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
>  	u16 reg_val = 0;
>  	int rc;
> +	struct vsc8531_private *vsc8531 = phydev->priv;
>  
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
> +
> +	rc = of_property_read_u32(of_node, "vsc8531,tx-delay",
> +				  &vsc8531->tx_delay);
> +	if (rc < 0)
> +		vsc8531->tx_delay = RGMII_CLK_DELAY_2_0_NS;
>  
>  	rc = vsc85xx_default_config(phydev);
>  	if (rc)
> @@ -2444,6 +2456,30 @@ static struct phy_driver vsc85xx_driver[] = {
>  	.get_strings    = &vsc85xx_get_strings,
>  	.get_stats      = &vsc85xx_get_stats,
>  },
> +{
> +	.phy_id		= PHY_ID_VSC8531_02,
> +	.name		= "Microsemi VSC8531-02",
> +	.phy_id_mask	= 0xfffffff0,

VSC8531 and VSC8531-02 share the same model number, therefore you
would have to switch both PHY drivers to exact match.
phy_id_mask = 0xffffffff, or better use macro PHY_ID_MATCH_EXACT().


> +	/* PHY_GBIT_FEATURES */
> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init	= &vsc85xx_config_init,
> +	.config_aneg	= &vsc85xx_config_aneg,
> +	.read_status	= &vsc85xx_read_status,
> +	.handle_interrupt	= vsc85xx_handle_interrupt,
> +	.config_intr	= &vsc85xx_config_intr,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,
> +	.probe		= &vsc85xx_probe,
> +	.set_wol	= &vsc85xx_wol_set,
> +	.get_wol	= &vsc85xx_wol_get,
> +	.get_tunable	= &vsc85xx_get_tunable,
> +	.set_tunable	= &vsc85xx_set_tunable,
> +	.read_page	= &vsc85xx_phy_read_page,
> +	.write_page	= &vsc85xx_phy_write_page,
> +	.get_sset_count = &vsc85xx_get_sset_count,
> +	.get_strings	= &vsc85xx_get_strings,
> +	.get_stats	= &vsc85xx_get_stats,
> +},
>  {
>  	.phy_id		= PHY_ID_VSC8540,
>  	.name		= "Microsemi FE VSC8540 SyncE",
> @@ -2668,6 +2704,7 @@ static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
>  	{ PHY_ID_VSC8514, 0xfffffff0, },
>  	{ PHY_ID_VSC8530, 0xfffffff0, },
>  	{ PHY_ID_VSC8531, 0xfffffff0, },
> +	{ PHY_ID_VSC8531_02, 0xfffffff0, },

Effectively this is the same as the line before. Maybe it would make sense
to change this table in a follow-up patch to just one entry covering all
PHY ID's with the vendor part being Microsemi, e.g. using macro
PHY_ID_MATCH_VENDOR().

>  	{ PHY_ID_VSC8540, 0xfffffff0, },
>  	{ PHY_ID_VSC8541, 0xfffffff0, },
>  	{ PHY_ID_VSC8552, 0xfffffff0, },
> 

