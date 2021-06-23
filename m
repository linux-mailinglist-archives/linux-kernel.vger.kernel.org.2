Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD13B1B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFWNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhFWNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:55:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311ECC061574;
        Wed, 23 Jun 2021 06:53:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso3273031wmc.1;
        Wed, 23 Jun 2021 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pKJo2zfQJAto+H7on6ydNnW2a5qzcSImZ5tu6Hz8SPs=;
        b=Ax5amtes4QHAh5hFHrs1nlkfPyuUGwzzAv1QPZ+CsoH50Xgyw/7JKR+P+GtUWWaSgA
         LiGgeYD93qjaZ9qlcD8BQYq3AbD/B6XtbKuu+CLCzjyKzUbz5/GGDF/zoXXSwVVOGF1y
         UnJBK3s0JXaeEYup+j5MgnOxc5tg5IJ0VSPPiiXkxll3ptUcEABrWbKu+trMyHnvn5SI
         7aqoE23wqwLp8KgTj4uV3ib+W7KRpVMDmKZeM95amRPuVRWF/NBuQDLqFYnaiJUq5dEu
         N3DNyMno4cj84YUSDj7vdOMlIswvYpmHq6E/6umWyWlzBabP5RLPpcbiwu3SEVLCwLp3
         IWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pKJo2zfQJAto+H7on6ydNnW2a5qzcSImZ5tu6Hz8SPs=;
        b=mL4khqoFTMlQNOd6iLQYKaLlnXebrZJ7IVakhO4WeeAuEYtMBjnJKbKwJmq2x+1k18
         gTmrCcK0kzzTzZ37mPPbJ7uzoBQw817HbZe2Z//+tQm0Y0Ng+Aau22rmynW6ZDqMrOgg
         47D9qMUk4mP4g646UK+NgAUtI5wxtaRFiBf5TUipkhLHAWPlVsYEy/aXiqTFVfo+bNIG
         uVqPGIPv4U/harUQZYdCUg5cB+AGawiGtbyxr60GhUo0bgWx4lEp4S77MaqNuW0ptZtE
         DtRbL5Da614ojlANlSgxS38A7v4ojGFPUnTG6q32agnaG3XbYJwTfSswLg9gqUq6mj1a
         DWJw==
X-Gm-Message-State: AOAM530ocVy48go1N3foKkHogpwMZ85vS+KPc5wrpqp71IHWBdO5yMr9
        yd8Y9tEaBjnkaBiImDV3/A8CjfWLR6oc
X-Google-Smtp-Source: ABdhPJx6MegljGgLzjeJ/OV84M5roMM/v+iHCm4FMq3beu+lQ7zyxaZd9zVURsttRoq10p/dwncWrQ==
X-Received: by 2002:a05:600c:ada:: with SMTP id c26mr11165067wmr.189.1624456399786;
        Wed, 23 Jun 2021 06:53:19 -0700 (PDT)
Received: from [192.168.200.247] (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.gmail.com with ESMTPSA id t82sm36707wmf.22.2021.06.23.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:53:19 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210623120001.164920-1-knaerzche@gmail.com>
 <c30377a1-90aa-d79e-a60a-5bc1a8e18c44@gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <b534795a-fc1d-3e89-7ea9-0606297cd9b1@gmail.com>
Date:   Wed, 23 Jun 2021 15:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c30377a1-90aa-d79e-a60a-5bc1a8e18c44@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am 23.06.21 um 14:53 schrieb Johan Jonker:
> Hi Alex,
>
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>
> On 6/23/21 2:00 PM, Alex Bee wrote:
>> RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
>> boards have sdio wifi connected to it. In order to use it
>> one would have to add the pinctrls from sdmmc0ext group which
>> is done on board level.
>>
>> While at that also add the reset controls for the other mmc
>> controllers.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index da84be6f4715..c13fa2f3f4cd 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -858,6 +858,8 @@ sdmmc: mmc@ff500000 {
>>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>   		fifo-depth = <0x100>;
>>   		max-frequency = <150000000>;
>> +		resets = <&cru SRST_MMC0>;
>> +		reset-names = "reset";
>>   		status = "disabled";
>>   	};
>>   
>> @@ -870,6 +872,8 @@ sdio: mmc@ff510000 {
>>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>   		fifo-depth = <0x100>;
>>   		max-frequency = <150000000>;
>> +		resets = <&cru SRST_SDIO>;
>> +		reset-names = "reset";
>>   		status = "disabled";
>>   	};
>>   
>> @@ -882,6 +886,8 @@ emmc: mmc@ff520000 {
>>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>   		fifo-depth = <0x100>;
>>   		max-frequency = <150000000>;
>> +		resets = <&cru SRST_EMMC>;
>> +		reset-names = "reset";
>>   		status = "disabled";
>>   	};
>>   
>> @@ -980,6 +986,20 @@ usb_host0_ohci: usb@ff5d0000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	sdmmc_ext: dwmmc@ff5f0000 {
> /arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: dwmmc@ff5f0000:
> $nodename:0: 'dwmmc@ff5f0000' does not match '^mmc(@.*)?$'

Argh: I submitted the pre-dtbs_check version. Thanks for checking.

Alex.

>> +		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
>> +		reg = <0x0 0xff5f0000 0x0 0x4000>;
>> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_SDMMC_EXT>, <&cru SCLK_SDMMC_EXT>,
>> +			 <&cru SCLK_SDMMC_EXT_DRV>, <&cru SCLK_SDMMC_EXT_SAMPLE>;
>> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> +		fifo-depth = <0x100>;
>> +		max-frequency = <150000000>;
>> +		resets = <&cru SRST_SDMMCEXT>;
>> +		reset-names = "reset";
>> +		status = "disabled";
>> +	};
>> +
>>   	usbdrd3: usb@ff600000 {
>>   		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
>>   		reg = <0x0 0xff600000 0x0 0x100000>;
>>
