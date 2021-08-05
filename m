Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84CA3E1897
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhHEPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbhHEPoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:44:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B7C06119A;
        Thu,  5 Aug 2021 08:43:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so6691151wms.2;
        Thu, 05 Aug 2021 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLMOhVLbljb+rc/o3B+4aERU4BHnBYm4XvzVswVbX4E=;
        b=BVtMMWpv4J0xrm84M+/UP9ui6rlbnSOcY1LttOu0zH2IrhGJ30D5jCk65ygbvauhJK
         8w/qZG1t2/U6g/eLH3Xmz9UW2KOk9osBz+HkJJ4IRVB1PYAbyT67XKzEYG4XDQ+rB/XR
         RGE5tbTcT9YQuHh3zirWLq2fDNI4soGSN4NXzWFn1zXJarhOKAm1HvFWwIz+yJ/o4AGo
         sJHhALQtNnEnsIYHHwVQietX9goCUrAeVQ1WA+Z496Uw+XabkBdtOMfmq2AHtQSLdsrM
         ehVAhPZdUvPrI3xi9vv8btZTc3F5kfEg1ko9sAERRGifsL/w7o2QrceY7kFrHfACf3UH
         30rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLMOhVLbljb+rc/o3B+4aERU4BHnBYm4XvzVswVbX4E=;
        b=mkz0O9RQeB0JdAjViOm+Ebu0vPIMBVCKchJ2byTHB956Ge5sdNHWdCjc8JyMAecD4a
         OrdRpbCLKN4syUSQNNgMweihf0omdY6Un+cplB+2NuM1fO2XdXb+m9Trt3zcMb+uvFCR
         /EfSXDhn/CoVrO9YA3O8ckFahtKoLlbeLnoLObab4/M+6XZ7vgWTPIZbip1QL4ApLhl3
         D0mkYxYmZxqHSySaFhW6/a/5fQnUcPT3CzrZ2h1FZ9/sVbDXq891vjAT9sNnvJ+EirEk
         CdNhRCYxfCCjCQLwWg6JQBObEQxQGFwUIsbVx2+gOwhjpiJ4KbtdNW+V4jbEWd847h5B
         4+Bw==
X-Gm-Message-State: AOAM531E14ddJvYmSrZxYVUlLlLd5Wxh6MK4u3d+QBfBIepOMJmjpTXY
        A8jZx70Vw7Bq572pir7qDSVvhUz5OspGPQ==
X-Google-Smtp-Source: ABdhPJxXuXaxWRVPF3y/KvqVMbS+a0BfKGWHXRTtMxB3b/nc9MTb/WyudGj4pLdPc4mKp0vpylcakg==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr5679136wmi.70.1628178201630;
        Thu, 05 Aug 2021 08:43:21 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id g16sm7688718wro.63.2021.08.05.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:43:21 -0700 (PDT)
Subject: Re: [v6 1/2] arm64: dts: mediatek: Add mt8192 clock controllers
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
 <20210727023205.20319-2-chun-jie.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c9c0bd84-5c62-d64b-efad-7d374f751a73@gmail.com>
Date:   Thu, 5 Aug 2021 17:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727023205.20319-2-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2021 04:32, Chun-Jie Chen wrote:
> Add clock controller nodes for SoC mt8192
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 163 +++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 9757138a8bbd..c7c7d4e017ae 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  /dts-v1/;
> +#include <dt-bindings/clock/mt8192-clk.h>

I'd need a stable branch from Stephen to be able to take this one. Otherwise
we'll need to wait for v5.15-rc1 to be published before I can take them without
compile errors.

Regards,
Matthias

