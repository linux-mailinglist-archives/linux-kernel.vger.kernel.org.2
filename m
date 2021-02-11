Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87273196A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhBKXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhBKXcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:32:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 564C764E35;
        Thu, 11 Feb 2021 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613086299;
        bh=Ng69JmZ0LQMnTDB7mQq8R4xgzcE7FVwpXtY5Bngs0UQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWnit77Rc6uiDZDmlxEDkawLUjK5F4rV/SN6a87SzbLSwbD0jCmpFH//qEZo9QEpu
         +/BXpFbFbodsXw4cQVQ9XemLKeTm8szYhNnWyDriM1S3cDbBQ7HZUGtoBXXtlvDORU
         FNEw0rrqjFp0i6jvTK5HsW5MSRccSfcP/CxX1duZABcLKuyNac502A6/Gj+9Wch1TC
         Oo1UYEBi+pzTfWxh5n9X0B30Op2UPjmjaAleRUtMZVcrQJm6p2CFHYnZBpISwhhXo+
         P47zrCL8edmwwxddVUc9Llm6gDLhWCFAhVT+lWuh6bjbWOkDaxlGIf8rgHmbUKL1FJ
         RT9J8OYaVIL5g==
Received: by pali.im (Postfix)
        id 017A9A80; Fri, 12 Feb 2021 00:31:36 +0100 (CET)
Date:   Fri, 12 Feb 2021 00:31:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v2 05/12] arm64: dts: marvell: armada-3720-db: add comphy
 references
Message-ID: <20210211233136.t36ytezz4n6lbtmn@pali>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-6-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210140949.32515-6-kostap@marvell.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 February 2021 16:09:42 kostap@marvell.com wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> 
> Adding phy description to pcie, sata and usb will allow appropriate drivers
> to configure marvell comphy-a3700 accordingly.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>

Hello! This patch is not needed too as Gregory already included into his
tree alternative patch which defines SATA PHY globally into main include
file armada-37xx.dtsi:

https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/commit/?h=for-next&id=6ece0f7dbd558670ec72ba390379949a4d4dc5c0

And PCIe and USB 3.0 PHY definitions are already in include file.

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 3e5789f37206..15e923f945d4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -132,11 +132,15 @@
>  	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
>  	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&comphy1 0>;
>  };
>  
>  /* CON3 */
>  &sata {
>  	status = "okay";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&comphy2 0>;
>  };
>  
>  &sdhci0 {
> @@ -217,4 +221,7 @@
>  &usb3 {
>  	status = "okay";
>  	usb-phy = <&usb3_phy>;
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&comphy0 0>;
> +	phy-names = "usb";
>  };
> -- 
> 2.17.1
> 
