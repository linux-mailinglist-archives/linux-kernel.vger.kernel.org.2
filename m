Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201E3D3605
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhGWHVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF9F60E8E;
        Fri, 23 Jul 2021 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627027330;
        bh=6YinZAsMPdgkrcEo3fOYcdgojoWi8BwaGZBL1Cc5HFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuvINrBS/8uO9mSrXmX2NCblHYi5UP289T2CGtI0mHFigHgm4+dXTg4YkhbzNt0hV
         UBoTuDWvmipzt5hAJK3geUDfPwE7jjC1H0rkLfildq8hTL08IKkERXH/Uno9zZFYMS
         wJ4BtBrOFO39jgDk4Zu7JfvgXyeolskN5uDgHqGnrkQtIe7fmhm+PaeBIuJqAOvM+Q
         6VthxMKi+S2wuFCSX2ImvkzdfbE5XmnvBhdZBYC0FNBd1IRGfurMtVwRg3CdtegfKD
         Szi0DJr2KEmHL00hxRz5VksvhAv9glFefNHpA2vRw2NRdoeJLgJSHwcex3N9eRFaQP
         JRwsPQKkDFUpA==
Date:   Fri, 23 Jul 2021 16:02:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, qiangqing.zhang@nxp.com,
        ping.bai@nxp.com, alice.guo@nxp.com, jun.li@nxp.com,
        peng.fan@nxp.com, thunder.leizhen@huawei.com, yibin.gong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Add dsp node
Message-ID: <20210723080203.GG30773@dragon>
References: <20210716124719.926483-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716124719.926483-1-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 03:47:19PM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a
> custom firmware or the open source SOF firmware [1]
> 
> DSP device is handled by SOF OF driver found in
> sound/soc/sof/sof-of-dev.c
> 
> Notice that the DSP node makes use of:
> 	- dsp_reserved, a reserved memory region for various Audio
> 	  resources (e.g firmware loading, audio buffers, etc).
> 	- Messaging Unit (mu2) for passing notifications betweem ARM
> 	  core and DSP.
> 
> [1] https://thesofproject.github.io/latest/platforms/index.html
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> 	* mark MU2 node as disabled, because mu2 clock support is not yet upstream.
> 
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9f7c7f587d38..fb0ac85c8473 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -135,6 +135,17 @@ clk_ext4: clock-ext4 {
>  		clock-output-names = "clk_ext4";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dsp_reserved: dsp@92400000 {
> +			reg = <0 0x92400000 0 0x2000000>;
> +			no-map;
> +		};
> +	};
> +
>  	pmu {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_PPI 7
> @@ -698,6 +709,14 @@ mu: mailbox@30aa0000 {
>  				#mbox-cells = <2>;
>  			};
>  
> +			mu2: mailbox@30e60000 {
> +				compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
> +				reg = <0x30e60000 0x10000>;
> +				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
>  			i2c5: i2c@30ad0000 {
>  				compatible = "fsl,imx8mp-i2c", "fsl,imx21-i2c";
>  				#address-cells = <1>;
> @@ -938,5 +957,15 @@ usb_dwc3_1: usb@38200000 {
>  				snps,dis-u2-freeclk-exists-quirk;
>  			};
>  		};
> +		dsp: dsp@3b6e8000 {

Please have a newline between nodes.

Shawn

> +			compatible = "fsl,imx8mp-dsp";
> +			reg = <0x3b6e8000 0x88000>;
> +			mbox-names = "txdb0", "txdb1",
> +				"rxdb0", "rxdb1";
> +			mboxes = <&mu2 2 0>, <&mu2 2 1>,
> +				<&mu2 3 0>, <&mu2 3 1>;
> +			memory-region = <&dsp_reserved>;
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.27.0
> 
