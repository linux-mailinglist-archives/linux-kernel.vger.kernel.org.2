Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B994113E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhITMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhITMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:03:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5665C061574;
        Mon, 20 Sep 2021 05:01:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so28912404wrr.9;
        Mon, 20 Sep 2021 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/ne40pWRrx2CrzneTyBnCtWRrTGbYgrZIHpswHWcqFg=;
        b=XQUOGT4c82LgLfAKQHMnG83GjfBn5NbeBgTZySjeCqPbRi/oPAEoMSZRRLjag6+hTP
         KV6WTUmbgmxWt3zAO7q1YlAud6ZMu8v0ORNJs5Tbd06ExzfdJCqDQ6XxmPBULWEHvKzc
         0b/QMImOjgmeJhBce1X3IDuPxmAGmjsI91Lrrzo0wgnuwqoEMvREmRKk8Hx0N/k9Lgsk
         ypY16GdBGxl3w/CHqtp4+wAVDOWyJCmowywK9hOyJYQtpTfibBFKgnasY8MaRgjwITwh
         pBn5kMGtDUqArcXygEp9xAvjxovdzHLqsFogf2Rf8uvGhqDDG51uWbzZRBaNxJx/nyX1
         K+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ne40pWRrx2CrzneTyBnCtWRrTGbYgrZIHpswHWcqFg=;
        b=xjy2zXw9iONUkJFIBsDYR3s+M8Jy5iPOMzd7ZxZVkCke5A0QYZqwtPHn9lpSlwP/N1
         8xyRac2QoRQs5jwlTKZT2GpJTDNj5Vnd6ucH9AMAEZSA4lo2za/yDAJOEyUw+MNYEPUa
         L+CzS2H1cgoIOfu2muOsB/WhDCY/6xsITJ0l7++RuSaIxowG4MculCOUjimXWTqygmA4
         Q4PIymtwZkeXoN7+WXr1rnQ1G+LLisr8KXxme4YsON/waC729FEjBIc4oSmlFvA2Py8j
         kSMrHatVowQ7dkB2U0bC4mVbfDJ5RIzTG7b/aXM1pwAqz/qzG7ahxE0UAcOp1qgMdG4u
         sX9g==
X-Gm-Message-State: AOAM5331vPLhfoKEhkQBbPfLVUwHSVTsH8wKEAcUs1bm/4WTLKYZgn21
        pI6FwyL0DCvV393ndlEB9iWpR8OlB5o=
X-Google-Smtp-Source: ABdhPJx69lUhsTXiVkcOUNtmVmoOBPXkrL/CXP1uxgR/bzPlKPCqAwWnBQwLvpTAC3aOmkWxW87b3g==
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr29133387wmp.74.1632139303375;
        Mon, 20 Sep 2021 05:01:43 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id h8sm18589623wmb.35.2021.09.20.05.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:01:42 -0700 (PDT)
Message-ID: <fe15479d-7500-a48e-8658-936eca0fc099@gmail.com>
Date:   Mon, 20 Sep 2021 14:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Content-Language: en-US
To:     Sungbo Eo <mans0n@gorani.run>, linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210822041333.5264-1-mans0n@gorani.run>
 <20210830155903.13907-1-mans0n@gorani.run>
 <20210830155903.13907-2-mans0n@gorani.run>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210830155903.13907-2-mans0n@gorani.run>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2021 17:59, Sungbo Eo wrote:
> MT7623 has an musb controller that is compatible with the one from MT2701.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>

Applied to v5.15-next/dts32

Thanks

> ---
> v4:
> * add tested by Frank
> 
> v3:
> * remove unnecessary status=okay from u2port2
> 
> v2:
> * rename usb3 label to usb0
> * move usb0 & u2phy1 nodes to the right sorted place
> * disable u2phy1 by default
> * correct u2port2 node name to match its reg address
> ---
>   arch/arm/boot/dts/mt7623.dtsi  | 33 +++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 3c11f7cfcc40..21c8a291b74e 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -585,6 +585,39 @@ spi2: spi@11017000 {
>   		status = "disabled";
>   	};
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
> +		};
> +	};
> +
>   	audsys: clock-controller@11220000 {
>   		compatible = "mediatek,mt7623-audsys",
>   			     "mediatek,mt2701-audsys",
> diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
> index 0735a1fb8ad9..d304b62d24b5 100644
> --- a/arch/arm/boot/dts/mt7623a.dtsi
> +++ b/arch/arm/boot/dts/mt7623a.dtsi
> @@ -35,6 +35,10 @@ &scpsys {
>   	clock-names = "ethif";
>   };
>   
> +&usb0 {
> +	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
> +};
> +
>   &usb1 {
>   	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
>   };
> 
