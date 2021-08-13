Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77063EBD9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhHMUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:49:12 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:40685 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhHMUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:49:10 -0400
Received: by mail-oo1-f54.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so3173575ooo.7;
        Fri, 13 Aug 2021 13:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPCRYSb4R3QRR/TZOTUEc168jUR0KRnGrwUUxVnp0ZY=;
        b=Xed6Ww3bhTAm48+wuR7PdmZOFTeS9JbxLPFuVbbuz+g4Y/TEsS4cPxzS6x3iKnanXi
         tLWwBoYdWrGhKu8YhcCVkKqFi8p3l6DY19dMyjHmTrHL4NtW6cnHNfivTL0uBrv1YXm1
         dxjmxkSDcMQDB51Ey6TkdJWtblrUbFKdeXbW5921LfTeh6r/SFGJhr6dcuwiKKscYuEi
         /570zRDipWXimNjyoY7M4Wlj1+4tAyg596V6rZt9Eqc1/t+dM7+AFXe5ZV+ygvQfFLlk
         bm5CcmLHEXaqeVv7gJoQmvQF+vz4eyhuealksTgyEt6VktmFGm2kNy/gK5sS40YYQGJe
         QoHg==
X-Gm-Message-State: AOAM532YGm1txnvDmUbtQCn/D1Oe6WpHnZYOL9gnF8xpeHexiAoTbhmZ
        /a0G5J8Om9nbtLbOrgLfjQ==
X-Google-Smtp-Source: ABdhPJyZNXWYZLbhbYEyv82dBusJ4poQxct5LqJsFDCJXH2Khf0S/rfsNnLPdLrkZXj63k50uh2bgw==
X-Received: by 2002:a4a:e907:: with SMTP id z7mr3212174ood.20.1628887723401;
        Fri, 13 Aug 2021 13:48:43 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-7254-0b80-dd3c-00c6.res6.spectrum.com. [2603:8080:2a06:ed00:7254:b80:dd3c:c6])
        by smtp.gmail.com with ESMTPSA id w16sm559046oiv.15.2021.08.13.13.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:48:42 -0700 (PDT)
Received: (nullmailer pid 4005099 invoked by uid 1000);
        Fri, 13 Aug 2021 20:48:41 -0000
Date:   Fri, 13 Aug 2021 15:48:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm: dts: mt7623: add musb device nodes
Message-ID: <YRbaqdF0EJxNcpsX@robh.at.kernel.org>
References: <20210803151320.71531-1-mans0n@gorani.run>
 <20210808123840.176738-1-mans0n@gorani.run>
 <20210808123840.176738-3-mans0n@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808123840.176738-3-mans0n@gorani.run>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 09:38:40PM +0900, Sungbo Eo wrote:
> MT7623 has an musb controller that is compatible with the one from MT2701.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> v2:
> * rename usb3 label to usb0
> * move usb0 & u2phy1 nodes to the right sorted place
> * disable u2phy1 by default
> * correct u2port2 node name to match its reg address
> ---
>  arch/arm/boot/dts/mt7623.dtsi  | 34 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 3c11f7cfcc40..790d74439cc6 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -585,6 +585,40 @@ spi2: spi@11017000 {
>  		status = "disabled";
>  	};
>  
> +	usb0: usb@11200000 {
> +		compatible = "mediatek,mt7623-musb",
> +			     "mediatek,mtk-musb";
> +		reg = <0 0x11200000 0 0x1000>;
> +		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "mc";
> +		phys = <&u2port2 PHY_TYPE_USB2>;
> +		dr_mode = "otg";
> +		clocks = <&pericfg CLK_PERI_USB0>,
> +			 <&pericfg CLK_PERI_USB0_MCU>,
> +			 <&pericfg CLK_PERI_USB_SLV>;
> +		clock-names = "main","mcu","univpll";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +		status = "disabled";
> +	};
> +
> +	u2phy1: t-phy@11210000 {
> +		compatible = "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
> +		reg = <0 0x11210000 0 0x0800>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +
> +		u2port2: usb-phy@11210800 {
> +			reg = <0 0x11210800 0 0x0100>;
> +			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
> +			clock-names = "ref";
> +			#phy-cells = <1>;
> +			status = "okay";

Enabled is the default and doesn't really make sense here given the 
parent is disabled. Drop.

> +		};
> +	};
> +
>  	audsys: clock-controller@11220000 {
>  		compatible = "mediatek,mt7623-audsys",
>  			     "mediatek,mt2701-audsys",
> diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
> index 0735a1fb8ad9..d304b62d24b5 100644
> --- a/arch/arm/boot/dts/mt7623a.dtsi
> +++ b/arch/arm/boot/dts/mt7623a.dtsi
> @@ -35,6 +35,10 @@ &scpsys {
>  	clock-names = "ethif";
>  };
>  
> +&usb0 {
> +	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
> +};
> +
>  &usb1 {
>  	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
>  };
> -- 
> 2.32.0
> 
> 
