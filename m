Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88A458295
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhKUIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhKUIyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:54:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 748BE60E90;
        Sun, 21 Nov 2021 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637484669;
        bh=wXp5EP6n1++fB2l1O4aW2QaUL4JglSU8mtQzpuD7of8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1Pi6HMpBISxG8U4F9kmiFWRzmt19i0MjDLkFAbXJ+6A6JGWh9bBPFsl/qApHTrmZ
         q7w+3JgV8rJjcZ8IQYhv3R8N4OJOc+0nrIteUxFPrp4CNblUp3qfKnzrsGkuIPwhhn
         7CGigxkgggtL2txfaa029W1vwmvI3PUVCq+Tui40rrdvAWg1vrQyiaWoaCjS+oJLsw
         1xFFAk6e31BvHj7GsP01acVkhCTfSEKy5KLAuLSQTcjccuXajIzmQ5hkBj9hWIcPk0
         qb39RAulbQB0Ufs9qQVu4boeBYGg19Gu9sxh2uR3jpU4DOr+0jR9rbSoadyZW1WZ56
         35/rqZgxVgI4w==
Date:   Sun, 21 Nov 2021 16:51:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: fix the schema check errors for
 fsl,tmu-calibration
Message-ID: <20211121085102.GM31998@dragon>
References: <20211029114050.39520-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029114050.39520-1-david@ixit.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 01:40:49PM +0200, David Heidelberg wrote:
> fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
> No functional changes. Fixes warnings as:
> $ make dtbs_check
> ...
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: tmu@30260000: fsl,tmu-calibration:0: Additional items are not allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 95, 10, 103, 11, 111, 65536, 27, 65537, 35, 65538, 43, 65539, 51, 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 65, 131077, 75, 131078, 87, 131079, 99, 131080, 111, 196608, 21, 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 95, 196615, 113 were unexpected)
>         From schema: /home/ubuntu/projects_remote/linux/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> ...
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 87 ++++++++++++-----------
>  1 file changed, 44 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 972766b67a15..50088b110ad4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -429,49 +429,50 @@ tmu: tmu@30260000 {
>  				clocks = <&clk IMX8MQ_CLK_TMU_ROOT>;
>  				little-endian;
>  				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
> -				fsl,tmu-calibration = <0x00000000 0x00000023
> -						       0x00000001 0x00000029
> -						       0x00000002 0x0000002f
> -						       0x00000003 0x00000035
> -						       0x00000004 0x0000003d
> -						       0x00000005 0x00000043
> -						       0x00000006 0x0000004b
> -						       0x00000007 0x00000051
> -						       0x00000008 0x00000057
> -						       0x00000009 0x0000005f
> -						       0x0000000a 0x00000067
> -						       0x0000000b 0x0000006f
> -
> -						       0x00010000 0x0000001b
> -						       0x00010001 0x00000023
> -						       0x00010002 0x0000002b
> -						       0x00010003 0x00000033
> -						       0x00010004 0x0000003b
> -						       0x00010005 0x00000043
> -						       0x00010006 0x0000004b
> -						       0x00010007 0x00000055
> -						       0x00010008 0x0000005d
> -						       0x00010009 0x00000067
> -						       0x0001000a 0x00000070
> -
> -						       0x00020000 0x00000017
> -						       0x00020001 0x00000023
> -						       0x00020002 0x0000002d
> -						       0x00020003 0x00000037
> -						       0x00020004 0x00000041
> -						       0x00020005 0x0000004b
> -						       0x00020006 0x00000057
> -						       0x00020007 0x00000063
> -						       0x00020008 0x0000006f
> -
> -						       0x00030000 0x00000015
> -						       0x00030001 0x00000021
> -						       0x00030002 0x0000002d
> -						       0x00030003 0x00000039
> -						       0x00030004 0x00000045
> -						       0x00030005 0x00000053
> -						       0x00030006 0x0000005f
> -						       0x00030007 0x00000071>;
> +				fsl,tmu-calibration =
> +						<0x00000000 0x00000023>,
> +						<0x00000001 0x00000029>,

Can we keep the indentation like below?

	fsl,tmu-calibration = <0x00000000 0x00000023>,
			      <0x00000001 0x00000029>,
			      ...


Shawn

> +						<0x00000002 0x0000002f>,
> +						<0x00000003 0x00000035>,
> +						<0x00000004 0x0000003d>,
> +						<0x00000005 0x00000043>,
> +						<0x00000006 0x0000004b>,
> +						<0x00000007 0x00000051>,
> +						<0x00000008 0x00000057>,
> +						<0x00000009 0x0000005f>,
> +						<0x0000000a 0x00000067>,
> +						<0x0000000b 0x0000006f>,
> +
> +						<0x00010000 0x0000001b>,
> +						<0x00010001 0x00000023>,
> +						<0x00010002 0x0000002b>,
> +						<0x00010003 0x00000033>,
> +						<0x00010004 0x0000003b>,
> +						<0x00010005 0x00000043>,
> +						<0x00010006 0x0000004b>,
> +						<0x00010007 0x00000055>,
> +						<0x00010008 0x0000005d>,
> +						<0x00010009 0x00000067>,
> +						<0x0001000a 0x00000070>,
> +
> +						<0x00020000 0x00000017>,
> +						<0x00020001 0x00000023>,
> +						<0x00020002 0x0000002d>,
> +						<0x00020003 0x00000037>,
> +						<0x00020004 0x00000041>,
> +						<0x00020005 0x0000004b>,
> +						<0x00020006 0x00000057>,
> +						<0x00020007 0x00000063>,
> +						<0x00020008 0x0000006f>,
> +
> +						<0x00030000 0x00000015>,
> +						<0x00030001 0x00000021>,
> +						<0x00030002 0x0000002d>,
> +						<0x00030003 0x00000039>,
> +						<0x00030004 0x00000045>,
> +						<0x00030005 0x00000053>,
> +						<0x00030006 0x0000005f>,
> +						<0x00030007 0x00000071>;
>  				#thermal-sensor-cells =  <1>;
>  			};
>  
> -- 
> 2.33.0
> 
