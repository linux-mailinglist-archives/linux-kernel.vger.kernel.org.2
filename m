Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0343B40A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFYJiR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Jun 2021 05:38:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34251 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFYJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:38:16 -0400
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 340181BF208;
        Fri, 25 Jun 2021 09:35:52 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:35:50 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-sr-som: Increase the PHY reset
 duration to 10ms
Message-ID: <20210625113550.7a135e69@bootlin.com>
In-Reply-To: <20210625083840.GS22278@shell.armlinux.org.uk>
References: <20210625083051.3691737-1-maxime.chevallier@bootlin.com>
        <20210625083840.GS22278@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, 25 Jun 2021 09:38:40 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

>On Fri, Jun 25, 2021 at 10:30:51AM +0200, Maxime Chevallier wrote:
>> The datasheet for the AR803x PHY present on this SoM recommends that the
>> reset line is asserted low for 10ms, so that the PHY has time to
>> properly reset the internal blocks.
>> 
>> The previous value of 2ms was found to be problematic on some setups,
>> causing intermittent issues where the PHY would be unresponsive
>> every once in a while on some sytems, with a low occurence (it typically
>> took around 30 consecutive reboots to encounter the issue).
>> 
>> Bumping the delay to the 10ms recommended value makes the issue
>> dissapear, with more than 2500 consecutive reboots performed without the
>> issue showing-up.  
>
>This isn't actually what the datasheet says, which is:
>
>  Input clock including the crystal and external input clock should be
>  stable for at least 1ms before RESET can be deasserted.
>
>  When using crystal, the clock is generated internally after power is
>  stable. For a reliable power on reset, suggest to keep asserting the
>  reset low long enough (10ms) to ensure the clock is stable and
>  clock-to-reset 1ms requirement is satisfied.
>
>The 10ms duration you quote is the _power on reset_ duration, and in
>those circumstances, there is a delay before the required clocks will
>be stable.
>
>This is not a power on reset scenario - the power was applied long ago
>by the time the kernel starts booting, and XI clock would have been
>running.
>
>So, I think the commit message which seems to be claiming that the reset
>line always needs to be asserted for 10ms is not entirely accurate.

You're correct, indeed, I guess we read that a bit too fast.

However, we do see that bumping the reset duration fixes the issue that
was encountered.

To give you more details about this issue, in that scenario the PHY
would fail the autoneg process, no matter how many times we
enable/disable the link and restart autoneg.

The low duration of the reset might put the internal blocks in an
unknown state, but I don't actually have the real hardware-side
explanation for what is actually happening.

Further testing showed, for example, that decreasing the time of reset
assertion to 1ms made the issue appear everytime, whereas bumping it to
10 ms fixed it entirely.

In the absence of any other indication about how long should that reset
be asserted, and after thourough testing, 10ms seems like a good enough
value.

I'll send a V2 with the commit log fixed.

Thanks for the quick review,

Maxime

>> 
>> Fixes: 208d7baf8085 ("ARM: imx: initial SolidRun HummingBoard support")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> Tested-by: Hervé Codina <herve.codina@bootlin.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
>> index 0ad8ccde0cf8..a54dafce025b 100644
>> --- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
>> @@ -54,7 +54,7 @@ &fec {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
>>  	phy-mode = "rgmii-id";
>> -	phy-reset-duration = <2>;
>> +	phy-reset-duration = <10>;
>>  	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>>  	status = "okay";
>>  
>> -- 
>> 2.25.4
>> 
>>   
>



-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
