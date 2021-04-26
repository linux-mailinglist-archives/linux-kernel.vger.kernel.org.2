Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970836AA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhDZBZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhDZBZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65AC661078;
        Mon, 26 Apr 2021 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619400302;
        bh=kiWJjYBYqhGRPnapDaXtKh585BBscvLrQg+YFOLyZis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbP+PrNPauTyCxQ9kyjMlwCQvHK9mb5OsUxFp92uXrrcgELQVi0hYpVtQW46hPw1T
         oYO6RGywipdaC2K2UQUYmVnPn+Sjl3sQe1myfUK/W9kBtllCLc8Xql7Gy61y1IAcNu
         idU06YgBYObe3CwkBu5tR8/idQvdbGTBecu3q41EhvFO/SM6uPXly1BUSWUSg3xgeS
         As7h57ASrWj+DsS1MJ7/HsdRwH0SsVezXZPL9SJVusSQZmdhiQvGAd3hL0zQ0zs50W
         TCII8Q5ANRlvhD83d98ua5aJ9Ny507ZTqUGnnEW3/CZrIycARe/zpe0/0Wm+RZRsex
         VM1MSNiGJ9J7Q==
Date:   Mon, 26 Apr 2021 09:24:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power
 up pcie phy
Message-ID: <20210426012456.GB27585@dragon>
References: <1617005163-29824-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617005163-29824-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:06:03PM +0800, Richard Zhu wrote:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 85b045253a0e..4d2035e3dd7c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -318,6 +318,7 @@
>  		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
>  		 <&pcie0_refclk>;
>  	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	vph-supply = <&vgen5_reg>;

Hmm, I do not see this in the bindings doc.

Shawn

>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
> 
