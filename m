Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441094113EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhITMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbhITMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:03:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4BC061574;
        Mon, 20 Sep 2021 05:01:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so27185840wrg.5;
        Mon, 20 Sep 2021 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yps8bt2FBtfainwuMRQ1I6tWL0WG1SqRqPwtRgGpER4=;
        b=JDe7MHo0RI1UpNcpZf39X/27jmaP/aMAWtvE1/dDVxxn/oJ2gAgGx9A1qpGhMmhV79
         YN70g/+yWW/BtVo85C+RKq51xkDfDSh4wrGzD2DWXZJja7B0G+Mc5AflUCt+aUazZ4Wl
         a4BfwIdshkv9AImT0hPCUuaUNag85WDXUg34Sv1tXoiwCDAYAzGKnS2SbilLeu97YftR
         MgPKzyMuDg2AzYBdTBh+rqiBlmGHcqTc6jCIxLmrxae395a3cmGGchcQ5KO87enlREHW
         zGzfeLhkOw3M67J9yRQAuHFPBYcTJDgyimash9t0fm53QuFdQrSOev4VylpYuC67tkQK
         NUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yps8bt2FBtfainwuMRQ1I6tWL0WG1SqRqPwtRgGpER4=;
        b=mjaCo+jJoyZf3j1rdyTZWD0xBspFuDL6uv6kLgyFCGZ0AtovXbItKjWhmrN+PXjHoM
         TcM2nOBzXKJE7+fzISJyT9bIeFbzXbrP/o53yuBoM33yvkoudyu0cKSOcha5DiqMba82
         +HNzhTuwLReCw9+eLM7iklW2cDJ2sdFYvP2IL9PSDMeaDI1bsVCiFzOH8co9DhrjkBh8
         DHZ2oStvbO4FsK88iHCBs8idJ+mxvkCqTsAcDjdg9FOhnK3rB7btx8Lz/qrla23oh8OI
         mLYq6JpxP8clM/iD35jTa7vOX2FWylT37DxhZ8v/GGJGgKBs3vSlymDb3R+NiJXNTOmk
         LX5A==
X-Gm-Message-State: AOAM533K62YqANuExI1QlN9I+Bl0YUw+x7fE8OU1UTHayNq405/lHxJs
        WE5DsO5IB98/ar/58IF+E9I=
X-Google-Smtp-Source: ABdhPJyx3C28Wosr1fZfE90gYcZrE47TW0kXFU7wZa3TCVGEDUsYZ4KwRuT0cjqIUbwKpXSJGF73ow==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr28494785wrq.37.1632139306631;
        Mon, 20 Sep 2021 05:01:46 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id c30sm15963916wrb.74.2021.09.20.05.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:01:46 -0700 (PDT)
Message-ID: <a55fca55-78d3-554a-4ad0-f555beac3fa8@gmail.com>
Date:   Mon, 20 Sep 2021 14:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2] arm: dts: mt7623: add otg nodes for bpi-r2
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210830145958.108605-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210830145958.108605-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2021 16:59, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add OTG-Nodes for BananaPi-R2
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied to v5.15-next/dts32

Thanks

> ---
> patch is based on
> 
> "arm: dts: mt7623: add musb device nodes"
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210822041333.5264-2-mans0n@gorani.run/
> ---
> v2:
> 	rebase on plain 5.14, v1 was based on some not upstreamed work
> ---
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index e96aa0ed1ebd..027c1b0c6a98 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -366,6 +366,14 @@ &pcie1_phy {
>   	status = "okay";
>   };
>   
> +&pio {
> +	musb_pins: musb {
> +		pins-musb {
> +			pinmux = <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VBUS>;
> +		};
> +	};
> +};
> +
>   &pwm {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pwm_pins_a>;
> @@ -396,6 +404,19 @@ &uart2 {
>   	status = "okay";
>   };
>   
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&musb_pins>;
> +	status = "okay";
> +	usb-role-switch;
> +
> +	connector {
> +		compatible = "gpio-usb-b-connector", "usb-b-connector";
> +		type = "micro";
> +		id-gpios = <&pio 44 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
>   &usb1 {
>   	vusb33-supply = <&reg_3p3v>;
>   	vbus-supply = <&reg_5v>;
> @@ -408,6 +429,10 @@ &usb2 {
>   	status = "okay";
>   };
>   
> +&u2phy1 {
> +	status = "okay";
> +};
> +
>   &u3phy1 {
>   	status = "okay";
>   };
> 
