Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF33F2E42
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbhHTOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhHTOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:42:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E3C061756;
        Fri, 20 Aug 2021 07:41:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bt14so20738897ejb.3;
        Fri, 20 Aug 2021 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJFscCgcBFTLxpC7110pUXSQKuAyqr9YiU5cPNgkLRY=;
        b=PHs1V6/5TbGtl/MKEsu/3csKKfnoqF9GCmVV2zWsJRqVDFrausf+7VEbHkw81dPDQd
         r+OSc4sHzlm0shGTcElQhEfpYg2GA4jQw5JhrZzEdSDOXIw1WLplB4Zsf2d/GtLAtsrx
         Wk6+UUSC6HTjoq4Ur8U6FkgaW7jvmjTY3iyh9WVYdcteQ0vbEXq+hoXgtqBN3jXI1XNP
         f0rW1DnXLmYSvgYu5/w9uYKjEo5o8N1dnJqKMch+VZ7STZPBtOGf6UDtqJaIvaF/6ChG
         hQufFqf8WQwv4U2zKBbJaY0FgEl6wpWzEADYDLch9d0EgZ+GRAaXOTd8F2xpvoUcwkZG
         3wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJFscCgcBFTLxpC7110pUXSQKuAyqr9YiU5cPNgkLRY=;
        b=t/+LKhQIoxV0CLGnyh16zp5NyMR/Xq9vUET0TPMSw4bMcQMsniwm+ChWi6C1yiTF4j
         WJpoaf+idzhucdYOM09KlNevHmMvPGczhjCkY5wLcHx3XR/kE6CtIrj+LFZwYca0w8BD
         8JGuMFQoXeXTmMESU/hmsG74CigXANtGks/qCM4NPrEa+QarnTNUjeq3zWr2uQWcy14Q
         lzQlng8DhvqLunfYc5ZQX9DmDtUxXt3qwjQyqAHHuz/ufW2uM+1UBjdDzTZEIXfVHyRZ
         lpi4f/9szFfxCpPF+cFq3qrn07EiVrYZJrwho5pEG3RVVgf7BdXUzGThYzw+1DkHicUM
         8qWw==
X-Gm-Message-State: AOAM532NFcCSaBFW6fWaQy1eWjp/H4awFvOVeQuUc6PT90akjMHO/1c+
        kl7fNz8aW0WEOA4qVawEtoCoJgN5kainQKSG
X-Google-Smtp-Source: ABdhPJyBSABg1n6G0NysIs53gBRpj6qZ8LmORkIhGcyVpwNkvinR5Vptfj+Woq115GaynGnkh7Cdzg==
X-Received: by 2002:a17:906:7d0:: with SMTP id m16mr22423561ejc.105.1629470494603;
        Fri, 20 Aug 2021 07:41:34 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u9sm3690373edt.60.2021.08.20.07.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:41:34 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: rockchip: remove cap-mmc-highspeed property
 from mk808 &mmc0 node
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paweljarosz3691@gmail.com
References: <20210820131920.1831-1-jbx6244@gmail.com>
 <bf6cba99-da3b-a6fe-4e4b-f4ea6e3c6e63@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c52b4cf0-d018-f6b4-8728-41551b8bf62b@gmail.com>
Date:   Fri, 20 Aug 2021 16:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bf6cba99-da3b-a6fe-4e4b-f4ea6e3c6e63@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 4:17 PM, Robin Murphy wrote:
> On 2021-08-20 14:19, Johan Jonker wrote:
>> On the MK808 only a microSD slot is connected with the SDMMC Host
>> Controller,
>> so remove the cap-mmc-highspeed property from the &mmc0 node.
> 
> Why, does it do any harm? 

Harm not. Example rk3066 u-boot:

>>>>sd_select_mode_and_width
sd card: widths [4, 1, ] modes [MMC legacy, SD High Speed (50MHz), UHS
SDR12 (25MHz), UHS SDR25 (50MHz), ]
host: widths [4, 1, ] modes [MMC legacy, MMC High Speed (26MHz), SD
High Speed (50MHz), MMC High Speed (52MHz), ]
trying mode SD High Speed (50MHz) width 4 (at 50 MHz)

I would say only advertise host capabilities that are under normal
circumstances occur. How realistic is it to use a TF/Micro SD TO SD Card
Extension Cable Adapter (giggle) for a deprecated mmc card?

Johan

It's perfectly possible to connect a
> full-sized card to a microSD slot with an adapter. I came across my old
> SDIO WiFi card a while back and tried it that way for a giggle, but
> unfortunately it turned out not to be a chipset supported by any
> upstream driver.
> 
> Robin.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   arch/arm/boot/dts/rk3066a-mk808.dts | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts
>> b/arch/arm/boot/dts/rk3066a-mk808.dts
>> index 9790bc63b..b67f5cb51 100644
>> --- a/arch/arm/boot/dts/rk3066a-mk808.dts
>> +++ b/arch/arm/boot/dts/rk3066a-mk808.dts
>> @@ -123,7 +123,6 @@
>>     &mmc0 {
>>       bus-width = <4>;
>> -    cap-mmc-highspeed;
>>       cap-sd-highspeed;
>>       vmmc-supply = <&vcc_sd>;
>>       status = "okay";
>>
