Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC743378E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhCKQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:12:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:57202 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhCKQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:11:56 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DxDV06DYQz1s00y;
        Thu, 11 Mar 2021 17:11:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DxDV0432hz1qr4l;
        Thu, 11 Mar 2021 17:11:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id jnJYO_qSd5et; Thu, 11 Mar 2021 17:11:50 +0100 (CET)
X-Auth-Info: 2KuBOCaE/sL/z2h12qu6ViGM9U9yOLCzuzHVP39GOc4=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 11 Mar 2021 17:11:50 +0100 (CET)
Subject: Re: [Linux-stm32] [PATCH v2 00/14] Introduce STM32MP1 RCC in secured
 mode
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
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
 <c1c9c89b-8794-9b91-b626-d743cd8ff31e@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <b87a2b24-678a-724d-e5df-1eabf5969ad2@denx.de>
Date:   Thu, 11 Mar 2021 17:11:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c1c9c89b-8794-9b91-b626-d743cd8ff31e@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 3:41 PM, Ahmad Fatoum wrote:
> Hello,

Hi,

> On 11.03.21 15:02, Alexandre TORGUE wrote:
>> On 3/11/21 12:43 PM, Marek Vasut wrote:
>>> On 3/11/21 9:08 AM, Alexandre TORGUE wrote:
>>>> 1- Break the current ABI: as soon as those patches are merged, stm32mp157c-dk2.dtb will impose to use
>>>> A tf-a for scmi clocks. For people using u-boot spl, the will have to create their own "no-secure" devicetree.
>>>
>>> NAK, this breaks existing boards and existing setups, e.g. DK2 that does not use ATF.
>>>
>>>> 2-As you suggest, create a new "secure" dtb per boards (Not my wish for maintenance perspectives).
>>>
>>> I agree with Alex (G) that the "secure" option should be opt-in.
>>> That way existing setups remain working and no extra requirements are imposed on MP1 users. Esp. since as far as I understand this, the "secure" part isn't really about security, but rather about moving clock configuration from Linux to some firmware blob.
>>>
>>>> 3- Keep kernel device tree as they are and applied this secure layer (scmi clocks phandle) thanks to dtbo in
>>>> U-boot.
>>>
>>> Is this really better than
>>> #include "stm32mp15xx-enable-secure-stuff.dtsi"
>>> in a board DT ? Because that is how I imagine the opt-in "secure" option could work.
>>>
>>
>> Discussing with Patrick about u-boot, we could use dtbo application thanks to extlinux.conf. BUT it it will not prevent other case (i.e. TF-A which jump directly in kernel@). So the "least worst" solution is to create a new "stm32mp1257c-scmi-dk2 board which will overload clock entries with a scmi phandle (as proposed by Alex).
> 
> I raised this issue before with your colleagues. I still believe the correct way
> would be for the TF-A to pass down either a device tree or an overlay with the
> actual settings in use, e.g.:
> 
>    - Clocks/Resets done via SCMI
>    - Reserved memory regions
> 
> If TF-A directly boots Linux, it can apply the overlay itself, otherwise it's
> passed down to SSBL that applies it before booting Linux.

That sounds good and it is something e.g. R-Car already does, it merges 
DT fragment from prior stages at U-Boot level and then passes the result 
to Linux.

So on ST hardware, the same could very well happen and it would work for 
both non-ATF / ATF / ATF+TEE options.
