Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14173403CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCRKsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhCRKsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:48:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2002564F30;
        Thu, 18 Mar 2021 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616064499;
        bh=wUjo7pXS0qwNu7qlROg2ZrsNqWJ+naCq27CZFw+tGxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obtiLjOk0EJbDJRy146lV/GRO7i2UbA3KHW5om4V5UtomD55RTLbQB1T0kl6l+IZc
         y+PXnX+UWBZ+ZdFT/FQWieKCNl4AnJP26lYa60Wr0JY2ctc8z2HTyqtN6cH6RZGD2O
         xBlGhvC4m381d8r1igAax3qQZWdavHiqUr6uzykYgLYCt5wzf27KZXEsQDGIu8rEdZ
         DgPf1m8/r70mV4Md7VG8tNBITyv6qS8ZykgCZGDGzNtiGdHg7LZrlffbK58bYY4Yh6
         nRekfn/A8SJ2EAIVcfZ5TMeaB0O2xKPDwdgfO/rZ1mkbmegX0nn0QUU2WfCN/iKKFv
         q9xyKl01a0ZGQ==
Date:   Thu, 18 Mar 2021 18:48:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
Message-ID: <20210318104813.GB22955@dragon>
References: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:40:13PM +0800, Joakim Zhang wrote:
> Some users report that FEC can't work on i.MX8MP EVK board, it brings
> inconvenience. The root cause should be FEC controller attached to
> generic phy driver, as Realtek phy driver is built as module in the
> defconfig file (CONFIG_REALTEK_PHY=m), so it is unavailable. If provide
> "reset-gpios" property, it will reset phy when probed, and no way to
> re-config phy since we use the generic phy dirver, which leads FEC can't
> work.
> 
> There are two ways to let FEC work:
> 
> 1. If you want to use generic phy dirver, please delete "reset-gpios"
> property, keep power-on strapping pins configurations.
> 
> 2. If you want to use Realtek phy driver, please buildin driver
> (CONFIG_REALTEK_PHY=y), and had better add another two reset
> properties:
> 	reset-assert-us = <20000>;
> 	reset-deassert-us = <150000>;
> According to  RTL8211 serials PHY datasheet, for a complete PHY reset,
> reset pin must be asserted low for at least 10ms for internal regulator.
> Wait for at least 72ms (for internal circuits settling time) before
> accessing the PHY register.
> 
> This patch selects method 1, since users may waste time to find out FEC
> failure, in most cases, they just want to use networking to debug other
> modules.
> 
> Fixs: commit 9e847693c6f34 ("arm64: dts: freescale: Add i.MX8MP EVK board support")
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 7db4273cc88b..4f5c2fb33eda 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -97,7 +97,6 @@
>  			compatible = "ethernet-phy-ieee802.3-c22";
>  			reg = <1>;
>  			eee-broken-1000t;
> -			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;

Hmm, DT is describing hardware.  If board schematic says there is
a reset GPIO, we should have it.

Shawn

>  		};
>  	};
>  };
> -- 
> 2.17.1
> 
