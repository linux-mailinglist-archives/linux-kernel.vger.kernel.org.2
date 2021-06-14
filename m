Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311B83A6E20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhFNSWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:22:31 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33453 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhFNSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:22:29 -0400
Received: by mail-ed1-f43.google.com with SMTP id f5so42746412eds.0;
        Mon, 14 Jun 2021 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sKSZ9wrMXoxo+h1UMeYe3Rp56xWJodwZ6blQ9Pbkae8=;
        b=DwLMaLaoTbeUAvGOTsy/SkYIvnv7XHKYUmQVkojwNz2xTkjCo0I82BSarS/GJ56dOQ
         a+x0WZyUvdUbpPLY9cjEBE7+3OJ0yacsfJjc+5HbEHxdHvFSfZUjphFvYR2iCeJutkXV
         WuRkE2BV7pOhksYfqRxrFuLujd9mhozA1mDbd188ZS2GqDVndSwhXtA0FAG2hYx/tQ0T
         IUDCmZOiWZBDk+qeArrz/zKdiLJ7NNuVo0nEjrsveX4d3XqV8NbDQjFwdWOW/oT+DaWL
         5YJ5Gu/YNlqBRwS4PAE5ucDaaoI01xCo3G1dwO/HA2KCewxaDY+01R9NZSzrXDSKS4ha
         AZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKSZ9wrMXoxo+h1UMeYe3Rp56xWJodwZ6blQ9Pbkae8=;
        b=OYEa5z257a1IF72GKVTOk8+ywh6vfZ+I/1YSuITRyyZ0cOfPnoScqyY1MUNHjysh38
         ePBaW4ggk0jkTkHD5yNCywhJQB23CkAv7cYkWSSjFAWEAybt83poxSL3k9s/sB/BXU8U
         5euwfgjm3+3w2CwoyBWxiQG0Qs857MNFA8yAnRvZunGZKcdIcOeb4wApE3R9J6yd6Equ
         Hdb4DCm3puhiptJkTTRpQtSdlcUOnubmNX3x8XY04+buwzj6gWFpu9Yh9xf1pMRTZqlw
         MAsKKkkIM4LZQ1omOZZR92FxYpFr4uA6L03JLBG3MPNdLO7qHWswGmN2HRxQN08ctycV
         db0Q==
X-Gm-Message-State: AOAM533Q83nSvXblABp2s8nGGbyOcYBl3N9ZCNB5TOLhnSDCdtJHvGHX
        q6RKBZSKTeCRAMtaFnhFff3uE90S1A4MOg==
X-Google-Smtp-Source: ABdhPJxjFyQMJJItkqPMDa3/jwo2ml924dXRR4tAnILyTLhDLOQC+wm2EDJZDic0Yd6fMVifQmcGEA==
X-Received: by 2002:aa7:da4b:: with SMTP id w11mr18983039eds.272.1623694765194;
        Mon, 14 Jun 2021 11:19:25 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id au11sm8135373ejc.88.2021.06.14.11.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:19:24 -0700 (PDT)
Subject: Re: [PATCH 2/4] dt-bindings: phy: rockchip: USB2: Add compatible for
 rk3568
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
 <20210614154359.805555-3-benjamin.gaignard@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <2d1e35d1-92ab-7ca2-d2e7-13b3885adaa9@gmail.com>
Date:   Mon, 14 Jun 2021 20:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614154359.805555-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

The '#phy-cells' in [PATCH 1/4] are already gone.
The nodename is renamed to pattern "usb2phy@[0-9a-f]+$".
phy-rockchip-inno-usb2.yaml is now also part of grf.yaml, so must take
care of both.

From rk3568.dtsi:

	usb2phy0_grf: syscon@fdca0000 {
		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
		reg = <0x0 0xfdca0000 0x0 0x8000>;
	};

	usb2phy1_grf: syscon@fdca8000 {
		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
		reg = <0x0 0xfdca8000 0x0 0x8000>;
	};

	usb2phy0: usb2phy@fe8a0000 {
		compatible = "rockchip,rk3568-usb2phy";
		reg = <0x0 0xfe8a0000 0x0 0x10000>;
		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&pmucru CLK_USBPHY0_REF>;
		clock-names = "phyclk";
		#clock-cells = <0>;
		assigned-clocks = <&cru USB480M>;
		assigned-clock-parents = <&usb2phy0>;
		clock-output-names = "usb480m_phy";
		rockchip,usbgrf = <&usb2phy0_grf>;
		status = "disabled";

		u2phy0_host: host-port {
			#phy-cells = <0>;
			status = "disabled";
		};

		u2phy0_otg: otg-port {
			#phy-cells = <0>;
			status = "disabled";
		};
	};

	usb2phy1: usb2phy@fe8b0000 {
		compatible = "rockchip,rk3568-usb2phy";
		reg = <0x0 0xfe8b0000 0x0 0x10000>;
		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&pmucru CLK_USBPHY1_REF>;
		clock-names = "phyclk";
		#clock-cells = <0>;
		rockchip,usbgrf = <&usb2phy1_grf>;
		status = "disabled";

		u2phy1_host: host-port {
			#phy-cells = <0>;
			status = "disabled";
		};

		u2phy1_otg: otg-port {
			#phy-cells = <0>;
			status = "disabled";
		};
	};

rockchip,rk3568-usb2phy-grf must also be added to grf.yaml.

See linux-next.

https://lore.kernel.org/linux-devicetree/20210601164800.7670-2-jbx6244@gmail.com/

Johan

On 6/14/21 5:43 PM, Benjamin Gaignard wrote:
> Add "rockchip,rk3568-usb2phy" in compatible list of the USB2 phy.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> index b14387a48f6a3..a1420d5e44be7 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> @@ -18,6 +18,7 @@ properties:
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy

--->

>        - rockchip,rv1108-usb2phy

> +      - rockchip,rk3568-usb2phy

Please sort in alphabetical order.

>  
>    reg:
>      maxItems: 1
> 
