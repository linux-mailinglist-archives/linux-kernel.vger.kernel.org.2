Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E882B414ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhIVNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhIVNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:42:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43489C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:40:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT2UI-0004uK-1E; Wed, 22 Sep 2021 15:40:38 +0200
Subject: Re: [PATCH] arm64: dts: rockchip: move aliases to rk356x dtsi
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20210917110528.24454-1-michael.riesch@wolfvision.net>
 <2397289.mVTDCA6dLn@diego>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <ce3f2ece-4c30-ad01-fd51-8a3e46297234@pengutronix.de>
Date:   Wed, 22 Sep 2021 15:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2397289.mVTDCA6dLn@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 17.09.21 14:01, Heiko Stübner wrote:
> Hi Michael,
> 
> Am Freitag, 17. September 2021, 13:05:28 CEST schrieb Michael Riesch:
>> In order to ensure deterministic probe order over different boards,
>> move the aliases of on-SoC components to the corresponding dtsi
>> files.
> 
> please read the git history on the other Rockchip SoCs. We just moved
> the aliases on them _to_ the board-files, as requested by
> arm-soc maintainers ;-)

[Adding Arnd to CC]

For old boards, changing the aliases may introduce breakage that outweighs
the benefit of having consistent numbering. This doesn't seem to apply here:
rk3566.dtsi is a new device tree not yet in v5.15-rc2 and rk3568 is new in
v5.14 and has only one board partially supported, so if we were to do this
change we should do it now. Boards will still be free to override the aliases,
but those that don't will have consistent numbering regardless of whether
nodes are enabled, cards are detected or probe order.


Cheers,
Ahmad

> 
> 
> Heiko
> 
> 
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 ------
>>  arch/arm64/boot/dts/rockchip/rk3566.dtsi           | 4 ++++
>>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   | 7 -------
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi           | 5 +++++
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi           | 2 ++
>>  5 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> index a244f7b87e38..156bbb8aa4c4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> @@ -10,12 +10,6 @@
>>  	model = "Pine64 RK3566 Quartz64-A Board";
>>  	compatible = "pine64,quartz64-a", "rockchip,rk3566";
>>  
>> -	aliases {
>> -		ethernet0 = &gmac1;
>> -		mmc0 = &sdmmc0;
>> -		mmc1 = &sdhci;
>> -	};
>> -
>>  	chosen: chosen {
>>  		stdout-path = "serial2:1500000n8";
>>  	};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> index 3839eef5e4f7..c1b3841caa77 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> @@ -4,6 +4,10 @@
>>  
>>  / {
>>  	compatible = "rockchip,rk3566";
>> +
>> +	aliases {
>> +		ethernet0 = &gmac1;
>> +	};
>>  };
>>  
>>  &power {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> index 184e2aa2416a..218f85af730c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> @@ -13,13 +13,6 @@
>>  	model = "Rockchip RK3568 EVB1 DDR4 V10 Board";
>>  	compatible = "rockchip,rk3568-evb1-v10", "rockchip,rk3568";
>>  
>> -	aliases {
>> -		ethernet0 = &gmac0;
>> -		ethernet1 = &gmac1;
>> -		mmc0 = &sdmmc0;
>> -		mmc1 = &sdhci;
>> -	};
>> -
>>  	chosen: chosen {
>>  		stdout-path = "serial2:1500000n8";
>>  	};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 2fd313a295f8..dd0e800cf752 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -8,6 +8,11 @@
>>  / {
>>  	compatible = "rockchip,rk3568";
>>  
>> +	aliases {
>> +		ethernet0 = &gmac0;
>> +		ethernet1 = &gmac1;
>> +	};
>> +
>>  	qos_pcie3x1: qos@fe190080 {
>>  		compatible = "rockchip,rk3568-qos", "syscon";
>>  		reg = <0x0 0xfe190080 0x0 0x20>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index e42fbac6147b..bb0540d3008c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -29,6 +29,8 @@
>>  		i2c3 = &i2c3;
>>  		i2c4 = &i2c4;
>>  		i2c5 = &i2c5;
>> +		mmc0 = &sdmmc0;
>> +		mmc1 = &sdhci;
>>  		serial0 = &uart0;
>>  		serial1 = &uart1;
>>  		serial2 = &uart2;
>>
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
