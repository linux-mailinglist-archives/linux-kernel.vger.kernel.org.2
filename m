Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB49A3A6CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhFNRLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:11:31 -0400
Received: from foss.arm.com ([217.140.110.172]:41832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235078AbhFNRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:11:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F066511D4;
        Mon, 14 Jun 2021 10:09:24 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39EBF3F70D;
        Mon, 14 Jun 2021 10:09:23 -0700 (PDT)
Subject: Re: [PATCH 3/4] PHY: rockchip: USB2: Allow 64 bits reg property
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
 <20210614154359.805555-4-benjamin.gaignard@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <19d8cb97-d715-eb5f-5b2c-0c273937fd00@arm.com>
Date:   Mon, 14 Jun 2021 18:09:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614154359.805555-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 16:43, Benjamin Gaignard wrote:
> In rk356x device-tree "reg" property could be coded on 64 bits.
> Change reg type and of_property_read_ to make it works.

On platforms with #address-cells=1, this isn't going to do what you 
think. Worse, it's not even going to fail, because you *can* read a 
64-bit value from an address cell with a size cell after it...

Robin.

> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 46ebdb1460a3d..45518f96d7217 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1068,7 +1068,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   	struct rockchip_usb2phy *rphy;
>   	const struct rockchip_usb2phy_cfg *phy_cfgs;
>   	const struct of_device_id *match;
> -	unsigned int reg;
> +	u64 reg;
>   	int index, ret;
>   
>   	rphy = devm_kzalloc(dev, sizeof(*rphy), GFP_KERNEL);
> @@ -1098,7 +1098,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   		rphy->usbgrf = NULL;
>   	}
>   
> -	if (of_property_read_u32(np, "reg", &reg)) {
> +	if (of_property_read_u64(np, "reg", &reg)) {
>   		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
>   			np);
>   		return -EINVAL;
> 