>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> @@ -257,6 +258,24 @@
>  			};
>  		};
>  
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8192-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: syscon@10001000 {
> +			compatible = "mediatek,mt8192-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8192-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		pio: pinctrl@10005000 {
>  			compatible = "mediatek,mt8192-pinctrl";
>  			reg = <0 0x10005000 0 0x1000>,
> @@ -282,6 +301,12 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8192-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		systimer: timer@10017000 {
>  			compatible = "mediatek,mt8192-timer",
>  				     "mediatek,mt6765-timer";
> @@ -291,6 +316,12 @@
>  			clock-names = "clk13m";
>  		};
>  
> +		scp_adsp: clock-controller@10720000 {
> +			compatible = "mediatek,mt8192-scp_adsp";
> +			reg = <0 0x10720000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		uart0: serial@11002000 {
>  			compatible = "mediatek,mt8192-uart",
>  				     "mediatek,mt6577-uart";
> @@ -311,6 +342,12 @@
>  			status = "disabled";
>  		};
>  
> +		imp_iic_wrap_c: clock-controller@11007000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_c";
> +			reg = <0 0x11007000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		spi0: spi@1100a000 {
>  			compatible = "mediatek,mt8192-spi",
>  				     "mediatek,mt6765-spi";
> @@ -436,6 +473,12 @@
>  			status = "disable";
>  		};
>  
> +		audsys: clock-controller@11210000 {
> +			compatible = "mediatek,mt8192-audsys", "syscon";
> +			reg = <0 0x11210000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		i2c3: i2c3@11cb0000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11cb0000 0 0x1000>,
> @@ -449,6 +492,12 @@
>  			status = "disabled";
>  		};
>  
> +		imp_iic_wrap_e: clock-controller@11cb1000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_e";
> +			reg = <0 0x11cb1000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		i2c7: i2c7@11d00000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11d00000 0 0x1000>,
> @@ -488,6 +537,12 @@
>  			status = "disabled";
>  		};
>  
> +		imp_iic_wrap_s: clock-controller@11d03000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_s";
> +			reg = <0 0x11d03000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		i2c1: i2c1@11d20000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11d20000 0 0x1000>,
> @@ -527,6 +582,12 @@
>  			status = "disabled";
>  		};
>  
> +		imp_iic_wrap_ws: clock-controller@11d23000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_ws";
> +			reg = <0 0x11d23000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		i2c5: i2c5@11e00000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11e00000 0 0x1000>,
> @@ -540,6 +601,12 @@
>  			status = "disabled";
>  		};
>  
> +		imp_iic_wrap_w: clock-controller@11e01000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_w";
> +			reg = <0 0x11e01000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		i2c0: i2c0@11f00000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11f00000 0 0x1000>,
> @@ -565,5 +632,101 @@
>  			#size-cells = <0>;
>  			status = "disabled";
>  		};
> +
> +		imp_iic_wrap_n: clock-controller@11f02000 {
> +			compatible = "mediatek,mt8192-imp_iic_wrap_n";
> +			reg = <0 0x11f02000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		msdc_top: clock-controller@11f10000 {
> +			compatible = "mediatek,mt8192-msdc_top";
> +			reg = <0 0x11f10000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		msdc: clock-controller@11f60000 {
> +			compatible = "mediatek,mt8192-msdc";
> +			reg = <0 0x11f60000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mfgcfg: clock-controller@13fbf000 {
> +			compatible = "mediatek,mt8192-mfgcfg";
> +			reg = <0 0x13fbf000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mmsys: syscon@14000000 {
> +			compatible = "mediatek,mt8192-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys: clock-controller@15020000 {
> +			compatible = "mediatek,mt8192-imgsys";
> +			reg = <0 0x15020000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys2: clock-controller@15820000 {
> +			compatible = "mediatek,mt8192-imgsys2";
> +			reg = <0 0x15820000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys_soc: clock-controller@1600f000 {
> +			compatible = "mediatek,mt8192-vdecsys_soc";
> +			reg = <0 0x1600f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys: clock-controller@1602f000 {
> +			compatible = "mediatek,mt8192-vdecsys";
> +			reg = <0 0x1602f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys: clock-controller@17000000 {
> +			compatible = "mediatek,mt8192-vencsys";
> +			reg = <0 0x17000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys: clock-controller@1a000000 {
> +			compatible = "mediatek,mt8192-camsys";
> +			reg = <0 0x1a000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawa: clock-controller@1a04f000 {
> +			compatible = "mediatek,mt8192-camsys_rawa";
> +			reg = <0 0x1a04f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawb: clock-controller@1a06f000 {
> +			compatible = "mediatek,mt8192-camsys_rawb";
> +			reg = <0 0x1a06f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawc: clock-controller@1a08f000 {
> +			compatible = "mediatek,mt8192-camsys_rawc";
> +			reg = <0 0x1a08f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		ipesys: clock-controller@1b000000 {
> +			compatible = "mediatek,mt8192-ipesys";
> +			reg = <0 0x1b000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mdpsys: clock-controller@1f000000 {
> +			compatible = "mediatek,mt8192-mdpsys";
> +			reg = <0 0x1f000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
>  	};
>  };
> 
