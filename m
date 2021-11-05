Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809DF446932
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhKETf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhKETf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:35:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6CDC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:32:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k4so11681235plx.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVPAwfzI1RODGdrDjPPqykSlzXxzSeyfbX3XOmwmzVQ=;
        b=i9gT4YH27ovkvjgIrcHPJk2UXEHCbJRy/hFnL/ROqysbibJVw8V/UGFOzxga4Jby+V
         biQiNz7kYGzyhFLJev3CYZEBLxMQS5FbnscAChtAlrT0fYrIuktnzPN9JmxRR3AGXt/F
         PWLWei4ajw1MT5wNFc9YDCamcUB6j1MmVYL+2IERNMLn5YrDaBgeWXzHds+h11yBhiO2
         0zUCbJlDHzcQQp0SRerZownGgs0HJb6Ft4A+hm7FL2JGlItX8ByKWH3R1DPlwHBpx/2s
         MatT+v87jdNuiDBGMZ1q9jyJ2+FhtzFzG1QTX+JDwl+aSNOaGYJnWgMsDm0FaCKXKD1I
         KJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVPAwfzI1RODGdrDjPPqykSlzXxzSeyfbX3XOmwmzVQ=;
        b=EOsCHmsJhjFTCYxQ9kTf+OIxG3cf7q85Mi7Xfj6xTwG3uQAsD9BtGaOYoGI6/Ik3s6
         zmZQtyoK0xm+1gJtxs+lDOGt3oDYpnjCmJBy62dhnl5n8FXWBLWs10KBQoska/qgZwwp
         Ql5/DJRuSC3hKBX075r0yfv6YOQ6egL4phrrRyHNroeevdUTvo97/3eGvuFJcM2rn+RQ
         L/YeMEvNtHAullbF+A1nbVkQzsWt8hFfvRlxPzaqCgvpnVUX7p1IrXqNLRxZmTLkCysE
         b3q1b+Q5SdqP4OSzGexRIMWbFwPyKO5QzkHOd024N4IVZ98yPsZbZ4y7gH+C3exZvu8K
         m79w==
X-Gm-Message-State: AOAM533Jg84/Us71O0YmL7XJ/ACPtz2GMkaAw3HZ0ErPA4GliUBBMup3
        luxHYMY82pyLmK6y8enI0iYgljjcQvzOFuepJL0MHg==
X-Google-Smtp-Source: ABdhPJyt6hw/5ZiXkQGMUXtxq2M1A0bzpW/TUXd9xMZSZI5X9LwULY6Zv30M23oUnTJ0lMCFsP5n0qgEjhCWAeAJ5NA=
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr28178586pjb.66.1636140765985;
 Fri, 05 Nov 2021 12:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211105134228.731331-1-aford173@gmail.com> <20211105134228.731331-2-aford173@gmail.com>
In-Reply-To: <20211105134228.731331-2-aford173@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 5 Nov 2021 12:32:34 -0700
Message-ID: <CAJ+vNU1UX8VZnApiYmQcZAN6ObHVEA_cEOB_r6tfS07FbfN31Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: imx8mm: Add CSI nodes
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        linux-media <linux-media@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 6:42 AM Adam Ford <aford173@gmail.com> wrote:
>
> There is a csi bridge and csis interface that tie together
> to allow csi2 capture.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 51 +++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c2f3f118f82e..1f69c14d953f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
>                         #size-cells = <1>;
>                         ranges = <0x32c00000 0x32c00000 0x400000>;
>
> +                       csi: csi@32e20000 {
> +                               compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";
> +                               reg = <0x32e20000 0x1000>;
> +                               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
> +                               clock-names = "mclk";
> +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
> +                               status = "disabled";
> +
> +                               port {
> +                                       csi_in: endpoint {
> +                                               remote-endpoint = <&imx8mm_mipi_csi_out>;
> +                                       };
> +                               };
> +                       };
> +
>                         disp_blk_ctrl: blk-ctrl@32e28000 {
>                                 compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
>                                 reg = <0x32e28000 0x100>;
> @@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
>                                 #power-domain-cells = <1>;
>                         };
>
> +                       mipi_csi: mipi-csi@32e30000 {
> +                               compatible = "fsl,imx8mm-mipi-csi2";
> +                               reg = <0x32e30000 0x1000>;
> +                               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +                               assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>,
> +                                                 <&clk IMX8MM_CLK_CSI1_PHY_REF>;
> +                               assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
> +                                                         <&clk IMX8MM_SYS_PLL2_1000M>;
> +                               clock-frequency = <333000000>;
> +                               clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> +                                        <&clk IMX8MM_CLK_CSI1_ROOT>,
> +                                        <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
> +                               clock-names = "pclk", "wrap", "phy", "axi";
> +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
> +                               status = "disabled";
> +
> +                               ports {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       port@0 {
> +                                               reg = <0>;
> +                                       };
> +
> +                                       port@1 {
> +                                               reg = <1>;
> +
> +                                               imx8mm_mipi_csi_out: endpoint {
> +                                                       remote-endpoint = <&csi_in>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +
>                         usbotg1: usb@32e40000 {
>                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>                                 reg = <0x32e40000 0x200>;
> --
> 2.32.0
>

Adam,

With your new series I can also now capture without hanging from
imx219 on imx8mm-venice-gw73xx-0x:

media-ctl --links "'imx219 2-0010':0->'imx7-mipi-csis.0':0[1]"
media-ctl -v -V "'imx219 2-0010':0 [fmt:SRGGB8/640x480 field:none]"
media-ctl -v -V "'csi':0 [fmt:SRGGB8/640x480 field:none]"
media-ctl --print-topology
gst-launch-1.0 -v v4l2src num-buffers=1 !
video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 !
filesink location=test.raw # not sure how to view this
gst-launch-1.0 -v v4l2src num-buffers=1 !
video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 !
bayer2rgb ! filesink location=test.rgb # not sure how to view this
gst-launch-1.0 -v v4l2src num-buffers=1 !
video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 !
bayer2rgb ! jpegenc ! filesink location=test.jpg # works - image is
good
gst-launch-1.0 -v v4l2src num-buffers=300 !
video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 !
bayer2rgb ! jpegenc ! avimux ! filesink location=test.avi # works
-image is good

Thanks for your work on this!

For the series:
Reviewed-By: Tim Harvey <tharvey@gateworks.com>
Tested-By: Tim Harvey <tharvey@gateworks.com>
(imx8mm-venice-gw73xx-0x + rpiv2 IMX219 camera)

Best regards,

Tim
