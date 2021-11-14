Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2444F7A1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhKNLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:36:16 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E1C061746;
        Sun, 14 Nov 2021 03:33:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m20so12387492edc.5;
        Sun, 14 Nov 2021 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogu/YhyQO8ICUmENU2FAy3SJRpIJSF2lRArsc1NLhYg=;
        b=OGFWL0sRErovz1CmXuD79Pc+BM+1UMzkkpVIsjQEYcS8LH3zaft7m/2u0GqYdhFVER
         cyyCr19jjWUWi3MLXoNrj8bCscylE2dFkS3+IU6gu98WhAWb/cRhxGhvbI+UMsyktXXh
         cWvuxc04U1tdViB+snjeyJIGIZlM1Bph3WkgNMK8T5eqiBt9gYJczxa/xxWd1ndmxXOa
         ljvV685pSS2gvNNJwwqlwd79dkufWsh4utGL6WYcdfK75EbWnV5EzIY/2gsbhR9uVOUh
         o36ALtbxYCLXmmnHWQfTmfsoe2/6MpW+UAaZfuJE7mkPOaRIKcEHOiwErQRo7SQT5cSd
         9qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogu/YhyQO8ICUmENU2FAy3SJRpIJSF2lRArsc1NLhYg=;
        b=IhshUQrx03BeywvPNoLJDHrELkD9BqKsvba96CzeNn48Y3Idye2BqiwWVHUNcwhBNU
         jEeWVcsBTIZKO+QQXnEBeTevo1yG+0LnWedYC5+djPG76jfrkHY15WUyIbUaxgMvpdd/
         ocamTt09zy1NXfhcw4s7tX3wqtvmfnsAa9Oa9IxlMTOzzUNAnqXdZenF5Ru1Xu23oGyb
         MzgWBJxm4Dm0BS9hkuwdxjOO7q19BNBTeQeHLzUjC9W+n0a83TBEAUrdAVXJA93NP0wL
         bzaDwCFJ39ktQRc7UJMsMXowo8U8QXG+6TOVRjss0Iv//9XRliV/QRAPtqfborcQs+vy
         FvpQ==
X-Gm-Message-State: AOAM531J6QIRqj0mm4RuVB+nrxOSANx13Cdemh+WoKfFeKmiiNq1uIbG
        OASVC2FF0MTpEz7GEQtXREA=
X-Google-Smtp-Source: ABdhPJwV64eWsyJF9IcerkYBp/vULP771LGHIpnfkZPUzLrrkmMRTLPAowgjZeLBZWvUEFXBZNEkNQ==
X-Received: by 2002:aa7:c3c8:: with SMTP id l8mr2270702edr.278.1636889600864;
        Sun, 14 Nov 2021 03:33:20 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m11sm5789601edd.58.2021.11.14.03.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 03:33:20 -0800 (PST)
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add naneng combo phy nodes
 for rk3568
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
 <20211025080632.32063-4-yifeng.zhao@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <167392de-8b5e-6877-94aa-66d9368e96a7@gmail.com>
Date:   Sun, 14 Nov 2021 12:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025080632.32063-4-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Add more compatible strings to:
Documentation/devicetree/bindings/mfd/syscon.yaml
Also add mfd maintainers and list to CC.

On 10/25/21 10:06 AM, Yifeng Zhao wrote:
> Add the core dt-node for the rk3568's naneng combo phys.
> 
> Signed-off-by:  Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v3:
> - Move pipe_phy_grf0 to rk3568.dtsi
> 
> Changes in v2:
> - Move phy0 to rk3568.dtsi
> 
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 21 +++++++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 47 ++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 2fd313a295f8..4db5d3c2a04e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,11 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	pipe_phy_grf0: syscon@fdc70000 {

> +		compatible = "rockchip,pipe-phy-grf", "syscon";

Compatible strings are supposed to be SOC related.

compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";


> +		reg = <0x0 0xfdc70000 0x0 0x1000>;
> +	};
> +
>  	qos_pcie3x1: qos@fe190080 {
>  		compatible = "rockchip,rk3568-qos", "syscon";
>  		reg = <0x0 0xfe190080 0x0 0x20>;
> @@ -71,6 +76,22 @@
>  			queue0 {};
>  		};
>  	};
> +
> +	combphy0_us: phy@fe820000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe820000 0x0 0x100>;

> +		#phy-cells = <1>;

Dump things with "#" down the list above status.
> +		clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;

> +		reset-names = "combphy-apb", "combphy";

There are 2 resets. When the reset order does matter then use
devm_reset_control_array_get() to get the resets.
The use of reset-names is then not needed.

> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
> +		status = "disabled";
> +	};
>  };
>  
>  &cpu0_opp_table {
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 46d9552f6028..4380580d061b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -214,11 +214,26 @@
>  		};
>  	};
>  
> +	pipegrf: syscon@fdc50000 {
> +		compatible = "rockchip,rk3568-pipegrf", "syscon";

compatible = "rockchip,rk3568-pipe-grf", "syscon";

> +		reg = <0x0 0xfdc50000 0x0 0x1000>;
> +	};
> +
>  	grf: syscon@fdc60000 {
>  		compatible = "rockchip,rk3568-grf", "syscon", "simple-mfd";
>  		reg = <0x0 0xfdc60000 0x0 0x10000>;
>  	};
>  
> +	pipe_phy_grf1: syscon@fdc80000 {
> +		compatible = "rockchip,pipe-phy-grf", "syscon";

Compatible strings are supposed to be SOC related.

compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";

> +		reg = <0x0 0xfdc80000 0x0 0x1000>;
> +	};
> +
> +	pipe_phy_grf2: syscon@fdc90000 {

> +		compatible = "rockchip,pipe-phy-grf", "syscon";

Compatible strings are supposed to be SOC related.

compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";

> +		reg = <0x0 0xfdc90000 0x0 0x1000>;
> +	};
> +
>  	pmucru: clock-controller@fdd00000 {
>  		compatible = "rockchip,rk3568-pmucru";
>  		reg = <0x0 0xfdd00000 0x0 0x1000>;
> @@ -1077,6 +1092,38 @@
>  		status = "disabled";
>  	};
>  
> +	combphy1_usq: phy@fe830000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe830000 0x0 0x100>;

> +		#phy-cells = <1>;
dito

> +		clocks = <&pmucru CLK_PCIEPHY1_REF>, <&cru PCLK_PIPEPHY1>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY1>, <&cru SRST_PIPEPHY1>;

> +		reset-names = "combphy-apb", "combphy";

dito

> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
> +		status = "disabled";
> +	};
> +
> +	combphy2_psq: phy@fe840000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe840000 0x0 0x100>;

> +		#phy-cells = <1>;

dito

> +		clocks = <&pmucru CLK_PCIEPHY2_REF>, <&cru PCLK_PIPEPHY2>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY2>, <&cru SRST_PIPEPHY2>;

> +		reset-names = "combphy-apb", "combphy";

dito

> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
> +		status = "disabled";
> +	};
> +
>  	pinctrl: pinctrl {
>  		compatible = "rockchip,rk3568-pinctrl";
>  		rockchip,grf = <&grf>;
> 
