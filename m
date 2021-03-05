Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103C132F553
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCEVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:35:17 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34737 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCEVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:34:46 -0500
Received: by mail-oi1-f174.google.com with SMTP id x78so4117117oix.1;
        Fri, 05 Mar 2021 13:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWcbtx/O03x0LQG+66LolRPL6itu+bSvwGPnuUWr9kM=;
        b=EbErSlpnT6rFb5+SNIkATfW1Mfz4hGyWETfd8IfJn2j7GGKGWqljD6ehKcW2470R4D
         n8mWgrbRQBLfcjORU7asdpZ+ad2bFoV15XFf3WZ+QvQ1oqyA13ItpFa9Yx3v5TA6IAAh
         NdhxV/xnt2sWoCJREXPNYm6fi6pOF8feBriszJKlHww6O64w/aKxpEKm2U6vEMZ2aRDO
         5VqnYJA/RAo5MIs9lbdNFELIWDeqURwFE/U1YQHoCN1eI43xoP+HZphJIgfouPxSZWFl
         u7iDsJ52405FgVlW/Oz5SDZi5CR4bRVwtdyW8GOthGK4eKqoXuM5/l9dwylP2+pYBx88
         ZFbA==
X-Gm-Message-State: AOAM531fC2wrIQ94fvCvNh3ROWt/be1HGAtj6Z4cAiWR8V5Nbcw/+MrW
        XkR9qPw1RPfPdbCV9J4htQ==
X-Google-Smtp-Source: ABdhPJw1ya/0+woo5VnoKWFK+NB4tu59mDauHNtwf+YhgvBwtX+bAr1qex2VwGmCkd51LCiWgor1vA==
X-Received: by 2002:aca:f388:: with SMTP id r130mr8809590oih.55.1614980086338;
        Fri, 05 Mar 2021 13:34:46 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r81sm804055oie.2.2021.03.05.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:34:45 -0800 (PST)
Received: (nullmailer pid 685224 invoked by uid 1000);
        Fri, 05 Mar 2021 21:34:44 -0000
Date:   Fri, 5 Mar 2021 15:34:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        linux@armlinux.org.uk, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, vkoul@kernel.org,
        kishon@ti.com, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v2 2/4] devicetree/bindings: add support for CP110 UTMI
 driver
Message-ID: <20210305213444.GA681416@robh.at.kernel.org>
References: <20210214160108.3879-1-kostap@marvell.com>
 <20210214160108.3879-3-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214160108.3879-3-kostap@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 06:01:06PM +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add DTS binding for Marvell CP110 UTMI driver

Bindings are for h/w blocks/devices, not drivers.

> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt | 78 ++++++++++++++++++--
>  1 file changed, 72 insertions(+), 6 deletions(-)

This is a big enough change, please convert to schema first.

> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> index aa99ceec73b0..b66066249861 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> @@ -1,30 +1,56 @@
> -MVEBU A3700 UTMI PHY
> ---------------------
> +MVEBU UTMI PHY
> +---------------
>  
>  USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
>  * Armada 3700
> +* Armada 7k/8k (on the CP110)
> +* Armada CN913x (on the CP115)
>  
>  On Armada 3700, there are two USB controllers, one is compatible with the USB2
>  and USB3 specifications and supports OTG. The other one is USB2 compliant and
>  only supports host mode. Both of these controllers come with a slightly
>  different UTMI PHY.
>  
> +On Armada 7k/8k and CN913x, there are two host and one device USB controllers.
> +Each of two exiting UTMI PHYs could be connected to either USB host or USB device
> +controller.
> +The USB device controller can only be connected to a single UTMI PHY port:
> +                    0.H----- USB HOST0
> +UTMI PHY0  --------/
> +                    0.D-----0
> +                             \------ USB DEVICE
> +                    1.D-----1
> +UTMI PHY1  --------\
> +                    1.H----- USB HOST1
> +
> +
>  Required Properties:
>  
>  - compatible: Should be one of:
>  	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
> -	        the USB2 host-only controller.
> +	        the USB2 host-only controller (for Armada3700 only).
>  	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
> -	        the USB3 and USB2 OTG capable controller.
> +	        the USB3 and USB2 OTG capable controller (for Armada3700 only.
> +	      * "marvell,cp110-utmi-phy" (for Armada 7k/8k or CN913x only).
>  - reg: PHY IP register range.
>  - marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
>  			region covering registers related to both the host
> -			controller and the PHY.
> -- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
> +			controller and the PHY (for Armada3700 only).
> +- marvell,system-controller: should contain a phandle to the system
> +			     controller node (for Armada 7k/8k or CN913x only)
> +- #phy-cells: Standard property (Documentation: phy-bindings.txt.
> +		Should be 0 (for Armada3700 only).
> +
> +
> +Required properties (child nodes, for Armada 7k/8k/CN913x only):
> +
> +- reg: UTMI PHY port ID (0 or 1).
> +- #phy-cells : Should be 0.
>  
>  
>  Example:
>  
> +Armada3700
>  	usb2_utmi_host_phy: phy@5f000 {
>  		compatible = "marvell,armada-3700-utmi-host-phy";
>  		reg = <0x5f000 0x800>;
> @@ -36,3 +62,43 @@ Example:
>  		compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
>  		reg = <0x5f800 0x800>;
>  	};
> +
> +Armada 7k/8k/CN913x
> +
> +	cp0_utmi: utmi@580000 {
> +		compatible = "marvell,cp110-utmi-phy";
> +		reg = <0x580000 0x2000>;
> +		marvell,system-controller = <&cp0_syscon0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";

Don't put status in examples.

> +
> +		cp0_utmi0: phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +		};
> +
> +		cp0_utmi1: phy@1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +
> +	cp0_usb3_0 {
> +		status = "okay";
> +		usb-phy = <&cp0_usb3_0_phy0>;
> +		phys = <&cp0_utmi0>;
> +		phy-names = "utmi";
> +		/* UTMI0 is connected to USB host controller (default mode) */
> +		dr_mode = "host";

Nodes need to be complete (and pass validation).

> +	};
> +
> +	cp0_usb3_1 {
> +		status = "okay";
> +		usb-phy = <&cp0_usb3_0_phy1>;
> +		phys = <&cp0_utmi1>;
> +		phy-names = "utmi";
> +		/* UTMI1 is connected to USB device controller */
> +		dr_mode = "peripheral";
> +	};
> +
> -- 
> 2.17.1
> 
