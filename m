Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0834F322910
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhBWKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhBWKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:51:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386BC06178A;
        Tue, 23 Feb 2021 02:50:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u20so33153516ejb.7;
        Tue, 23 Feb 2021 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/1JNEV3PIgicB1am1l2YiBw1QtFaWJe84twwNeW3fU=;
        b=sbyScH7H7LXNHh4yh+UgXkonko8so3LzRkfz9yrn7msK1FKyYdgQev/OTj6nABvnAx
         Ndxr0plTbNcKNaAp2shfwJdrHxCEhB3j62wy4I7peJrx2pDerOoT0Y/0kNc7Aes5CLpP
         Wq4BLLAAMX9195J4zIb8wlEekLdedjItrAKbXGW2Eph7ffqRm8W5Ih5DgM8RIaNgx6jo
         nTwWD9Y5F19aFyezTK67VTMD3rr7/rDBuMyuJTDNDZ79Y3U0+hrTV0IH+LLn7hBqFXDK
         JoJChikw9YbVqyOrdrACYCZ/1TrL1jY3vxPpKcZkCc1iU6qoVOtPHK7jGvIHl2ah1BrP
         z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/1JNEV3PIgicB1am1l2YiBw1QtFaWJe84twwNeW3fU=;
        b=nBqYQ99hqG1qt1bBdBXxjB5zvnwEsArmI+ffyiEUrnG7JDr3GYjyBETq38tnc3MXVS
         lXdS5udSlxINGt0rj/3g7Hf7Svghpd3cizf3xcBcYotyvc3GxuACMJdCYvgbE6EBsb6S
         btn2tY/cchS5wRyZh9G9Pc+v7mVA0Um+eQ9oZoXodIGQYBVqwfsla6dVQdhYgqNIyFJv
         /EPdlaeQGk8mGB4lK2I9LIif4wdczgY2iFA0XzAqNjcTUv2NOzxizaU+FZ+G6Eh9Grik
         c0U91fYYzD1Oq5W4wZhthV6/OskhGVdiLEjq9PQ1I0SrPzyL0VaZ5g3Llj4yhjps6Uf4
         6vxg==
X-Gm-Message-State: AOAM533Yv+kD/sOpqchPcwn0avFikLXCVA4KpRsc8BbYU754wof+Rv7K
        tg8HaRha00xHIYoWrdkmszM=
X-Google-Smtp-Source: ABdhPJzXHFXMEOji4avwfFcQdLZA7rv5Vj6DrXXynyzrv8X/eQxl2iIGEjF+xb3ztZgLCzcXWlPgsg==
X-Received: by 2002:a17:906:4e95:: with SMTP id v21mr364290eju.112.1614077428321;
        Tue, 23 Feb 2021 02:50:28 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m19sm13519029eds.8.2021.02.23.02.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 02:50:28 -0800 (PST)
Subject: Re: [PATCH v1 1/4] dt-bindings: add bindings for rk3568 clock
 controller
To:     Elaine Zhang <zhangqing@rock-chips.com>, sboyd@kernel.org,
        heiko@sntech.de
Cc:     huangtao@rock-chips.com, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        cl@rock-chips.com
References: <20210223095352.11544-1-zhangqing@rock-chips.com>
 <20210223095352.11544-2-zhangqing@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <eb82f0a4-ca89-d1bc-5660-49bd05b7fc50@gmail.com>
Date:   Tue, 23 Feb 2021 11:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210223095352.11544-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

This is a new document.
Could you convert rockchip,rk3568-cru.txt to yaml?

To get an acked-by you must include:

robh+dt@kernel.org
devicetree@vger.kernel.org

./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
--nogit <patch>

Your patch should show up here after filtering:
https://patchwork.ozlabs.org/project/devicetree-bindings/list/

Check with:

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/rockchip,rk3568-cru.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/rockchip,rk3568-cru.yaml

./scripts/checkpatch.pl --strict <patch>


On 2/23/21 10:53 AM, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3568-cru.txt    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> new file mode 100644
> index 000000000000..b1119aecb7c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
> @@ -0,0 +1,66 @@
> +* Rockchip RK3568 Clock and Reset Unit
> +
> +The RK3568 clock controller generates and supplies clock to various
> +controllers within the SoC and also implements a reset controller for SoC
> +peripherals.
> +
> +Required Properties:
> +
> +- compatible: PMU for CRU should be "rockchip,rk3568-pmucru"
> +- compatible: CRU should be "rockchip,rk3568-cru"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +- #reset-cells: should be 1.
> +
> +Optional Properties:
> +
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +  If missing, pll rates are not changeable, due to the missing pll lock status.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume. All available clocks are defined as
> +preprocessor macros in the dt-bindings/clock/rk3568-cru.h headers and can be
> +used in device tree sources. Similar macros exist for the reset sources in
> +these files.
> +
> +External clocks:
> +
> +There are several clocks that are generated outside the SoC. It is expected
> +that they are defined using standard clock bindings with following
> +clock-output-names:
> + - "xin24m" - crystal input - required,
> + - "xin32k" - rtc clock - optional,
> + - "i2sx_mclkin" - external I2S clock - optional,
> + - "xin_osc0_usbphyx_g" - external USBPHY clock - optional,
> + - "xin_osc0_mipidsiphyx_g" - external MIPIDSIPHY clock - optional,
> +
> +Example: Clock controller node:
> +
> +	pmucru: clock-controller@fdd00000 {
> +		compatible = "rockchip,rK3568-pmucru";
> +		reg = <0x0 0xfdd00000 0x0 0x1000>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +	cru: clock-controller@fdd20000 {
> +		compatible = "rockchip,rK3568-cru";
> +		reg = <0x0 0xfdd20000 0x0 0x1000>;
> +		rockchip,grf = <&grf>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +Example: UART controller node that consumes the clock generated by the clock
> +  controller:
> +
> +	uart1: serial@fe650000 {
> +		compatible = "rockchip,rK3568-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xfe650000 0x0 0x100>;
> +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> +		clock-names = "baudclk", "apb_pclk";
> +	};
> 

