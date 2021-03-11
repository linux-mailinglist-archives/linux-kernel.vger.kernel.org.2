Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5FE3375F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhCKOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCKOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:41:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4170C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:41:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lKMV0-0001gR-ML; Thu, 11 Mar 2021 15:41:14 +0100
Subject: Re: [Linux-stm32] [PATCH v2 00/14] Introduce STM32MP1 RCC in secured
 mode
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne CARRIERE <etienne.carriere@st.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <2e04f814-b694-119d-fe8a-13e6df129536@gmail.com>
 <AS8PR10MB4712C27260707345FA99ED5AEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
 <c57775fe-41ef-07f5-56a2-04b8f70797c1@denx.de>
 <463dafed-ec60-cd9a-33d2-ba118a6af629@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <c1c9c89b-8794-9b91-b626-d743cd8ff31e@pengutronix.de>
Date:   Thu, 11 Mar 2021 15:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <463dafed-ec60-cd9a-33d2-ba118a6af629@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11.03.21 15:02, Alexandre TORGUE wrote:
> On 3/11/21 12:43 PM, Marek Vasut wrote:
>> On 3/11/21 9:08 AM, Alexandre TORGUE wrote:
>>> 1- Break the current ABI: as soon as those patches are merged, stm32mp157c-dk2.dtb will impose to use
>>> A tf-a for scmi clocks. For people using u-boot spl, the will have to create their own "no-secure" devicetree.
>>
>> NAK, this breaks existing boards and existing setups, e.g. DK2 that does not use ATF.
>>
>>> 2-As you suggest, create a new "secure" dtb per boards (Not my wish for maintenance perspectives).
>>
>> I agree with Alex (G) that the "secure" option should be opt-in.
>> That way existing setups remain working and no extra requirements are imposed on MP1 users. Esp. since as far as I understand this, the "secure" part isn't really about security, but rather about moving clock configuration from Linux to some firmware blob.
>>
>>> 3- Keep kernel device tree as they are and applied this secure layer (scmi clocks phandle) thanks to dtbo in
>>> U-boot.
>>
>> Is this really better than
>> #include "stm32mp15xx-enable-secure-stuff.dtsi"
>> in a board DT ? Because that is how I imagine the opt-in "secure" option could work.
>>
> 
> Discussing with Patrick about u-boot, we could use dtbo application thanks to extlinux.conf. BUT it it will not prevent other case (i.e. TF-A which jump directly in kernel@). So the "least worst" solution is to create a new "stm32mp1257c-scmi-dk2 board which will overload clock entries with a scmi phandle (as proposed by Alex).

I raised this issue before with your colleagues. I still believe the correct way
would be for the TF-A to pass down either a device tree or an overlay with the
actual settings in use, e.g.:

  - Clocks/Resets done via SCMI
  - Reserved memory regions

If TF-A directly boots Linux, it can apply the overlay itself, otherwise it's
passed down to SSBL that applies it before booting Linux.

Cheers,
Ahmad

> 
> Gabriel, can you wait a bit before sending something about SCMI in dtsi, I would like to align this strategy internally.
> 
> Marek, Alex: thanks for your inputs.
> 
> Regards
> Alex
> 
>>> The third could be the less costly.
>>
>> [...]
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
