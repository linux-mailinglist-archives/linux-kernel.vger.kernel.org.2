Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACDD3AD02F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhFRQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbhFRQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:17:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80850C0617A8;
        Fri, 18 Jun 2021 09:14:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e22so7776034wrc.1;
        Fri, 18 Jun 2021 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sJ6tmXCDWjYjTczKpyWz/c7MXBSmbvzpLSbj8oATx1Q=;
        b=bzfqVe75gKphpiq2mBVpRUpqbWAfNiGGhYiKv5KnyMBkGwdeRYT2HRmSIgt1eazns8
         x185YYf5Bi4dJW5Dj6VQk0m9RiQKxqNJT26JeeJqUqNxgUJ0/R7X6J3y3SAv7Beh1UaM
         R7S3EjGfqLAqWstc2RBaKjRF666GRtuA/W6pNCvgsvP2Xm5jkKwDzbLFuGeMCUb+VB7l
         vpN5DK9ilJs+L6uQ88Ma7RHwFd/K49zAnfdb3lIkxwp1lYG/ZeM01blEPOKkpwdtltlU
         3UJGg9oa7dNdPa7pklG7IeZlXaUAqACPHwPbQjk51YtRynr11vB4c+b/Rw+k/ElBTp8V
         okVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sJ6tmXCDWjYjTczKpyWz/c7MXBSmbvzpLSbj8oATx1Q=;
        b=G7dNo6aXSQtUXWE1X3Bja+3PueSvxaQbwtwYPOgKrN2kyG/S0nUaohVGLSol9NMPsp
         G5yegsR/c1Go3Z464HVlNHAQA2GoaBjcCxSFm+kZidRX8KJ9vFtuX1+CaIHun9vLchVl
         CjvrGn7RNsdiZ40ecNkLyxoDaCeud/nsxZN/CueAW06ExieDlQLrjm4MVXTpeX8n23KM
         x4ze5LaavNfuoENSpmYS5kfIJCHb4NfqEiAHuJxoaZr8iiJorn/cM8Wb3kcGsPd/q5Ur
         7nvU97xTvirmITCchQUwDB7bybmbcYPRpGKPBQVcUewGY3YIJdbk8W5JNQ0gwwn8NrVt
         y6ig==
X-Gm-Message-State: AOAM532iZOYyTuhFKlSTVIzw3t0TIBI9kd4jWfl28wQGFjydPUm9yXYB
        UTATUGfdvjnDqYPKipgDEg==
X-Google-Smtp-Source: ABdhPJzyRQ3tfsoH1rSyh/EmkjzS6/pApI0k24VzPoJ3O+CU+eYsyrsdp2T0S+bhgTosH5J7ozEfcg==
X-Received: by 2002:adf:ea49:: with SMTP id j9mr13474888wrn.366.1624032886125;
        Fri, 18 Jun 2021 09:14:46 -0700 (PDT)
Received: from [192.168.200.247] (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.gmail.com with ESMTPSA id w18sm9053618wrt.55.2021.06.18.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 09:14:45 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add ES8316 codec for Rock Pi4
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210617044955.598994-1-knaerzche@gmail.com>
 <d562b025-23cc-f26d-b118-e269501f459b@gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <d4e4e06e-6ddd-4707-232d-b829c1d646e6@gmail.com>
Date:   Fri, 18 Jun 2021 18:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d562b025-23cc-f26d-b118-e269501f459b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am 18.06.21 um 11:54 schrieb Johan Jonker:
> Hi Alex,
>
> On 6/17/21 6:49 AM, Alex Bee wrote:
>> Rock Pi4 boards have the codec connected to i2s0 and it is accessible
>> via i2c1 address 0x11.
>> Add an audio-graph-card it.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> index 7d0a7c697703..e5c1083174ff 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> @@ -36,6 +36,12 @@ sdio_pwrseq: sdio-pwrseq {
>>   		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>>   	};
>>   
>> +	sound {
>> +		compatible = "audio-graph-card";
>> +		label = "rockchip,rk3399";
> See previous discussion:
>
> https://lore.kernel.org/linux-rockchip/e5ab2c62-ad00-4cdf-8b0a-24fda59c980b@gmail.com/
>
> It seems that aplay/linux? adds "-1" to it and removes the comma and
> "-", so we get:
>
> hdmisound
> rockchiprk3399
> rockchiprk339_1
>
> Shouldn't we label it with something that reflect the function/output.
> Shouldn't we standardize to SPDIF, HDMI and Analog similar to rk3318/rk3328?
> Make a shorter label without spaces or special chars, so that chars
> don't get removed?
>
> Proposal:
>
> Analog
> HDMI
> ES8316 <---
> SPDIF

OK - thanks for that, I wasn't aware.

I'll go for "Analog", since that seems to be the accepted solution for 
RockPro64 board and I think we should keep it the same across boards (on 
distro side it can get annoying if you need a couple of alsa configs 
with the same contents, just because audio card names are different).

Alex.

>
>
> Possible example solutions:
>
> [PATCH] arm64: dts: rockchip: more user friendly name of sound nodes
> https://lore.kernel.org/lkml/20210110151913.3615326-1-katsuhiro@katsuster.net/
>
> ===
>
> Johan
>
>> +		dais = <&i2s0_p0>;
>> +	};
>> +
>>   	vcc12v_dcin: dc-12v {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vcc12v_dcin";
>> @@ -422,6 +428,20 @@ &i2c1 {
>>   	i2c-scl-rising-time-ns = <300>;
>>   	i2c-scl-falling-time-ns = <15>;
>>   	status = "okay";
>> +
>> +	es8316: codec@11 {
>> +		compatible = "everest,es8316";
>> +		reg = <0x11>;
>> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
>> +		clock-names = "mclk";
>> +		#sound-dai-cells = <0>;
>> +
>> +		port {
>> +			es8316_p0_0: endpoint {
>> +				remote-endpoint = <&i2s0_p0_0>;
>> +			};
>> +		};
>> +	};
>>   };
>>   
>>   &i2c3 {
>> @@ -441,6 +461,14 @@ &i2s0 {
>>   	rockchip,capture-channels = <2>;
>>   	rockchip,playback-channels = <2>;
>>   	status = "okay";
>> +
>> +	i2s0_p0: port {
>> +		i2s0_p0_0: endpoint {
>> +			dai-format = "i2s";
>> +			mclk-fs = <256>;
>> +			remote-endpoint = <&es8316_p0_0>;
>> +		};
>> +	};
>>   };
>>   
>>   &i2s1 {
>>
