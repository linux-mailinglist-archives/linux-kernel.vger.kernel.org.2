Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4E33719E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCKLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:43:37 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44764 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhCKLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:43:11 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dx6Wv6wKFz1ry9k;
        Thu, 11 Mar 2021 12:43:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dx6Wv4vCTz1qr4m;
        Thu, 11 Mar 2021 12:43:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id bwhSiK_6OLsr; Thu, 11 Mar 2021 12:43:05 +0100 (CET)
X-Auth-Info: PWDLWpU/RF1mQ0vyUrR2TmlPpbT0QFk+u0aQwwhF6ik=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 11 Mar 2021 12:43:05 +0100 (CET)
Subject: Re: [PATCH v2 00/14] Introduce STM32MP1 RCC in secured mode
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <2e04f814-b694-119d-fe8a-13e6df129536@gmail.com>
 <AS8PR10MB4712C27260707345FA99ED5AEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
From:   Marek Vasut <marex@denx.de>
Message-ID: <c57775fe-41ef-07f5-56a2-04b8f70797c1@denx.de>
Date:   Thu, 11 Mar 2021 12:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <AS8PR10MB4712C27260707345FA99ED5AEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 9:08 AM, Alexandre TORGUE wrote:
> Hi ALex

Hello everyone,

[...]

>> Subject: Re: [PATCH v2 00/14] Introduce STM32MP1 RCC in secured mode
>>
>> On 1/26/21 3:01 AM, gabriel.fernandez@foss.st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>>
>>> Platform STM32MP1 can be used in configuration where some clocks and
>>> IP resets can relate as secure resources.
>>> These resources are moved from a RCC clock/reset handle to a SCMI
>>> clock/reset_domain handle.
>>>
>>> The RCC clock driver is now dependent of the SCMI driver, then we have
>>> to manage now the probe defering.
>>>
>>> v1 -> v2:
>>>     - fix yamllint warnings.
>>
>> Hi Gabriel,
>>
>> I don't have much clout with the maintainers, but I have to NAK this series
>> after finding major breakage.
>>
>> The problem with series is that it breaks pretty much every board it touches.
>> I have a DK2 here that I'm using for development, which no longer boots with
>> this series applied.
>>
>> The crux of the matter is that this series assumes all boards will boot with an
>> FSBL that implements a very specific SCMI clock tree. This is major ABI
>> breakage for anyone not using TF-A as the first stage bootloader. Anyone
>> using u-boot SPL is screwed.
>>
>> This series imposes a SOC-wide change via the dtsi files. So even boards that
>> you don't intend to convert to SCMI will get broken this way.
>> Adding a -no-scmi file that isn't used anywhere doesn't help things.
> 
> You are right. We mainly take care about NO ST (DH/...) boards, but  not really about current usage
> Of our stm32 boards. Several options exist:

Since a lot of people benefit from the good upstream support for the MP1 
_and_ keep updating their machines to get the latest fixes, it is very 
important to keep the current usage working.

> 1- Break the current ABI: as soon as those patches are merged, stm32mp157c-dk2.dtb will impose to use
> A tf-a for scmi clocks. For people using u-boot spl, the will have to create their own "no-secure" devicetree.

NAK, this breaks existing boards and existing setups, e.g. DK2 that does 
not use ATF.

> 2-As you suggest, create a new "secure" dtb per boards (Not my wish for maintenance perspectives).

I agree with Alex (G) that the "secure" option should be opt-in.
That way existing setups remain working and no extra requirements are 
imposed on MP1 users. Esp. since as far as I understand this, the 
"secure" part isn't really about security, but rather about moving clock 
configuration from Linux to some firmware blob.

> 3- Keep kernel device tree as they are and applied this secure layer (scmi clocks phandle) thanks to dtbo in
> U-boot.

Is this really better than
#include "stm32mp15xx-enable-secure-stuff.dtsi"
in a board DT ? Because that is how I imagine the opt-in "secure" option 
could work.

> The third could be the less costly.

[...]
