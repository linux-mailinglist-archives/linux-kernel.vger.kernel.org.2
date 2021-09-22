Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3811D4149E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhIVM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhIVM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:59:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51489C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:58:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT1pI-0007Q2-Lw; Wed, 22 Sep 2021 14:58:16 +0200
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
 <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
 <181c4037-3c34-0f71-6bb7-a9c11b173064@linaro.org>
 <dbd1c20c-e3be-6c92-52a8-2ad76d0092d0@pengutronix.de>
 <8fc0a5e2-18c0-fa81-3eed-a6d596361633@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d580dd06-8bc8-91c9-262b-f6f276b033c2@pengutronix.de>
Date:   Wed, 22 Sep 2021 14:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8fc0a5e2-18c0-fa81-3eed-a6d596361633@linaro.org>
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

Hi Srini,

On 22.09.21 14:49, Srinivas Kandagatla wrote:
> 
> 
> On 22/09/2021 13:31, Ahmad Fatoum wrote:
>>>>
>>>> On 08.09.21 12:02, Joakim Zhang wrote:
>>>>> From: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>>>>
>>>>> Some of the nvmem providers encode data for certain type of nvmem cell,
>>>>> example mac-address is stored in ascii or with delimiter or in reverse order.
>>>>>
>>>>> This is much specific to vendor, so having a cell-type would allow nvmem
>>>>> provider drivers to post-process this before using it.
>>>> I don't agree with this assessment. Users of the OCOTP so far
>>>> used this specific encoding. Bootloaders decode the OCOTP this way, but this
>>>> encoding isn't really an inherent attribute of the OCOTP. A new NXP SoC
>>>> with a different OTP IP will likely use the same format. Users may even
>>>> use the same format on an EEPROM to populate a second off-SoC interface, .. etc.
>>>>
>>> That is okay.
>> How would you go about using this same format on an EEPROM?
> 
> Am guessing that by the time there are more users for such formats, those post-processing functions should be converted into some library functions.

User A wants to reverse bytes in MAC address. User B stores it in ASCII.
Both use the exact same EEPROM. How could this ever work when the
encoding decision is left to the EEPROM driver?

> 
> --srini
> 
>>
>>>> I'd thus prefer to not make this specific to the OCOTP as all:
>>>>
>>>>     * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX    /* ... */
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
