Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297093AD06B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhFRQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhFRQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:32:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7ADC061574;
        Fri, 18 Jun 2021 09:30:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so6166463wmf.0;
        Fri, 18 Jun 2021 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l9rirGTX9IKkD9bpHXZHalsVI51vG9jgV3KWdghVMEw=;
        b=kfdepGu517XhNkOHjQLDoHqOKJRZRJLi6aQLe0B0vz1ZrehFoPBcKilWIjKQGRxhzu
         GrHN0rSqh+yzWgNZyeBTVs0SjeA508kM7rFJh+riQ6gTXsMYKCQU/VmnRbc24UHS9xiE
         P+Crk97KjZve0b8MKnUEwPmi8OoBDuY+SQjAvC/61nyatMxYOXYavpo5+P7bKl28PIDv
         69TctXGe9nPkXd0Art5wZvwic6UKMz9NSBkPs8GihQ70WrbwMmSrTfH4vAyj1N2yEyyA
         LHBPOLRKEOpb/Tgdp2QSdB29jo71EomWH8+aGUDH7UBCdkdj7mo2Ko548+PT25uSgeQu
         sGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l9rirGTX9IKkD9bpHXZHalsVI51vG9jgV3KWdghVMEw=;
        b=kqbQIKudEsdVcaWvPGT2tP/5wkP2kOvPRvGmM23spBj4gf5+UURF4AvtO40q7v5HOc
         ox9JN95Y6koiYMA2PmlNgGB01gpaDorymHZjZz78n+u/eOVQmFrMnXRoDSDpDN6uDxlI
         Dt5GZ3Fiwngjcjy7k0WaXYtV+KFQ7ZsFA0WaiTRWqCkCAg6qsaRavzTIkJNEqExxmr9o
         TT/HwIn8zgIWkMNKXmcjVawt/Qe60BY7RgPLHfUzViZqK7Bb0k7xR7OweKXqwPpjT26E
         xSIxDowiXW6U7OvYsPcIN5PdXP0uGhkbGXGkr1nMSL2FJtw26d5MWxv22VtW1OIuBKuf
         SpJw==
X-Gm-Message-State: AOAM531u5cgaATY8CDSxe5Iz05ZhoSTA15nObhQxUtrwKverz5y2V7pE
        o1VNPtE+x2TBgCCzUdHWRA==
X-Google-Smtp-Source: ABdhPJyH/jfmzkG+Bu55AqXkxDs9qM0nYbBphoXS6Ff83BHpbC3sFi1TCxb1evEQ1Ul0PgG4r8YebA==
X-Received: by 2002:a05:600c:3ba0:: with SMTP id n32mr12483723wms.107.1624033811784;
        Fri, 18 Jun 2021 09:30:11 -0700 (PDT)
Received: from [192.168.200.247] (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.gmail.com with ESMTPSA id a24sm7871081wmj.30.2021.06.18.09.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 09:30:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add RK3399 Rock Pi 4a plus
 board
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210617044955.598994-1-knaerzche@gmail.com>
 <20210617044955.598994-2-knaerzche@gmail.com> <4545451.QWXsJ6tzlI@diego>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <d88df311-9ec5-9552-7b12-2db88b99b434@gmail.com>
Date:   Fri, 18 Jun 2021 18:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4545451.QWXsJ6tzlI@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 18.06.21 um 15:08 schrieb Heiko Stübner:
> Am Donnerstag, 17. Juni 2021, 06:49:54 CEST schrieb Alex Bee:
>> Rock Pi 4a plus board is the successor of Rock Pi 4a board.
>>
>> Differences to the original version are
>> - has RK3399 OP1 SoC revision
>> - has eMMC (16 or 32 GB) soldered on board (no changes required,
>>    since it is enabled in rk3399-rock-pi-4.dtsi)
>> - dev boards have SPI flash soldered, but as per manufacturer response,
>>    this won't be the case for mass production boards
>>
>> I didn't add yet another compatible, since the small set of differences
>> are captured by the device tree.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile              |  1 +
>>   .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts   | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index c3e00c0e2db7..dbd7d37950f1 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
>> new file mode 100644
>> index 000000000000..2deaab7f9307
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
>> + * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include "rk3399-rock-pi-4.dtsi"
>> +#include "rk3399-op1-opp.dtsi"
>> +
>> +/ {
>> +	model = "Radxa ROCK Pi 4A plus";
>> +	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
> hmm, I don't really follow why you're re-using the radxa,rockpi4a
> compatible. I'd assume this should be radxa,rockpi4a+ or something?

Ah, yes this was part of my cover letter, which obviously got lost 
somewhere.

Anyways: Reason I thought of was: For example broadcom nvram file names 
must match the compatible string and they have to be copied/symlinked 
over and over if we add new compatibles for every minor changed revision 
of a board. I guess there are more examples for that in userland.

>
> I.e. if a bootloader needs to select the matching devicetree from a list
> of available devicetrees, this could end up running a regular rockpi4a
> (without +) using the OP1 operating points and thus at way too high
> frequencies.

Besides I wasn't aware, that "a bootloader" can do that already I 
understand your concerns and will change it.

Alex.

>
> Heiko
>
>
>> +};
>>
>
>
>
