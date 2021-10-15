Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C805242E63E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhJOBss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhJOBsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:48:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA56E61151;
        Fri, 15 Oct 2021 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634262399;
        bh=6Vd2kFlVhKA+VeEZ2dIfDQIgBxQl4oG8AFsgsstnr50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOKNk03QioGmzRuvR0Fz3uTRGp/X9NU3b+ubEfcOl9MLOD4GL4nM1v9czC8cJUtyD
         1LG2TwrOf94Ik3MYhbyoO/E2pWo7iuZAlgURt9CyprnCfKP6Zp0+yb3H1gA7uQSrIQ
         wCWpey3Kd9SiUpfepykLsAqaVtCTrVFku+SsouDoND1TdYKERe2XxH0LLq7Ui3iNWo
         +i/LyVP6rlwZiqKRMp0TFry6Xa/zxzSdDdSCHBFwfj57BpifYaGnM47h9CdkOP9IFd
         VQx5bZHh1mw/6XC7D7m0CEbL9TLCeURw3vWZUPPIvHe30BE95o1mjM7TRVMSBe3/lH
         n6Ft1O7wiMFIQ==
Date:   Fri, 15 Oct 2021 09:46:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH v2 7/7] arm64: dts: imx8mq-librem5: set debounce interval
 of volume buttons to 50ms
Message-ID: <20211015014632.GC10197@dragon>
References: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
 <20211005134902.2138731-8-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005134902.2138731-8-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:49:02PM +0200, Martin Kepplinger wrote:
> From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> 
> The default of 5ms is too low.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Your SoB is missing here.  I fixed it up and applied the series, thanks!

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index d86486fd659d..60d47c71499b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -40,12 +40,14 @@ vol-down {
>  			label = "VOL_DOWN";
>  			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEDOWN>;
> +			debounce-interval = <50>;
>  		};
>  
>  		vol-up {
>  			label = "VOL_UP";
>  			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <50>;
>  		};
>  	};
>  
> -- 
> 2.30.2
> 
