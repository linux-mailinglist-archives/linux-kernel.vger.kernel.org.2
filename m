Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3532D1E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhCDLhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238943AbhCDLhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:37:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3CA64EDF;
        Thu,  4 Mar 2021 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614857825;
        bh=lCDSwJ74OmvlKz5hZIDCsA90A6//34lLgcYAEC2sM+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDaFwIDlQYoQkwavVKQyD+6VkWmaN2DDWWXmG0tDQv5LlZwNaNCxNSmPyqo5AJneG
         3txPXmHiNa3pXyO53zAA3mUFC57bE7/5vxMIw9b+TZG97xdztAZ2G9oQ8Fm5z2OMY+
         y0/RMpilXTAVTlTZVFc35MaDJUaJ8Zv2uaTbRAVn4U2bHhE/Y6+oy3ZqpQuQgt9RLa
         AbVJ9mdSBBynXnasvXkSVhph/n9odjsnpcZ+UZNgCzzdd/b8GYsZjHtNWlo0Ymgi1p
         luKiQOS3S6Wn3Q894qsZE5/Dj9pZyV53u2u1s5vgmfwKVmmqhClB/vq3Z4gn6jUFIy
         k6uZRpns/vqsg==
Date:   Thu, 4 Mar 2021 19:37:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
Message-ID: <20210304113659.GQ15865@dragon>
References: <20210209005259.29725-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209005259.29725-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:52:59AM +0100, Michael Walle wrote:
> The legacy interrupt INT_A is hardwired to the event collector. RCEC is
> bascially supported starting with v5.11. Having a correct interrupt, will
> make RCEC at least probe correctly.
> 
> There are still issues with how RCEC is implemented in the RCiEP on the
> LS1028A. RCEC will report an error, but it cannot find the correct
> subdevice.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 262fbad8f0ec..c1f2f402ad53 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -1114,6 +1114,12 @@
>  					full-duplex;
>  				};
>  			};
> +
> +			rcec@1f,0 {

Just curious how unit-address comes to '1f,0'?

Shawn

> +				reg = <0x00f800 0 0 0 0>;
> +				/* IEP INT_A */
> +				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			};
>  		};
>  
>  		rcpm: power-controller@1e34040 {
> -- 
> 2.20.1
> 
